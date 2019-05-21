//
//  ColorSizeMacro.h
//  SunAndMoon
//
//  Created by mc on 2019/1/21.
//  Copyright © 2019年 xueping. All rights reserved.
//

#ifndef ColorSizeMacro_h
#define ColorSizeMacro_h

#define UIColorFromRGB(rgbValue) [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#define KIsiPhoneX ([UIScreen instancesRespondToSelector:@selector(currentMode)] ?\
(CGSizeEqualToSize(CGSizeMake(1125, 2436), [[UIScreen mainScreen] currentMode].size)||\
CGSizeEqualToSize(CGSizeMake(750, 1624), [[UIScreen mainScreen] currentMode].size)||\
CGSizeEqualToSize(CGSizeMake(1242, 2688), [[UIScreen mainScreen] currentMode].size)\
) : NO)


#define kScreenHeight    [[UIScreen mainScreen]bounds].size.height

#define kScreenWidth     [[UIScreen mainScreen]bounds].size.width


#define Themecolor 0x346ec0



#endif /* ColorSizeMacro_h */
