//
//  STSolunarTidesHandler.m
//  Solunar Tides
//
//  Created by xueping on 2019/5/13.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "STSolunarTidesHandler.h"

#import "STLocationModel.h"

@implementation STSolunarTidesHandler


+ (STSolunarTidesHandler *)sharehanlder {
    static STSolunarTidesHandler *handler;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        handler = [[STSolunarTidesHandler alloc] init];
    });
    
    return handler;
    
}


- (instancetype)init {
    
    self = [super init ];
    if (self) {
        
        self.tidalEventArray = [NSMutableArray array];
    }
    
    return self;
}

@end
