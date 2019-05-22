//
//  LBNetworkBijiHandler.h
//  lamabiji
//
//  Created by mc on 2018/9/13.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FishNetworkBaseHandler.h"

@interface FishNetworkFirstHandler : NSObject

+ (void)fishcateWithparamater:(NSDictionary*)paramaters
                      success:(LBSuccessBlock)successBlock
                       failed:(LBFailedBlock)failedBlock;

+ (void)lamacatCouponWithPath:(NSString *)urlpath
                    paramater:(NSDictionary *)paramaters
                      success:(LBSuccessBlock)successBlock
                       failed:(LBFailedBlock)failedBlock;


//+ (void)lamacategoryWithparamater:(NSDictionary*)paramaters
//                          success:(LBSuccessBlock)successBlock
//                           failed:(LBFailedBlock)failedBlock;
//
+ (void)configWithparamater:(NSDictionary *)paramaters
                    success:(LBSuccessBlock)successBlock
                     failed:(LBFailedBlock)failedBlock;

//
//+ (void)scanCouponWithparamater:(NSDictionary *)paramaters
//                    success:(LBSuccessBlock)successBlock
//                     failed:(LBFailedBlock)failedBlock;
//
//+ (void)seachHintWithparamater:(NSDictionary *)paramaters
//                       success:(LBSuccessBlock)successBlock
//                        failed:(LBFailedBlock)failedBlock;
//
+ (void)lamasearchWithPath:(NSString *)path
                 paramater:(NSDictionary *)paramaters
                   success:(LBSuccessBlock)successBlock
                    failed:(LBFailedBlock)failedBlock;
//
//+ (void)xunquansearchWithparamater:(NSDictionary *)paramaters
//                           success:(LBSuccessBlock)successBlock
//                            failed:(LBFailedBlock)failedBlock;
//
//
//+ (void)lamacateBabyWithPath:(NSString *)urlpath
//                   paramater:(NSDictionary *)paramaters
//                     success:(LBSuccessBlock)successBlock
//                      failed:(LBFailedBlock)failedBlock;
//
//
//+ (void)lamaitemconfigWithparamater:(NSDictionary *)paramaters
//                            success:(LBSuccessBlock)successBlock
//                             failed:(LBFailedBlock)failedBlock;
//
+ (void)lamaDetailImagesWithItemId:(NSString *)itemId
                         paramater:(NSDictionary *)paramaters
                           success:(LBSuccessBlock)successBlock
                            failed:(LBFailedBlock)failedBlock;
//
//+ (void)lamaRateWithparamater:(NSDictionary *)paramaters
//                      success:(LBSuccessBlock)successBlock
//                       failed:(LBFailedBlock)failedBlock;
//
//+ (void)lamaImageTransWithparamater:(NSDictionary *)paramaters
//                            success:(LBSuccessBlock)successBlock
//                             failed:(LBFailedBlock)failedBlock;
//


+ (void)getWaterWithparamater:(NSDictionary *)paramaters
                    success:(LBSuccessBlock)successBlock
                     failed:(LBFailedBlock)failedBlock;



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





@end
