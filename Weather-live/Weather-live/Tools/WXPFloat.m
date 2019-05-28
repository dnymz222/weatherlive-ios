//
//  WXPFloat.m
//  ttjxiossdk
//
//  Created by xxxsalis on 16/10/27.
//  Copyright © 2016年 xxxsalis. All rights reserved.
//

#import "WXPFloat.h"
#include <math.h>

@implementation WXPFloat


+ (WXPFloatEffectiveNumberType)caculateEffectiveNumberWithFloat:(float)number {

    if ( number-(int)number < 0.001f ||  number-(int)number > 0.999f) {
        return WXPFloatEffectiveNumberTypeZero;
    } else if (number*10.f - (int)(number*10.f)<0.09f || number*10.f -(int)(number*10.f) > 0.99f ) {
        
        return WXPFloatEffectiveNumberTypeOne;
    } else {
     
        return  WXPFloatEffectiveNumberTypeTwo;
    }

}

+ (NSString *)stringWithfloat:(float)number {

    WXPFloatEffectiveNumberType  type = [WXPFloat caculateEffectiveNumberWithFloat:number];
    
    switch (type) {
        case WXPFloatEffectiveNumberTypeZero:
            return [NSString stringWithFormat:@"%d",(int)number];
            
            break;
            case WXPFloatEffectiveNumberTypeOne:
            
            return [NSString stringWithFormat:@"%0.1f",number];
            
            break;
            
            case WXPFloatEffectiveNumberTypeTwo:
            
            return [NSString stringWithFormat:@"%0.2f",number];
            break;
            
        default:
            break;
    }

}


@end
