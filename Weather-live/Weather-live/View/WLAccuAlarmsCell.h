//
//  WLAccuAlarmsCell.h
//  Weather-live
//
//  Created by xueping on 2019/5/24.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WLAccuAlarmsModel;

@interface WLAccuAlarmsCell : UITableViewCell


- (void)configAlarms:(WLAccuAlarmsModel *)alarms;

@end

NS_ASSUME_NONNULL_END
