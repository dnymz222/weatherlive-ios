//
//  LBDetialHeaderView.m
//  lamabiji
//
//  Created by xueping on 2018/9/30.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishDetailHeaderView.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"

@interface  FishDetailHeaderView ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIView *sperateView;

@end

@implementation FishDetailHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.sperateView];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.equalTo(@240);
            make.height.equalTo(@20);
        }];
        
        [self.sperateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.height.equalTo(@0.5);
        }];
        
    }
    
    return self;
}


- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = UIColorFromRGB(0x666666);
    }
    
    return _titleLabel;
}

- (UIView *)sperateView {
    
    if (!_sperateView) {
        _sperateView = [[UIView alloc] init];
        _sperateView.backgroundColor = UIColorFromRGB(0xeeeeee);
    }
    return _sperateView;
}

- (void)configTitle:(NSString *)title {
    
    _titleLabel.text = title;
    
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
