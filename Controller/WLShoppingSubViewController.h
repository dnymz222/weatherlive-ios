//
//  WLShoppingSubViewController.h
//  Weather-live
//
//  Created by xueping on 2019/5/21.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class WLCateModel;

@interface WLShoppingSubViewController : UIViewController

@property(nonatomic,assign)NSInteger index;

- (void)configCateModel:(WLCateModel *)cate;

@end

NS_ASSUME_NONNULL_END
