//
//  STAcuuWeatherDailyCell.h
//  Solunar Tides
//
//  Created by xueping on 2019/5/18.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class STAcuuWeatherDailyModel;

@interface STAcuuWeatherDailyCell : UITableViewCell



- (void)configModel:(STAcuuWeatherDailyModel *)model day:(BOOL)isDay;

@end

NS_ASSUME_NONNULL_END
