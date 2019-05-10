//
//  FLUIKitTableViewCell.m
//  MyHomeWork
//
//  Created by 凤梨 on 2019/5/9.
//  Copyright © 2019年 zhandongwang. All rights reserved.
//

#import "FLUIKitTableViewCell.h"
#import <Masonry/Masonry.h>
#import "UIImageView+WebCache.h"
#import "FLMovieModel.h"
#import "FLConst.h"
@interface FLUIKitTableViewCell ()

@property (nonatomic, strong) UIImageView *picImageView;
@property (nonatomic, strong) UILabel *nameLabel;

@end


@implementation FLUIKitTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupStyle];
        [self setupSubViews];
        [self setupLayout];
    }
    return self;
}

- (void)setupStyle {
    self.contentView.backgroundColor = [UIColor blackColor];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
}
- (void)setupSubViews {
    [self.contentView addSubview:self.picImageView];
    [self.contentView addSubview:self.nameLabel];
    
}
- (void)setupLayout {
    [self.picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView);
    }];
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.equalTo(self.contentView).offset(10);
        make.trailing.equalTo(self.contentView).offset(-10);
        make.bottom.equalTo(self.contentView).offset(-10);
    }];
}

- (void)updateWithImageUrl:(NSString *)url name:(NSString *)name{
    self.nameLabel.text = name;
    NSURL *picUrl = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",kFLNetworkOriginalPosterImageUrl,url]];
    [self.picImageView sd_setImageWithURL:picUrl];
}

- (UIImageView *)picImageView {
    if (!_picImageView) {
        _picImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
        _picImageView.contentMode = UIViewContentModeScaleAspectFill;
        _picImageView.clipsToBounds = YES;
    }
    return _picImageView;
}
- (UILabel *)nameLabel {
    if (!_nameLabel) {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _nameLabel.textColor = [UIColor whiteColor];
        _nameLabel.font = [UIFont systemFontOfSize:16];
        _nameLabel.numberOfLines = 1;
        _nameLabel.textAlignment = NSTextAlignmentLeft;
        _nameLabel.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _nameLabel;
}
@end
