//
//  LBNetworkBaseHanlder.m
//  lamabiji
//
//  Created by mc on 2018/9/12.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "WLNetworkBaseHandler.h"
#import <UIKit/UIKit.h>
#import "LBKeyMacro.h"
#import "LFCGzipUtility.h"


#if DEBUG
//#define URLrootpath @"http://127.0.0.1:5000/api/v2.0"
#define URLrootpath @"https://www.xunquan.shop/api/v3.0"
#else
#define URLrootpath @"https://www.xunquan.shop/api/v3.0"

#endif



@implementation WLNetworkBaseHandler


+ (void)sendGetRequestWithPath:(NSString*)path
                     paramater:(NSDictionary*)paramaters
                       success:(LBSuccessBlock)successBlock
                        failed:(LBFailedBlock)failedBlock
{
    
    NSString *urlString = [WLNetworkBaseHandler transferGetUrlWithpath:path paramaters:paramaters];
#if DEBUG
    NSLog(@"urlstring:%@",urlString);
#endif
    
    //[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURL *url  = [NSURL  URLWithString:urlString];
    
    __block  __strong  NSMutableURLRequest *request =  [NSMutableURLRequest requestWithURL:url];
    
#if DEBUG
    request.timeoutInterval = 10;
#else
    request.timeoutInterval = 15;
#endif
    
    
    NSURLSession *session = [WLNetwork shareInstance].session;
    
    __block NSURLSessionDataTask *task  = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
       // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error) {
            failedBlock(error);
            
        }else{
            
            NSDictionary   *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil ];
            
            if (dict) {
                
                NSInteger code = [[dict valueForKey:@"code"] integerValue];
                if (code == 200) {
                    
                    id data = [dict valueForKey:@"data"];
                    
                    successBlock(response,data);
                    
                }else {
                    
                    
                    NSError *error = [NSError errorWithDomain:@"error" code:20001 userInfo:dict];
                    failedBlock(error);
                    
                }
                
               
                
            }else {
                
#if DEBUG
                NSLog(@"error:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
#endif
                
                NSDictionary *dict = @{NSLocalizedDescriptionKey:@"没有数据了"};
                NSError *error = [NSError errorWithDomain:@"error" code:20002 userInfo:dict];
                failedBlock(error);
            }
            
            
            
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}

+ (void)sendPostRequestWithPath:(NSString*)path
                     paramater:(NSDictionary*)paramaters
                       success:(LBSuccessBlock)successBlock
                        failed:(LBFailedBlock)failedBlock
{
    
    NSString *urlString = [URLrootpath stringByAppendingString:path];;
#if DEBUG
    NSLog(@"urlstring:%@",urlString);
#endif
   
    
    NSURL *url  = [NSURL  URLWithString:urlString];
    
    __block  __strong  NSMutableURLRequest *request =  [NSMutableURLRequest requestWithURL:url];
    request.HTTPMethod = @"POST";
    
    NSArray *allkeys = [paramaters allKeys];
    NSString *bodystring = @"";
    for (NSString *key in allkeys) {
        NSString *string = [NSString stringWithFormat:@"%@=%@&",key,[paramaters valueForKey:key]];
        bodystring  = [bodystring    stringByAppendingString:string];
    }
    bodystring = [bodystring stringByAppendingString:[NSString stringWithFormat:@"appVersion=%@&day=%@&source=%@&sysv=%@&os=iOS&adzoneId=%@",[WLNetwork shareInstance].sourceVersion,[WLNetwork shareInstance].dateString,@"weatherlive",[WLNetwork shareInstance].sysVersion,adzone_id]];
    request.HTTPBody = [bodystring dataUsingEncoding:NSUTF8StringEncoding];
    
#if DEBUG
    request.timeoutInterval = 10;
#else
    request.timeoutInterval = 30;
#endif
    
    
    NSURLSession *session = [WLNetwork shareInstance].session;
    
    __block NSURLSessionDataTask *task  = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
   
        
        if (error) {
            failedBlock(error);
            
        }else{
            
            NSDictionary   *dict = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil ];
            
            if (dict) {
                
                NSInteger code = [[dict valueForKey:@"code"] integerValue];
                if (code == 200) {
                    
                    id data = [dict valueForKey:@"data"];
                    
                    successBlock(response,data);
                    
                }else {
                    
                    
                    NSError *error = [NSError errorWithDomain:@"error" code:20001 userInfo:dict];
                    failedBlock(error);
                    
                }
                
                
                
            }else {
                
#if DEBUG
                NSLog(@"error:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
#endif
                
                NSDictionary *dict = @{NSLocalizedDescriptionKey:@"没有数据了"};
                NSError *error = [NSError errorWithDomain:@"error" code:20002 userInfo:dict];
                failedBlock(error);
            }
            
            
            
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}




+ (NSString*)transferGetUrlWithpath:(NSString*)path paramaters:(NSDictionary*)paramaters {
    
    
    NSString *urlString = [URLrootpath stringByAppendingString:path];
    urlString = [urlString stringByAppendingString:@"?"];
    
    if (paramaters) {
        
        NSArray *allkeys = [paramaters allKeys];
        
        for (NSString *key in allkeys) {
            
            NSString *value = [NSString stringWithFormat:@"%@",[paramaters valueForKey:key]];
            
            NSString *keyvalue = [NSString stringWithFormat:@"%@=%@&",key,value ];
            
            urlString  =[urlString stringByAppendingString:keyvalue];
        }
    }
    
    
    
    
   urlString  = [urlString stringByAppendingString:[NSString stringWithFormat:@"appVersion=%@&day=%@&source=%@&sysv=%@&os=iOS&adzoneId=%@",[WLNetwork shareInstance].sourceVersion,[WLNetwork shareInstance].dateString,@"weatherlive",[WLNetwork shareInstance].sysVersion,adzone_id]];
    
    urlString = [urlString stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet characterSetWithCharactersInString:@"`#%^@,{}\"[]|\\<> "].invertedSet];
    
    return urlString;
    
    
    
    
}


