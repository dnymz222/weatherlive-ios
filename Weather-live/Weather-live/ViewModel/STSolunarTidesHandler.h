//
//  STSolunarTidesHandler.h
//  Solunar Tides
//
//  Created by xueping on 2019/5/13.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


@class STLocationModel;

@interface STSolunarTidesHandler : NSObject


@property(nonatomic,strong)STLocationModel *locationModel;

@property(nonatomic,strong)NSMutableArray *tidalEventArray;

+ (STSolunarTidesHandler *)sharehanlder;

@end

NS_ASSUME_NONNULL_END
