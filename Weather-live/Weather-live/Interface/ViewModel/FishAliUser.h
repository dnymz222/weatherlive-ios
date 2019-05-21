//
//  LBUser.h
//  lamabiji
//
//  Created by mc on 2018/9/14.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FishAliUser : NSObject

@property(nonatomic,assign)BOOL openTaobao;

@property(nonatomic,assign)BOOL openh5;
@property(nonatomic,copy)NSString *cartjs;
@property(nonatomic,assign)int showscore;
@property(nonatomic,copy)NSString *guideurl;
@property(nonatomic,copy)NSString *cartpath;
@property(nonatomic,assign)BOOL showdetail;
@property(nonatomic,assign)NSInteger showrate;

+ (FishAliUser *)shareInstance;

- (void)storeData;

@end
