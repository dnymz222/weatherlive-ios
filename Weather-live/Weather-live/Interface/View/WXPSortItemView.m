//
//  WXPSortItemView.m
//  xunquan
//
//  Created by xueping on 2018/11/20.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "WXPSortItemView.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"

@interface WXPSortItemView ()

@property(nonatomic,strong)UIImageView *bottomView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *upButton;
@property(nonatomic,strong)UIButton *downButton;
@property(nonatomic,assign)BOOL isSelect;
@property(nonatomic,assign)NSInteger status;
@property(nonatomic,assign)BOOL isPrice;

@end

@implementation WXPSortItemView


- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.titleLabel];
        [self addSubview:self.bottomView];
        [self addSubview:self.upButton];
        [self addSubview:self.downButton];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self);
            make.width.equalTo(@40);
            make.height.equalTo(@20);
        }];
        
        [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@1);
        }];
        
        [self.upButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.bottom.equalTo(self.mas_centerY).offset(1);
            make.width.equalTo(@11);
            make.height.equalTo(@11);
            
        }];
        
        [self.downButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right);
            make.top.equalTo(self.mas_centerY).offset(-1);
            make.width.equalTo(@11);
            make.height.equalTo(@11);
            
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIn)];
        
        [self addGestureRecognizer:tap];
        
        self.status = 0;
    }
    
    return self;
}

- (UIImageView *)bottomView {
    if (!_bottomView) {
        _bottomView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"line"];
        [_bottomView setImage:image];
        _bottomView.hidden = YES;
    }
    
    return _bottomView;
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

- (UIButton *)upButton   {
    
    if (!_upButton) {
        _upButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *image = [UIImage imageNamed:@"asec_normal"];
        UIImage *selectImage = [UIImage imageNamed:@"asec_select"];
        [_upButton setImage:image forState:UIControlStateNormal];
        [_upButton setImage:selectImage forState:UIControlStateSelected];
        _upButton.userInteractionEnabled = NO;
        _upButton.selected = NO;
        _upButton.hidden = YES;
        
    }
    
    return _upButton;
}

- (UIButton *)downButton  {
    
    if (!_downButton) {
        _downButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        UIImage *image = [UIImage imageNamed:@"desc_normal"];
        UIImage *selectImage = [UIImage imageNamed:@"des_select"];
        [_downButton setImage:image forState:UIControlStateNormal];
        [_downButton setImage:selectImage forState:UIControlStateSelected];
        _downButton.userInteractionEnabled = NO;
        _downButton.selected = NO;
        _downButton.hidden = YES;
        
    }
    
    return _downButton;
}

- (void)configTitle:(NSString *)title {
    
    
    _titleLabel.text = title;
    
}

- (void)configIsPrice:(BOOL)isPrice {
    
    
    _isPrice  = isPrice;
    if (_isPrice) {
        _upButton.hidden = NO;
        _downButton.hidden = NO;
    }
    
}

- (void)configSlectIndex:(NSInteger)slectIndex {
    
    
    _isSelect    =  (slectIndex == self.tag);
    if (_isSelect) {
        _bottomView.hidden = NO;
        if (_isPrice) {
            _status  = 1;
            _upButton.selected = YES;
            _downButton.selected = NO;
        }
    } else {
        _bottomView.hidden = YES;
        if (_isPrice) {
            _status = 0;
            _upButton.selected = NO;
            _downButton.selected = NO;
        }
    }
}




- (void)tapIn {
    
    if (_isSelect) {
        if (_isPrice) {
            if (1 == _status) {
                _status = 2;
                _upButton.selected = NO;
                _downButton.selected = YES;
            } else {
                _status = 1;
                _upButton.selected = YES;
                _downButton.selected = NO;
                
            }
            
            if (_delegate && [_delegate respondsToSelector:@selector(sortItemViewTapPriceChangeWithStatus:)]) {
                [_delegate sortItemViewTapPriceChangeWithStatus:_status];
            }
        }
    } else {
        if (_delegate && [_delegate respondsToSelector:@selector(sortItemViewTapInselectIndex:)]) {
            [_delegate sortItemViewTapInselectIndex:self.tag];
        }
        
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
