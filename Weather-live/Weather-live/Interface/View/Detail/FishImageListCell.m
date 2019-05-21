//
//  LBImageListCell.m
//  lamabiji
//
//  Created by xueping on 2018/9/30.
//  Copyright © 2018年 xueping. All rights reserved.
//

#import "FishImageListCell.h"
#import "Masonry.h"
#import "UIImageView+WebCache.h"
#import "FishImageItemModel.h"
#import "ColorSizeMacro.h"

@interface FishImageListCell ()

@property(nonatomic,strong)UIImageView *picView;

@end

@implementation FishImageListCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:self.picView];
        [self.picView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.top.bottom.equalTo(self.contentView);
        }];
        
    }
    
    return self;
}

- (UIImageView *)picView {
    
    if (!_picView) {
        _picView = [[UIImageView alloc] init];
        _picView.contentMode = UIViewContentModeScaleAspectFit;
        
    }
    
    return _picView;
}

- (void)configWithModel:(FishImageItemModel *)imageModel {
    
    [_picView sd_setImageWithURL:[NSURL URLWithString:imageModel.image] completed:^(UIImage * _Nullable image, NSError * _Nullable error, SDImageCacheType cacheType, NSURL * _Nullable imageURL) {
        if (!imageModel.outHeight) {
            if (image) {
                if (image.size.width && image.size.height) {
                    imageModel.outHeight = image.size.height/image.size.width *kScreenWidth;
                    if (_delegate && [_delegate respondsToSelector:@selector(reloadImageHeight)]) {
                        [_delegate reloadImageHeight];
                    }
                }
            }
        }
       
        
    }];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
