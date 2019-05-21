//
//  NSString+LB.m
//  lamabiji
//
//  Created by xueping on 2018/9/17.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "NSString+LB.h"

@implementation NSString (LB)



/**encode编码*/
-(NSString*)fish_encodeToPercentEscapeString
{
    NSString* outputStr=(__bridge NSString*)CFURLCreateStringByAddingPercentEscapes(
                                                                                    
                                                                                    NULL,/*allocator*/
                                                                                    
                                                                                    (__bridge CFStringRef)self,
                                                                                    
                                                                                    NULL,/*charactersToLeaveUnescaped*/
                                                                                    
                                                                                    (CFStringRef)@"!*'();:@&;=+$,/?%#[]",
                                                                                    
                                                                                    kCFStringEncodingUTF8);
    
    
    return outputStr;
}

- (NSString*)fish_decodeFromPercentEscapeString
{
    NSMutableString*outputStr=[NSMutableString stringWithString:self];
    [outputStr replaceOccurrencesOfString:@"+"
                               withString:@""
                                  options:NSLiteralSearch
                                    range:NSMakeRange(0,[outputStr length])];
    return [outputStr stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
}

+ (NSString *)fish_dictTojsonWithJsonObject:(id)dict {
    NSError *error;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dict options:NSJSONWritingPrettyPrinted error:&error];
    
    NSString *jsonString;
    
    if (!jsonData) {
        
        NSLog(@"%@",error);
        
    }else{
        
        jsonString = [[NSString alloc]initWithData:jsonData encoding:NSUTF8StringEncoding];
        
    }
    
    NSMutableString *mutStr = [NSMutableString stringWithString:jsonString];
//    return mutStr;
    
    NSRange range = {0,jsonString.length};
    
    //去掉字符串中的空格
    
    [mutStr replaceOccurrencesOfString:@" " withString:@"" options:NSLiteralSearch range:range];
    
    NSRange range2 = {0,mutStr.length};
    
    //去掉字符串中的换行符
    
    [mutStr replaceOccurrencesOfString:@"\n" withString:@"" options:NSLiteralSearch range:range2];
    
    return mutStr;
    
}



+ (NSDictionary *)fish_jsonTodictWithString:(NSString *)json {
    
    if (json == nil) {
        return nil;
    }
    
    NSData *jsonData = [json dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    if(err)
    {
        NSLog(@"json解析失败：%@",err);
        return nil;
    }
    return dic;
    
}


@end
