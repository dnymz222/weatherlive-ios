//
//  UIColor+WXP.h
//  xunquan
//
//  Created by xueping on 2018/9/15.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (WXP)

+ (UIColor *)setGradualChangingColor:(CGRect)bounds fromColor:(UIColor*)fromColor toColor:(UIColor *)toColor;

+ (UIColor *) wxp_colorWithHexString: (NSString *) hexString;

@end
