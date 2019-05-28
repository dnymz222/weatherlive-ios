//
//  NSObject+WL.m
//  Weather-live
//
//  Created by xueping on 2019/5/27.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "NSObject+WL.h"
#import "YYModel.h"



@implementation NSObject (WL)

- (NSString *)debugDescription {
    
    return [self yy_modelDescription];
}

@end
