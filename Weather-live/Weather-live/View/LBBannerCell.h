//
//  LBBannerCell.h
//  lamabiji
//
//  Created by xueping on 2018/11/13.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol LBBannerCellDelegate <NSObject>

@optional

- (void)lbBannerCellClickImageAtIndex:(NSInteger)index;

@end

@interface LBBannerCell : UITableViewCell

- (void)configImageArray:(NSArray *)imageArray;

@property(nonatomic,weak)id <LBBannerCellDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
