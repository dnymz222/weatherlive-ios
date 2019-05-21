//
//  LBCouponCollectionViewCell.m
//  lamabiji
//
//  Created by mc on 2018/9/12.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishCouponCollectionViewCell.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "FishCouponItemModel.h"
#import "UIImageView+WebCache.h"

@interface FishCouponCollectionViewCell ()

@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel *titleLable;
@property(nonatomic,strong)UIButton *couponButton;
@property(nonatomic,strong)UILabel *priceLable;
@property(nonatomic,strong)UILabel *sellLabel;
@property(nonatomic,strong)UILabel *shopLabel;
@property(nonatomic,copy)NSDictionary *couponAttrsDict;


@end

@implementation FishCouponCollectionViewCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.titleLable];
        
        [self.contentView addSubview:self.sellLabel];
        [self.contentView addSubview:self.shopLabel];
        
        [self.contentView addSubview:self.priceLable];
        [self.contentView addSubview:self.couponButton];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-100);
            
        }];
        
        [self.titleLable  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_bottom).offset(5);
            make.left.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.contentView).offset(-5);
            make.height.equalTo(@40);
        }];
        
        
        [self.sellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-5);
            make.top.equalTo(self.titleLable.mas_bottom).offset(2);
            make.width.equalTo(@60);
            make.height.equalTo(@12);
        }];
        
        [self.shopLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.sellLabel.mas_left).offset(-6);
            make.centerY.equalTo(self.sellLabel);
            make.height.equalTo(@12);
        }];
        [self.couponButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-5);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.equalTo(@65);
            make.height.equalTo(@23);
            
        }];
        
        [self.priceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@20);
            make.right.equalTo(self.couponButton.mas_left).offset(-5);
            
        }];
        
        _couponAttrsDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13.f],
                             NSForegroundColorAttributeName:[UIColor whiteColor]
                             };
        
        
        
    }
    
    return self;
    
    
}

- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.backgroundColor = UIColorFromRGB(0xf9f9f9);
    }
    
    return _iconView;
}

- (UILabel *)titleLable {
    
    if (!_titleLable) {
        _titleLable = [[UILabel alloc] init];
        _titleLable.textAlignment = NSTextAlignmentLeft;
        _titleLable.font = [UIFont systemFontOfSize:12.f];
        _titleLable.numberOfLines = 2;
        _titleLable.textColor = UIColorFromRGB(0x444444);
    }
    
    
    return _titleLable ;
    
}


- (UILabel *)sellLabel {
    
    if (!_sellLabel) {
        _sellLabel = [[UILabel alloc] init];
        _sellLabel.textAlignment = NSTextAlignmentRight;
        _sellLabel.font =[UIFont systemFontOfSize:10.f];
        _sellLabel.textColor = UIColorFromRGB(0xaaaaaa);
    }
    
    
    return _sellLabel;
    
}

- (UILabel *)shopLabel {
    
    if (!_shopLabel) {
        _shopLabel = [[UILabel alloc] init];
        _shopLabel.textAlignment = NSTextAlignmentLeft;
        _shopLabel.font= [UIFont systemFontOfSize:10.f];
        _shopLabel.textColor = UIColorFromRGB(0xaaaaaa);
    }
    
    return _shopLabel;
    
}


- (UILabel *)priceLable {
    
    if (!_priceLable) {
        _priceLable = [[UILabel alloc] init];
        _priceLable.textColor = UIColorFromRGB(0xfc4b36);
        _priceLable.textAlignment = NSTextAlignmentLeft;
        _priceLable.font = [UIFont systemFontOfSize:16.f];
    }
    
    return _priceLable;
}




- (UIButton *)couponButton {
    
    if (!_couponButton) {
        _couponButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"coupon_bg"];
        [_couponButton setBackgroundImage:image forState:UIControlStateNormal];
        _couponButton.userInteractionEnabled = NO;
    }
    
    return _couponButton;
}

- (void)congfigWithModel:(FishCouponItemModel *)model {
    
//    if (!model.hasReplace) {
//        model.image = [model.image stringByReplacingOccurrencesOfString:@"_250x250" withString:@"_400x400"];
//
//        model.hasReplace = YES;
//    }
//
    NSString *picurl  = [model.pict_url stringByAppendingString:@"_400x400"];
    
    [_iconView sd_setImageWithURL:[NSURL URLWithString:picurl]];
    _titleLable.text = model.short_title;
    NSString *string = [NSString stringWithFormat:@"%zd元券", model.coupon_amount];
    
    NSAttributedString *couponAttrs = [[NSAttributedString alloc] initWithString:string attributes:_couponAttrsDict];
    [_couponButton setAttributedTitle:couponAttrs forState:UIControlStateNormal];
    
    _priceLable.text = [NSString stringWithFormat:@"￥%0.2f",[model.zk_final_price floatValue] - model.coupon_amount];
    if ([@"0" isEqualToString: model.volume]) {
        self.sellLabel.text = @"";
    } else {
        self.sellLabel.text = [NSString stringWithFormat:@"月销 %@",model.volume];
    }
    
    self.shopLabel.text = model.shop_title;
    
}



//- ( *)couponLabel {
//
//    if (!_couponLabel) {
//        _couponLabel = [[UILabel alloc] init];
////        _couponLabel.textColor = UIColorFromRGB(0xfa61e9);
//        _couponLabel.font = [UIFont systemFontOfSize:15.f];
//        _couponLabel.textAlignment = NSTextAlignmentLeft;
//    }
//
//
//    return _couponLabel;
//
//}


@end
