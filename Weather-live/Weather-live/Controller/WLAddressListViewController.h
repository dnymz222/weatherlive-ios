//
//  WLAddressListViewController.h
//  Weather-live
//
//  Created by xueping on 2019/8/27.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class STLocationModel;

@protocol WLAddressListViewControllerDelegate <NSObject>

- (void)addresslistSelectlocation:(STLocationModel *)loction;

@end

@interface WLAddressListViewController : UIViewController

@property(nonatomic,weak)id<WLAddressListViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
