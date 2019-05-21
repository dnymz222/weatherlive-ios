//
//  STLocationModel.h
//  Solunar Tides
//
//  Created by xueping on 2019/5/12.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
NS_ASSUME_NONNULL_BEGIN

@interface STLocationModel : NSObject

//@property(nonatomic,assign)double longtitude;
//@property(nonatomic,assign)double latitude;
//@property(nonatomic,assign)double altitude;

@property(nonatomic,strong)CLLocation *location;
@property(nonatomic,copy)NSString *name;


- (instancetype)initWithClLocation:(CLLocation *)location;


- (void)reverseGeocodeCompleted:(void(^)(NSString *name))block;

- (double)distanceBetweenOtherLocation:(STLocationModel *)othermodel;

@end

NS_ASSUME_NONNULL_END
