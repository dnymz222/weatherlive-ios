//
//  WLAccuFooterReusableView.m
//  Weather-live
//
//  Created by xueping on 2019/5/29.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAccuFooterReusableView.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"

@interface WLAccuFooterReusableView ()
@property(nonatomic,strong)UIButton *linkButton;

@property(nonatomic,strong)UILabel *powerLabel;
@end

@implementation WLAccuFooterReusableView


- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.linkButton];
        [self addSubview:self.powerLabel];
        
        [self.linkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self).offset(50);
            make.centerY.equalTo(self);
            make.width.equalTo(@170);
            make.height.equalTo(@24);
        }];
        
        [self.powerLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.linkButton.mas_left).offset(-5);
            make.left.equalTo(self).offset(10);
            make.centerY.equalTo(self);
            make.height.equalTo(@26);
        }];
        
        
    }
    
    return self;
}


- (UIButton *)linkButton {
    if (!_linkButton) {
        _linkButton = [UIButton buttonWithType:UIButtonTypeCustom];
        UIImage *image = [UIImage imageNamed:@"AW_CMYK_Small"];
        [_linkButton setImage:image forState:UIControlStateNormal];
        [_linkButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    return _linkButton;
}

- (UILabel *)powerLabel {
    
    if (!_powerLabel) {
        _powerLabel = [[UILabel alloc] init];
        _powerLabel.textAlignment = NSTextAlignmentRight;
        _powerLabel.font = [UIFont systemFontOfSize:18.f];
        _powerLabel.textColor = UIColorFromRGB(0x666666);
        _powerLabel.text = @"Powered by";
    }
    
    return _powerLabel;
}


-(void)buttonClick:(UIButton *)button {
    
    if (self.delegate ) {
        [self.delegate AcuuWeatherFooterViewClickButtonLink];
    }
    
}



@end
