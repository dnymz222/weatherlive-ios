//
//  WLTaobaoCouponCell.m
//  Weather-live
//
//  Created by xueping on 2019/5/26.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLTaobaoCouponCell.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "FishCouponItemModel.h"
#import "UIImageView+WebCache.h"
#import "WXPFloat.h"


@interface WLTaobaoCouponCell ()

@property(nonatomic,weak)UILabel *titleLable;

@property(nonatomic,weak)UIImageView *iconview;

@property(nonatomic,weak)UILabel *currentPriceLable;

@property(nonatomic,weak)UIButton *couponlable;



@property(nonatomic,weak)UILabel *endtimeLabel;

@property(nonatomic,weak)UILabel *shoptitleLabel;

@property(nonatomic,weak)UILabel *sellLable;

@property(nonatomic,copy)NSDictionary *couponAttrsDict;

@property(nonatomic,strong)FishCouponItemModel *itemModel;



@end

@implementation WLTaobaoCouponCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat height = [UIScreen mainScreen].bounds.size.width *0.4f;
        //CGFloat scale = [UIScreen mainScreen].bounds.size.width/320.f;
        
        UIImageView *imageview = [[UIImageView alloc] init];
        [self.contentView addSubview:imageview];
        _iconview   = imageview;
        
        
        
        [_iconview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-12);
            make.width.equalTo(@(height-12));
        }];
        
        
        _iconview.backgroundColor = UIColorFromRGB(0xe6e6e6);
        
        UILabel *label = [[UILabel alloc] init];
        [self.contentView addSubview:label];
        _titleLable = label;
        _titleLable.textColor = UIColorFromRGB(0x333333);
        _titleLable.numberOfLines = 0 ;
        _titleLable.font = [UIFont systemFontOfSize:14.f];
        _titleLable.textAlignment =NSTextAlignmentLeft;
        
        [_titleLable mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(_iconview.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(@36);
            
        }];
        
        
        
        
        
        
        UIButton *couponLabel = [UIButton buttonWithType:UIButtonTypeCustom];
        [self.contentView addSubview:couponLabel];
        _couponlable = couponLabel;
        //_couponlable.textAlignment = NSTextAlignmentCenter;
        //_couponlable.font = [UIFont systemFontOfSize:14.f];
        //_couponlable.backgroundColor= UIColorFromRGB(KColorThemecolor);
        //_couponlable.layer.cornerRadius  = 3.f;
        //_couponlable.layer.masksToBounds = YES ;
        //_couponlable.textColor = [UIColor whiteColor];
        //_couponlable.adjustsFontSizeToFitWidth = YES;
        UIImage *image = [UIImage imageNamed:@"coupon_back"];
        [_couponlable setBackgroundImage:image forState:UIControlStateNormal];
        
        [_couponlable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.bottom.equalTo(self.contentView).offset(-16);
            make.width.equalTo(@68);
            make.height.equalTo(@22);
            
        }];
        
        _couponlable.userInteractionEnabled = NO;
        
        _couponAttrsDict = @{NSFontAttributeName:[UIFont systemFontOfSize:13.f],
                             NSForegroundColorAttributeName:[UIColor whiteColor]
                             };
        
        
        UILabel *currentpriceLabel = [[UILabel alloc] init];
        [self.contentView addSubview:currentpriceLabel];
        _currentPriceLable = currentpriceLabel;
        _currentPriceLable.textColor = UIColorFromRGB(0xfc4b36);
        _currentPriceLable.textAlignment = NSTextAlignmentLeft ;
        _currentPriceLable.adjustsFontSizeToFitWidth = YES;
        
        [_currentPriceLable mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconview.mas_right).offset(10);
            make.right.equalTo(_couponlable.mas_left).offset(-5);
            make.centerY.equalTo(_couponlable);
            make.height.equalTo(@20);
            
        }];
        
        
        UILabel *endtimeLabel = [[UILabel alloc] init];
        [self.contentView addSubview:endtimeLabel];
        _endtimeLabel = endtimeLabel;
        
        _endtimeLabel.textAlignment = NSTextAlignmentRight ;
        _endtimeLabel.textColor = UIColorFromRGB(0xaaaaaa);
        _endtimeLabel.font = [UIFont systemFontOfSize:11.f];
        
        [_endtimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-12);
            make.bottom.equalTo(self.couponlable.mas_top).offset(-10);
            make.height.equalTo(@20);
            make.width.equalTo(@80);
        }];
        
        
        
        
        
        UILabel *shopLabel = [[UILabel alloc] init];
        [self.contentView addSubview:shopLabel];
        _shoptitleLabel = shopLabel;
        _shoptitleLabel.textColor = UIColorFromRGB(0xaaaaaa);
        _shoptitleLabel.font = [UIFont systemFontOfSize:11.f];
        _shoptitleLabel.textAlignment = NSTextAlignmentLeft;
        _shoptitleLabel.numberOfLines = 2;
        
        
        
        [_shoptitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_iconview.mas_right).offset(10);
            make.right.equalTo(_endtimeLabel.mas_left).offset(-5);
            make.centerY.equalTo(_endtimeLabel);
            make.height.equalTo(@30);
        }];
        
        
        
        
        
    }
    
    return self;
    
}

