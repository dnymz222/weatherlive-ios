//
//  WLColor.m
//  Weather-live
//
//  Created by xueping on 2019/10/26.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLColor.h"
#import "ColorSizeMacro.h"

#ifndef IOS_VERSION_13_OR_LATER

#define IOS_VERSION_13_OR_LATER (([[[UIDevice currentDevice] systemVersion] floatValue] >12.9)? (YES):(NO))
#endif


@implementation WLColor

+ (UIColor *)cellTextColor {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    

        if (@available(iOS 13.0, *)) {
            UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
                if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                    return UIColorFromRGB(0x666666);
                }
                else {
                    return UIColorFromRGB(0x999999);
                }
            }];
            
            return dyColor;
        } else {
            // Fallback on earlier versions
              return  UIColorFromRGB(0x666666);
        }
          
   
  
#else
    
    
    return  UIColorFromRGB(0x666666);
#endif
    
    
}

+ (UIColor *)headercolor {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    

        if (@available(iOS 13.0, *)) {
            UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
                if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                    return UIColorFromRGB(0x444444);
                }
                else {
                    return UIColorFromRGB(0xaaaaaa);
                }
            }];
            
            return dyColor;
        } else {
            return  UIColorFromRGB(0x444444);
            // Fallback on earlier versions
        }
   
    
   
    
#else
    
    
    return  UIColorFromRGB(0x444444);
#endif
    
    
}

+ (UIColor *)boldcolor {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    

        if (@available(iOS 13.0, *)) {
            UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
                if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                    return UIColorFromRGB(0x333333);
                }
                else {
                    return UIColorFromRGB(0xbbbbbb);
                }
            }];
            
            return dyColor;
        } else {
            return  UIColorFromRGB(0x333333);
            // Fallback on earlier versions
        }
   
    
   
    
#else
    
    
    return  UIColorFromRGB(0x333333);
#endif
    
    
}





+ (UIColor*)viewColor {
    
    
    
    #if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    
    
   
        if (@available(iOS 13.0, *)) {
            UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
                if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                    return UIColorFromRGB(0xffffff);
                }
                else {
                    return UIColorFromRGB(0x000000);
                }
            }];
            
            return dyColor;
        } else {
            // Fallback on earlier versions
             return  UIColorFromRGB(0xffffff);
        }
 
        
      
        
    #else
        
        
        return  UIColorFromRGB(0xffffff);
    #endif
    
    
}


+ (UIColor*)heaerviewColor {
    
    #if __IPHONE_13_0
  
        if (@available(iOS 13.0, *)) {
            UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
                if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                    return UIColorFromRGB(0xffffff);
                }
                else {
                    return UIColorFromRGB(0x111111);
                }
            }];
            
            return dyColor;
        } else {
            return  UIColorFromRGB(0xffffff);
            // Fallback on earlier versions
        }
  
        
       
        
    #else
        
        
        return  UIColorFromRGB(0xffffff);
    #endif
    
    
}


+ (UIColor*)verseviewColor {
    
#if __IPHONE_OS_VERSION_MAX_ALLOWED >= __IPHONE_13_0
    
    
        if (@available(iOS 13.0, *)) {
            UIColor *dyColor = [UIColor colorWithDynamicProvider:^UIColor * _Nonnull(UITraitCollection * _Nonnull trainCollection) {
                if ([trainCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                    return UIColorFromRGB(0x000000);
                }
                else {
                    return UIColorFromRGB(0xffffff);
                }
            }];
            
            return dyColor;
        } else {
            return  UIColorFromRGB(0x000000);
            // Fallback on earlier versions
        }
 
        
       
        
    #else
        
        
        return  UIColorFromRGB(0x000000);
    #endif
    
    
}





@end
