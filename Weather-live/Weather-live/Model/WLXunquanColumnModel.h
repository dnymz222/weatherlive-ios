//
//  WLXunquanColumnModel.h
//  Weather-live
//
//  Created by xueping on 2019/5/28.
//  Copyright © 2019 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface WLXunquanColumnModel : NSObject

@property(nonatomic,assign)NSInteger type;
@property(nonatomic,copy)NSString *name;
@property(nonatomic,copy)NSString *image;
@property(nonatomic,copy)NSString *itemId;
@property(nonatomic,copy)NSString *url;


@end

NS_ASSUME_NONNULL_END
