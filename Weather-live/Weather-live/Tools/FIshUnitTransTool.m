//
//  FIshUnitTransTool.m
//  fishinghelper
//
//  Created by xueping on 2019/2/19.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "FIshUnitTransTool.h"

@implementation FIshUnitTransTool

+ (float)nieshitransfromhuashi:(float)huashi

{
    
    float nieshi = 5/9.f*(huashi-32.f);
    return nieshi;
}

+ (float)mmtransfrominches:(float)inches {
    
    return inches*2.54*10;
}

+ (float)kmtransfrommiles:(float)miles {
    return miles *1.60931;
}

+ (NSString *)timetransfromtimestamp:(NSInteger)timstamp {
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timstamp];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    return [formatter stringFromDate:date];
    
}

+ (NSString *)hundrepercentfromfloat:(float)value {
    
    int intvalue = value *100;
    NSString *string = [NSString stringWithFormat:@"%d",intvalue];
    return [string stringByAppendingString:@"%"];
    
    
    
}

+ (FishWindDirection)directiontranfromeWindBearing:(NSInteger)windBearing {
    NSInteger index  = windBearing/45;
    NSInteger left = windBearing %45;
    if (left > 22.5) {
        index ++;
    }
    if (index > 7) {
        index = 0;
    }
    
    return (FishWindDirection)index;
    
}

+ (NSString *)directionDescriptionFromDirection:(FishWindDirection)direction {
    
    NSString *string;
    switch (direction) {
        case FishWindDirectionNorth:
            string  =@"北";
            
            break;
        case FishWindDirectionEastNorth:
            string = @"东北";
            break;
        case FishWindDirectionEast:
            string  = @"东";
            break;
        case FishWindDirectionEastSouth:
            string = @"东南";
            break;
        case FishWindDirectionSouth:
            string  = @"南";
            break;
        case FishWindDirectionWestSouth:
            string = @"西南";
            break;
        case FishWindDirectionWset:
            string = @"西";
            break;
        case FishWindDirectionWestNorth:
            string = @"西北";
            break;
            
        default:
            break;
    }
    
    
    return string;
    
    
}

+ (float)meterpersecondfromnileperhour:(float)mileh {
    
    float meters = [FIshUnitTransTool kmtransfrommiles:mileh]*1000;
    
    return meters/3600.f;
}


@end
