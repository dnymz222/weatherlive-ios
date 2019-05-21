//
//  LBCouponDetailBottomView.m
//  lamabiji
//
//  Created by mc on 2018/9/17.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishCouponDetailBottomView.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"


@interface FishCouponDetailBottomView()


@property(nonatomic,strong)UIButton *backButton;
@property(nonatomic,strong)UIButton *buyButton;

@end

@implementation FishCouponDetailBottomView


- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xeeeeee);
        [self addSubview:self.backButton ];
        [self addSubview:self.buyButton];
        
//        [self.backButton  ]
        [self.backButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.bottom.equalTo(self);
            make.right.equalTo(self.mas_centerX).offset(-0.5);
             make.top.equalTo(self).offset(0.5);
        }];
        
        [self.buyButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.bottom.equalTo(self);
            make.left.equalTo(self.mas_centerX).offset(0.5);
            make.top.equalTo(self).offset(0.5);
        }];
        
        
        
        
        
        
    }
    
    return self;
}

- (UIButton *)backButton {
    
    if (!_backButton) {
        _backButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _backButton.backgroundColor = [UIColor whiteColor];
        _backButton.tag = 0;
        [_backButton setTitle:@"返回上一页" forState:UIControlStateNormal];
        [_backButton setTitleColor:UIColorFromRGB(0x666666) forState:UIControlStateNormal];
        [_backButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _backButton;
}

- (UIButton *)buyButton {
    
    if (!_buyButton) {
        _buyButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        _buyButton.backgroundColor = UIColorFromRGB(0xfc4b36);
       // CGFloat width = [UIScreen mainScreen].bounds.size.width;
        _buyButton.backgroundColor =UIColorFromRGB(0xfc4b36);

        //[UIColor setGradualChangingColor:CGRectMake(0, 0, width/2, 44) fromColor:UIColorFromRGB(0xfa6189) toColor:UIColorFromRGB(0xfc8836)];
        [_buyButton setTitle:@"领券购买" forState:UIControlStateNormal];
        [_buyButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _buyButton.tag = 1;
        [_buyButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return _buyButton;
}

- (void)buttonClick:(UIButton *)button {
    
    if (_delegate && [_delegate respondsToSelector:@selector(bottomViewClickButtonAtIndex:)]) {
        [_delegate bottomViewClickButtonAtIndex:button.tag];
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
