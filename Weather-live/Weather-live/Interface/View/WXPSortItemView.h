//
//  WXPSortItemView.h
//  xunquan
//
//  Created by xueping on 2018/11/20.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol WXPSortItemViewDelegate <NSObject>
@optional;
- (void)sortItemViewTapInselectIndex:(NSInteger)selectIndex ;

- (void)sortItemViewTapPriceChangeWithStatus:(NSInteger)status;//1:升序 2：降序

@end

@interface WXPSortItemView : UIView

@property(nonatomic,weak)id <WXPSortItemViewDelegate> delegate;

- (void)configTitle:(NSString *)title;

- (void)configIsPrice:(BOOL)isPrice;

- (void)configSlectIndex:(NSInteger)slectIndex;

@end

NS_ASSUME_NONNULL_END
