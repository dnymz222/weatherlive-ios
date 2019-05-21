//
//  STAcuuWeatherFooterView.m
//  Solunar Tides
//
//  Created by xueping on 2019/5/19.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "STAcuuWeatherFooterView.h"
#import "Masonry.h"

@interface STAcuuWeatherFooterView ()

@property(nonatomic,strong)UIButton *linkButton;

@end

@implementation STAcuuWeatherFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.linkButton];
        
        [self.linkButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.equalTo(@212);
            make.height.equalTo(@30);
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


-(void)buttonClick:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(AcuuWeatherFooterViewClickButtonLink)]) {
        [self.delegate AcuuWeatherFooterViewClickButtonLink];
    }
    
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
