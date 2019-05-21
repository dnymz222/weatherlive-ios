//
//  LBUser.m
//  lamabiji
//
//  Created by mc on 2018/9/14.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishAliUser.h"

@implementation FishAliUser

+ (FishAliUser *)shareInstance {
    
    static FishAliUser *user;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        user = [[FishAliUser alloc] init];
    });
    
    return user;
}

- (instancetype)init {
    
    self = [super init];
    if (self) {
        
        if ([[NSUserDefaults standardUserDefaults] valueForKey:@"wl_cartpath"]) {
            
            self.showscore  = (int) [[NSUserDefaults standardUserDefaults ] integerForKey:@"wl_showscore"];
            self.showdetail = [[NSUserDefaults standardUserDefaults] boolForKey:@"wl_showdetail"];
            self.openh5  = [[NSUserDefaults standardUserDefaults] boolForKey:@"wl_openh5"];
            self.openTaobao = [[NSUserDefaults standardUserDefaults] boolForKey:@"wl_openTaobao"];
            self.cartpath  = [[NSUserDefaults standardUserDefaults] valueForKey:@"wl_cartpath"];
            self.cartjs  = [[NSUserDefaults standardUserDefaults] valueForKey:@"wl_cartjs"];
            self.guideurl   = [[NSUserDefaults standardUserDefaults] valueForKey:@"wl_guideurl"];
            self.showrate = [[NSUserDefaults standardUserDefaults] integerForKey:@"wl_showrate"];
            
            
        }
        
    }
    
    
    return self;
}

- (void)storeData  {
    
    
    [[NSUserDefaults standardUserDefaults] setBool:self.showdetail forKey:@"wl_showdetail"];
    [[NSUserDefaults standardUserDefaults] setBool:self.openh5 forKey:@"wl_openh5"];
    [[NSUserDefaults standardUserDefaults] setBool:self.openTaobao forKey:@"wl_openTaobao"];
    [[NSUserDefaults standardUserDefaults] setInteger:self.showscore forKey:@"wl_showscore"];
    [[NSUserDefaults standardUserDefaults] setObject:self.cartjs forKey:@"wl_cartjs"];
    [[NSUserDefaults standardUserDefaults] setObject:self.cartpath forKey:@"wl_cartpath"];
    [[NSUserDefaults standardUserDefaults] setObject:self.guideurl forKey:@"wl_guideurl"];
    [[NSUserDefaults standardUserDefaults] setInteger:self.showrate forKey:@"wl_showrate"];
    
}

@end
