//
//  WXPErrorTipView.m
//  xunquan
//
//  Created by xueping on 2018/6/4.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "WXPErrorTipView.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"

@interface WXPErrorTipView ()

@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *titleLabel;

@property(nonatomic,assign)NSInteger    lastTime;

@end

@implementation WXPErrorTipView


- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.iconView];
        [self addSubview:self.titleLabel];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.equalTo(self);
            make.height.equalTo(@(frame.size.width));
        }];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.bottom.equalTo(self);
            make.height.equalTo(@40);
        }];
        
        UITapGestureRecognizer *tap  = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIn:)];
        [self addGestureRecognizer:tap];
        tap.numberOfTapsRequired = 1;
        
        self.lastTime = 0;
        
        
    }
    
    return self;
}


- (UIImageView *)iconView {
    
    if (!_iconView) {
        _iconView = [[UIImageView alloc] init];
        _iconView.userInteractionEnabled = YES;
        _iconView.contentMode = UIViewContentModeScaleAspectFit;
    }
    
    return _iconView;
}

- (UILabel *)titleLabel {
    
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.textColor  = UIColorFromRGB(0x999999);
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
    }
    
    return _titleLabel;
}

- (void)tapIn:(UITapGestureRecognizer *)regnizer {
    
    
    if (_delegate  && [_delegate respondsToSelector:@selector(errorviewTapinView:)]) {
        
        NSInteger nowtime  = [[NSDate date] timeIntervalSince1970];
        if ((nowtime-self.lastTime) > 5) {
            self.lastTime = nowtime;
             [_delegate errorviewTapinView:self];
            
        }
        
       
    }
    
    
}

- (void)setImage:(UIImage *)image title:(NSString *)title {
    [_iconView setImage:image];
    _titleLabel.text = title;
    
}

+ (void)showInView:(UIView *)superView delegate:(id<WXPErrorTipViewDelegate>)delegate {
    
    if ([WXPErrorTipView hasErrorviewInView:superView]) {
        return;
    }
    CGFloat width = superView.frame.size.width;
    CGFloat height = superView.frame.size.height;
    WXPErrorTipView *erroview = [[WXPErrorTipView alloc] initWithFrame:CGRectMake(width*0.5-80, height*0.5-120, 160, 200)];
    [superView addSubview:erroview];
    erroview.delegate = delegate;
    [erroview setImage:[UIImage imageNamed:@"loaderror"] title:@"加载失败，请点击重试"];
    
}

+ (void)removeErrorviewInView:(UIView *)superview {
    NSArray *subviews = superview.subviews;
    for (UIView *view in subviews) {
        
        if ([view isKindOfClass:[WXPErrorTipView class]]) {
            [view removeFromSuperview];
        }
    }
    
}

+ (BOOL)hasErrorviewInView:(UIView *)superView {
    
    NSArray *subviews = superView.subviews;
 
    for (UIView *view in subviews) {
        
        if ([view isKindOfClass:[WXPErrorTipView class]]) {
            return YES;
        }
    }
    
    return NO;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
