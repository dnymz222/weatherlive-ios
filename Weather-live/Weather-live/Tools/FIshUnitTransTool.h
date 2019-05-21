//
//  FIshUnitTransTool.h
//  fishinghelper
//
//  Created by xueping on 2019/2/19.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN


typedef NS_ENUM(NSInteger,FishWindDirection) {
    FishWindDirectionNorth =0 ,
    FishWindDirectionEastNorth,
    FishWindDirectionEast,
    FishWindDirectionEastSouth,
    FishWindDirectionSouth,
    FishWindDirectionWestSouth,
    FishWindDirectionWset,
    FishWindDirectionWestNorth,
    
};

@interface FIshUnitTransTool : NSObject

+ (float)nieshitransfromhuashi:(float)huashi;

+ (float)mmtransfrominches:(float)inches;

+ (float)kmtransfrommiles:(float)miles;

+ (NSString *)timetransfromtimestamp:(NSInteger)timstamp;

+ (NSString *)hundrepercentfromfloat:(float)value;

+ (FishWindDirection)directiontranfromeWindBearing:(NSInteger)windBearing;

+ (NSString *)directionDescriptionFromDirection:(FishWindDirection)direction;

+ (float)meterpersecondfromnileperhour:(float)mileh;

@end

NS_ASSUME_NONNULL_END
