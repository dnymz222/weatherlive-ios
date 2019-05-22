//
//  WLAccuCurrentModel.h
//  Weather-live
//
//  Created by xueping on 2019/5/22.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLAccuCurrentModel : NSObject

@property(nonatomic,assign)NSInteger EpochTime;
@property(nonatomic,copy)NSDictionary *RealFeelTemperature;
@property(nonatomic,assign)NSInteger WeatherIcon;
@property(nonatomic,assign)NSInteger CloudCover;
@property(nonatomic,copy)NSDictionary *WindGust;
@property(nonatomic,copy)NSDictionary *RealFeelTemperatureShade;
@property(nonatomic,copy)NSDictionary *WindChillTemperature;
@property(nonatomic,copy)NSDictionary *Temperature;
@property(nonatomic,assign)BOOL HasPrecipitation;
@property(nonatomic,copy)NSDictionary *Ceiling;
@property(nonatomic,copy)NSDictionary *LocalSource;
@property(nonatomic,assign)NSInteger PrecipitationType;
@property(nonatomic,copy)NSDictionary *PrecipitationSummary;
@property(nonatomic,copy)NSDictionary *Visibility;
@property(nonatomic,copy)NSDictionary *Pressure;
@property(nonatomic,copy)NSString *Link;
@property(nonatomic,assign)BOOL IsDayTime;
@property(nonatomic,copy)NSDictionary *Precip1hr;
@property(nonatomic,assign)NSInteger RelativeHumidity;
@property(nonatomic,copy)NSString *LocalObservationDateTime;
@property(nonatomic,copy)NSDictionary *DewPoint;
@property(nonatomic,copy)NSString *UVIndexText;
@property(nonatomic,copy)NSDictionary *Past24HourTemperatureDeparture;
@property(nonatomic,copy)NSString *WeatherText;
@property(nonatomic,copy)NSString *ObstructionsToVisibility;
@property(nonatomic,copy)NSDictionary *WetBulbTemperature;
@property(nonatomic,copy)NSString *MobileLink;
@property(nonatomic,copy)NSDictionary *Wind;
@property(nonatomic,copy)NSDictionary *TemperatureSummary;
@property(nonatomic,copy)NSDictionary *ApparentTemperature;
@property(nonatomic,assign)NSInteger UVIndex;
@property(nonatomic,copy)NSDictionary *PressureTendency;





@end

NS_ASSUME_NONNULL_END
