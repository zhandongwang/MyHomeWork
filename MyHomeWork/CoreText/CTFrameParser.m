//
//  CTFrameParser.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/4/30.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "CTFrameParser.h"
#import <CoreText/CoreText.h>
#import "CoreTextImageData.h"

static CGFloat ascentCallback(void *ref) {
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"height"] floatValue];
}

static CGFloat descentCallback(void *ref){
    
    return 0;
}
static CGFloat widthCallback(void *ref){
    
    return [(NSNumber *)[(__bridge NSDictionary *)ref objectForKey:@"width"] floatValue];
}

@implementation CTFrameParser

+(CoreTextData *)parseTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config {
    NSMutableArray *imageArray = [NSMutableArray array];
    
    NSAttributedString *content = [self loadTemplateFile:path config:config imageArray:imageArray];
    CoreTextData *data = [self parseAttributedContent:content config:config];
    data.imageArray = imageArray;
    
    return data;
}

+(NSAttributedString *)loadTemplateFile:(NSString *)path config:(CTFrameParserConfig *)config  imageArray:(NSMutableArray *)imageArray {
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableAttributedString *result = [[NSMutableAttributedString alloc] init];
    if (data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        if ([array isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in array) {
                NSString *type = dict[@"type"];
                if ([type isEqualToString:@"txt"]) {
                    NSAttributedString *as = [self parseAttributeContentFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                } else if ([type isEqualToString:@"img"]) {
                    CoreTextImageData *imageData = [CoreTextImageData new];
                    imageData.name = dict[@"name"];
                    imageData.position = [result length];
                    [imageArray addObject:imageData];
                    NSAttributedString *as = [self parseImageDataFromNSDictionary:dict config:config];
                    [result appendAttributedString:as];
                }
            }
        }
    }
    return result;
}

+(NSAttributedString *)parseImageDataFromNSDictionary:(NSDictionary *)dict config:(CTFrameParserConfig *)config {
    CTRunDelegateCallbacks callbacks;
    memset(&callbacks, 0, sizeof(CTRunDelegateCallbacks));
    callbacks.version = kCTRunDelegateVersion1;
    callbacks.getAscent = ascentCallback;
    callbacks.getDescent = descentCallback;
    callbacks.getWidth = widthCallback;
    CTRunDelegateRef delegate = CTRunDelegateCreate(&callbacks, (__bridge void *)dict);
    
    //空白字符
    unichar objectReplacementChar = 0xFFFC;
    NSString *content = [NSString stringWithCharacters:&objectReplacementChar length:1];
    NSDictionary *attibutes = [self attributesWithConfig:config];
    NSMutableAttributedString *space = [[NSMutableAttributedString alloc] initWithString:content attributes:attibutes];
    //设置字符的CTRunDelegate
    CFAttributedStringSetAttribute((CFMutableAttributedStringRef)space, CFRangeMake(0, 1), kCTRunDelegateAttributeName, delegate);
    CFRelease(delegate);
    
    return space;
    
}


+(NSAttributedString *)parseAttributeContentFromNSDictionary:(NSDictionary*)dict config:(CTFrameParserConfig *)config {
    NSMutableDictionary *attributes = [NSMutableDictionary dictionaryWithDictionary:[self attributesWithConfig:config]];
    //设置颜色
    UIColor *color = [self colorFromTemplate:dict[@"color"]];
    if (color) {
        attributes[(id)kCTForegroundColorAttributeName] = (id)color.CGColor;
    }
    
    //设置字号
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize>0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attributes[(id)kCTFontAttributeName] = (__bridge id)fontRef;
        CFRelease(fontRef);
    }
    
    NSString *content = dict[@"content"];
    return [[NSAttributedString alloc] initWithString:content attributes:attributes];

}

+(UIColor *)colorFromTemplate:(NSString *)name{
    
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    }else if ([name isEqualToString:@"red"]){
        return [UIColor redColor];
    }else if ([name isEqualToString:@"black"]){
        return [UIColor blackColor];
    }else{
        return nil;
    }
}

+(CoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(CTFrameParserConfig *)config {
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize =  CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    CoreTextData *data = [[CoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    
    CFRelease(framesetter);
    CFRelease(frame);
    
    return data;
}

+(CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter config:(CTFrameParserConfig *)config height:(CGFloat)height{
    
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}


+(NSDictionary *)attributesWithConfig:(CTFrameParserConfig *)config{
    CGFloat fontSize = config.fontSize;
    CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    //段落
    CGFloat lineSpcing = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpcing},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpcing},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpcing},
    };
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    UIColor *textColor = config.textColor;
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[(id)kCTForegroundColorAttributeName] = (id)textColor.CGColor;
    dict[(id)kCTFontAttributeName] = (__bridge id)fontRef;
    dict[(id)kCTParagraphStyleAttributeName] = (__bridge id)theParagraphRef;
    
    CFRelease(fontRef);
    CFRelease(theParagraphRef);
    return dict;
}
@end
