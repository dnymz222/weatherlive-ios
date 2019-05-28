//
//  UIView+WL.m
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "UIView+WL.h"

@implementation UIView (WL)

+ (CGFloat)wl_heightWithCount:(NSInteger)count {
    if (!count) {
        return 0.00001f;
    }
    if (count < 5) {
        return [UIScreen mainScreen].bounds.size.width/4 + 10;
    }
    
    
    NSInteger rows = count/5;
    NSInteger cols = count %5;
    if (cols > 0) {
        rows = rows + 1;
    }
    
    CGFloat itemheight = [UIScreen mainScreen].bounds.size.width /5.0 +10;
    return rows * itemheight;
    
}


@end
