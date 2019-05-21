//
//  LBDetailTitleCell.m
//  lamabiji
//
//  Created by xueping on 2018/9/30.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishDetailTitleCell.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "FishDetailItemModel.h"
#import "FishCouponItemModel.h"

@interface  FishDetailTitleCell ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *priceLabel;
@property(nonatomic,strong)UILabel *sellLabel;

@property(nonatomic,strong)UIButton *couponButton;

@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *rightLabel;
@property(nonatomic,strong)UIImageView *seperateView;


@end

@implementation FishDetailTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier  {
    
    self = [super initWithStyle:style   reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.priceLabel];
        [self.contentView addSubview:self.sellLabel];
        
        [self.contentView addSubview:self.couponButton];
        
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.rightLabel];
        [self.contentView addSubview:self.seperateView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.right.equalTo(self.contentView).offset(-15);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(@40);
        }];
        
        [self.priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(15);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.height.equalTo(@20);
            make.width.equalTo(@180);
        }];
        
        [self.sellLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.priceLabel);
            make.height.equalTo(@20);
            make.width.equalTo(@100);
        }];
        
        [self.couponButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.right.equalTo(self.contentView).offset(-20);
            make.top.equalTo(self.priceLabel.mas_bottom).offset(10);
            make.height.equalTo(@70);
        }];
        
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.couponButton);
            make.left.equalTo(self.couponButton.mas_left).offset(10);
            make.right.equalTo(self.couponButton.mas_centerX).offset(-10);
            make.height.equalTo(@20);
        }];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.centerY.equalTo(self.couponButton);
            make.left.equalTo(self.couponButton.mas_centerX).offset(10);
            make.right.equalTo(self.couponButton.mas_right).offset(-10);
            make.height.equalTo(@20);
        }];
        [self.seperateView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.couponButton).offset(10);
            make.bottom.equalTo(self.couponButton).offset(-10);
            make.centerX.equalTo(self.couponButton);
            make.width.equalTo(@1);
        }];
        
        
        
        
        
    }
    
    return self;
    
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
     }
    
    return _titleLabel;
}

- (UILabel *)priceLabel {
    
    if (!_priceLabel) {
        _priceLabel = [[UILabel alloc] init];
        _priceLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _priceLabel;
}


- (UILabel *)sellLabel {
    
    if (!_sellLabel) {
        _sellLabel = [[UILabel alloc] init];
        _sellLabel.textAlignment  = NSTextAlignmentRight;
        _sellLabel.textColor = UIColorFromRGB(0x999999);
        _sellLabel.font = [UIFont systemFontOfSize:12.f];
    }
    
    return _sellLabel;
}

- (UIButton  *)couponButton {
    
    if (!_couponButton) {
        _couponButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"bg_coupon"];
        [_couponButton setBackgroundImage:image forState:UIControlStateNormal];
//        _couponButton.imageView.contentMode = UIViewContentModeScaleAspectFill;
        [_couponButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _couponButton;
}

- (UIImageView *)seperateView {
    
    if (!_seperateView) {
        _seperateView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"col_line"];
        [_seperateView setImage:image];
    }
    
    return _seperateView;
}

- (void)buttonClick:(UIButton *)button {
    if (_delegate && [_delegate respondsToSelector:@selector(couponButtonClick:)]) {
        [_delegate couponButtonClick:button];
    }
    
}


- (void)configWithDetailItemModel:(FishDetailItemModel *)itemModel
                           coupon:(FishCouponItemModel *)couponModel
{
    _titleLabel.text  = couponModel.title;
    
    if ([couponModel.volume isEqualToString:@"0"]) {
        _sellLabel.text = @"";
    } else {
        
        _sellLabel.text = [NSString stringWithFormat:@"月销：%@",couponModel.volume];
    }
    
    
    _leftLabel.text = [NSString stringWithFormat:@"%ld元券",couponModel.coupon_amount];
    
    NSDictionary *oriAttrsdict = @{NSForegroundColorAttributeName:UIColorFromRGB(0xaaaaaa),NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSBaselineOffsetAttributeName:@0,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick)};
    
    
    NSAttributedString *oriAttrs = [[NSAttributedString alloc] initWithString:[NSString  stringWithFormat:@"￥%@", couponModel.zk_final_price] attributes:oriAttrsdict];
    
    
    
    NSDictionary *currattrsDict = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.f],NSForegroundColorAttributeName:UIColorFromRGB(0xfc4b36)};
    NSString *   currprice= [NSString stringWithFormat:@"￥%0.2f ",[couponModel.zk_final_price floatValue] - couponModel.coupon_amount];
    NSMutableAttributedString *currAttrs = [[NSMutableAttributedString alloc] initWithString:currprice attributes:currattrsDict];
    [currAttrs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, 1)];
    [currAttrs appendAttributedString:oriAttrs];
    _priceLabel.attributedText = currAttrs.copy;
    
    
}


- (UILabel *)leftLabel {
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentCenter;
        _leftLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _leftLabel.textColor = [UIColor whiteColor];
        
    }
    
    return _leftLabel;
}


- (UILabel *)rightLabel {
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textColor = [UIColor whiteColor];
        _rightLabel.textAlignment = NSTextAlignmentCenter;
        _rightLabel.font = [UIFont boldSystemFontOfSize:18.f];
        _rightLabel.text = @"立即领券";
    }
    
    
    return _rightLabel;
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
