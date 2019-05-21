//
//  WXPSortHeaderView.m
//  xunquan
//
//  Created by xueping on 2018/11/20.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "WXPSortHeaderView.h"
#import "WXPSortItemView.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"


@interface  WXPSortHeaderView ()<WXPSortItemViewDelegate>

@property(nonatomic,strong)WXPSortItemView *comprehensiveView;
@property(nonatomic,strong)WXPSortItemView *saleView;
@property(nonatomic,strong)WXPSortItemView *priceView;

@end

@implementation WXPSortHeaderView

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColorFromRGB(0xf6f6f6);
        [self addSubview:self.comprehensiveView];
        [self addSubview:self.saleView];
        [self addSubview:self.priceView];
        
        [self.saleView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self);
            make.top.bottom.equalTo(self);
            make.width.equalTo(@66);
        }];
        
        [self.comprehensiveView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(30);
            make.top.bottom.equalTo(self);
            make.width.equalTo(@66);
        
        }];
        
        [self.priceView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self).offset(-30);
            make.top.bottom.equalTo(self);
            make.width.equalTo(@66);
            
        }];
        
        [self.comprehensiveView configTitle:@"综合"];
        [self.saleView configTitle:@"销量"];
        [self.priceView configTitle:@"价格"];
        
        [self.priceView configIsPrice:YES];
        
        
    }
   
    return self;
    
}

- (WXPSortItemView *)comprehensiveView {
    if (!_comprehensiveView) {
        _comprehensiveView = [[WXPSortItemView alloc] init];
        
        _comprehensiveView.delegate = self;
        _comprehensiveView.tag = 0;

    }
    
    return _comprehensiveView ;
}

- (WXPSortItemView *)saleView {
    if (!_saleView) {
        _saleView = [[WXPSortItemView alloc] init];
        
        _saleView.delegate = self;
        _saleView.tag = 1;
        
    }
    
    return _saleView ;
}

- (WXPSortItemView *)priceView {
    if (!_priceView) {
        _priceView= [[WXPSortItemView alloc] init];
        
        _priceView.delegate = self;
        _priceView.tag = 2;
        
    }
    
    return _priceView ;
}

- (void)resertStatus {
    [self.comprehensiveView configSlectIndex:0];
    [self.saleView configSlectIndex:0];
    [self.priceView configSlectIndex:0];
    
}



- (void)sortItemViewTapInselectIndex:(NSInteger)selectIndex {
    
    [self.comprehensiveView configSlectIndex:selectIndex];
    [self.saleView configSlectIndex:selectIndex];
    [self.priceView configSlectIndex:selectIndex];
    
    if (_delegate && [_delegate respondsToSelector:@selector(sortHeaderChangeStatusWithString:)]) {
        NSString *sort;
        if (0 == selectIndex) {
            sort = nil;
        } else if (1 == selectIndex ) {
            sort = @"total_sales_des";
        } else if (2 == selectIndex) {
            
            sort   = @"price_asc";
        }
        
        [_delegate sortHeaderChangeStatusWithString:sort];
    }
    
    
}

- (void)sortItemViewTapPriceChangeWithStatus:(NSInteger)status {
    
    if (_delegate && [_delegate respondsToSelector:@selector(sortHeaderChangeStatusWithString:)]) {
        NSString *sort;
        if (1 == status) {
            sort =@"price_asc" ;
        }  else {
            
            sort   = @"price_des";
        }
        
        [_delegate sortHeaderChangeStatusWithString:sort];
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
