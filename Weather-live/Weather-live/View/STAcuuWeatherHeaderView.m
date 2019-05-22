//
//  STAcuuWeatherHeaderView.m
//  Solunar Tides
//
//  Created by xueping on 2019/5/19.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "STAcuuWeatherHeaderView.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "STAcuuWeatherDailyModel.h"

@interface STAcuuWeatherHeaderView ()

@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *tempratureIconView;
@property(nonatomic,strong)UILabel *tempratureLabel;

@property(nonatomic,strong)UIImageView *sunriseIconView;
@property(nonatomic,strong)UILabel *sunriseLabel;
@property(nonatomic,strong)UIImageView *sunsetIconView;
@property(nonatomic,strong)UILabel *sunsetLabel;
@property(nonatomic,strong)UILabel *pollenLabel;
//@property(nonatomic,strong)UIImageView *moonRiseIconView;
//@property(nonatomic,strong)UILabel *moonRiseLabel;
//@property(nonatomic,strong)UIImageView *moonSetIconView;
//@property(nonatomic,strong)UILabel *moonSetLabel;
//@property(nonatomic,strong)UILabel *moonPhaseLabel;




@end

@implementation STAcuuWeatherHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.tempratureIconView];
        [self.contentView addSubview:self.tempratureLabel];
        [self.contentView addSubview:self.sunriseIconView];
        [self.contentView addSubview:self.sunriseLabel];
        [self.contentView addSubview:self.sunsetIconView];
        [self.contentView addSubview:self.sunsetLabel   ];
        [self.contentView addSubview:self.pollenLabel];
        
//        [self.contentView addSubview:self.moonRiseIconView];
//        [self.contentView addSubview:self.moonRiseLabel];
//        [self.contentView addSubview:self.moonSetIconView];
//        [self.contentView addSubview:self.moonSetLabel];
//        [self.contentView addSubview:self.moonPhaseLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(5);
            make.width.equalTo(@160);
            make.height.equalTo(@20);
        }];
        
        
        [self.tempratureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.timeLabel);
            make.height.equalTo(@20);
            make.width.equalTo(@100);
        }];
        
        
        
        [self.tempratureIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tempratureLabel.mas_left).offset(-2);
            make.centerY.equalTo(self.timeLabel);
            make.height.equalTo(@20);
            make.width.equalTo(@20);
        }];
        
        [self.sunriseIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        [self.sunriseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sunriseIconView.mas_right).offset(5);
            make.centerY.equalTo(self.sunriseIconView);
            make.width.equalTo(@80);
            make.height.equalTo(@20);
        }];
        
        
        [self.sunsetIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sunriseLabel.mas_right).offset(2);
            make.centerY.equalTo(self.sunriseIconView);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [self.sunsetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sunsetIconView.mas_right).offset(5);
            make.centerY.equalTo(self.sunriseIconView);
            make.width.equalTo(@80);
            make.height.equalTo(@20);
        }];
        
        [self.pollenLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sunsetLabel.mas_right).offset(20);
            make.centerY.equalTo(self.sunriseIconView);
            make.width.equalTo(@160);
            make.height.equalTo(@20);
        }];
        
        
        
        
        
        
        
        
        
        
        
        
//        
//        [self.moonRiseIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView).offset(10);
//            make.top.equalTo(self.sunriseIconView.mas_bottom).offset(10);
//            make.width.equalTo(@20);
//            make.height.equalTo(@20);
//        }];
//        
//        [self.moonRiseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.moonRiseIconView.mas_right).offset(5);
//            make.centerY.equalTo(self.moonRiseIconView);
//            make.width.equalTo(@80);
//            make.height.equalTo(@20);
//        }];
//        
//        
//        [self.moonSetIconView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.moonRiseLabel.mas_right).offset(2);
//            make.centerY.equalTo(self.moonRiseIconView);
//            make.width.equalTo(@20);
//            make.height.equalTo(@20);
//        }];
//        
//        [self.moonSetLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.moonSetIconView.mas_right).offset(5);
//            make.centerY.equalTo(self.moonRiseIconView);
//            make.width.equalTo(@80);
//            make.height.equalTo(@20);
//        }];
//        
//        [self.moonPhaseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.moonRiseIconView.mas_right).offset(20);
//            make.centerY.equalTo(self.moonRiseIconView);
//            make.width.equalTo(@100);
//            make.height.equalTo(@20);
//        }];
//        
        
        
        
        
    }
    
    return self;
}


- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorFromRGB(Themecolor);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:16.f];
        
    }
    
    return _timeLabel;
}

- (UIImageView *)tempratureIconView {
    if (!_tempratureIconView) {
        _tempratureIconView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"temprature"];
        [_tempratureIconView setImage:image];
    }
    
    return _tempratureIconView;
    
}

- (UILabel *)tempratureLabel {
    if (!_tempratureLabel) {
        _tempratureLabel = [[UILabel alloc] init];
        _tempratureLabel.textAlignment = NSTextAlignmentLeft;
        _tempratureLabel.textColor = UIColorFromRGB(0x666666);
        _tempratureLabel.font = [UIFont systemFontOfSize:14.f];
    }
    
    return _tempratureLabel;
}

- (UIImageView *)sunriseIconView {
    
    if (!_sunriseIconView) {
        _sunriseIconView = [[UIImageView alloc] init];
        _sunriseIconView.contentMode = UIViewContentModeScaleAspectFill;
        UIImage *image = [UIImage imageNamed:@"sunrise"];
        [_sunriseIconView setImage:image];
    }
    
    return _sunriseIconView;
}


- (UILabel *)sunriseLabel {
    
    if (!_sunriseLabel) {
        _sunriseLabel = [[UILabel alloc] init];
        _sunriseLabel.textAlignment = NSTextAlignmentLeft;
        _sunriseLabel.textColor = UIColorFromRGB(0x666666);
        _sunriseLabel.font = [UIFont systemFontOfSize:14.f];
        
    }
    
    return _sunriseLabel;
}





- (UIImageView *)sunsetIconView {
    if (!_sunsetIconView) {
        _sunsetIconView = [[UIImageView alloc] init];
        _sunsetIconView.contentMode = UIViewContentModeScaleAspectFill;
        UIImage *image = [UIImage imageNamed:@"sunset"];
        [_sunsetIconView setImage:image];
    }
    return _sunsetIconView;
}

