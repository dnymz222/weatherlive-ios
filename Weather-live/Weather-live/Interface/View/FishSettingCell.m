//
//  LBSettingCell.m
//  lamabiji
//
//  Created by xueping on 2018/9/24.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishSettingCell.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"

@interface  FishSettingCell ()

@property(nonatomic,strong,readwrite)UIImageView *iconView;
@property(nonatomic,strong,readwrite)UILabel *titleLabel;
@property(nonatomic,strong,readwrite)UILabel *detailLabel;


@end



@implementation FishSettingCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(nullable NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.iconView ];
        [self.contentView addSubview:self.titleLabel];
//        [self.contentView addSubview:self.detailLabel];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.contentView).offset(15);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@22);
            make.height.equalTo(@22);
        }];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.iconView.mas_right).offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@120);
            make.height.equalTo(@20);
            
        }];
        
//        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//
//            make.right.equalTo(self.contentView).offset(-20);
//            make.centerY.equalTo(self.contentView);
//            make.width.equalTo(@120);
//            make.height.equalTo(@20);
//
//        }];
        
        
        
    }

    return self;
}

- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init ];
    }
    
    
    return _iconView;
    
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        
    }
    
    return _titleLabel;
    
}

//- (UILabel *)detailLabel {
//    if (!_detailLabel) {
//        _detailLabel = [[UILabel alloc] init];
//        _detailLabel.textAlignment = NSTextAlignmentRight;
//        _detailLabel.font = [UIFont systemFontOfSize:12.f];
//        _detailLabel.textColor = UIColorFromRGB(0xfc4b36);
//    }
//
//    return _detailLabel;
//}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