+ (void)sendGetRequestWithUrl:(NSString*)urlString

                       success:(LBSuccessBlock)successBlock
                        failed:(LBFailedBlock)failedBlock
{
    
   
#if DEBUG
    NSLog(@"urlstring:%@",urlString);
#endif
   // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
    
    NSURL *url  = [NSURL  URLWithString:urlString];
    
    __block  __strong  NSMutableURLRequest *request =  [NSMutableURLRequest requestWithURL:url];
    
#if DEBUG
    request.timeoutInterval = 10;
#else
    request.timeoutInterval = 30;
#endif
    
    
    NSURLSession *session = [WLNetwork shareInstance].session;
    
    __block NSURLSessionDataTask *task  = [session dataTaskWithRequest:request completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        
       // [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
        
        if (error) {
            failedBlock(error);
            
        }else if(data) {
            

            
                NSInteger code = ((NSHTTPURLResponse *)response).statusCode;
                if (code == 200) {
                    

                        successBlock(response,data);
                    
                    

                    
                    
                }else {
                    
                    

#if DEBUG
                NSLog(@"error:%@",[[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding]);
#endif
                
                NSDictionary *dict = @{NSLocalizedDescriptionKey:@"没有数据了"};
                NSError *error = [NSError errorWithDomain:@"error" code:20002 userInfo:dict];
                failedBlock(error);
            }
            
            
            
        } else {
            NSDictionary *dict = @{NSLocalizedDescriptionKey:@"没有数据了"};
            NSError *error = [NSError errorWithDomain:@"error" code:20002 userInfo:dict];
            failedBlock(error);
        }
        
        
    }];
    
    [task resume];
    
    
    
    
}

+ (void)requestweatherWithParamaters:(NSDictionary*)paramaters
                             success:(LBSuccessBlock)successBlock
                              failed:(LBFailedBlock)failedBlock {
    
    //    NSString *appcode = @"03302ec93478463a9e1579abc4bc8f5b";
    //    NSString *host = @"https://ali-weather.showapi.com";
    //    NSString *path = @"/gps-to-weather";
    NSString *method =  @"GET";
    //    NSString *querys = @"?from=5&lat=40.242266&lng=116.2278&need3HourForcast=1&needAlarm=0&needHourData=1&needIndex=1&needMoreDay=1";
    //    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    //    NSString *bodys = @"";
    
    NSString *url = @"https://www.xunquan.shop/api/v2.0/weather?";
    NSArray *allkeys = [paramaters allKeys];
    for (NSString *key in allkeys) {
        NSString *vaylue = [paramaters valueForKey:key];
        NSString *keyvalue = [NSString stringWithFormat:@"%@=%@&",key,vaylue];
        url = [url stringByAppendingString:keyvalue];
    }
    
    url = [url stringByAppendingString:@"version=1.0"];
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  30];
    request.HTTPMethod  =  method;
    //    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       if (error) {
                                                           failedBlock(error);
                                                       } else{
                                                           //                                                       NSLog(@"Response object: %d" , body.length);
                                                           NSData *uncompressdata = [LFCGzipUtility ungzipData:body];
                                                           //                                                           NSLog(@"Response object unzip: %d" , uncompressdata.length);
                                                           if (!uncompressdata) {
                                                               NSError *readerror;
                                                               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingAllowFragments error:&readerror];
                                                               if (readerror) {
                                                                   failedBlock(readerror);
                                                               } else {
                                                                   if ([dict isKindOfClass:[NSDictionary class ]]) {
                                                                       successBlock(response,dict);
                                                                   } else {
                                                                       
                                                                       NSString *message = [[NSString alloc] initWithData:uncompressdata encoding:NSUTF8StringEncoding];
                                                                       NSError *resulterror = [NSError errorWithDomain:@"error" code:201 userInfo:@{@"message":message}];
                                                                       failedBlock(resulterror);
                                                                   }
                                                               }
                                                               
//                                                               NSError *unziprror = [NSError errorWithDomain:@"error" code:203 userInfo:@{@"message":@"unzip"}];
//                                                               failedBlock(unziprror);
                                                               return ;
                                                           }
                                                           NSError *readerror;
                                                           NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:uncompressdata options:NSJSONReadingAllowFragments error:&readerror];
                                                           if (readerror) {
                                                               failedBlock(readerror);
                                                           } else {
                                                               if ([dict isKindOfClass:[NSDictionary class ]]) {
                                                                   successBlock(response,dict);
                                                               } else {
                                                                   
                                                                   NSString *message = [[NSString alloc] initWithData:uncompressdata encoding:NSUTF8StringEncoding];
                                                                   NSError *resulterror = [NSError errorWithDomain:@"error" code:201 userInfo:@{@"message":message}];
                                                                   failedBlock(resulterror);
                                                               }
                                                           }
                                                           
                                                       }
                                                       
                                                       //                                                       NSString *bodyString = [[NSString alloc] initWithData:uncompressdata encoding:NSUTF8StringEncoding];
                                                       
                                                       
                                                       //打印应答中的body
                                                       //                                                       NSLog(@"Response body: %@" , bodyString);
                                                   }];
    
    [task resume];
    
    
    
}

