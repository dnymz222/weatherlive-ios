//
//  STAcuuWeatherDailyCell.m
//  Solunar Tides
//
//  Created by xueping on 2019/5/18.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "STAcuuWeatherDailyCell.h"
#import "STAcuuWeatherDailyModel.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "WLUnitTransTool.h"




@interface STAcuuWeatherDailyCell ()


@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *iconView;
@property(nonatomic,strong)UILabel *phraseLabel;
@property(nonatomic,strong)UIImageView *cloudCoverIconView;
@property(nonatomic,strong)UILabel *cloudCoverLabel;
@property(nonatomic,strong)UIImageView *windIconView;
@property(nonatomic,strong)UILabel *windLabel;
@property(nonatomic,strong)UIImageView *probabilityIconview;
@property(nonatomic,strong)UILabel *probilityLabel;
@property(nonatomic,strong)UIImageView *itensityIconView;
@property(nonatomic,strong)UILabel *intensityLabel;






@end

@implementation STAcuuWeatherDailyCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier   {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.phraseLabel];
        [self.contentView addSubview:self.cloudCoverIconView];
        [self.contentView addSubview:self.cloudCoverLabel];
        [self.contentView addSubview:self.windIconView];
        [self.contentView addSubview:self.windLabel];
        [self.contentView addSubview:self.probabilityIconview];
        [self.contentView addSubview:self.probilityLabel];
        [self.contentView addSubview:self.itensityIconView];
        [self.contentView addSubview:self.intensityLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(@15);
            make.width.equalTo(@120);
        }];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
            make.width.equalTo(@50);
            make.height.equalTo(@30);
        }];
        
        
        [self.phraseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.iconView);
            make.left.equalTo(self.iconView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-110);
            make.height.equalTo(@40);
        }];
        
        [self.cloudCoverIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-72);
            make.centerY.equalTo(self.iconView);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [self.cloudCoverLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.iconView);
            make.width.equalTo(@60);
            make.height.equalTo(@20);
        }];
        
        [self.windIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView);
            make.top.equalTo(self.iconView.mas_bottom).offset(10);
            make.width.equalTo(@15);
            make.height.equalTo(@15);
        }];
        [self.windLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.windIconView.mas_right).offset(2);
            make.centerY.equalTo(self.windIconView);
            make.height.equalTo(@20);
            make.width.equalTo(@140);
        }];
        
        [self.probabilityIconview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.windIconView);
            make.left.equalTo(self.contentView.mas_centerX).offset(-2);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [self.probilityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.windIconView);
            make.left.equalTo(self.probabilityIconview.mas_right).offset(2);
            make.width.equalTo(@100);
            make.height.equalTo(@20);
        }];
        
        [self.itensityIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.windIconView);
            make.right.equalTo(self.contentView).offset(-72);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [self.intensityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.windIconView);
            make.right.equalTo(self.contentView).offset(-10);
            make.width.equalTo(@60);
            make.height.equalTo(@20);
        }];
        
    }
    
    return self;
    
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorFromRGB(Themecolor);
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        _timeLabel.font = [UIFont systemFontOfSize:12.f];
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

- (UILabel *)phraseLabel {
    
    if (!_phraseLabel) {
        _phraseLabel = [[UILabel alloc] init];
        _phraseLabel.textAlignment = NSTextAlignmentLeft;
        _phraseLabel.textColor = UIColorFromRGB(0x666666);
        _phraseLabel.font = [UIFont systemFontOfSize:14.f];
        _phraseLabel.numberOfLines = 2;
        _phraseLabel.adjustsFontSizeToFitWidth = YES;
        
    }
    
    return _phraseLabel;
}


- (UIImageView *)cloudCoverIconView {
    
    if (!_cloudCoverIconView) {
        _cloudCoverIconView = [[UIImageView alloc] init];
        _cloudCoverIconView.contentMode = UIViewContentModeScaleAspectFit;
        UIImage *image = [UIImage imageNamed:@"cloudCover"];
        [_cloudCoverIconView setImage:image];
    }
    
    return _cloudCoverIconView;
    
}


