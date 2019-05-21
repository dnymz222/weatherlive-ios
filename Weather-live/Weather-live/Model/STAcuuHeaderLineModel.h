//
//  STAcuuHeaderLineModel.h
//  Solunar Tides
//
//  Created by xueping on 2019/5/19.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface STAcuuHeaderLineModel : NSObject

@property(nonatomic,copy)NSString *Category;
@property(nonatomic,copy)NSString *EndDate;
@property(nonatomic,assign)NSInteger Severity;
@property(nonatomic,copy)NSString *EffectiveDate;
@property(nonatomic,copy)NSString *Text;
@property(nonatomic,assign)NSInteger EndEpochDate;
@property(nonatomic,assign)NSInteger EffectiveEpochDate;
@property(nonatomic,copy)NSString *Link;
@property(nonatomic,copy)NSString *MobileLink;



@end

NS_ASSUME_NONNULL_END