+ (void)requestAcuuIndexWithParamaters:(NSDictionary*)paramaters
                               success:(LBSuccessBlock)successBlock
                                failed:(LBFailedBlock)failedBlock {
    
    //    NSString *appcode = @"03302ec93478463a9e1579abc4bc8f5b";
    //    NSString *host = @"https://ali-weather.showapi.com";
    //    NSString *path = @"/gps-to-weather";
    NSString *method =  @"GET";
    //    NSString *querys = @"?from=5&lat=40.242266&lng=116.2278&need3HourForcast=1&needAlarm=0&needHourData=1&needIndex=1&needMoreDay=1";
    //    NSString *url = [NSString stringWithFormat:@"%@%@%@",  host,  path , querys];
    //    NSString *bodys = @"";
    
    NSString *url = @"https://www.xunquan.shop/api/v3.0/acuu/index?";
    NSArray *allkeys = [paramaters allKeys];
    for (NSString *key in allkeys) {
        NSString *vaylue = [paramaters valueForKey:key];
        NSString *keyvalue = [NSString stringWithFormat:@"%@=%@&",key,vaylue];
        url = [url stringByAppendingString:keyvalue];
    }
    
    url = [url stringByAppendingString:@"version=1.0"];
    
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString: url]  cachePolicy:1  timeoutInterval:  30];
    request.HTTPMethod  =  method;
    //    [request addValue:  [NSString  stringWithFormat:@"APPCODE %@" ,  appcode]  forHTTPHeaderField:  @"Authorization"];
    NSURLSession *requestSession = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration]];
    NSURLSessionDataTask *task = [requestSession dataTaskWithRequest:request
                                                   completionHandler:^(NSData * _Nullable body , NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                       if (error) {
                                                           failedBlock(error);
                                                       } else{
                                                          //NSLog(@"Response object: %d" , body.length);
                                                           NSData *uncompressdata = [LFCGzipUtility ungzipData:body];
                                                           //                                                           NSLog(@"Response object unzip: %d" , uncompressdata.length);
                                                           if (!uncompressdata) {
                                                               NSError *readerror;
                                                               NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:body options:NSJSONReadingAllowFragments error:&readerror];
                                                               if (readerror) {
                                                                   failedBlock(readerror);
                                                               } else {
                                                                   if ([dict isKindOfClass:[NSDictionary class ]]) {
                                                                       successBlock(response,dict);
                                                                   } else {
                                                                       
                                                                       NSString *message = [[NSString alloc] initWithData:uncompressdata encoding:NSUTF8StringEncoding];
                                                                       NSError *resulterror = [NSError errorWithDomain:@"error" code:201 userInfo:@{@"message":message}];
                                                                       failedBlock(resulterror);
                                                                   }
                                                               }
                                                               
                                                               //                                                               NSError *unziprror = [NSError errorWithDomain:@"error" code:203 userInfo:@{@"message":@"unzip"}];
                                                               //                                                               failedBlock(unziprror);
                                                               return ;
                                                           }
                                                           NSError *readerror;
                                                           id object = [NSJSONSerialization JSONObjectWithData:uncompressdata options:NSJSONReadingAllowFragments error:&readerror];
                                                           if (readerror) {
                                                               failedBlock(readerror);
                                                           } else {
                                                               if ([object isKindOfClass:[NSArray class ]]) {
                                                                   successBlock(response,object);
                                                               } else {
                                                                   
                                                                   NSString *message = [[NSString alloc] initWithData:uncompressdata encoding:NSUTF8StringEncoding];
                                                                   NSError *resulterror = [NSError errorWithDomain:@"error" code:201 userInfo:@{@"message":message}];
                                                                   failedBlock(resulterror);
                                                               }
                                                           }
                                                           
                                                       }
                                                       
                                                       //                                                       NSString *bodyString = [[NSString alloc] initWithData:uncompressdata encoding:NSUTF8StringEncoding];
                                                       
                                                       
                                                       //打印应答中的body
                                                       //                                                       NSLog(@"Response body: %@" , bodyString);
                                                   }];
    
    [task resume];
    
    
    
}




@end
