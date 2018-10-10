//
// Created by 於卓慧 on 16/4/18.
// Copyright (c) 2016 杭州迪火科技有限公司. All rights reserved.
//

#import "TDFVerticalButton.h"


@implementation TDFVerticalButton

- (void)layoutSubviews
{
    [super layoutSubviews];

    CGRect titleLabelFrame = self.titleLabel.frame;
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated-declarations"
    CGSize labelSize = [self.titleLabel.text sizeWithFont:self.titleLabel.font constrainedToSize:CGSizeMake(self.frame.size.width, CGFLOAT_MAX) lineBreakMode:NSLineBreakByWordWrapping];
#pragma GCC diagnostic pop

    CGRect imageFrame = self.imageView.frame;

    CGSize fitBoxSize = (CGSize){.height = labelSize.height + 0 +  imageFrame.size.height, .width = MAX(imageFrame.size.width, labelSize.width)};

    CGRect fitBoxRect = CGRectInset(self.bounds, (self.bounds.size.width - fitBoxSize.width)/2, (self.bounds.size.height - fitBoxSize.height)/2);

    imageFrame.origin.y = fitBoxRect.origin.y;
    imageFrame.origin.x = CGRectGetMidX(fitBoxRect) - (imageFrame.size.width/2);
    self.imageView.frame = imageFrame;

    // Adjust the label size to fit the text, and move it below the image

    titleLabelFrame.size.width = labelSize.width;
    titleLabelFrame.size.height = labelSize.height;
    titleLabelFrame.origin.x = (self.frame.size.width / 2) - (labelSize.width / 2);
    titleLabelFrame.origin.y = fitBoxRect.origin.y + imageFrame.size.height + 0;
    self.titleLabel.frame = titleLabelFrame;

}

@end
