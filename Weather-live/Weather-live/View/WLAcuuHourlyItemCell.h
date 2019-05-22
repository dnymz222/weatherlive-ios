//
//  WLAcuuHourlyItemCell.h
//  Weather-live
//
//  Created by xueping on 2019/5/22.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WLAccuHourlyModel;

@interface WLAcuuHourlyItemCell : UICollectionViewCell

- (void)configHourlyModel:(WLAccuHourlyModel *)model;


@end

NS_ASSUME_NONNULL_END
