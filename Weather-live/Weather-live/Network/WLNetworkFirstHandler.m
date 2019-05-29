//
//  LBNetworkBijiHandler.m
//  lamabiji
//
//  Created by mc on 2018/9/13.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "WLNetworkFirstHandler.h"


#define xunquanlamaCatPath @"/fish/cate"
#define xunquancatepath @"/xunquan/cate"
#define lamacatePath @"/lama/cate"
#define configPath @"/xunquan/config"
#define searchCheckPath @"/lama/search/check"
#define searchHintPath @"/xunquan/search/hint"
#define lamasearchPath @"/lama/search"
#define xunquansearhPath @"/xunquan/search"
#define lamaconfigPath  @"/lama/new/item/config"
#define lamaratePath @"/xunquan/detail/rate"
#define lamaimagetranspath @"/xunquan/image/trans"
#define xunquanbannerpath @"/xunquan/banner"
#define xunquansearchcheckpath @"/xunquan/search/check"
#define xunquancolumnpath @"/xunquan/column"

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


+ (void)fishcateWithparamater:(NSDictionary *)paramaters
                      success:(LBSuccessBlock)successBlock
                       failed:(LBFailedBlock)failedBlock
{
    
    [WLNetworkBaseHandler sendGetRequestWithPath:xunquanlamaCatPath
                                       paramater:paramaters
                                         success:^(NSURLResponse *response, id data) {
                                             successBlock(response,data);
    
                                         }
                                          failed:^(NSError *error) {
        
                                              failedBlock(error);
                                          }];
    
    
    
}


+ (void)xunquancateWithparamater:(NSDictionary *)paramaters
                      success:(LBSuccessBlock)successBlock
                       failed:(LBFailedBlock)failedBlock
{
    
    [WLNetworkBaseHandler sendGetRequestWithPath:xunquancatepath
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                
                                                failedBlock(error);
                                            }];
    
    
    
}

+ (void)xunquanbannerWithparamater:(NSDictionary *)paramaters
                         success:(LBSuccessBlock)successBlock
                          failed:(LBFailedBlock)failedBlock
{
    
    [WLNetworkBaseHandler sendGetRequestWithPath:xunquanbannerpath
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                
                                                failedBlock(error);
                                            }];
    
    
    
}


+ (void)xunquancolumnWithparamater:(NSDictionary *)paramaters
                           success:(LBSuccessBlock)successBlock
                            failed:(LBFailedBlock)failedBlock
{
    
    [WLNetworkBaseHandler sendGetRequestWithPath:xunquancolumnpath
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                
                                                failedBlock(error);
                                            }];
    
    
    
}







+ (void)xunquancatCouponWithPath:(NSString *)urlpath
                    paramater:(NSDictionary *)paramaters
                      success:(LBSuccessBlock)successBlock
                       failed:(LBFailedBlock)failedBlock
{
    
    [WLNetworkBaseHandler sendGetRequestWithPath:urlpath
                                       paramater:paramaters
                                         success:^(NSURLResponse *response, id data) {
                                             
                                             successBlock(response,data);
  
                                         }
                                          failed:^(NSError *error) {
        
                                              failedBlock(error);
                                          }];
    
    
    
}

+ (void)xunquansearchCheckWithparamater:(NSDictionary *)paramaters
                         success:(LBSuccessBlock)successBlock
                          failed:(LBFailedBlock)failedBlock
{
    
    [WLNetworkBaseHandler sendGetRequestWithPath:xunquansearchcheckpath
                                         paramater:paramaters
                                           success:^(NSURLResponse *response, id data) {
                                               successBlock(response,data);
                                               
                                           }
                                            failed:^(NSError *error) {
                                                
                                                failedBlock(error);
                                            }];
    
}

//+ (void)lamacateBabyWithPath:(NSString *)urlpath
//                    paramater:(NSDictionary *)paramaters
//                      success:(LBSuccessBlock)successBlock
//                       failed:(LBFailedBlock)failedBlock
//{
//
//    [FishNetworkBaseHandler sendGetRequestWithPath:urlpath
//                                       paramater:paramaters
//                                         success:^(NSURLResponse *response, id data) {
//
//                                             successBlock(response,data);
//
//                                         }
//                                          failed:^(NSError *error) {
//
//                                              failedBlock(error);
//                                          }];
//
//
//
//}


//+ (void)lamacategoryWithparamater:(NSDictionary*)paramaters
//                          success:(LBSuccessBlock)successBlock
//                           failed:(LBFailedBlock)failedBlock
//{
//
//    [FishNetworkBaseHandler sendGetRequestWithPath:lamacatePath
//                                       paramater:paramaters
//                                         success:^(NSURLResponse *response, id data) {
//
//                                             successBlock(response,data);
//                                         }
//                                          failed:^(NSError *error) {
//                                              failedBlock(error);
//
//                                          }];
//
//
//}


