//
//  LBNetwork.m
//  lamabiji
//
//  Created by mc on 2018/9/12.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishNetwork.h"
#import <UIKit/UIKit.h>

@interface FishNetwork ()<NSURLSessionDelegate>

@end

@implementation FishNetwork

+ (instancetype)shareInstance {
    
    static  FishNetwork *network ;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        network = [[FishNetwork alloc] init];
    });
    
    return network;
    
}

-(instancetype)init
{
    self = [super init];
    if (self) {
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        
        
        
        
        config.requestCachePolicy =  NSURLRequestUseProtocolCachePolicy;
        
        _session  = [NSURLSession sessionWithConfiguration:config delegate:self delegateQueue:[NSOperationQueue mainQueue]];
        
        NSDateFormatter *datefomter = [[NSDateFormatter alloc] init];
        [datefomter setDateFormat:@"yyyy-MM-dd"];
        _dateString = [datefomter stringFromDate:[NSDate date]];
        
        _sourceVersion =[[[NSBundle mainBundle] infoDictionary] valueForKey:@"CFBundleShortVersionString"];
        
        _sysVersion = [@"iOS" stringByAppendingString:[UIDevice currentDevice].systemVersion];
        
        
        
        
        
    }
    
    return self;
    
}

- (void)URLSession:(NSURLSession *)session
didReceiveChallenge:(NSURLAuthenticationChallenge *)challenge
 completionHandler:(void (^)(NSURLSessionAuthChallengeDisposition, NSURLCredential *))completionHandler
{
    
    
    // 如果使用默认的处置方式，那么 credential 就会被忽略
    NSURLSessionAuthChallengeDisposition disposition = NSURLSessionAuthChallengePerformDefaultHandling;
    NSURLCredential *credential = nil;
    
    if ([challenge.protectionSpace.authenticationMethod
         isEqualToString:
         NSURLAuthenticationMethodServerTrust]) {
        
        credential = [NSURLCredential credentialForTrust:challenge.protectionSpace.serverTrust];
        if (credential) {
            disposition = NSURLSessionAuthChallengeUseCredential;
        } else {
            disposition = NSURLSessionAuthChallengeCancelAuthenticationChallenge;
        }
        
    }
    if (completionHandler) {
        completionHandler(disposition, credential);
    }
    
}


@end
