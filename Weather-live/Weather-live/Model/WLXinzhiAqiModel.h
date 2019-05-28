//
//  WLXinzhiAqiModel.h
//  Weather-live
//
//  Created by xueping on 2019/5/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,WLXinzhiAqiType) {
    WLXinzhiAqiTypeExcellent,
    WLXinzhiAqiTypeGood,
    WLXinzhiAqiTypeMild,
    WLXinzhiAqiTypeModerate,
    WLXinzhiAqiTypeSevere,
    WLXinzhiAqiTypeSerious,
    
    
};


@interface WLXinzhiAqiModel : NSObject

@property(nonatomic,copy)NSString *co;
@property(nonatomic,copy)NSString *pm10;
@property(nonatomic,copy)NSString *o3;
@property(nonatomic,copy)NSString *quality;
@property(nonatomic,copy)NSString *last_update;
@property(nonatomic,copy)NSString *so2;
@property(nonatomic,copy)NSString *pm25;
@property(nonatomic,copy)NSString *aqi;
@property(nonatomic,copy)NSString *primary_pollutant;
@property(nonatomic,copy)NSString *no2;

@property(nonatomic,assign)WLXinzhiAqiType type;

@property(nonatomic,copy)NSString *aqiGrade;

@property(nonatomic,strong)UIColor *valueColor;


- (void)calcaulteType;


@end

NS_ASSUME_NONNULL_END
