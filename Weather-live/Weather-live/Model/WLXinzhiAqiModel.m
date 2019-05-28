//
//  WLXinzhiAqiModel.m
//  Weather-live
//
//  Created by xueping on 2019/5/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLXinzhiAqiModel.h"
#import "ColorSizeMacro.h"

@implementation WLXinzhiAqiModel

- (void)calcaulteType {
    
    float value = [self.quality floatValue];
    if (value < 50) {
        self.type = WLXinzhiAqiTypeExcellent;
        self.aqiGrade = @"优";
        self.valueColor = UIColorFromRGB(0x00e904);
    } else if (value < 100) {
        self.type  =WLXinzhiAqiTypeGood;
        self.aqiGrade = @"良";
        self.valueColor = UIColorFromRGB(0xfeff00);
    } else if (value < 150) {
        self.type = WLXinzhiAqiTypeMild;
        self.aqiGrade = @"轻度污染";
        self.valueColor = UIColorFromRGB(0xff9711);
    }else if (value < 200) {
        self.type  =WLXinzhiAqiTypeModerate;
        self.aqiGrade = @"中度污染";
        self.valueColor = UIColorFromRGB(0xf90303);
    } else if (value < 300) {
        self.type = WLXinzhiAqiTypeSevere;
        self.aqiGrade = @"重度污染";
        self.valueColor = UIColorFromRGB(0x800479);
    }else {
        self.type = WLXinzhiAqiTypeSerious;
        self.aqiGrade = @"极度污染";
        self.valueColor = UIColorFromRGB(0x790622);
    }
    
    
    
}

@end
