//
//  WLAccuCurrentCell.m
//  Weather-live
//
//  Created by xueping on 2019/5/22.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAccuCurrentCell.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "WLAccuCurrentModel.h"
#import "WLUnitTransTool.h"

@interface WLAccuCurrentCell ()

@property(nonatomic,strong)UILabel *weathertextLabel;
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel *tempratureLabel;
@property(nonatomic,strong)UILabel *pricipeLabel;
@property(nonatomic,strong)UILabel *uvindexLabel;
@property(nonatomic,strong)UILabel *pressureLabel;
@property(nonatomic,strong)UIImageView *pressureTrendView;
@property(nonatomic,strong)UILabel *humilityLabel;
@property(nonatomic,strong)UIImageView *windIconView;
@property(nonatomic,strong)UILabel *windLabel;

@property(nonatomic,strong)UILabel *dewLabel;




@end

@implementation WLAccuCurrentCell


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        [self.contentView addSubview:self.weathertextLabel];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.tempratureLabel];
        [self.contentView addSubview:self.pricipeLabel];
        [self.contentView addSubview:self.uvindexLabel];
        [self.contentView addSubview:self.humilityLabel];
        [self.contentView addSubview:self.pressureLabel];
//        [self.contentView addSubview:self.pressureTrendView];
        [self.contentView addSubview:self.windIconView];
        [self.contentView addSubview:self.windLabel];
        [self.contentView addSubview:self.dewLabel];
        
        [self.weathertextLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(5);
            make.width.equalTo(@100);
            make.height.equalTo(@32);
        }];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(20);
            make.top.equalTo(self.contentView).offset(40);
            make.height.equalTo(@80);
            make.width.equalTo(@80);
        }];
        
        [self.tempratureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.bottom.equalTo(self.contentView).offset(-5);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        
        [self.pricipeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(60);
            make.top.equalTo(self.contentView).offset(3);
            make.width.equalTo(@160);
            make.height.equalTo(@20);
            
        }];
        
        [self.uvindexLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pricipeLabel);
            make.top.equalTo(self.pricipeLabel.mas_bottom).offset(6);
            make.width.equalTo(@160);
            make.height.equalTo(@20);
            
        }];
        
        [self.humilityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pricipeLabel);
            make.top.equalTo(self.uvindexLabel.mas_bottom).offset(6);
            make.width.equalTo(@120);
            make.height.equalTo(@20);
            
        }];
        
        [self.pressureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pricipeLabel);
            make.top.equalTo(self.humilityLabel.mas_bottom).offset(6);
            make.width.equalTo(@160);
            make.height.equalTo(@20);
            
        }];
        
        [self.windIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pricipeLabel);
            make.top.equalTo(self.pressureLabel.mas_bottom).offset(8.5);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
            
        }];
        
        [self.windLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.windIconView.mas_right).offset(2);
            make.centerY.equalTo(self.windIconView);
            make.width.equalTo(@160);
            make.height.equalTo(@20);
            
        }];
        
        [self.dewLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pricipeLabel);
            make.top.equalTo(self.windLabel.mas_bottom).offset(6);
            make.width.equalTo(@160);
            make.height.equalTo(@20);
        }];
        
        
        
        
        
        
  
        
       
        
        
        
    }
    
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (UILabel *)weathertextLabel {
    
    if (!_weathertextLabel) {
        _weathertextLabel = [[UILabel alloc] init];
        _weathertextLabel.font = [UIFont systemFontOfSize:15.f];
        _weathertextLabel.textColor = UIColorFromRGB(0x666666);
        _weathertextLabel.textAlignment = NSTextAlignmentCenter;
        _weathertextLabel.numberOfLines = 2;
        _weathertextLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    
    return _weathertextLabel;
    
}


- (UIImageView *)iconView {
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _iconView;
    
}

- (UILabel *)tempratureLabel {
    if (!_tempratureLabel) {
        _tempratureLabel = [[UILabel alloc] init];
        _tempratureLabel.textAlignment = NSTextAlignmentCenter;
        _tempratureLabel.font = [UIFont systemFontOfSize:16.f];
        _tempratureLabel.textColor = UIColorFromRGB(0x666666);
    }
    
    return _tempratureLabel;
}


- (UILabel *)pricipeLabel {
    
    if (!_pricipeLabel) {
        _pricipeLabel= [[UILabel alloc] init];
        _pricipeLabel.textAlignment = NSTextAlignmentLeft;
        _pricipeLabel.textColor = UIColorFromRGB(0x666666);
        _pricipeLabel.font = [UIFont systemFontOfSize:14.f];
        
    }
    
    return _pricipeLabel;
    
}


- (UILabel *)uvindexLabel {
    if (!_uvindexLabel) {
        _uvindexLabel = [[UILabel alloc] init];
        _uvindexLabel.textAlignment = NSTextAlignmentLeft;
        _uvindexLabel.textColor = UIColorFromRGB(0x666666);
        _uvindexLabel.font = [UIFont systemFontOfSize:14.f];
        
    }
    
    return _uvindexLabel;
    
}


- (UILabel *)humilityLabel {
    
    if (!_humilityLabel) {
        _humilityLabel = [[UILabel alloc] init];
        _humilityLabel.textColor = UIColorFromRGB(0x666666);
        _humilityLabel.font = [UIFont systemFontOfSize:14.f];
        _humilityLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _humilityLabel;
    
}

- (UILabel *)pressureLabel {
    
    if (!_pressureLabel) {
        _pressureLabel = [[UILabel alloc] init];
        _pressureLabel.textAlignment= NSTextAlignmentLeft;
        _pressureLabel.font = [UIFont systemFontOfSize:14.f];
        _pressureLabel.textColor = UIColorFromRGB(0x666666);
    }
    
    return _pressureLabel;
}

- (UIImageView *)pressureTrendView {
    if (!_pressureTrendView) {
        _pressureTrendView = [[UIImageView alloc] init];
        _pressureTrendView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _pressureTrendView;
}

- (UIImageView *)windIconView {
    if (!_windIconView) {
        _windIconView = [[UIImageView alloc] init];
        _windIconView.contentMode = UIViewContentModeScaleAspectFill;
        UIImage *image = [UIImage imageNamed:@"winddirection"];
        [_windIconView setImage:image];
    }
    return _windIconView;
}


- (UILabel *)windLabel {
    if (!_windLabel) {
        _windLabel = [[UILabel alloc] init];
        _windLabel.textColor = UIColorFromRGB(0x666666);
        _windLabel.textAlignment = NSTextAlignmentLeft;
        _windLabel.font = [UIFont systemFontOfSize:14.f];
    }
    
    return _windLabel;
    
}



- (UILabel *)dewLabel {
    
    if (!_dewLabel) {
        _dewLabel = [[UILabel alloc] init];
        _dewLabel.textAlignment = NSTextAlignmentLeft;
        _dewLabel.font = [UIFont systemFontOfSize:14.f];
        _dewLabel.textColor = UIColorFromRGB(0x666666);
    }
    
    return _dewLabel;
    
}


- (void)configCurrentModel:(WLAccuCurrentModel *)model {
    
    
    self.weathertextLabel.text = model.WeatherText;
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%02d",model.WeatherIcon]];
    [self.iconView setImage:image];
    
    NSDictionary *temparature = model.Temperature;
    NSDictionary *tempmetric = [temparature valueForKey:@"Metric"];
    self.tempratureLabel.text = [NSString stringWithFormat:@"%0.1f°C",[tempmetric[@"Value"] floatValue]];
    
//    NSDictionary *pricipedic = model.Precip1hr;
//    NSDictionary *pricipemetricDict = [pricipedic valueForKey:@"Metric"];
    
    NSDictionary *realfeelTempdict = model.RealFeelTemperature;
    NSDictionary *relafelltempmetric = [realfeelTempdict valueForKey:@"Metric"];
    
    self.pricipeLabel.text =[NSString stringWithFormat:@"体感温度:%0.1f°C",[relafelltempmetric[@"Value"] floatValue]] ;
    
    self.humilityLabel.text = [NSString stringWithFormat:@"湿度:%d%@",model.RelativeHumidity,@"%"];
    
    NSDictionary *presuureDict = model.Pressure;
    NSDictionary *pressureMetricDict = [presuureDict valueForKey:@"Metric"];
    
    NSDictionary *PressureTendencyDict = model.PressureTendency;
    NSDictionary *attrsDict = @{NSFontAttributeName:[UIFont systemFontOfSize:14.f],
                                NSForegroundColorAttributeName:UIColorFromRGB(0x666666)
                                };
    NSString *pressureString = [NSString stringWithFormat:@"大气压:%@ hpa",pressureMetricDict[@"Value"]];
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:pressureString attributes:attrsDict];
    NSString *code = [PressureTendencyDict valueForKey:@"Code"];
    if ([code isEqualToString:@"R"]) {
        
        NSTextAttachment *textattachment = [[NSTextAttachment alloc] init];
        UIImage *image = [UIImage imageNamed:@"pressureasend"];
        textattachment.image = image;
        textattachment.bounds = CGRectMake(0, 0, 15, 15);
        NSAttributedString *attachAttrs = [NSAttributedString attributedStringWithAttachment:textattachment];
        [attrs appendAttributedString:attachAttrs];
        
    } else if([code isEqualToString:@"F"]){
        NSTextAttachment *textattachment = [[NSTextAttachment alloc] init];
        UIImage *image = [UIImage imageNamed:@"pressuredesend"];
        textattachment.image = image;
        textattachment.bounds = CGRectMake(0, 0, 15, 15);
        NSAttributedString *attachAttrs = [NSAttributedString attributedStringWithAttachment:textattachment];
        [attrs appendAttributedString:attachAttrs];
    }
    
    self.pressureLabel.attributedText = attrs;
    
    
    NSDictionary *windDict = model.Wind;
    NSDictionary *windDirectionDict = [windDict valueForKey:@"Direction"];
    NSDictionary *windSpeedDict = [windDict valueForKey:@"Speed"];
    NSDictionary *windSpeedMetricDict = [windSpeedDict valueForKey:@"Metric"];
    NSInteger degree =[ [windDirectionDict valueForKey:@"Degrees"] integerValue];
    NSString *direction = [windDirectionDict valueForKey:@"Localized"];
    
    float radians = (degree-45)/180.0*M_PI;
    self.windIconView.transform = CGAffineTransformMakeRotation(radians);
    float windmerterperhour = [WLUnitTransTool meterpersecondfromkilometerhour:[windSpeedMetricDict[@"Value"] floatValue]];
    
    
    
    self.windLabel.text= [NSString stringWithFormat:@"%@ %0.1f米/秒",direction,windmerterperhour,windSpeedMetricDict[@"Unit"]];
    
    self.uvindexLabel.text = [NSString stringWithFormat:@"紫外线指数:%d",model.UVIndex];
    
    NSDictionary *dewpoint = model.DewPoint;
    NSDictionary *dewpointmetric = [dewpoint valueForKey:@"Metric"];
    self.dewLabel.text = [NSString stringWithFormat:@"露点：%0.1f°C",[dewpointmetric[@"Value"] floatValue]];
    
    
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
