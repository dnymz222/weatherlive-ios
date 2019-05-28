//
//  WLAccuRadarCell.m
//  Weather-live
//
//  Created by xueping on 2019/5/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAccuRadarCell.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "UIImageView+WebCache.h"
#import "WLAccuuRadarModel.h"
#import "SDWebImageDownloader.h"
#import "SDWebImageManager.h"


@interface WLAccuRadarCell ()

@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UIImageView *radarView;
@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,assign)NSInteger selectIndex;

@property(nonatomic,copy)NSArray *radarArray;

@property(nonatomic,strong)NSConditionLock *lock;
@property(nonatomic,strong)UILabel *timedetaLabel;

@property(nonatomic,strong)UIView *valueView;

@property(nonatomic,assign)CGFloat width;

@property(nonatomic,strong)NSDateFormatter *formatter;

@property(nonatomic,assign)dispatch_queue_t queue;

@property(nonatomic,assign)NSInteger timeinterval;

@end

@implementation WLAccuRadarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.width = [UIScreen mainScreen].bounds.size.width;
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.timedetaLabel];
        [self.contentView addSubview:self.valueView];
        [self.contentView addSubview:self.radarView];
        self.formatter = [[NSDateFormatter alloc] init];
        [self.formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss Z"];
        self.timeinterval  = 0;
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(5);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@20);
        }];
        
        [self.timedetaLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
            make.height.equalTo(@15);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        [self.valueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.timedetaLabel.mas_bottom).offset(5);
            make.height.equalTo(@6);
            make.width.equalTo(@(0));
            
        }];
        
        
        
        [self.radarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(56);
        }];
        
      
        
        
        
    }
    
    return self;
    
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        _timeLabel = [[UILabel alloc] init];
        _timeLabel.textColor = UIColorFromRGB(0x666666);
        _timeLabel.font = [UIFont systemFontOfSize:16.f];
        _timeLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _timeLabel;
}

- (UILabel *)timedetaLabel {
    
    if (!_timedetaLabel) {
        _timedetaLabel = [[UILabel alloc] init];
        _timedetaLabel.textColor = UIColorFromRGB(Themecolor);
        _timedetaLabel.font = [UIFont systemFontOfSize:14.f];
        _timedetaLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    return _timedetaLabel;
    
}


- (UIView *)valueView {
    if (!_valueView) {
        _valueView = [[UIView alloc] init];
        _valueView.backgroundColor = UIColorFromRGB(Themecolor);
    }
    return _valueView;
}


- (UIImageView *)radarView {
    if (!_radarView) {
        _radarView = [[UIImageView alloc] init];
        _radarView.contentMode = UIViewContentModeScaleAspectFill;
    }
    
    return _radarView;
}

- (void)configRadarArray:(NSArray *)radarArray time:(NSInteger)timeinterval {
    if (timeinterval == self.timeinterval) {
        return;
    } else {
        self.timeinterval = timeinterval;
    }
    
    self.radarArray = radarArray;
//    WLAccuuRadarModel *model =radarArray[0];
//    self.timeLabel.text = model.Date;
//    [self.radarView sd_setImageWithURL:[NSURL URLWithString:model.Url]];
    
    self.lock = [[NSConditionLock alloc  ] initWithCondition:0];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self removeTimmer];
        [self addTimer];
    });
    
    
}




- (void)addTimer {
    self.selectIndex = 0;
    [self configSeleIndex:self.selectIndex];
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextpage:) userInfo:nil repeats:YES];
        
        [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
    }
    
}

-(void)removeTimmer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)nextpage:(NSTimer *)timer {
    
    NSInteger selectIndex = self.selectIndex +1;
    self.selectIndex = selectIndex %(self.radarArray.count);
    [self configSeleIndex:self.selectIndex];
    
}

- (void)configSeleIndex:(NSInteger)selectIndex {
    
    
//    WLAccuuRadarModel *model = self.radarArray[selectIndex];
//
//    self.timeLabel.text = model.Date;
//    [self.valueView mas_remakeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.contentView);
//        make.top.equalTo(self.timedetaLabel.mas_bottom).offset(5);
//        make.height.equalTo(@10);
//        make.width.equalTo(@(self.width *((selectIndex+1)/5.0)));
//
//    }];
//
//    NSString *string = [model.Date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
//    string = [string stringByReplacingOccurrencesOfString:@"+" withString:@" +"];
//        NSDate *date= [self.formatter dateFromString:string];
//    NSTimeInterval time= [[NSDate date] timeIntervalSinceDate:date];
//    self.timedetaLabel.text = [NSString stringWithFormat:@"%0.0f分钟前",time/60.0];
//    [self.radarView sd_setImageWithURL:[NSURL URLWithString:model.Url]];
    //
//    
     __weak typeof(self) wself = self;
    
    dispatch_async(dispatch_get_main_queue(), ^{
        
    
        NSInteger index = selectIndex;
//        [wself.lock lockWhenCondition:index];
        WLAccuuRadarModel *model =wself.radarArray[index];
        
        
        [[SDWebImageManager sharedManager].imageDownloader downloadImageWithURL:[NSURL URLWithString:model.Url] options:SDWebImageDownloaderHighPriority|SDWebImageDownloaderUseNSURLCache progress:^(NSInteger receivedSize, NSInteger expectedSize, NSURL * _Nullable targetURL) {
            
        } completed:^(UIImage * _Nullable image, NSData * _Nullable data, NSError * _Nullable error, BOOL finished) {
            
            if (image) {
                
                dispatch_async(dispatch_get_main_queue(), ^{
                    wself.timeLabel.text = model.Date;
                    [wself.valueView mas_remakeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(wself.contentView);
                        make.top.equalTo(wself.timedetaLabel.mas_bottom).offset(5);
                        make.height.equalTo(@6);
                        make.width.equalTo(@(wself.width *((index+1)/5.0)));
                        
                    }];
                    
                    NSString *string = [model.Date stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                    string = [string stringByReplacingOccurrencesOfString:@"+" withString:@" +"];
                        NSDate *date= [wself.formatter dateFromString:string];
                    NSTimeInterval time= [[NSDate date] timeIntervalSinceDate:date];
                    wself.timedetaLabel.text = [NSString stringWithFormat:@"%0.0f分钟前",time/60.0];
                    
                    
                    
                    [wself.radarView setImage:image];
                   
                });
            }
//            dispatch_async(dispatch_get_main_queue(), ^{
//
//                [wself.lock unlockWithCondition:(index+1)%(wself.radarArray.count)];
//
//
//            });
            
        }];
    });
    
  

    
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