- (void)configWithCoupon:(FishCouponItemModel *)coupon {
    
    
    if (coupon) {
        _itemModel = coupon;
        _titleLable.text = coupon.title;
        
        //NSString *coverimage = [itemModel.image stringByAppendingString:@"_250x250"];
        if (![_itemModel.pict_url hasPrefix:@"http"]) {
            _itemModel.pict_url = [@"https:" stringByAppendingString:_itemModel.pict_url];
            
        }
        
        NSString *pict_url = [_itemModel.pict_url stringByAppendingString:@"_250x250"];
        [_iconview sd_setImageWithURL:[NSURL URLWithString:pict_url]];
        
        NSString *string = [NSString stringWithFormat:@"%zd元券", _itemModel.coupon_amount];
        
        NSAttributedString *couponAttrs = [[NSAttributedString alloc] initWithString:string attributes:_couponAttrsDict];
        [_couponlable setAttributedTitle:couponAttrs forState:UIControlStateNormal];
        
        _endtimeLabel.text = _itemModel.volume?[NSString stringWithFormat:@"月销 %zd",_itemModel.volume]:@"";
        
        if (_itemModel.shop_title) {
            _shoptitleLabel.text = _itemModel.shop_title;
        } else if(_itemModel.item_description){
            _shoptitleLabel.text = _itemModel.item_description;
        } else {
        _shoptitleLabel.text = @"";
        }
        
        NSDictionary *oriAttrsdict = @{NSForegroundColorAttributeName:UIColorFromRGB(0xaaaaaa),NSFontAttributeName:[UIFont systemFontOfSize:12.f],NSBaselineOffsetAttributeName:@0,NSStrikethroughStyleAttributeName:@(NSUnderlineStyleThick)};
        NSAttributedString *oriAttrs = [[NSAttributedString alloc] initWithString:[NSString  stringWithFormat:@"￥%@", [WXPFloat stringWithfloat: [_itemModel.zk_final_price floatValue]]] attributes:oriAttrsdict];
        
        
        
        NSDictionary *currattrsDict = @{NSFontAttributeName:[UIFont boldSystemFontOfSize:15.f],NSForegroundColorAttributeName:UIColorFromRGB(0xfc4b36)};
        NSString *   currprice= [NSString stringWithFormat:@"￥%@ ",[WXPFloat stringWithfloat:[_itemModel.zk_final_price floatValue] - _itemModel.coupon_amount]];
        NSMutableAttributedString *currAttrs = [[NSMutableAttributedString alloc] initWithString:currprice attributes:currattrsDict];
        [currAttrs addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12.0f] range:NSMakeRange(0, 1)];
        [currAttrs appendAttributedString:oriAttrs];
        _currentPriceLable.attributedText = currAttrs;
        
        
        
        
    }
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
