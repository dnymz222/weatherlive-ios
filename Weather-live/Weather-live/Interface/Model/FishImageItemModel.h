//
//  LBImageItemModel.h
//  lamabiji
//
//  Created by xueping on 2018/9/30.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FishImageItemModel : NSObject

@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *width;
@property(nonatomic,copy)NSString *height;
@property(nonatomic,assign)CGFloat outHeight;


@end

NS_ASSUME_NONNULL_END
