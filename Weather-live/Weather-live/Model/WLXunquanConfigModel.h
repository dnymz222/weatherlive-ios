//
//  WLXunquanConfigModel.h
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLXunquanConfigModel : NSObject

@property(nonatomic,assign)NSInteger scancart;
@property(nonatomic,copy)NSString  *cartpath;
@property(nonatomic,copy)NSString *cartjs;



@end

NS_ASSUME_NONNULL_END
