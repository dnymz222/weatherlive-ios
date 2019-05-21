//
//  LBDetailTitleCell.h
//  lamabiji
//
//  Created by xueping on 2018/9/30.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FishDetailItemModel,FishCouponItemModel;

@protocol LBDetailTitleCellDelegate <NSObject>

@optional

- (void)couponButtonClick:(UIButton *)button;

@end

@interface FishDetailTitleCell : UITableViewCell

@property(nonatomic,weak)id <LBDetailTitleCellDelegate> delegate;
- (void)configWithDetailItemModel:(FishDetailItemModel *)itemModel coupon:(FishCouponItemModel *)couponModel;
@end

NS_ASSUME_NONNULL_END
