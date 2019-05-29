//
//  WLTaobaoCouponCell.h
//  Weather-live
//
//  Created by xueping on 2019/5/26.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@class WLCouponItemModel;

@interface WLTaobaoCouponCell : UITableViewCell

- (void)configWithCoupon:(WLCouponItemModel *)coupon;




@end

NS_ASSUME_NONNULL_END
