//
//  WLAccuCurrentCell.h
//  Weather-live
//
//  Created by xueping on 2019/5/22.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WLAccuCurrentModel;

@interface WLAccuCurrentCell : UITableViewCell

- (void)configCurrentModel:(WLAccuCurrentModel *)model;

@end

NS_ASSUME_NONNULL_END
