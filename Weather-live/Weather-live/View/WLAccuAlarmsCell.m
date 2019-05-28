//
//  WLAccuAlarmsCell.m
//  Weather-live
//
//  Created by xueping on 2019/5/24.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAccuAlarmsCell.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "WLAccuAlarmsModel.h"

@interface WLAccuAlarmsCell ()

@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UILabel *timeLabel;

@end

@implementation WLAccuAlarmsCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.typeLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@20);
        }];
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@20);
        }];
        
        
    }
    return self;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorFromRGB(Themecolor);
        _timeLabel.font = [UIFont systemFontOfSize:16.f];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
        
    }
    
    
    return _timeLabel;
    
}


- (UILabel *)typeLabel {
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.textAlignment = NSTextAlignmentLeft;
        _typeLabel.textColor = UIColorFromRGB(0x666666);
        _typeLabel.font = [UIFont systemFontOfSize:14.f];
    }
    
    return _typeLabel;
}




- (void)configAlarms:(WLAccuAlarmsModel *)alarms {
    
    self.timeLabel.text = alarms.Date;
    self.typeLabel.text = [alarms.Alarms valueForKey:@"AlarmType"];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
