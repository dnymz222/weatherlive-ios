//
//  WLXunquanCloumnItemCell.m
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLXunquanCloumnItemCell.h"
#import "UIImageView+WebCache.h"
#import "Masonry.h"
#import "colorSizeMacro.h"
#import "WLXunquanColumnModel.h"


@interface WLXunquanCloumnItemCell ()

@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel *titleLabel;



@end

@implementation WLXunquanCloumnItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLabel];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(12);
            make.left.equalTo(self.contentView).offset(18);
            make.right.equalTo(self.contentView).offset(-18);
            make.bottom.equalTo(self.contentView).offset(-34);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@15);
        }];
        
        
        
        
    }
    
    return self;
}

- (void)configColumn:(WLXunquanColumnModel *)column {
    
    [self.iconView sd_setImageWithURL:[NSURL URLWithString:column.image]];
    
    self.titleLabel.text = column.name;
    
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _iconView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
 
        _titleLabel.textAlignment  = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:12.f];
        _titleLabel.textColor = UIColorFromRGB(0x999999);
        
    }
    
    return _titleLabel;
}

@end
