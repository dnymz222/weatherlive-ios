//
//  STAcuuWeatherDailyModel.h
//  Solunar Tides
//
//  Created by xueping on 2019/5/18.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "STAcuuDayAndNightModel.h"

NS_ASSUME_NONNULL_BEGIN


@interface STAcuuWeatherDailyModel : NSObject

@property(nonatomic,copy)NSDictionary *Temperature;
@property(nonatomic,copy)NSDictionary *Sun;
@property(nonatomic,copy)NSDictionary *RealFeelTemperature;
@property(nonatomic,copy)NSDictionary *Moon;
@property(nonatomic,copy)NSDictionary *Sources;
@property(nonatomic,copy)NSDictionary *DegreeDaySummary;
@property(nonatomic,copy)NSString *Link;
@property(nonatomic,copy)NSDictionary *AirAndPollen;
@property(nonatomic,copy)NSDictionary *HoursOfSun;
@property(nonatomic,strong)STAcuuDayAndNightModel *Night;
@property(nonatomic,copy)NSString *Date;
@property(nonatomic,copy)NSDictionary *RealFeelTemperatureShade;
@property(nonatomic,assign)NSInteger EpochDate;
@property(nonatomic,copy)NSString *MobileLink;
@property(nonatomic,strong)STAcuuDayAndNightModel *Day;




@end

NS_ASSUME_NONNULL_END
