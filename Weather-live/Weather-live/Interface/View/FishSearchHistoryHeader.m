//
//  LBSearchHistoryHeader.m
//  lamabiji
//
//  Created by xueping on 2018/11/19.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishSearchHistoryHeader.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"

@interface FishSearchHistoryHeader ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UIButton *clearButton;


@end

@implementation FishSearchHistoryHeader


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        self.contentView.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.clearButton];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@160);
            make.height.equalTo(@24);
        }];
        
        
        [self.clearButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@36);
            make.height.equalTo(@36);
        }];
        
        
        
        
    }
    
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/


- (UILabel *)titleLabel {
    
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14.0];
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        _titleLabel.text = @"历史搜索";
      
        
        
        
    }
    
    
    return _titleLabel;
    
}


- (UIButton *)clearButton {
    
    if (!_clearButton) {
        _clearButton = [UIButton buttonWithType:UIButtonTypeCustom];
//        NSAttributedString *attrs =  [NSAttributedString wxp_iconFontWithCode:WXPIconfontDelete Size:18.f color:UIColorFromRGB(0x999999)];
//        [_clearButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        UIImage *image = [UIImage imageNamed:@"clear"];
        [_clearButton setImage:image forState:UIControlStateNormal];
        
        
        [_clearButton addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _clearButton;
}


- (void)buttonClick:(UIButton*)button {
    
    
    if (_delegate && [_delegate respondsToSelector:@selector(searchHistoryClearButtonClick)]) {
        
        [_delegate searchHistoryClearButtonClick];
    }
    
    
}


@end
