//
//  CCDTimeSaver.m
//  Pods
//
//  Created by 凤梨 on 18/5/18.
//
//

#import "CCDTimeSaver.h"
#include <signal.h>
#include <pthread.h>
#include <libkern/OSAtomic.h>
#include <execinfo.h>

#define CCDTimeSaverInterval     1.0f

#define CCDTimeSaverPingNotification    @"CCDTimeSaverPingNotification"
#define CCDTimeSaverPongNotification    @"CCDTimeSaverPongNotification"
#define CALLSTACK_SIG SIGUSR1
static pthread_t mainThreadID;

static void thread_singal_handler(int sig)
{
    if (sig != CALLSTACK_SIG) {
        return;
    }
    
    NSArray* callStack = [NSThread callStackSymbols];
    id<CCDTimeSaverDelegate> del = [CCDTimeSaver sharedInstance].detectorDelegate;
    if (del != nil && [del respondsToSelector:@selector(mainThreadSlowWorkDetected:)]) {
        [del mainThreadSlowWorkDetected:callStack];
    }
    return;
}

static void install_signal_handler() {
    signal(CALLSTACK_SIG, thread_singal_handler);
}

static void printMainThreadCallStack() {
    //向UI线程发送signal， UI线程会被即刻暂停，并进入singal_handler
    pthread_kill(mainThreadID, CALLSTACK_SIG);
}


dispatch_source_t createGCDTimer(uint64_t interval, uint64_t leeway, dispatch_queue_t queue, dispatch_block_t block) {
    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    if (timer) {
        dispatch_source_set_timer(timer, dispatch_walltime(NULL, interval), interval, leeway);
        dispatch_source_set_event_handler(timer, block);
        dispatch_resume(timer);
    }
    return timer;
}


@interface CCDTimeSaver ()

@property (nonatomic, strong) dispatch_source_t    pingTimer;
@property (nonatomic, strong) dispatch_source_t    pongTimer;
@property (nonatomic, assign) NSInteger frameRate;
@end

@implementation CCDTimeSaver

+ (instancetype)sharedInstance {
    static CCDTimeSaver* instance = nil;

    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[self alloc] init];
    });

    return instance;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)startWorkWithDelegate:(id<CCDTimeSaverDelegate>)delegate frameRate:(NSInteger)frameRate {
    
    NSAssert([NSThread isMainThread] == YES, @"Error: TimeSaver must be start from main thread!");
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectPingFromWorkerThread) name:CCDTimeSaverPingNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(detectPongFromMainThread) name:CCDTimeSaverPongNotification object:nil];
    
    install_signal_handler();
    
    mainThreadID = pthread_self();
    self.detectorDelegate = delegate;
    self.frameRate = frameRate;
    
    [self startPing];
}

- (void)startPing {
    //ping from worker thread
    uint64_t interval = CCDTimeSaverInterval * NSEC_PER_SEC;
    __weak __typeof(self)weakSelf = self;
    self.pingTimer = createGCDTimer(interval, interval / 10000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf pingMainThread];
    });
}

- (void)pingMainThread {
    uint64_t interval = (1.0 / self.frameRate) / 1000 * NSEC_PER_SEC;//换算成ms
    __weak __typeof(self)weakSelf = self;
    self.pongTimer = createGCDTimer(interval, interval / 10000, dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        [weakSelf onPongTimeout];
    });
    //向UI线程发送ping
    dispatch_async(dispatch_get_main_queue(), ^{
        [[NSNotificationCenter defaultCenter] postNotificationName:CCDTimeSaverPingNotification object:nil];
    });
}

- (void)detectPingFromWorkerThread {
    [[NSNotificationCenter defaultCenter] postNotificationName:CCDTimeSaverPongNotification object:nil];
}

- (void)onPongTimeout {
    [self cancelPongTimer];
    [self cancelPingTimer];
    printMainThreadCallStack();
}

- (void)detectPongFromMainThread {
    [self cancelPongTimer];
}

- (void)cancelPongTimer {
    if (self.pongTimer) {
        dispatch_source_cancel(_pongTimer);
        _pongTimer = nil;
    }
}

- (void)cancelPingTimer {
    if (self.pingTimer) {
        dispatch_source_cancel(_pingTimer);
        _pingTimer = nil;
    }
}

@end
