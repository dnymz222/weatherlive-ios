//
//  WXPSortHeaderView.h
//  xunquan
//
//  Created by xueping on 2018/11/20.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WXPSortHeaderViewDelegate <NSObject>

@optional;

- (void)sortHeaderChangeStatusWithString:(NSString *)sort;

@end

@interface WXPSortHeaderView : UIView

@property(nonatomic,weak)id <WXPSortHeaderViewDelegate> delegate;

- (void)resertStatus;


@end

NS_ASSUME_NONNULL_END
