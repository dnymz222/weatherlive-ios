//
//  LBCouponDetailBottomView.h
//  lamabiji
//
//  Created by mc on 2018/9/17.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>\

@protocol LBCouponDetailBottomViewDelegate<NSObject>


@optional
- (void)bottomViewClickButtonAtIndex:(NSInteger)buttonIndex;

@end

@interface FishCouponDetailBottomView : UIView

@property(nonatomic,weak)id <LBCouponDetailBottomViewDelegate> delegate;

@end
