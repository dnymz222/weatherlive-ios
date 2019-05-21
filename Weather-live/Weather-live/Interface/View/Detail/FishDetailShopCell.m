//
//  LBDetailShopCell.m
//  lamabiji
//
//  Created by xueping on 2018/10/2.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishDetailShopCell.h"
#import "Masonry.h"
#import "FishSellerModel.h"
#import "UIImageView+WebCache.h"
#import "ColorSizeMacro.h"
#import "UIColor+HexString.h"


@interface  FishDetailShopCell ()

@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UIImageView *typeIconView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *leftLabel;
@property(nonatomic,strong)UILabel *centerLabel;
@property(nonatomic,strong)UILabel *rightLabel;

@end

@implementation FishDetailShopCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.iconView ];
        [self.contentView addSubview:self.typeIconView];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.leftLabel];
        [self.contentView addSubview:self.centerLabel];
        [self.contentView addSubview:self.rightLabel];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-10);
            make.width.equalTo(@60);
        }];
        
        [self.typeIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(12);
            make.top.equalTo(self.iconView);
            make.height.equalTo(@22);
            make.width.equalTo(@22);
        }];
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.typeIconView.mas_right).offset(5);
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.typeIconView);
            make.height.equalTo(@20);
        }];
        
       
        
        [self.leftLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.typeIconView);
            make.width.equalTo(@80);
            make.centerY.equalTo(self.centerLabel);
            make.height.equalTo(@20);
        }];
        
        [self.centerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.leftLabel.mas_right).offset(3);
            make.bottom.equalTo(self.iconView.mas_bottom);
            make.height.equalTo(@20);
            make.width.equalTo(@80);
        }];
        
        [self.rightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.centerLabel.mas_right).offset(3);
            make.width.equalTo(@80);
            make.centerY.equalTo(self.centerLabel);
            make.height.equalTo(@20);
        }];
        
        
        
    }
    
    return self;
}


- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView  alloc] init];
        
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    
    return _iconView;
}

- (UIImageView *)typeIconView {
    
    if (!_typeIconView) {
        _typeIconView = [[UIImageView alloc] init];
        _typeIconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _typeIconView;
    
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return   _titleLabel;
}


- (UILabel *)leftLabel {
    
    if (!_leftLabel) {
        _leftLabel = [[UILabel alloc] init];
        _leftLabel.textAlignment = NSTextAlignmentLeft;
    
    }
    
    return _leftLabel;
}

- (UILabel *)centerLabel {
    
    if (!_centerLabel) {
        _centerLabel = [[UILabel alloc] init];
        _centerLabel.textAlignment = NSTextAlignmentLeft;
     }
    
    return _centerLabel;
    
}

- (UILabel *)rightLabel {
    
    if (!_rightLabel) {
        _rightLabel = [[UILabel alloc] init];
        _rightLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _rightLabel;
}

- (void)configWithModel:(FishSellerModel *)sellerModel {
    
    _titleLabel.text = sellerModel.shopName;
    NSString *image  = sellerModel.shopIcon;
    if ([image hasPrefix:@"https:"] || [image hasPrefix:@"http:"]) {
        
    } else {
        image = [@"https:" stringByAppendingString:image];
    }
    [_iconView sd_setImageWithURL:[NSURL URLWithString:image]];
    
    if ([sellerModel.shopType isEqualToString:@"B"]) {
        [_typeIconView setImage:[UIImage imageNamed:@"icon_tmall"]];
    } else {
        [_typeIconView setImage:[UIImage imageNamed:@"icon_taobao"]];
    }
    
    NSDictionary *attrsdict = @{NSFontAttributeName:[UIFont systemFontOfSize:12.f],
                           NSForegroundColorAttributeName:UIColorFromRGB(0x999999)
                           };
    FishSellerScoreModel *leftModel =sellerModel.evaluates[0];
    NSString *leftString = [NSString stringWithFormat:@"%@ %@",leftModel.title,leftModel.score];
    NSMutableAttributedString *leftattrs = [[NSMutableAttributedString alloc] initWithString:leftString attributes:attrsdict];
    [leftattrs addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:leftModel.levelTextColor] range:NSMakeRange(leftModel.title.length, leftString.length-leftModel.title.length)];
    _leftLabel.attributedText = leftattrs.copy;
    
    FishSellerScoreModel *centerModel =sellerModel.evaluates[1];
    NSString *centerString = [NSString stringWithFormat:@"%@ %@",centerModel.title,centerModel.score];
    NSMutableAttributedString *centerattrs = [[NSMutableAttributedString alloc] initWithString:centerString attributes:attrsdict];
    [centerattrs addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:centerModel.levelTextColor] range:NSMakeRange(centerModel.title.length, centerString.length-centerModel.title.length)];
    _centerLabel.attributedText = centerattrs.copy;
    
    
    FishSellerScoreModel *rightModel =sellerModel.evaluates[2];
    NSString *rightString = [NSString stringWithFormat:@"%@ %@",rightModel.title,rightModel.score];
    NSMutableAttributedString *rightattrs = [[NSMutableAttributedString alloc] initWithString:rightString attributes:attrsdict];
    [rightattrs  addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:rightModel.levelTextColor] range:NSMakeRange(rightModel.title.length, rightString.length-rightModel.title.length)];
    _rightLabel.attributedText = rightattrs.copy;
    
    
    
    
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
