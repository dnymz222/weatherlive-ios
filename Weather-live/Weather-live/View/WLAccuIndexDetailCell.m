//
//  WLAccuIndexDetailCell.m
//  Weather-live
//
//  Created by xueping on 2019/5/23.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLAccuIndexDetailCell.h"
#import "WLAccuIndexGroupModel.h"
#import "WLAccuIndexModel.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"



@interface WLAccuIndexDetailCell ()
@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UILabel *categoryLabel;

@property(nonatomic,strong)UILabel *detailLabel;

@property(nonatomic,strong)UIImageView *valueBackView;
@property(nonatomic,strong)UIImageView *valueView;

@property(nonatomic,strong)UILabel *vaLueLabel;




@end

@implementation WLAccuIndexDetailCell


- (instancetype)initWithFrame:(CGRect)frame {
    
    
    self  = [super initWithFrame:frame];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.backgroundColor  = [UIColor whiteColor];
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.categoryLabel];
        [self.contentView addSubview:self.detailLabel];
        [self.contentView addSubview:self.valueBackView];
        [self.contentView addSubview:self.valueView];
        [self.contentView addSubview:self.vaLueLabel];
        
        
        
        
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(5);
            make.left.equalTo(self.contentView).offset(10);
            make.height.equalTo(@20);
            make.right.equalTo(self.contentView).offset(-5);
        }];
        
        [self.categoryLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(5);
            make.height.equalTo(@20);
        }];
        
        
        
        [self.valueBackView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.categoryLabel.mas_bottom).offset(5);
            make.height.equalTo(@15);
            make.left.equalTo(self.contentView).offset(10);
            make.width.equalTo(@120);
        }];
        
        [self.valueView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.categoryLabel.mas_bottom).offset(5);
            make.height.equalTo(@15);
            make.left.equalTo(self.contentView).offset(10);
            make.width.equalTo(@120);
        }];
        
        [self.vaLueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.valueBackView.mas_right).offset(3);
            make.width.equalTo(@25);
            make.centerY.equalTo(self.valueBackView);
            make.height.equalTo(@16);
        }];
        
        
        
        
       
        
        
       
        [self.detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
            make.bottom.equalTo(self.contentView).offset(-5);
            make.height.equalTo(@32);
            make.right.equalTo(self.contentView).offset(-5);
        }];
        
        
        
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:14.f];
        _titleLabel.textColor = UIColorFromRGB(Themecolor);
    }
    
    return _titleLabel;
    
}

- (UILabel*)detailLabel {
    if (!_detailLabel) {
        _detailLabel = [[UILabel alloc] init];
        _detailLabel.textAlignment = NSTextAlignmentLeft;
        _detailLabel.numberOfLines = 2;
        _detailLabel.textColor = UIColorFromRGB(0x666666);
        _detailLabel.font = [UIFont systemFontOfSize:13.f];
        _detailLabel.adjustsFontSizeToFitWidth = YES;
    }
    return _detailLabel;
}


- (UILabel *)categoryLabel {
    
    if (!_categoryLabel) {
        _categoryLabel = [[UILabel alloc] init];
        _categoryLabel.textAlignment = NSTextAlignmentLeft;
        _categoryLabel.font = [UIFont systemFontOfSize:18.f];
        _categoryLabel.textColor = UIColorFromRGB(0x333333);
        
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
    
    float width  =120 * model.Value/10.f;
    
    [self.valueView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.categoryLabel.mas_bottom).offset(5);
        make.height.equalTo(@15);
        make.left.equalTo(self.contentView).offset(10);
        make.width.equalTo(@(width));
    }];
    
    
    self.vaLueLabel.text =[NSString stringWithFormat:@"%0.1f",model.Value];
    
    
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}



@end
