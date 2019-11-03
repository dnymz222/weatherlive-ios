//
//  WLAddLocationFooterView.m
//  Weather-live
//
//  Created by xueping on 2019/8/27.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAddLocationFooterView.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "WLColor.h"

@interface WLAddLocationFooterView ()

@property(nonatomic,strong)UIButton *addbutton;

@end

@implementation WLAddLocationFooterView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.addbutton];
        [self.addbutton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.equalTo(self.contentView);
            make.centerX.equalTo(self.contentView);
            make.width.equalTo(@200);
        }];
        
        
    }
    return self;
}

- (UIButton *)addbutton {
    if (!_addbutton) {
        _addbutton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_addbutton setImage:[UIImage imageNamed:@"addition"] forState:UIControlStateNormal];
        [_addbutton setTitle:NSLocalizedString(@"add location", nil) forState:UIControlStateNormal];
        [_addbutton setTitleColor:[WLColor boldcolor] forState:UIControlStateNormal];
        [_addbutton  addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _addbutton;
}

- (void)buttonClick:(UIButton *)button {
    
    if (_delegate ) {
        [_delegate addbuttonClick];
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
