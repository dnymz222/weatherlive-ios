//
//  LBImagItemCell.m
//  lamabiji
//
//  Created by xueping on 2018/9/29.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "LBImagItemCell.h"
#import "Masonry.h"
//#import "UIImageView+WebCache.h"

@interface LBImagItemCell ()

@property(nonatomic,strong)UIImageView *imageView;

@end

@implementation LBImagItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    
    self = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.imageView];
        
        
        [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.right.bottom.equalTo(self.contentView);
        }];
        
    }
    
    return self;
}


- (UIImageView *)imageView {
    
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    return _imageView;
}

- (void)configWithImage:(NSString *)image {
    
    
//    [self.imageView sd_setImageWithURL:[NSURL URLWithString:image]];
    
}
@end
