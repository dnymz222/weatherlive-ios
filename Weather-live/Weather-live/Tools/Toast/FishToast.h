//
//  LBToast.h
//  lamabiji
//
//  Created by xueping on 2018/9/22.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface FishToast : NSObject

+ (void)view:(UIView*)view toastMessage:(NSString*)message;


+ (void)view:(UIView *)view toastError:(NSError*)error;

@end

NS_ASSUME_NONNULL_END
