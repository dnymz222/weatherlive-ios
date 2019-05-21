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

@end

@implementation STAcuuWeatherHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.tempratureIconView];
        [self.contentView addSubview:self.tempratureLabel];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@160);
            make.height.equalTo(@20);
        }];
        
        
        [self.tempratureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@20);
            make.width.equalTo(@100);
        }];
        
        
        
        [self.tempratureIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.tempratureLabel.mas_left).offset(-2);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@20);
            make.width.equalTo(@20);
        }];
        
        
        
    }
    
    return self;
}


- (UILabel *)timeLabel {
    
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorFromRGB(Themecolor);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:14.f];
        
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



- (void)configWithModel:(STAcuuWeatherDailyModel *)model {
    
    self.timeLabel.text = [model.Date substringToIndex:10];
    NSDictionary *maxtemperatureDict = [model.Temperature valueForKey:@"Maximum"];
    NSDictionary *mintemperatureDict = [model.Temperature  valueForKey:@"Minimum"];
    
    self.tempratureLabel.text = [NSString stringWithFormat:@"%@ %@-%@ %@",mintemperatureDict[@"Value"],mintemperatureDict[@"Unit"],maxtemperatureDict[@"Value"],maxtemperatureDict[@"Unit"]];
    
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
