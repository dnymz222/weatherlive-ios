//
//  LBImageListCell.h
//  lamabiji
//
//  Created by xueping on 2018/9/30.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class FishImageItemModel;

@protocol LBImageListCellDelegate <NSObject>

@optional

- (void)reloadImageHeight;

@end

@interface FishImageListCell : UITableViewCell

@property(nonatomic,weak)id <LBImageListCellDelegate> delegate;

- (void)configWithModel:(FishImageItemModel *)imageModel;

@end

NS_ASSUME_NONNULL_END
