//
//  NSNull+LB.m
//  lamabiji
//
//  Created by xueping on 2018/10/3.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "NSNull+LB.h"

@implementation NSNull (LB)

- (BOOL)isEqualToString:(NSString *)aString {
    
    if ([aString isEqualToString:@"0"]) {
        return YES;
    }
    
    return NO;
}

- (NSTimeInterval)timeIntervalSince1970 {
    return 0;
}
@end
