//
//  WLWigdetIndexItemView.m
//  widget
//
//  Created by xueping on 2019/10/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLWigdetIndexItemView.h"
//#import "WLAccuIndexGroupModel.h"
#import "WLAccuIndexModel.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import "WLColor.h"

@interface WLWigdetIndexItemView ()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *categoryLabel;

@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)UIImageView *valueBackView;
@property(nonatomic,strong)UIImageView *valueView;

@property(nonatomic,strong)UILabel *vaLueLabel;




@end

@implementation WLWigdetIndexItemView



- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self  = [super initWithFrame:frame];
    if (self) {
        
//        self.backgroundColor  = [UIColor whiteColor];
        [self addSubview:self.titleLabel];
        [self  addSubview:self.categoryLabel];
        [self  addSubview:self.detailLabel];
        [self addSubview:self.valueBackView];
        [self addSubview:self.valueView];
        [self  addSubview:self.vaLueLabel];
        
        
        
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self).offset(0);
            make.left.equalTo(self).offset(10);
            make.height.equalTo(@20);
            make.right.equalTo(self).offset(-5);
        }];
        
        [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.right.equalTo(self).offset(-10);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(0);
            make.height.equalTo(@20);
        }];
        
        
        
        [self.valueBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.categoryLabel.mas_bottom).offset(0);
            make.height.equalTo(@15);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@100);
        }];
        
        [self.valueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.categoryLabel.mas_bottom).offset(0);
            make.height.equalTo(@15);
            make.left.equalTo(self).offset(10);
            make.width.equalTo(@100);
        }];
        
        [self.vaLueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.valueBackView.mas_right).offset(3);
            make.width.equalTo(@25);
            make.centerY.equalTo(self.valueBackView);
            make.height.equalTo(@16);
        }];
        
        
        
        
       
        
        
       
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(10);
            make.bottom.equalTo(self).offset(-2);
            make.height.equalTo(@32);
            make.right.equalTo(self).offset(-5);
        }];
        
        
        
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.numberOfLines = 0;
        _titleLabel.textColor = UIColorFromRGB(Themecolor);
    }
    
    return _titleLabel;
    
}

- (UILabel*)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.numberOfLines = 2;
        _detailLabel.textColor = [WLColor headercolor];
        _detailLabel.font = [UIFont systemFontOfSize:13.f];
        _detailLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _detailLabel;
}


- (UILabel *)categoryLabel {
    
    if (!_categoryLabel) {
        _categoryLabel = [[UILabel alloc] init];
        _categoryLabel.textAlignment = NSTextAlignmentLeft;
        _categoryLabel.font = [UIFont systemFontOfSize:16.f];
        _categoryLabel.textColor = [WLColor boldcolor];
        
    }
    
    return _categoryLabel;
    
}


- (UIImageView *)valueView {
    if (!_valueView) {
        _valueView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"valueindictor"];
        [_valueView setImage:image];
        _valueView.contentMode = UIViewContentModeScaleToFill;
    }
    
    return _valueView;
}

- (UIImageView *)valueBackView {
    if (!_valueBackView) {
        _valueBackView = [[UIImageView alloc] init];
        UIImage *image = [UIImage imageNamed:@"valueback"];
        _valueView.contentMode = UIViewContentModeScaleAspectFill;
//        _valueBackView.contentMode = UIViewContentModeScaleToFill;
        [_valueBackView setImage:image];
        
    }
    return _valueBackView;
}

- (UILabel *)vaLueLabel {
    if (!_vaLueLabel) {
        _vaLueLabel = [[UILabel alloc] init];
        _vaLueLabel.textAlignment = NSTextAlignmentLeft;
        _vaLueLabel.font =[UIFont systemFontOfSize:13.f];
        _vaLueLabel.textColor = UIColorFromRGB(Themecolor);
    }
    
    return _vaLueLabel;
}




- (void)configIndexModel:(WLAccuIndexModel *)model {
    
    self.titleLabel.text = model.Name;
    self.detailLabel.text = model.Text;
    self.categoryLabel.text = model.Category;
    
    float width  =100 * model.Value/10.f;
    
    [self.valueView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryLabel.mas_bottom).offset(0);
        make.height.equalTo(@15);
        make.left.equalTo(self).offset(10);
        make.width.equalTo(@(width));
    }];
    
    
    self.vaLueLabel.text =[NSString stringWithFormat:@"%0.1f",model.Value];
    
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
