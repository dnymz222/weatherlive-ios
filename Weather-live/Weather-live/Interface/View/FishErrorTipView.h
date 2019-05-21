//
//  LBErrorTipView.h
//  lamabiji
//
//  Created by xueping on 2018/9/22.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FishErrorTipView;
@protocol LBErrorTipViewDelegate<NSObject>

- (void)errorviewTapinView:(FishErrorTipView*)errorView;
@end


@interface FishErrorTipView : UIView


@property(nonatomic,weak)id <LBErrorTipViewDelegate> delegate;

+ (void)removeErrorviewInView:(UIView *)superview;

+ (void)showInView:(UIView *)superView delegate:(id<LBErrorTipViewDelegate>) delegate;


@end

NS_ASSUME_NONNULL_END
