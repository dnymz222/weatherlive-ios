//
//  STSolunarTidesHandler.m
//  Solunar Tides
//
//  Created by xueping on 2019/5/13.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLWeatherLocationHandler.h"


#import "STLocationModel.h"

@implementation WLWeatherLocationHandler


+ (WLWeatherLocationHandler *)sharehanlder {
    static WLWeatherLocationHandler *handler;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[WLWeatherLocationHandler alloc] init];
    });
    
    return handler;
    
}




@end
