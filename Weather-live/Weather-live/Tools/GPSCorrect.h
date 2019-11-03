//
//  GPSCorrect.h
//  Weather-live
//
//  Created by xueping on 2019/10/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

NS_ASSUME_NONNULL_BEGIN

@interface GPSCorrect : NSObject

+ (CLLocation *) transformLocation: (CLLocation*)location;

@end

NS_ASSUME_NONNULL_END
