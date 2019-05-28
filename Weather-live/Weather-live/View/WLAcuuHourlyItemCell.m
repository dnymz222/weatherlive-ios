//
//  WLAcuuHourlyItemCell.m
//  Weather-live
//
//  Created by xueping on 2019/5/22.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAcuuHourlyItemCell.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "WLAccuHourlyModel.h"
#import "FIshUnitTransTool.h"

@interface WLAcuuHourlyItemCell ()

@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel *tempratureLabel;

@property(nonatomic,strong)UIImageView *windIconView;

@property(nonatomic,strong)UILabel *windLabel;
@property(nonatomic,strong)UILabel *pricipeLabel;




@end

@implementation WLAcuuHourlyItemCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.tempratureLabel];
        [self.contentView addSubview:self.windIconView];
        [self.contentView addSubview:self.windLabel];
        [self.contentView addSubview:self.pricipeLabel];
       // self.userInteractionEnabled  = NO;
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(@16);
        }];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        
        [self.tempratureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.iconView.mas_bottom).offset(6);
            make.height.equalTo(@16);
        }];
        
        [self.windIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView  ).offset(8);
            make.top.equalTo(self.tempratureLabel.mas_bottom).offset(5);
            make.height.equalTo(@16);
            make.width.equalTo(@16);
        }];
        
        [self.windLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.windIconView.mas_right).offset(2);
            make.right.equalTo(self.contentView).offset(-5);
            make.height.equalTo(@16);
            make.centerY.equalTo(self.windIconView);
        }];
        
        [self.pricipeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.windLabel.mas_bottom).offset(8);
            make.height.equalTo(@16);
            make.left.right.equalTo(self.contentView);
            
        }];
        
        
     
        
     
        
    }
    
    return self;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        _timeLabel.font = [UIFont systemFontOfSize:14.f];
        _timeLabel.textColor = UIColorFromRGB(0x666666);
        
    }
    
    return _timeLabel;
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
        _tempratureLabel.textColor = UIColorFromRGB(0x666666);
        _tempratureLabel.font = [UIFont systemFontOfSize:14.f];
    }
    
    return _tempratureLabel;
}

- (UILabel *)windLabel {
    if (!_windLabel) {
        _windLabel = [[UILabel alloc] init];
        _windLabel.textAlignment = NSTextAlignmentLeft;
        _windLabel.font = [UIFont systemFontOfSize:14.f];
        _windLabel.textColor = UIColorFromRGB(0x666666);
    }
    
    return _windLabel;
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

- (UILabel *)pricipeLabel {
    
    if (!_pricipeLabel) {
        _pricipeLabel = [[UILabel alloc] init];
        _pricipeLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _pricipeLabel;
}

- (void)configHourlyModel:(WLAccuHourlyModel *)model {
    
    self.timeLabel.text = [model.DateTime substringWithRange:NSMakeRange(11, 5)];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%02d",model.WeatherIcon]];
    [self.iconView setImage:image];
    NSDictionary *temperatureDict = model.Temperature;
    float temperature = [FIshUnitTransTool nieshitransfromhuashi:[temperatureDict[@"Value"] floatValue] ];
    self.tempratureLabel.text = [NSString stringWithFormat:@"%0.1f°C",temperature];
    
    NSDictionary  *direction = (NSDictionary*)model.Wind[@"Direction"];
    float degrees = [[direction valueForKey:@"Degrees"] floatValue];
//    NSString *DirectionLoclized = [direction valueForKey:@"Localized"];
    
    NSDictionary *speed  = (NSDictionary *)model.Wind[@"Speed"];
    
    float speedvalue =[FIshUnitTransTool meterpersecondfromnileperhour:[[speed valueForKey:@"Value"] floatValue]];
    
    
//    NSString *speedunit = [speed valueForKey:@"Unit"];
    self.windIconView.transform = CGAffineTransformIdentity;
    float radians = (degrees-45)/180.0*M_PI;
    self.windIconView.transform = CGAffineTransformMakeRotation(radians);
    self.windLabel.text = [NSString stringWithFormat:@"%0.1f m/s",speedvalue];
    

    NSDictionary *attrsDict = @{NSForegroundColorAttributeName:UIColorFromRGB(0x666666),
                                NSFontAttributeName:[UIFont systemFontOfSize:14.f],
                                NSBaselineOffsetAttributeName:@(2)
                                };
    NSMutableAttributedString *attrs = [[NSMutableAttributedString alloc] initWithString:@"" attributes:attrsDict];
    NSTextAttachment    *attach = [[NSTextAttachment alloc] init];
    attach.image = [UIImage imageNamed:@"rain_probability"];
    attach.bounds = CGRectMake(0, 0, 15, 15);
    NSAttributedString *attachattrs = [NSAttributedString attributedStringWithAttachment:attach];
    [attrs appendAttributedString:attachattrs];
    NSString *pricipestring  =[NSString stringWithFormat:@"%d%@",model.PrecipitationProbability,@"%"];
    NSAttributedString *pricipeattrs = [[NSAttributedString alloc] initWithString:pricipestring attributes:attrsDict];
    [attrs appendAttributedString:pricipeattrs];
    self.pricipeLabel.attributedText = attrs;
    
    
    
    
}



@end
