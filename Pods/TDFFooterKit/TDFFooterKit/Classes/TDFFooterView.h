//
//  TDFFooterView.h
//  Pods
//
//  Created by tripleCC on 2017/8/25.
//
//

#import <UIKit/UIKit.h>
#import "TDFFooter.h"

@interface TDFFooterView : UIView
@property (strong, nonatomic) id <TDFFooterProtocol> footer;
@property (strong, nonatomic) UIButton *button;
@end
