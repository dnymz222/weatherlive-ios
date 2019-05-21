//
//  LBCateModel.h
//  lamabiji
//
//  Created by mc on 2018/9/15.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FishCateModel : NSObject

@property(nonatomic,copy)NSString *cateId;
@property(nonatomic,copy)NSString *url;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,assign)NSInteger type;
@property(nonatomic,assign)BOOL five;


@end
