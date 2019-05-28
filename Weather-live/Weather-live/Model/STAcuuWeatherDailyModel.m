//
//  STAcuuWeatherDailyModel.m
//  Solunar Tides
//
//  Created by xueping on 2019/5/18.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "STAcuuWeatherDailyModel.h"
#import "YYModel.h"



@implementation STAcuuWeatherDailyModel

+ (nullable NSDictionary<NSString *, id> *)modelContainerPropertyGenericClass {
    
    return  @{@"night":[STAcuuDayAndNightModel class],
              @"day":[STAcuuDayAndNightModel class]
              };
}




@end
