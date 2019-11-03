//
//  WLIndexSelectCell.m
//  Weather-live
//
//  Created by xueping on 2019/10/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLIndexSelectCell.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "WLAccuIndexModel.h"

@interface WLIndexSelectCell ()

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIImageView *button;



@end

@implementation WLIndexSelectCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        

            [self.contentView addSubview:self.titleLabel];
              [self.contentView addSubview:self.button];
        
              [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.left.equalTo(self.contentView).offset(10);
                  make.centerY.equalTo(self.contentView);
                  make.right.equalTo(self.contentView).offset(-60);
                  make.height.equalTo(@20);
              }];
              
              [self.button mas_makeConstraints:^(MASConstraintMaker *make) {
                  make.right.equalTo(self.contentView).offset(-10);
                  make.width.equalTo(@32);
                  make.top.equalTo(self.contentView).offset(6);
                  make.bottom.equalTo(self.contentView).offset(-6);
              }];
              
        
    }
    
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.font = [UIFont systemFontOfSize:16.f];
        _titleLabel.textColor = UIColorFromRGB(Themecolor);
    }
    
    return _titleLabel;
}

- (UIImageView *)button {
    
    if (!_button) {
        _button = [[UIImageView alloc] init];
//        [_button  setImage:[UIImage imageNamed:@"shezhi"] forState:UIControlStateNormal];
        _button.contentMode = UIViewContentModeCenter;
        _button.userInteractionEnabled = YES;
        
    }
    
    return _button;
}


- (void)configWithModel:(WLAccuIndexModel *)model  first:(NSInteger)selectFirst second:(NSInteger)selectSecond{
    
    _titleLabel.text = model.Name;
    if ( selectFirst ==  model.ID ) {
        UIImage *image0 = [UIImage imageNamed:@"select1"];
        [_button setImage:image0];
        model.selectType = 1;
        
    } else if(selectSecond == model.ID){
        UIImage *image0 = [UIImage imageNamed:@"select2"];
        [_button setImage:image0];
        model.selectType = 2;
        
    } else{
      UIImage *image0 = [UIImage imageNamed:@"select0"];
       [_button setImage:image0];
        model.selectType = 0;
    }
    
}

@end
