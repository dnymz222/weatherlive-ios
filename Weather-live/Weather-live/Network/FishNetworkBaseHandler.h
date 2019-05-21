//
//  LBNetworkBaseHanlder.h
//  lamabiji
//
//  Created by mc on 2018/9/12.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^LBSuccessBlock)(NSURLResponse *response ,id data);

typedef void(^LBFailedBlock)(NSError *error);

@interface FishNetworkBaseHandler : NSObject


+ (void)sendGetRequestWithPath:(NSString*)path
                     paramater:(NSDictionary*)paramaters
                       success:(LBSuccessBlock)successBlock
                        failed:(LBFailedBlock)failedBlock;

+ (void)sendGetRequestWithUrl:(NSString*)urlString
                      success:(LBSuccessBlock)successBlock
                       failed:(LBFailedBlock)failedBlock;

+ (void)sendPostRequestWithPath:(NSString*)path
                      paramater:(NSDictionary*)paramaters
                        success:(LBSuccessBlock)successBlock
                         failed:(LBFailedBlock)failedBlock;

+ (void)requestweatherWithParamaters:(NSDictionary*)paramaters
                             success:(LBSuccessBlock)successBlock
                              failed:(LBFailedBlock)failedBlock;

@end
