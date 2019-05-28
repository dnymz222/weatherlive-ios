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

@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *imageUrl;
@property(nonatomic,copy)NSString *specialId;
@property(nonatomic,copy)NSString *bannerUrl;
@property(nonatomic,copy)NSString *bannerId;
@property(nonatomic,assign)NSInteger type;//1.网页 2.淘宝 3.跳转;

@end

NS_ASSUME_NONNULL_END
