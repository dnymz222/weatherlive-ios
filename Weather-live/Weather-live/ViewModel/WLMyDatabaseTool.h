//
//  WLMyDatabaseTool.h
//  Weather-live
//
//  Created by xueping on 2019/8/27.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class STLocationModel;

@interface WLMyDatabaseTool : NSObject

+ (void)addlocation:(STLocationModel *)location;

+ (void)removeLocation:(STLocationModel *)location;

+ (NSArray *)excuteLocationArray;

@end

NS_ASSUME_NONNULL_END
