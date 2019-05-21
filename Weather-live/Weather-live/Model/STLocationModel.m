//
//  STLocationModel.m
//  Solunar Tides
//
//  Created by xueping on 2019/5/12.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "STLocationModel.h"

@interface STLocationModel ()

@property(nonatomic,strong)CLGeocoder *gecoder;

@end

@implementation STLocationModel

- (instancetype)initWithClLocation:(CLLocation *)location {
    
    self = [super init];
    if (self) {
        self.location = location;
    }
    
    return self;
}


- (void)reverseGeocodeCompleted:(void (^)(NSString * _Nonnull name))block  {
    
    if (_name) {
        block(_name);
        return;
    }
    
    CLLocation *loction = self.location;
    __weak typeof(self) wself = self;
    [self.gecoder reverseGeocodeLocation:loction completionHandler:^(NSArray<CLPlacemark *> * _Nullable placemarks, NSError * _Nullable error) {
        
        if ((!error)  && placemarks.count  ) {
            CLPlacemark *mark0 = [placemarks firstObject];
            NSDictionary *dict = mark0.addressDictionary;
            if (!dict) {
                wself.name = @"";
                block(wself.name);
            } else {
                
                NSString *name = [NSString stringWithFormat:@"%@ %@",dict[@"City"],dict[@"SubLocality"]];
                wself.name = name;
                block(name);
            }
        }
        
    }];
    
}

- (CLGeocoder *)gecoder {
    
    if (!_gecoder) {
        _gecoder = [[CLGeocoder alloc] init];
    }
    
    return _gecoder;
}


- (double)distanceBetweenOtherLocation:(STLocationModel *)othermodel {
    
    CLLocation *cuurrentLOcation = self.location;
    CLLocation *otherLocation = othermodel.location;
    
    return [cuurrentLOcation distanceFromLocation:otherLocation];
}


@end
