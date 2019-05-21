//
//  LBDetailItemModel.h
//  lamabiji
//
//  Created by xueping on 2018/9/29.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FishDetailItemModel : NSObject
@property(nonatomic,copy)NSString *itemId;
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;
@property(nonatomic,copy)NSArray *images;
@property(nonatomic,copy)NSString *categoryId;
@property(nonatomic,copy)NSString *rootCategoryId;
@property(nonatomic,copy)NSString *brandValueId;
@property(nonatomic,copy)NSString *commentCount;
@property(nonatomic,copy)NSString *favcount;
@property(nonatomic,copy)NSString *tmallDescUrl;
@property(nonatomic,copy)NSString *moduleDescUrl;



@end

NS_ASSUME_NONNULL_END
