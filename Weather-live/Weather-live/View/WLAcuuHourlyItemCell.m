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

@interface WLAcuuHourlyItemCell ()

@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel *tempratureLabel;


@end

@implementation WLAcuuHourlyItemCell


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.tempratureLabel];
       // self.userInteractionEnabled  = NO;
        
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(@20);
        }];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        
        [self.tempratureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView).offset(-5);
            make.height.equalTo(@20);
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

- (void)configHourlyModel:(WLAccuHourlyModel *)model {
    
    self.timeLabel.text = [model.DateTime substringWithRange:NSMakeRange(11, 5)];
    UIImage *image = [UIImage imageNamed:[NSString stringWithFormat:@"%02d",model.WeatherIcon]];
    [self.iconView setImage:image];
    NSDictionary *temperatureDict = model.Temperature;
    self.tempratureLabel.text = [NSString stringWithFormat:@"%@%@",temperatureDict[@"Value"],temperatureDict[@"Unit"]];
    
    
    
    
    
}



@end
