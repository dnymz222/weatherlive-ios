//
//  LBSellerModel.m
//  lamabiji
//
//  Created by xueping on 2018/9/29.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishSellerModel.h"


@implementation FishSellerScoreModel



@end

@implementation FishSellerModel

+ ( NSDictionary *)modelContainerPropertyGenericClass {
    
    return @{@"evaluates":[FishSellerScoreModel class]};
}


@end
