//
//  TDFThemeManager.m
//  RestApp
//
//  Created by happyo on 2017/6/23.
//  Copyright © 2017年 杭州迪火科技有限公司. All rights reserved.
//

#import "TDFThemeManager.h"
#import "YYModel.h"

NSString * kHomeThemeChangedNotification = @"HOME_THEME_CHANGED_NOTIFICATION";

NSString * kHomeThemeId = @"HOME_THEME_ID";

@interface TDFThemeManager ()

@property (nonatomic, strong, readwrite) NSArray<TDFHomeBackgroundImageModel *> *backgroundImageList;

@property (nonatomic, assign, readwrite) NSInteger themeId;

@end
@implementation TDFThemeManager

+ (instancetype)sharedInstance
{
    static TDFThemeManager *themeManager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        themeManager = [[TDFThemeManager alloc] init];
        
        NSNumber *themeNumber = [[NSUserDefaults standardUserDefaults] objectForKey:kHomeThemeId];
        themeManager.themeId = [themeNumber integerValue];
        
        // 启动定时任务
        [themeManager timingTask];
    });
    return themeManager;
}

- (void)timingTask {
    //首先获取一个时间
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    //设置一个时间点. 比如 16:16:16
    NSString *beginDateStr = [NSString stringWithFormat:@"%@ 04:00:00", dateStr];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSDate *beginDate = [dateFormatter dateFromString:beginDateStr];
    
    NSString *endDateStr = [NSString stringWithFormat:@"%@ 19:00:00", dateStr];
    NSDate *endDate = [dateFormatter dateFromString:endDateStr];
    
    
    //然后初始化一个NSTimer.
    //一天的秒数是86400.然后设置重复repeats:YES.指定执行哪个方法.
    //最后添加到runloop就行了.从你运行代码的当天起,就开始执行了.
    NSTimer *beginTimer  = [[NSTimer alloc] initWithFireDate:beginDate interval:86400 target:self selector:@selector(timeTrigger) userInfo:nil repeats:YES];
    NSTimer *endTimer  = [[NSTimer alloc] initWithFireDate:endDate interval:86400 target:self selector:@selector(timeTrigger) userInfo:nil repeats:YES];

    [[NSRunLoop currentRunLoop] addTimer:beginTimer forMode:NSDefaultRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:endTimer forMode:NSDefaultRunLoopMode];
 
}

- (void)timeTrigger {
    [[NSNotificationCenter defaultCenter] postNotificationName:kHomeThemeChangedNotification object:nil];
}

- (void)changeTheme:(NSInteger)themeId
{
    self.themeId = themeId;
    
    [[NSUserDefaults standardUserDefaults] setObject:@(themeId) forKey:kHomeThemeId];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:kHomeThemeChangedNotification object:nil];
}

#pragma mark -- Public Methods --

- (UIImage *)getBackgroundImage
{
    TDFHomeBackgroundImageModel *imageModel = self.backgroundImageList[self.themeId];
    
    //首先获取一个时间
    NSDate *date = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.dd"];
    NSString *dateStr = [dateFormatter stringFromDate:date];
    //设置一个时间点. 比如 16:16:16
    NSString *beginDateStr = [NSString stringWithFormat:@"%@ 04:00:00", dateStr];
    [dateFormatter setDateFormat:@"yyyy.MM.dd HH:mm:ss"];
    NSDate *beginDate = [dateFormatter dateFromString:beginDateStr];
    
    NSString *endDateStr = [NSString stringWithFormat:@"%@ 19:00:00", dateStr];
    NSDate *endDate = [dateFormatter dateFromString:endDateStr];
    
    NSString *imageString;
    if ([date compare:beginDate] == NSOrderedDescending && [date compare:endDate] == NSOrderedAscending) {
        imageString = imageModel.dayImageString;
    } else {
        imageString = imageModel.nightImageString;
    }
    
    return [UIImage imageNamed:imageString];
}

- (BOOL)isDynamicTheme
{
    TDFHomeBackgroundImageModel *imageModel = self.backgroundImageList[self.themeId];

    return imageModel.isDynamic;
}

#pragma mark -- Getters && Setters --

- (NSArray<TDFHomeBackgroundImageModel *> *)backgroundImageList
{
    if (!_backgroundImageList) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"TDFHomeTheme" ofType:@"plist"];
        NSDictionary *dic = [NSDictionary dictionaryWithContentsOfFile:path];
        _backgroundImageList = [NSArray<TDFHomeBackgroundImageModel *> yy_modelArrayWithClass:[TDFHomeBackgroundImageModel class] json:dic[@"homeBackgroundImageList"]];
    }
    
    return _backgroundImageList;
}

@end
