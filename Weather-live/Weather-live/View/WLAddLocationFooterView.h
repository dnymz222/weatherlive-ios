//
//  WLAddLocationFooterView.h
//  Weather-live
//
//  Created by xueping on 2019/8/27.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  WLAddLocationFooterViewDelegate  <NSObject>

- (void)addbuttonClick;

@end

@interface WLAddLocationFooterView : UITableViewHeaderFooterView

@property(nonatomic,weak)id <WLAddLocationFooterViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
