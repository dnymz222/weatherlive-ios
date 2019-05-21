//
//  STAcuuWeatherHeaderView.h
//  Solunar Tides
//
//  Created by xueping on 2019/5/19.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class STAcuuWeatherDailyModel;

@interface STAcuuWeatherHeaderView : UITableViewHeaderFooterView

- (void)configWithModel:(STAcuuWeatherDailyModel *)model;

@end

NS_ASSUME_NONNULL_END
