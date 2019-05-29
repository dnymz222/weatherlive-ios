//
//  WLXinzhiAqiCell.m
//  Weather-live
//
//  Created by xueping on 2019/5/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLXinzhiAqiCell.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "WLXinzhiAqiModel.h"


@interface WLXinzhiAqiCell ()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *valueLabel;

@property(nonatomic,strong)UILabel *CoLabel;
@property(nonatomic,strong)UILabel *Pm10Label;
@property(nonatomic,strong)UILabel *O3Label;
@property(nonatomic,strong)UILabel *So2Label;
@property(nonatomic,strong)UILabel *Pm25Label;
@property(nonatomic,strong)UILabel *No2Label;


@property(nonatomic,copy)NSDictionary *titleAttrsDict;

@property(nonatomic,copy)NSDictionary *valueAttrsDict;


@end

@implementation WLXinzhiAqiCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.valueLabel];
        [self.contentView addSubview:self.Pm25Label];
        [self.contentView addSubview:self.Pm10Label];
        [self.contentView addSubview:self.So2Label];
        [self.contentView addSubview:self.No2Label];
        [self.contentView addSubview:self.CoLabel];
        [self.contentView addSubview:self.O3Label];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(5);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        
        [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.titleLabel.mas_right).offset(5);
            make.centerY.equalTo(self.titleLabel);
            make.height.equalTo(@18);
            make.width.equalTo(@160);
        }];
        
        
        [self.Pm25Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        
        [self.Pm10Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.Pm25Label);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        
        [self.So2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.Pm25Label);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        
        
        
        [self.No2Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.Pm25Label.mas_bottom).offset(5);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        
        [self.CoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.centerY.equalTo(self.No2Label);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        
        [self.O3Label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.No2Label);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        
        
        self.titleAttrsDict = @{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
                                NSForegroundColorAttributeName:UIColorFromRGB(0x888888)
                                };
        
        self.valueAttrsDict = @{NSForegroundColorAttributeName:UIColorFromRGB(0x444444),
                                NSFontAttributeName:[UIFont systemFontOfSize:14.f]
                                };
        
        
        
        
        
    }
    
    
    return self;
    
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        _titleLabel.font = [UIFont systemFontOfSize:15.f];
        _titleLabel.text = @"空气质量指数";
        
    }
    return _titleLabel;
}

- (UILabel *)valueLabel {
    
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.textColor = [UIColor whiteColor];
        _valueLabel.font = [UIFont systemFontOfSize:14.f];
        _valueLabel.layer.cornerRadius = 4.f;
        _valueLabel.layer.masksToBounds= YES;
    }
    
    return _valueLabel;
}


- (UILabel *)Pm25Label {
    if (!_Pm25Label) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.f];
        _Pm25Label = label;
    }
    return _Pm25Label;
}
- (UILabel *)Pm10Label {
    if (!_Pm10Label) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.f];
        _Pm10Label = label;
    }
    
    return _Pm10Label;
}

- (UILabel *)So2Label {
    if (!_So2Label) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.f];
        _So2Label = label;
    }
    return _So2Label;
}


- (UILabel *)No2Label {
    if (!_No2Label) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.f];
        _No2Label = label;
    }
    
    return _No2Label;
}

- (UILabel *)CoLabel {
    if (!_CoLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.f];
        _CoLabel     =label;
    }
    return _CoLabel;
}

- (UILabel *)O3Label {
    if (!_O3Label) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.f];
        _O3Label  = label;
    }
    return _O3Label;
}

- (void)configAqiModel:(WLXinzhiAqiModel *)model {
    
    NSString *value = [NSString stringWithFormat:@"%@ %@",model.aqi,model.aqiGrade];
    _valueLabel.backgroundColor = model.valueColor;
    _valueLabel.text = value;
    
    [self.valueLabel mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLabel.mas_right).offset(5);
        make.centerY.equalTo(self.titleLabel);
        make.height.equalTo(@18);
        make.width.equalTo(@(value.length*14+10));
    }];
    
    [self configTitle:@"PM2.5 " value:model.pm25 label:self.Pm25Label];
    [self configTitle:@"PM10 " value:model.pm10 label:self.Pm10Label];
    [self configTitle:@"SO2 " value:model.so2 label:self.So2Label];
    [self configTitle:@"NO2 " value:model.no2 label:self.No2Label];
    [self configTitle:@"CO " value:model.co label:self.CoLabel];
    [self configTitle:@"O3 " value:model.o3 label:self.O3Label];
    
    
    
    
    
   
    
}

- (void)configTitle:(NSString *)title value:(NSString *)value label:(UILabel *)label {
    
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:title attributes:self.titleAttrsDict];
    NSAttributedString *valueAttrs = [[NSAttributedString alloc] initWithString:value attributes:self.valueAttrsDict];
    [attrs appendAttributedString:valueAttrs];
    label.attributedText = attrs;
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
