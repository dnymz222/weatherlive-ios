//
//  WLXinzhiAqiCell.h
//  Weather-live
//
//  Created by xueping on 2019/5/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WLXinzhiAqiModel;

@interface WLXinzhiAqiCell : UITableViewCell

- (void)configAqiModel:(WLXinzhiAqiModel *)model;

@end

NS_ASSUME_NONNULL_END