- (UILabel *)cloudCoverLabel {
    if (!_cloudCoverLabel) {
        _cloudCoverLabel = [[UILabel alloc] init];
        _cloudCoverLabel.textAlignment = NSTextAlignmentLeft;
        _cloudCoverLabel.font = [UIFont systemFontOfSize:14.f];
        _cloudCoverLabel.textColor = UIColorFromRGB(0x666666);
    }
    
    return _cloudCoverLabel;
}


- (UIImageView *)windIconView {
    
    if (!_windIconView) {
        _windIconView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"winddirection"];
        [_windIconView setImage:image];
    }
    
    return _windIconView;
}

- (UILabel *)windLabel {
    if (!_windLabel) {
        _windLabel = [[UILabel alloc] init];
        _windLabel.textAlignment =  NSTextAlignmentLeft;
        _windLabel.textColor = UIColorFromRGB(0x666666);
        _windLabel.font = [UIFont systemFontOfSize:14.f];
    }
    
    return _windLabel;
}

- (UIImageView *)probabilityIconview {
    if (!_probabilityIconview) {
        _probabilityIconview = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"rain_probability"];
        [_probabilityIconview setImage:image];
    }
    
    return _probabilityIconview;
}

- (UILabel *)probilityLabel {
    
    if (!_probilityLabel) {
        _probilityLabel = [[UILabel alloc] init];
        _probilityLabel.textColor = UIColorFromRGB(0x666666);
        _probilityLabel.font = [UIFont systemFontOfSize:14.f];
        _probilityLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _probilityLabel;
    
}

- (UIImageView *)itensityIconView {
    
    if (!_itensityIconView) {
        _itensityIconView = [[UIImageView alloc] init];
        UIImage *image = [ UIImage imageNamed:@"rain_intensity"];
        [_itensityIconView setImage:image];
    }
    
    return _itensityIconView;
    
}


- (UILabel *)intensityLabel {
    
    if (!_intensityLabel) {
        _intensityLabel = [[UILabel alloc] init];
        _intensityLabel.textAlignment = NSTextAlignmentLeft;
        _intensityLabel.textColor = UIColorFromRGB(0x666666);
        _intensityLabel.font = [UIFont systemFontOfSize:14.f];
    }
    
    return _intensityLabel;
    
}

- (void)configModel:(STAcuuWeatherDailyModel *)model day:(BOOL)isDay {
    
    STAcuuDayAndNightModel *weatherModel = isDay?model.Day:model.Night;
    [self.iconView setImage:[UIImage imageNamed:[NSString stringWithFormat:@"%02d",weatherModel.Icon]]];
    self.phraseLabel.text = weatherModel.LongPhrase;
    self.cloudCoverLabel.text = [NSString stringWithFormat:@"%d%@",weatherModel.CloudCover,@"%"];
    
    
    NSDictionary  *direction = (NSDictionary*)weatherModel.Wind[@"Direction"];
    float degrees = [[direction valueForKey:@"Degrees"] floatValue];
    NSString *DirectionLoclized = [direction valueForKey:@"Localized"];
    
    NSDictionary *speed  = (NSDictionary *)weatherModel.Wind[@"Speed"];
    
    float speedvalue =[[speed valueForKey:@"Value"] floatValue];
    
    
    NSString *speedunit = [speed valueForKey:@"Unit"];
    self.windIconView.transform = CGAffineTransformIdentity;
    float radians = (degrees-45)/180.0*M_PI;
    self.windIconView.transform = CGAffineTransformMakeRotation(radians);
    self.windLabel.text = [NSString stringWithFormat:@"%@ %0.1f %@",DirectionLoclized,speedvalue,speedunit];
    
    self.probilityLabel.text = [NSString stringWithFormat:@"%d%@",weatherModel.RainProbability,@"%"];
    
    
    NSDictionary *totoalliquid = weatherModel.TotalLiquid;
    float intensity = [totoalliquid[@"Value"] floatValue];
    self.intensityLabel.text = [NSString stringWithFormat:@"%0.1f %@",intensity,totoalliquid[@"Unit"]];

    self.timeLabel.text = isDay?NSLocalizedString(@"day", nil):NSLocalizedString(@"night", nil);
    
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
