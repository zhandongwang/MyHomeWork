//
//  TDFFooterSvgView.m
//  TDFCore
//
//  Created by larou on 2017/12/18.
//

#import "TDFFooterSvgView.h"
#import "NSBundle+LanguageWithSVG.h"

#define TDFFooterButtonSize 55.0f
@interface TDFFooterSvgView ()
@property (nonatomic, strong) UILabel *svgLabel;
@end

@implementation TDFFooterSvgView

- (void)setFooter:(id<TDFFooterProtocol>)footer {
    [super setFooter:footer];
    if ([footer respondsToSelector:@selector(svgName)]) {
        [self.button setTitle:[footer svgName] forState:UIControlStateNormal];
        self.backgroundColor = [UIColor clearColor];
        if (footer.alignment == TDFFooterAlignmentLeft || self.footer.alignment == TDFFooterAlignmentLeftForVerticalVersion) {
            UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(handleHelpButtonPanGestureRecognizer:)];
            [self.button addGestureRecognizer:pan];
            CGRect buttonFrame = self.button.frame;
            self.button.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
            self.button.frame = CGRectMake(buttonFrame.origin.x, buttonFrame.origin.y
                                           , 34, 34);
            self.button.titleLabel.font = [UIFont fontWithName:NSLocalizedSVGWithoutText size:34];
            
            self.button.layer.cornerRadius = 17;
            self.button.layer.masksToBounds = YES;
        } else {
            self.button.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:1.0];
            self.button.titleLabel.font = [UIFont fontWithName:NSLocalizedSVG size:54];
            self.button.layer.cornerRadius = 28;
            self.button.layer.masksToBounds = YES;
        }
    }
    if ([footer respondsToSelector:@selector(viewBackColor)]) {
        [self.button setTitleColor:[footer viewBackColor] forState:UIControlStateNormal];
    }
}

- (void)handleHelpButtonPanGestureRecognizer:(UIPanGestureRecognizer*)recognizer {
    
    CGPoint translation = [recognizer translationInView:self.superview];
    CGFloat centerX = recognizer.view.superview.center.x+ translation.x;
    CGFloat centerY = recognizer.view.superview.center.y+ translation.y;
    CGFloat thecenter = 0;
    
    recognizer.view.superview.center=CGPointMake(centerX,recognizer.view.superview.center.y+ translation.y);
    [recognizer setTranslation:CGPointZero inView:self.superview];
    
    if(recognizer.state == UIGestureRecognizerStateEnded || recognizer.state == UIGestureRecognizerStateCancelled) {
        
        thecenter=TDFFooterButtonSize/2+8;
        
        if (centerY < TDFFooterButtonSize/2) {
            centerY = TDFFooterButtonSize/2;
        }else if (centerY > [UIScreen mainScreen].bounds.size.height-100) {
            centerY =  [UIScreen mainScreen].bounds.size.height - 100;
        }
        
        [UIView animateWithDuration:0.3 animations:^{
            recognizer.view.superview.center=CGPointMake(thecenter, centerY);
        }];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.footer.alignment == TDFFooterAlignmentLeft || self.footer.alignment == TDFFooterAlignmentLeftForVerticalVersion) {
        self.button.frame = CGRectMake(0, 0 , 34, 34);
        self.button.center = CGPointMake(self.frame.size.width/2, self.frame.size.width/2);
    }
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
