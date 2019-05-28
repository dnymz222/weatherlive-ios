//
//  WXPErrorTipView.h
//  xunquan
//
//  Created by xueping on 2018/6/4.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WXPErrorTipView;
@protocol WXPErrorTipViewDelegate<NSObject>

- (void)errorviewTapinView:(WXPErrorTipView *)errorView;
@end

@interface WXPErrorTipView : UIView

@property(nonatomic,weak)id <WXPErrorTipViewDelegate> delegate;

- (void)setImage:(UIImage *)image title:(NSString *)title;
+ (void)removeErrorviewInView:(UIView *)superview;

+ (void)showInView:(UIView *)superView delegate:(id<WXPErrorTipViewDelegate>) delegate;

@end
