//
//  LBNetwork.h
//  lamabiji
//
//  Created by mc on 2018/9/12.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WLNetwork : NSObject

+ (instancetype)shareInstance;

@property(nonatomic,strong,readonly)NSURLSession *session;

@property(nonatomic,copy)NSString *dateString;

@property(nonatomic,copy)NSString *sourceVersion;

@property(nonatomic,copy)NSString *sysVersion;

+ (NSInteger)cacluteTotalWithLat:(NSString *)latitude lon:(NSString *)longtitude time:(NSInteger)timstamp;



@end
