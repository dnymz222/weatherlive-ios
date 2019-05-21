//
//  LBErrorTipView.m
//  lamabiji
//
//  Created by xueping on 2018/9/22.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishErrorTipView.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"

@interface FishErrorTipView ()

@property(nonatomic,strong) UIImageView *iconView;
@property(nonatomic,strong) UILabel *titleLabel;

@end

@implementation FishErrorTipView


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
        [_delegate errorviewTapinView:self];
    }
    
    
}

- (void)setImage:(UIImage *)image title:(NSString *)title {
    [_iconView setImage:image];
    _titleLabel.text = title;
    
}

+ (void)showInView:(UIView *)superView delegate:(id<LBErrorTipViewDelegate>)delegate {
    
    if ([FishErrorTipView hasErrorviewInView:superView]) {
        return;
    }
    CGFloat width = superView.frame.size.width;
    CGFloat height = superView.frame.size.height;
    FishErrorTipView *erroview = [[FishErrorTipView alloc] initWithFrame:CGRectMake(width*0.5-80, height*0.5-120, 160, 200)];
    [superView addSubview:erroview];
    erroview.delegate = delegate;
    [erroview setImage:[UIImage imageNamed:@"loadfailed"] title:@"加载失败，请点击重试"];
    
}

+ (void)removeErrorviewInView:(UIView *)superview {
    NSArray *subviews = superview.subviews;
    for (UIView *view in subviews) {
        
        if ([view isKindOfClass:[FishErrorTipView class]]) {
            [view removeFromSuperview];
        }
    }
    
}

+ (BOOL)hasErrorviewInView:(UIView *)superView {
    
    NSArray *subviews = superView.subviews;
    
    for (UIView *view in subviews) {
        
        if ([view isKindOfClass:[FishErrorTipView class]]) {
            return YES;
        }
    }
    
    return NO;
}

/*

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
