//
//  WLAccuIndexModel.m
//  Weather-live
//
//  Created by xueping on 2019/5/23.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAccuIndexModel.h"

@implementation WLAccuIndexModel


- (void)caculateDay {
    
    self.Day = [self.LocalDateTime substringWithRange:NSMakeRange(5, 5)];
    
}

@end
