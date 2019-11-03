//
//  WLAccuNormalHeaderView.m
//  Weather-live
//
//  Created by xueping on 2019/5/22.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAccuNormalHeaderView.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"

@implementation WLAccuNormalHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.button];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
        
            make.right.equalTo(self.contentView).offset(-60);
            make.top.bottom.equalTo(self.contentView);
        }];
        
        [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.width.equalTo(@60);
            make.top.bottom.equalTo(self.contentView);
        }];
        
        
    }
    
    return self;
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.textColor = UIColorFromRGB(Themecolor);
        _titleLabel.numberOfLines =0;
        _titleLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    return _titleLabel;
}

- (UIButton *)button {
    
    if (!_button) {
        _button = [UIButton buttonWithType:UIButtonTypeCustom];
        [_button  setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
        _button.imageView.contentMode = UIViewContentModeCenter;
        
    }
    
    return _button;
}






/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
