//
//  LBCouponCollectionViewCell.h
//  lamabiji
//
//  Created by mc on 2018/9/12.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WLCouponItemModel;

@interface WLCouponCollectionViewCell : UICollectionViewCell

- (void)congfigWithModel:(WLCouponItemModel*)model;

@end