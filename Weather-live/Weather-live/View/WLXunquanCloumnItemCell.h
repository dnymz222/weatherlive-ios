//
//  WLXunquanCloumnItemCell.h
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WLXunquanColumnModel;

@interface WLXunquanCloumnItemCell : UICollectionViewCell

- (void)configColumn:(WLXunquanColumnModel*)column;
@end

NS_ASSUME_NONNULL_END
