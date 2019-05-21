//
//  LBToast.m
//  lamabiji
//
//  Created by xueping on 2018/9/22.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishToast.h"
#import "UIView+Toast.h"

@implementation FishToast

+ (void)view:(UIView*)view toastMessage:(NSString*)message
{
    
    
    [view makeToast:message duration:0.25f position:CSToastPositionCenter];
    
    
}


+ (void)view:(UIView *)view toastError:(NSError*)error
{
    
    if (error.code == 20001) {
        [view makeToast:@"没有数据了" duration:0.25f position:CSToastPositionCenter];
    }else{
        
        NSString *string = [error.userInfo valueForKey:NSLocalizedDescriptionKey];
        
        [view makeToast:string duration:0.25f position:CSToastPositionCenter];
        
        
        
    }
    
    
    
}


@end
