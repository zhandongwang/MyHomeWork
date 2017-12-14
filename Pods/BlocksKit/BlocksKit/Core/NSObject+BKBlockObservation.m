//
//  NSObject+BKBlockObservation.m
//  BlocksKit
//

#import <objc/runtime.h>
#import <objc/message.h>
#import "NSArray+BlocksKit.h"
#import "NSDictionary+BlocksKit.h"
#import "NSObject+BKAssociatedObjects.h"
#import "NSObject+BKBlockObservation.h"
#import "NSSet+BlocksKit.h"

typedef NS_ENUM(int, BKObserverContext) {
	BKObserverContextKey,
	BKObserverContextKeyWithChange,
	BKObserverContextManyKeys,
	BKObserverContextManyKeysWithChange
};

@interface _BKObserver : NSObject {
	BOOL _isObserving;
}

@property (nonatomic, readonly, unsafe_unretained) id observee;
@property (nonatomic, readonly) NSMutableArray *keyPaths;
@property (nonatomic, readonly) id task;
@property (nonatomic, readonly) BKObserverContext context;

- (id)initWithObservee:(id)observee keyPaths:(NSArray *)keyPaths context:(BKObserverContext)context task:(id)task;

@end

static void *BKObserverBlocksKey = &BKObserverBlocksKey;
static void *BKBlockObservationContext = &BKBlockObservationContext;

@implementation _BKObserver

- (id)initWithObservee:(id)observee keyPaths:(NSArray *)keyPaths context:(BKObserverContext)context task:(id)task
{
	if ((self = [super init])) {
		_observee = observee;
		_keyPaths = [keyPaths mutableCopy];
		_context = context;
		_task = [task copy];
	}
	return self;
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
	if (context != BKBlockObservationContext) return;

	@synchronized(self) {
		switch (self.context) {
			case BKObserverContextKey: {
				void (^task)(id) = self.task;
				task(object);
				break;
			}
			case BKObserverContextKeyWithChange: {
				void (^task)(id, NSDictionary *) = self.task;
				task(object, change);
				break;
			}
			case BKObserverContextManyKeys: {
				void (^task)(id, NSString *) = self.task;
				task(object, keyPath);
				break;
			}
			case BKObserverContextManyKeysWithChange: {
				void (^task)(id, NSString *, NSDictionary *) = self.task;
				task(object, keyPath, change);
				break;
			}
		}
	}
}

- (void)startObservingWithOptions:(NSKeyValueObservingOptions)options
{
	@synchronized(self) {
		if (_isObserving) return;

		[self.keyPaths bk_each:^(NSString *keyPath) {
			[self.observee addObserver:self forKeyPath:keyPath options:options context:BKBlockObservationContext];
		}];

		_isObserving = YES;
	}
}

- (void)stopObservingKeyPath:(NSString *)keyPath
{
	NSParameterAssert(keyPath);

	@synchronized (self) {
		if (!_isObserving) return;
		if (![self.keyPaths containsObject:keyPath]) return;

		NSObject *observee = self.observee;
		if (!observee) return;

		[self.keyPaths removeObject: keyPath];
		keyPath = [keyPath copy];

		if (!self.keyPaths.count) {
			_task = nil;
			_observee = nil;
			_keyPaths = nil;
		}

		[observee removeObserver:self forKeyPath:keyPath context:BKBlockObservationContext];
	}
}

- (void)_stopObservingLocked
{
	if (!_isObserving) return;

	_task = nil;

	NSObject *observee = self.observee;
	NSArray *keyPaths = [self.keyPaths copy];

	_observee = nil;
	_keyPaths = nil;

	[keyPaths bk_each:^(NSString *keyPath) {
		[observee removeObserver:self forKeyPath:keyPath context:BKBlockObservationContext];
	}];
}

- (void)stopObserving
{
	if (_observee == nil) return;

	@synchronized (self) {
		[self _stopObservingLocked];
	}
}

- (void)dealloc
{
	if (self.keyPaths) {
        //移除所有观察关系
		[self _stopObservingLocked];
	}
}

@end

@implementation NSObject (BlockObservation)

- (NSString *)bk_addObserverForKeyPath:(NSString *)keyPath task:(void (^)(id target))task
{
	NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
	[self bk_addObserverForKeyPaths:@[ keyPath ] identifier:token options:0 context:BKObserverContextKey task:task];
	return token;
}

- (NSString *)bk_addObserverForKeyPaths:(NSArray *)keyPaths task:(void (^)(id obj, NSString *keyPath))task
{
	NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
	[self bk_addObserverForKeyPaths:keyPaths identifier:token options:0 context:BKObserverContextManyKeys task:task];
	return token;
}

- (NSString *)bk_addObserverForKeyPath:(NSString *)keyPath options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSDictionary *change))task
{
	NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
	[self bk_addObserverForKeyPath:keyPath identifier:token options:options task:task];
	return token;
}

- (NSString *)bk_addObserverForKeyPaths:(NSArray *)keyPaths options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSString *keyPath, NSDictionary *change))task
{
	NSString *token = [[NSProcessInfo processInfo] globallyUniqueString];
	[self bk_addObserverForKeyPaths:keyPaths identifier:token options:options task:task];
	return token;
}

- (void)bk_addObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)identifier options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSDictionary *change))task
{
	BKObserverContext context = (options == 0) ? BKObserverContextKey : BKObserverContextKeyWithChange;
	[self bk_addObserverForKeyPaths:@[keyPath] identifier:identifier options:options context:context task:task];
}