- (UILabel *)sunsetLabel {
    
    if (!_sunsetLabel) {
        _sunsetLabel = [[UILabel alloc] init];
        _sunsetLabel.font = [UIFont systemFontOfSize:14.f];
        _sunsetLabel.textColor = UIColorFromRGB(0x666666);
        _sunsetLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _sunsetLabel;
    
}

- (UILabel *)pollenLabel {
    
    if (!_pollenLabel) {
        _pollenLabel = [[UILabel alloc] init];
        _pollenLabel.textColor = UIColorFromRGB(0x666666);
        _pollenLabel.font = [UIFont systemFontOfSize:14.f];
        _pollenLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _pollenLabel;
    
}

//- (UIImageView *)moonRiseIconView {
//    if (!_moonRiseIconView) {
//        _moonRiseIconView = [[UIImageView alloc] init];
//        _moonRiseIconView.contentMode = UIViewContentModeScaleAspectFill;
//        UIImage *image = [UIImage imageNamed:@"moonrise"];
//        [_moonRiseIconView setImage:image];
//
//    }
//
//    return _moonRiseIconView;
//
//}
//
//
//
//- (UILabel *)moonRiseLabel {
//
//    if (!_moonRiseLabel) {
//        _moonRiseLabel = [[UILabel alloc] init];
//        _moonRiseLabel.textAlignment = NSTextAlignmentLeft;
//        _moonRiseLabel.textColor = UIColorFromRGB(0x666666);
//        _moonRiseLabel.font = [UIFont systemFontOfSize:14.f];
//    }
//
//    return _moonRiseLabel;
//
//}
//
//
//
//
//
//- (UIImageView *)moonSetIconView {
//
//    if (!_moonSetIconView) {
//        _moonSetIconView = [[UIImageView alloc] init];
//        _moonSetIconView.contentMode = UIViewContentModeScaleAspectFill;
//        UIImage *image = [UIImage imageNamed:@"moonset"];
//        [_moonSetIconView setImage:image];
//    }
//    return _moonSetIconView;
//}
//
//
//- (UILabel *)moonSetLabel {
//
//    if (!_moonSetLabel) {
//        _moonSetLabel = [[UILabel alloc] init];
//        _moonSetLabel.textAlignment = NSTextAlignmentLeft;
//        _moonSetLabel.font  = [ UIFont systemFontOfSize:14.f];
//        _moonSetLabel.textColor = UIColorFromRGB(0x666666);
//    }
//
//    return _moonSetLabel;
//
//}
//
//
//- (UILabel *)moonPhaseLabel {
//
//    if (!_moonPhaseLabel) {
//        _moonPhaseLabel = [[UILabel alloc] init];
//        _moonPhaseLabel.textAlignment = NSTextAlignmentLeft;
//        _moonPhaseLabel.font = [UIFont systemFontOfSize:14.f];
//        _moonPhaseLabel.textColor = UIColorFromRGB(0x666666);
//
//    }
//
//    return _moonPhaseLabel;
//}





- (void)configWithModel:(STAcuuWeatherDailyModel *)model {
    
    self.timeLabel.text = [model.Date substringToIndex:10];
    NSDictionary *maxtemperatureDict = [model.Temperature valueForKey:@"Maximum"];
    NSDictionary *mintemperatureDict = [model.Temperature  valueForKey:@"Minimum"];
    
    self.tempratureLabel.text = [NSString stringWithFormat:@"%@ %@-%@ %@",mintemperatureDict[@"Value"],mintemperatureDict[@"Unit"],maxtemperatureDict[@"Value"],maxtemperatureDict[@"Unit"]];
    
    NSDictionary *sundict = model.Sun;
    
    NSString *sunrise = [sundict valueForKey:@"Rise"];
    if (sunrise && [sunrise isKindOfClass:[NSString class]]) {
        sunrise = [sunrise   substringWithRange:NSMakeRange(11, 5)];
        self.sunriseLabel.text = sunrise;
        
    } else {
        self.sunriseLabel.text =@"无";
    }
    
    NSString *sunset = [sundict valueForKey:@"Set"];
    if (sunset && [sunset isKindOfClass:[NSString class]]) {
        sunset = [sunset substringWithRange:NSMakeRange(11, 5)];
        self.sunsetLabel.text = sunset;
        
    } else {
        self.sunsetLabel.text =@"无";
    }
    
    NSArray *airpollen = model.AirAndPollen;
    
    NSPredicate *prdicate = [NSPredicate predicateWithFormat:@"CategoryValue=%d",5];
    
    NSArray *pollen = [airpollen filteredArrayUsingPredicate:prdicate];
    if (pollen && pollen.count) {
        NSDictionary *pollendict = [pollen firstObject];
        
        self.pollenLabel.text = [NSString stringWithFormat:@"紫外线指数:%@(%@)",pollendict[@"Value"],pollendict[@"Category"]];
    } else {
        self.pollenLabel.text = @"";
    }
    
    
    
//    NSDictionary *moonDict = model.Moon;
//
//    NSString *moonrise = [moonDict valueForKey:@"Rise"];
//    if (moonrise  && [moonrise isKindOfClass:[NSString class]]) {
//        moonrise = [moonrise   substringWithRange:NSMakeRange(11, 5)];
//        self.moonRiseLabel.text = moonrise;
//
//    } else {
//        self.moonRiseLabel.text =@"无";
//    }
//
//    NSString *moonset = [moonDict valueForKey:@"Set"];
//    if (moonset && [moonset isKindOfClass:[NSString class]]) {
//        moonset = [moonset substringWithRange:NSMakeRange(11, 5)];
//        self.moonSetLabel.text = moonset;
//
//    } else {
//        self.moonSetLabel.text =@"无";
//    }
//
    
    
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
