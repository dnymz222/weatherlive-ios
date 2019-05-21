//
//  LBSearchHistoryHeader.h
//  lamabiji
//
//  Created by xueping on 2018/11/19.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LBSearchHistoryHeaderDelegate <NSObject>

@optional

- (void)searchHistoryClearButtonClick;



@end

@interface FishSearchHistoryHeader : UITableViewHeaderFooterView


@property(nonatomic,weak)id <LBSearchHistoryHeaderDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
