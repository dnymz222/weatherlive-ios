//
//  LBSettingCell.h
//  lamabiji
//
//  Created by xueping on 2018/9/24.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FishSettingCell : UITableViewCell

@property(nonatomic,strong,readonly)UIImageView *iconView;
@property(nonatomic,strong,readonly)UILabel *titleLabel;
@property(nonatomic,strong,readonly)UILabel *detailLabel;

@end

NS_ASSUME_NONNULL_END
