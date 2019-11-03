//
//  STSolunarTidesHandler.h
//  Solunar Tides
//
//  Created by xueping on 2019/5/13.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WLAccuLocationModel.h"

NS_ASSUME_NONNULL_BEGIN


@class STLocationModel;

@interface WLWeatherLocationHandler : NSObject


@property(nonatomic,strong)STLocationModel *locationModel;
@property(nonatomic,strong)WLAccuLocationModel *accuLoctionModel;
//@property(nonatomic,copy)NSString *locationKey;

@property(nonatomic,assign)BOOL becomeActive;


@property(nonatomic,copy)NSArray *indexArray;



+ (WLWeatherLocationHandler *)sharehanlder;

@end

NS_ASSUME_NONNULL_END
