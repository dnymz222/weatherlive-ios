//
//  WLAccuIndexModel.h
//  Weather-live
//
//  Created by xueping on 2019/5/23.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLAccuIndexModel : NSObject

@property(nonatomic,copy)NSString *Category;
@property(nonatomic,copy)NSString *Name;
@property(nonatomic,copy)NSString *Text;
@property(nonatomic,assign)float Value;
@property(nonatomic,assign)BOOL Ascending;
@property(nonatomic,copy)NSString *Link;
@property(nonatomic,copy)NSString *LocalDateTime;
@property(nonatomic,assign)NSInteger ID;
@property(nonatomic,copy)NSString *MobileLink;
@property(nonatomic,assign)NSInteger EpochDateTime;
@property(nonatomic,assign)NSInteger CategoryValue;

@property(nonatomic,copy)NSString *Day;


- (void)caculateDay;




@end

NS_ASSUME_NONNULL_END
