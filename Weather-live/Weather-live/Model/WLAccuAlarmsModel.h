//
//  WLAccuAlarmsModel.h
//  Weather-live
//
//  Created by xueping on 2019/5/24.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>


NS_ASSUME_NONNULL_BEGIN



@interface WLAccuAlarmsModel : NSObject

@property(nonatomic,copy)NSString *Date;
@property(nonatomic,copy)NSString *Link;
@property(nonatomic,assign)NSInteger EpochDate;
@property(nonatomic,copy)NSDictionary *Alarms;
@property(nonatomic,copy)NSString *MobileLink;

@end




NS_ASSUME_NONNULL_END