+ (void)configWithparamater:(NSDictionary *)paramaters
                      success:(LBSuccessBlock)successBlock
                       failed:(LBFailedBlock)failedBlock
{
    
    [WLNetworkBaseHandler sendGetRequestWithPath:configPath
                                       paramater:paramaters
                                         success:^(NSURLResponse *response, id data) {
                                             successBlock(response,data);
                                             
                                         }
                                          failed:^(NSError *error) {
                                              
                                              failedBlock(error);
                                          }];
    
    
    
}

//+ (void)scanCouponWithparamater:(NSDictionary *)paramaters
//                        success:(LBSuccessBlock)successBlock
//                         failed:(LBFailedBlock)failedBlock
//{
//
//    [FishNetworkBaseHandler sendGetRequestWithPath:searchCheckPath
//                                       paramater:paramaters
//                                         success:^(NSURLResponse *response, id data) {
//                                             successBlock(response,data);
//
//                                         }
//                                          failed:^(NSError *error) {
//
//                                              failedBlock(error);
//                                          }];
//
//
//}


//+ (void)seachHintWithparamater:(NSDictionary *)paramaters
//                        success:(LBSuccessBlock)successBlock
//                         failed:(LBFailedBlock)failedBlock
//{
//
//    [FishNetworkBaseHandler sendGetRequestWithPath:searchHintPath
//                                       paramater:paramaters
//                                         success:^(NSURLResponse *response, id data) {
//                                             successBlock(response,data);
//
//                                         }
//                                          failed:^(NSError *error) {
//
//                                              failedBlock(error);
//                                          }];
//
//
//}

+ (void)lamasearchWithPath:(NSString *)path
                 paramater:(NSDictionary *)paramaters
                   success:(LBSuccessBlock)successBlock
                    failed:(LBFailedBlock)failedBlock
{
    
    [WLNetworkBaseHandler sendGetRequestWithPath:path
                                       paramater:paramaters
                                         success:^(NSURLResponse *response, id data) {
                                             successBlock(response,data);
                                             
                                         }
                                          failed:^(NSError *error) {
                                              
                                              failedBlock(error);
                                          }];

}

//+ (void)xunquansearchWithparamater:(NSDictionary *)paramaters
//                        success:(LBSuccessBlock)successBlock
//                         failed:(LBFailedBlock)failedBlock
//{
//
//    [FishNetworkBaseHandler sendGetRequestWithPath:xunquansearhPath
//                                       paramater:paramaters
//                                         success:^(NSURLResponse *response, id data) {
//                                             successBlock(response,data);
//
//                                         }
//                                          failed:^(NSError *error) {
//
//                                              failedBlock(error);
//                                          }];
//
//
//}


//+ (void)lamaitemconfigWithparamater:(NSDictionary *)paramaters
//                   success:(LBSuccessBlock)successBlock
//                    failed:(LBFailedBlock)failedBlock
//{
//
//    [FishNetworkBaseHandler sendGetRequestWithPath:lamaconfigPath
//                                       paramater:paramaters
//                                         success:^(NSURLResponse *response, id data) {
//                                             successBlock(response,data);
//
//                                         }
//                                          failed:^(NSError *error) {
//
//                                              failedBlock(error);
//                                          }];
//
//}

+ (void)lamaDetailImagesWithItemId:(NSString *)itemId
                            paramater:(NSDictionary *)paramaters
                            success:(LBSuccessBlock)successBlock
                             failed:(LBFailedBlock)failedBlock
{
    NSString *path = [NSString stringWithFormat:@"/xunquan/detail_image/%@",itemId];
    [WLNetworkBaseHandler sendGetRequestWithPath:path
                                       paramater:paramaters
                                         success:^(NSURLResponse *response, id data) {
                                             successBlock(response,data);
                                             
                                         }
                                          failed:^(NSError *error) {
                                              
                                              failedBlock(error);
                                          }];
    
}

//+ (void)lamaRateWithparamater:(NSDictionary *)paramaters
//                            success:(LBSuccessBlock)successBlock
//                             failed:(LBFailedBlock)failedBlock
//{
//
//    [FishNetworkBaseHandler sendGetRequestWithPath:lamaratePath
//                                       paramater:paramaters
//                                         success:^(NSURLResponse *response, id data) {
//                                             successBlock(response,data);
//
//                                         }
//                                          failed:^(NSError *error) {
//
//                                              failedBlock(error);
//                                          }];
//
//}

//+ (void)lamaImageTransWithparamater:(NSDictionary *)paramaters
//                      success:(LBSuccessBlock)successBlock
//                       failed:(LBFailedBlock)failedBlock
//
//{
//
//    [FishNetworkBaseHandler sendPostRequestWithPath:lamaimagetranspath paramater:paramaters success:^(NSURLResponse *response, id data) {
//        successBlock(response,data);
//
//    } failed:^(NSError *error) {
//        failedBlock(error);
//
//    }];
//
//
//
//
//}

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
