//
//  WLXunquanColumnCell.h
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN


@protocol WLXunquanColumnCellDelegate <NSObject>

- (void)WLXunquanColumnCellDidSelectIndex:(NSInteger)index;

@end

@interface WLXunquanColumnCell : UITableViewCell

@property(nonatomic,weak)id <WLXunquanColumnCellDelegate> delegate;


- (void)configItemList:(NSArray *)itemList;

@end

NS_ASSUME_NONNULL_END
