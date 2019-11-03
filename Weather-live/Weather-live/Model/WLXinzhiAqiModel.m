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
    
    float value = [self.aqi floatValue];
    if (value < 50) {
        self.type = WLXinzhiAqiTypeExcellent;
        self.aqiGrade = NSLocalizedString(@"a", nil);
        self.valueColor = UIColorFromRGB(0x00e904);
    } else if (value < 100) {
        self.type  =WLXinzhiAqiTypeGood;
        self.aqiGrade = NSLocalizedString(@"b", nil);;
        self.valueColor = UIColorFromRGB(0xf9dd64);
    } else if (value < 150) {
        self.type = WLXinzhiAqiTypeMild;
        self.aqiGrade = NSLocalizedString(@"c", nil);;
        self.valueColor = UIColorFromRGB(0xff9711);
    }else if (value < 200) {
        self.type  =WLXinzhiAqiTypeModerate;
        self.aqiGrade = NSLocalizedString(@"d", nil);;
        self.valueColor = UIColorFromRGB(0xf90303);
    } else if (value < 300) {
        self.type = WLXinzhiAqiTypeSevere;
        self.aqiGrade = NSLocalizedString(@"e", nil);;
        self.valueColor = UIColorFromRGB(0x800479);
    }else {
        self.type = WLXinzhiAqiTypeSerious;
        self.aqiGrade = NSLocalizedString(@"f", nil);;
        self.valueColor = UIColorFromRGB(0x790622);
    }
    
    
    
}

@end
