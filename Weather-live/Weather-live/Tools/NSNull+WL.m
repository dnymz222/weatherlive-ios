//
//  NSNull+WL.m
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "NSNull+WL.h"

@implementation NSNull (WL)

- (NSInteger)length{
    return 0;
}

- (BOOL)isEqualToString:(NSString *)aString {
    
    return NO;
}

- (float)floatValue  {
    
    return 0;
}

- (NSInteger)integerValue {
    return 0;
}

- (int)intValue {
    
    return 0;
}

- (double)doubleValue {
    return 0;
}


@end
