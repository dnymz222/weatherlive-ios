//
//  WLAccuLocationModel.h
//  Weather-live
//
//  Created by xueping on 2019/5/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLAccuLocationModel : NSObject

@property(nonatomic,copy)NSDictionary *SupplementalAdminAreas;
@property(nonatomic,copy)NSDictionary *ParentCity;
@property(nonatomic,copy)NSDictionary *Country;
@property(nonatomic,copy)NSDictionary *Region;
@property(nonatomic,assign)BOOL IsAlias;
@property(nonatomic,assign)NSInteger Rank;
@property(nonatomic,copy)NSString *LocalizedName;
@property(nonatomic,assign)NSInteger Version;
@property(nonatomic,copy)NSString *PrimaryPostalCode;

@property(nonatomic,copy)NSString *Key;
@property(nonatomic,copy)NSDictionary *DataSets;
@property(nonatomic,copy)NSDictionary *TimeZone;
@property(nonatomic,copy)NSString*EnglishName;
@property(nonatomic,copy)NSDictionary *AdministrativeArea;
@property(nonatomic,copy)NSString *Type;
@property(nonatomic,copy)NSDictionary *GeoPosition;



@end

NS_ASSUME_NONNULL_END
