//
//  LBSellerModel.h
//  lamabiji
//
//  Created by xueping on 2018/9/29.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FishSellerScoreModel : NSObject
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *score;
@property(nonatomic,copy)NSString *type;
@property(nonatomic,copy)NSString *level;
@property(nonatomic,copy)NSString *levelText;
@property(nonatomic,copy)NSString *levelTextColor;
@property(nonatomic,copy)NSString *levelBackgroundColor;
@property(nonatomic,copy)NSString *tmallLevelTextColor;
@property(nonatomic,copy)NSString *tmallLevelBackgroundColor;
@end


@interface FishSellerModel : NSObject

@property(nonatomic,copy)NSString *userId;
@property(nonatomic,copy)NSString *shopId;
@property(nonatomic,copy)NSString *shopName;
@property(nonatomic,copy)NSString *shopUrl;
@property(nonatomic,copy)NSString *taoShopUrl;
@property(nonatomic,copy)NSString *shopIcon;
@property(nonatomic,copy)NSString *fans;
@property(nonatomic,copy)NSString *allItemCount;
@property(nonatomic,copy)NSString *shopCard;
@property(nonatomic,copy)NSString *sellerType;
@property(nonatomic,copy)NSString *shopType;
@property(nonatomic,copy)NSArray<FishSellerScoreModel *> *evaluates;
@property(nonatomic,copy)NSString *sellerNick;
@property(nonatomic,copy)NSString *creditLevel;
@property(nonatomic,copy)NSString *creditLevelIcon;
@property(nonatomic,copy)NSString *tagIcon;
@property(nonatomic,copy)NSString *starts;
@property(nonatomic,copy)NSString *goodRatePercentage;
@property(nonatomic,copy)NSString *fbt2User;



@end

NS_ASSUME_NONNULL_END
