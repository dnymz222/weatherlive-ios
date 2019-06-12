//
//  WLXunquanBannerModel.h
//  Weather-live
//
//  Created by xueping on 2019/5/27.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLXunquanBannerModel : NSObject

@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *welfareId;
@property(nonatomic,copy)NSString *status;
@property(nonatomic,copy)NSString *onTime;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *endTime;
@property(nonatomic,copy)NSString *activeUrl;
@property(nonatomic,copy)NSString *welfareUrl;
@property(nonatomic,assign)NSInteger type;//0.没有安装去推广 1.已经安装了打开链接

@end

NS_ASSUME_NONNULL_END
