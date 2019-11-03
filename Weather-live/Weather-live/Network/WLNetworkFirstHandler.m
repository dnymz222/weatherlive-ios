//
//  LBNetworkBijiHandler.m
//  lamabiji
//
//  Created by mc on 2018/9/13.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "WLNetworkFirstHandler.h"




#define weatherPath  @"/weather"
#define waterPath  @"/water"

#define acuu_locationkey_path @"/acuu/loctionkey"
#define acuu_weather_apth @"/acuu/weather"
#define acuu_cuurrent_apth @"/acuu/current"
#define acuu_hourly_path @"/acuu/hourly"
#define acuu_index_path @"/acuu/index"
#define acuu_alarms_path @"/acuu/alarms"
#define acuu_radar_path @"/acuu/radar"
#define xinzhi_aqi_path @"/xinzhi/aqi"



@implementation WLNetworkFirstHandler












+ (void)fishWeatherWithparamater:(NSDictionary *)paramaters
                      success:(LBSuccessBlock)successBlock
                          failed:(LBFailedBlock)failedBlock

{
    [WLNetworkBaseHandler sendGetRequestWithPath:weatherPath
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               
                                               successBlock(response,data);
        
    }
                                            failed:^(NSError *error) {
                                                failedBlock(error);
    }];
    
    
    
    
}


+ (void)getWaterWithparamater:(NSDictionary *)paramaters
                      success:(LBSuccessBlock)successBlock
                       failed:(LBFailedBlock)failedBlock
{
    [WLNetworkBaseHandler sendGetRequestWithPath:waterPath
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                failedBlock(error);
                                            }];
    
}

+ (void)acuuloctationKeyWithparamater:(NSDictionary *)paramaters
                              success:(LBSuccessBlock)successBlock
                               failed:(LBFailedBlock)failedBlock
{
    [WLNetworkBaseHandler sendGetRequestWithPath:acuu_locationkey_path
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                failedBlock(error);
                                            }];
    
}


+ (void)acuuWeatherWithparamater:(NSDictionary *)paramaters
                         success:(LBSuccessBlock)successBlock
                          failed:(LBFailedBlock)failedBlock
{
    [WLNetworkBaseHandler sendGetRequestWithPath:acuu_weather_apth
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                failedBlock(error);
                                            }];
    
}

+ (void)accuCurrentWithparamater:(NSDictionary *)paramaters
                         success:(LBSuccessBlock)successBlock
                          failed:(LBFailedBlock)failedBlock
{
    [WLNetworkBaseHandler sendGetRequestWithPath:acuu_cuurrent_apth
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                failedBlock(error);
                                            }];
    
}

+ (void)accuHourlyWithparamater:(NSDictionary *)paramaters
                         success:(LBSuccessBlock)successBlock
                          failed:(LBFailedBlock)failedBlock
{
    [WLNetworkBaseHandler sendGetRequestWithPath:acuu_hourly_path
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                failedBlock(error);
                                            }];
    
}

+ (void)accuIndexWithparamater:(NSDictionary *)paramaters
                        success:(LBSuccessBlock)successBlock
                         failed:(LBFailedBlock)failedBlock
{
    [WLNetworkBaseHandler sendGetRequestWithPath:acuu_index_path
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                failedBlock(error);
                                            }];
    
}

+ (void)accuAlarmsWithparamater:(NSDictionary *)paramaters
                       success:(LBSuccessBlock)successBlock
                        failed:(LBFailedBlock)failedBlock
{
    [WLNetworkBaseHandler sendGetRequestWithPath:acuu_alarms_path
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                failedBlock(error);
                                            }];
    
}


+ (void)accuRadarWithparamater:(NSDictionary *)paramaters
                        success:(LBSuccessBlock)successBlock
                         failed:(LBFailedBlock)failedBlock
{
    [WLNetworkBaseHandler sendGetRequestWithPath:acuu_radar_path
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                failedBlock(error);
                                            }];
    
}

+ (void)xinzhiAqiWithparamater:(NSDictionary *)paramaters
                       success:(LBSuccessBlock)successBlock
                        failed:(LBFailedBlock)failedBlock
{
    [WLNetworkBaseHandler sendGetRequestWithPath:xinzhi_aqi_path
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                failedBlock(error);
                                            }];
    
}

















@end
