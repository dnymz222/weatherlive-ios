//
//  NSString+LB.h
//  lamabiji
//
//  Created by xueping on 2018/9/17.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LB)

- (NSString*)fish_encodeToPercentEscapeString;
- (NSString*)fish_decodeFromPercentEscapeString;

+ (NSString *)fish_dictTojsonWithJsonObject:(id)dict;

+ (NSDictionary *)fish_jsonTodictWithString:(NSString *)json;



@end

NS_ASSUME_NONNULL_END