- (void)bk_addObserverForKeyPaths:(NSArray *)keyPaths identifier:(NSString *)identifier options:(NSKeyValueObservingOptions)options task:(void (^)(id obj, NSString *keyPath, NSDictionary *change))task
{
	BKObserverContext context = (options == 0) ? BKObserverContextManyKeys : BKObserverContextManyKeysWithChange;
	[self bk_addObserverForKeyPaths:keyPaths identifier:identifier options:options context:context task:task];
}

- (void)bk_removeObserverForKeyPath:(NSString *)keyPath identifier:(NSString *)token
{
	NSParameterAssert(keyPath.length);
	NSParameterAssert(token.length);

	NSMutableDictionary *dict;

	@synchronized (self) {
		dict = [self bk_observerBlocks];
		if (!dict) return;
	}

	_BKObserver *observer = dict[token];
	[observer stopObservingKeyPath:keyPath];

	if (observer.keyPaths.count == 0) {
		[dict removeObjectForKey:token];
	}

	if (dict.count == 0) [self bk_setObserverBlocks:nil];
}

- (void)bk_removeObserversWithIdentifier:(NSString *)token
{
	NSParameterAssert(token);

	NSMutableDictionary *dict;

	@synchronized (self) {
		dict = [self bk_observerBlocks];
		if (!dict) return;
	}

	_BKObserver *observer = dict[token];
	[observer stopObserving];

	[dict removeObjectForKey:token];

	if (dict.count == 0) [self bk_setObserverBlocks:nil];
}

- (void)bk_removeAllBlockObservers
{
	NSDictionary *dict;

	@synchronized (self) {
		dict = [[self bk_observerBlocks] copy];
		[self bk_setObserverBlocks:nil];
	}

	[dict.allValues bk_each:^(_BKObserver *trampoline) {
		[trampoline stopObserving];
	}];
}

#pragma mark - "Private"s

+ (NSMutableSet *)bk_observedClassesHash
{
	static dispatch_once_t onceToken;
	static NSMutableSet *swizzledClasses = nil;
	dispatch_once(&onceToken, ^{
		swizzledClasses = [[NSMutableSet alloc] init];
	});

	return swizzledClasses;
}

- (void)bk_addObserverForKeyPaths:(NSArray *)keyPaths identifier:(NSString *)identifier options:(NSKeyValueObservingOptions)options context:(BKObserverContext)context task:(id)task
{
	NSParameterAssert(keyPaths.count);
	NSParameterAssert(identifier.length);
	NSParameterAssert(task);

    Class classToSwizzle = self.class;
    //获取所有修改过dealloc的类
    NSMutableSet *classes = self.class.bk_observedClassesHash;
    @synchronized (classes) {
        //获取当前类名，并判断是否修改过dealloc
        NSString *className = NSStringFromClass(classToSwizzle);
        if (![classes containsObject:className]) {
            SEL deallocSelector = sel_registerName("dealloc");
            
			__block void (*originalDealloc)(__unsafe_unretained id, SEL) = NULL;
            //实现新的dealloc
			id newDealloc = ^(__unsafe_unretained id objSelf) {
                [objSelf bk_removeAllBlockObservers];//先移除掉所有Observer
                
                if (originalDealloc == NULL) {//如果原有的dealloc没有找到，则查找父类的dealloc并调用
                    struct objc_super superInfo = {
                        .receiver = objSelf,
                        .super_class = class_getSuperclass(classToSwizzle)
                    };
                    
                    void (*msgSend)(struct objc_super *, SEL) = (__typeof__(msgSend))objc_msgSendSuper;
                    msgSend(&superInfo, deallocSelector);
                } else {//找到了原有的dealloc，调用
                    originalDealloc(objSelf, deallocSelector);
                }
            };
            
            IMP newDeallocIMP = imp_implementationWithBlock(newDealloc);
            //向当前类添加dealloc，多半会失败，因为已有dealloc
            if (!class_addMethod(classToSwizzle, deallocSelector, newDeallocIMP, "v@:")) {
                // The class already contains a method implementation.
                //获取原有dealloc的实现
                Method deallocMethod = class_getInstanceMethod(classToSwizzle, deallocSelector);
                
                // We need to store original implementation before setting new implementation
                // in case method is called at the time of setting.
                originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_getImplementation(deallocMethod);
                
                // We need to store original implementation again, in case it just changed.
                originalDealloc = (void(*)(__unsafe_unretained id, SEL))method_setImplementation(deallocMethod, newDeallocIMP);
            }
            
            [classes addObject:className];
        }
    }

	NSMutableDictionary *dict;
    //以自己为被观察者创建一个观察者实例
	_BKObserver *observer = [[_BKObserver alloc] initWithObservee:self keyPaths:keyPaths context:context task:task];
	[observer startObservingWithOptions:options];

	@synchronized (self) {
		dict = [self bk_observerBlocks];

		if (dict == nil) {
			dict = [NSMutableDictionary dictionary];
			[self bk_setObserverBlocks:dict];
		}
	}

	dict[identifier] = observer;
}

- (void)bk_setObserverBlocks:(NSMutableDictionary *)dict
{
	[self bk_associateValue:dict withKey:BKObserverBlocksKey];
}

- (NSMutableDictionary *)bk_observerBlocks
{
	return [self bk_associatedValueForKey:BKObserverBlocksKey];
}

@end
