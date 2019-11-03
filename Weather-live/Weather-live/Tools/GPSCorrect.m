//
//  GPSCorrect.m
//  Weather-live
//
//  Created by xueping on 2019/10/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "GPSCorrect.h"
#include <Math.h>

// static double pi = 3.14159265358979324;
 static double a = 6378245.0;
 static double ee = 0.00669342162296594323;


@implementation GPSCorrect


+ (CLLocation *) transformLocation: (CLLocation*)location {
     
    double wgLat, wgLon;
    wgLat = location.coordinate.latitude;
    wgLon = location.coordinate.longitude;
    
    double nwLat,nwLon;
    
       if ([GPSCorrect outOfChinaWithLat:wgLat lon:wgLon]) {
           nwLat = wgLat;
           nwLon = wgLon;
        CLLocation *nwLocatopn = [[CLLocation alloc] initWithLatitude:nwLat longitude:nwLon];
           return nwLocatopn;
       }
    double dLat = [GPSCorrect transformLatWithLat:wgLon-105.0    lon:wgLat-35.0];
      // double dLat = transformLat(wgLon - 105.0, wgLat - 35.0);
    double dLon = [GPSCorrect transformLonWithLat:wgLon-105.0 lon:wgLat-35.0];
//       double dLon = transformLon(wgLon - 105.0, wgLat - 35.0);
       double radLat = wgLat / 180.0 * M_PI;
       double magic = sin(radLat);
       magic = 1 - ee *  magic;
       double sqrtMagic = sqrt(magic);
       dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * M_PI);
       dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * M_PI);
       nwLat = wgLat + dLat;
       nwLon = wgLon + dLon;
      CLLocation *nwLocatopn = [[CLLocation alloc] initWithLatitude:nwLat longitude:nwLon];
    return nwLocatopn;
   }

+ (BOOL)outOfChinaWithLat:(double) lat lon:(double) lon {
       if (lon < 72.004 || lon > 137.8347)
           return true;
       if (lat < 0.8293 || lat > 55.8271)
           return true;
       return false;
   }

+ (double) transformLatWithLat:(double)x  lon:(double) y {
       double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * sqrt(fabs(x));
       ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 *sin(2.0 * x * M_PI)) * 2.0 / 3.0;
       ret += (20.0 * sin(y * M_PI) + 40.0 * sin(y / 3.0 * M_PI)) * 2.0 / 3.0;
       ret += (160.0 * sin(y / 12.0 * M_PI) + 320 * sin(y * M_PI / 30.0)) * 2.0 / 3.0;
       return ret;
   }

+ (double)transformLonWithLat:(double) x  lon:(double) y {
       double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * sqrt(fabs(x));
       ret += (20.0 * sin(6.0 * x * M_PI) + 20.0 * sin(2.0 * x * M_PI)) * 2.0 / 3.0;
       ret += (20.0 * sin(x * M_PI) + 40.0 * sin(x / 3.0 * M_PI)) * 2.0 / 3.0;
       ret += (150.0 * sin(x / 12.0 * M_PI) + 300.0 * sin(x / 30.0 * M_PI)) * 2.0 / 3.0;
       return ret;
   }






@end
