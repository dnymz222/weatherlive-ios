//
//  WXpFloat.h
//  ttjxiossdk
//
//  Created by xxxsalis on 16/10/27.
//  Copyright © 2016年 xxxsalis. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger,WXPFloatEffectiveNumberType) {
    
    WXPFloatEffectiveNumberTypeZero = 0,//不显示小数
    WXPFloatEffectiveNumberTypeOne, //小数点后显示一位
    WXPFloatEffectiveNumberTypeTwo,//小数点后显示两位
};

@interface WXPFloat : NSObject

+ (WXPFloatEffectiveNumberType)caculateEffectiveNumberWithFloat:(float)number;


+  (NSString *)stringWithfloat:(float)number;


@end
