//
//  LBNetworkBijiHandler.h
//  lamabiji
//
//  Created by mc on 2018/9/13.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLNetworkBaseHandler.h"

@interface WLNetworkFirstHandler : NSObject













+ (void)acuuloctationKeyWithparamater:(NSDictionary *)paramaters
                              success:(LBSuccessBlock)successBlock
                               failed:(LBFailedBlock)failedBlock;


+ (void)acuuWeatherWithparamater:(NSDictionary *)paramaters
                         success:(LBSuccessBlock)successBlock
                          failed:(LBFailedBlock)failedBlock;

+ (void)accuCurrentWithparamater:(NSDictionary *)paramaters
                         success:(LBSuccessBlock)successBlock
                          failed:(LBFailedBlock)failedBlock;



+ (void)accuHourlyWithparamater:(NSDictionary *)paramaters
                        success:(LBSuccessBlock)successBlock
                         failed:(LBFailedBlock)failedBlock;

+ (void)accuIndexWithparamater:(NSDictionary *)paramaters
                       success:(LBSuccessBlock)successBlock
                        failed:(LBFailedBlock)failedBlock;

+ (void)accuAlarmsWithparamater:(NSDictionary *)paramaters
                        success:(LBSuccessBlock)successBlock
                         failed:(LBFailedBlock)failedBlock;

+ (void)accuRadarWithparamater:(NSDictionary *)paramaters
                       success:(LBSuccessBlock)successBlock
                        failed:(LBFailedBlock)failedBlock;

+ (void)xinzhiAqiWithparamater:(NSDictionary *)paramaters
                       success:(LBSuccessBlock)successBlock
                        failed:(LBFailedBlock)failedBlock;





@end
