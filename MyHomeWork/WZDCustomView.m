//
//  WZDCustomView.m
//  MyHomeWork
//
//  Created by 凤梨 on 16/12/17.
//  Copyright © 2016年 zhandongwang. All rights reserved.
//

#import "WZDCustomView.h"

@interface WZDCustomView()

@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSThread *thread;
@end


@implementation WZDCustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
    }
    return self;
}
    
- (void)drawRect:(CGRect)rect {
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 100, 100)];
//    [[UIColor blueColor] setFill];
//    [path fill];
    
//    CGContextRef context = UIGraphicsGetCurrentContext();
//    CGContextSetStrokeColorWithColor(context, [UIColor blackColor].CGColor);
//    CGContextSetLineWidth(context, 3);
//    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:myrect cornerRadius:10];
//    [path stroke];
    
//    CGContextAddEllipseInRect(context, myrect);
//    CGContextSetFillColorWithColor(context, [UIColor blueColor].CGColor);
//    CGContextFillPath(context);
    
//    UIBezierPath *path = [UIBezierPath bezierPathWithOvalInRect:rect];
//    [[UIColor blueColor] setFill];
//    [path fill];
//    
    CGSize size = self.bounds.size;
//
//    CGFloat lineHeight = 3.0;
//    CGFloat lineWidth = 60;
//    UIBezierPath *linePath = [UIBezierPath bezierPath];
//    linePath.lineWidth = lineHeight;
//    [linePath moveToPoint:CGPointMake(size.width/2 - lineWidth/2, size.height/2)];
//    [linePath addLineToPoint:CGPointMake(size.width/2 + lineWidth/2, size.height/2)];
//    
//    [linePath moveToPoint:CGPointMake(size.width/2 ,size.height/2 - lineWidth/2)];
//    [linePath addLineToPoint:CGPointMake( size.width/2, size.height/2 + lineWidth/2)];
//    
//    [[UIColor whiteColor] setStroke];
//    [linePath stroke];
    
//    CGPoint center = CGPointMake(100, 100);
//    CGFloat radius = 100;
//    CGFloat arcWidth = 30;
//    
//    CGFloat startAngle = 3* M_PI / 4;
//    CGFloat endAngle = M_PI / 4;
//    
//    UIBezierPath *arcPath = [UIBezierPath bezierPathWithArcCenter:center radius:(radius / 2 - arcWidth / 2)startAngle:startAngle endAngle:endAngle clockwise:YES];
//    
//    arcPath.lineWidth = arcWidth;
//    [[UIColor redColor] setStroke];
//    [arcPath stroke];
//    
    
}
//-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
//    NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(show) object:nil];
//    self.thread = thread;
//    [thread start];
//}

- (void)show {
    [[NSRunLoop currentRunLoop] addPort:[NSMachPort port] forMode:NSDefaultRunLoopMode];
    //RunLoop中要至少有一个Timer 或 一个Source
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(test) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:timer forMode:NSDefaultRunLoopMode];
    //创建监听者
    CFRunLoopObserverRef observer = CFRunLoopObserverCreateWithHandler(CFAllocatorGetDefault(), kCFRunLoopAllActivities, YES, 0, ^(CFRunLoopObserverRef observer, CFRunLoopActivity activity) {
        switch (activity) {
            case kCFRunLoopEntry:
            NSLog(@"RunLoop进入");
            break;
            case kCFRunLoopBeforeTimers:
            NSLog(@"RunLoop要处理Timers了");
            break;
            case kCFRunLoopBeforeSources:
            NSLog(@"RunLoop要处理Sources了");
            break;
            case kCFRunLoopBeforeWaiting:
            NSLog(@"RunLoop要休息了");
            break;
            case kCFRunLoopAfterWaiting:
            NSLog(@"RunLoop醒来了");
            break;
            case kCFRunLoopExit:
            NSLog(@"RunLoop退出了");
            break;
            
            default:
            break;
        }
    });
    CFRunLoopAddObserver(CFRunLoopGetCurrent(), observer, kCFRunLoopDefaultMode);
    [[NSRunLoop currentRunLoop] run];
    CFRelease(observer);
}
    
    
    
- (void)updateName:(NSString *)name {
    self.name = name;
}

@end
