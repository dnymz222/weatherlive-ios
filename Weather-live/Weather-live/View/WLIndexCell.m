//
//  WLIndexCell.m
//  Weather-live
//
//  Created by xueping on 2019/10/25.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLIndexCell.h"
#import "WLWigdetIndexItemView.h"
#import "Masonry.h"
#import "LBKeyMacro.h"
#import "WLAccuIndexModel.h"
#import "ColorSizeMacro.h"


@interface WLIndexCell ()

@property(nonatomic,strong)WLWigdetIndexItemView *itemview1;
@property(nonatomic,strong)WLWigdetIndexItemView *itemView2;


@property(nonatomic,strong)UILabel *tipLabel;

@property(nonatomic,assign)NSInteger selectFirst;
@property(nonatomic,assign)NSInteger selectTwo;

@property(nonatomic,strong)NSUserDefaults *userdefaults;

@end

@implementation WLIndexCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        NSUserDefaults *userdefalult = [[NSUserDefaults alloc] initWithSuiteName:Appgroupkey];
        
       
        self.userdefaults = userdefalult;
        
        [self.contentView addSubview:self.itemview1];
        [self.contentView addSubview:self.itemView2];
         [self.contentView addSubview:self.tipLabel];
        
        [self.itemview1 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView.mas_centerX);
        }];
        
        [self.itemView2 mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.top.bottom.equalTo(self.contentView);
            make.left.equalTo(self.contentView.mas_centerX);
            
        }];
        
        [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.equalTo(self.contentView);
            make.width.equalTo(@280);
            make.height.equalTo(@60);
        }];
        
       
        
        
        
    }
    
    return self;
}

- (WLWigdetIndexItemView *)itemview1 {
    
    if (!_itemview1) {
        _itemview1 = [[WLWigdetIndexItemView alloc] init];
        
    }
    
    return _itemview1;
}


- (WLWigdetIndexItemView *)itemView2 {
    if (!_itemView2) {
        _itemView2 = [[WLWigdetIndexItemView alloc] init];
    }
    
    return _itemView2;
}


- (void)configDataArray:(NSArray *)dataArray {
    
    self.selectFirst = [self.userdefaults   integerForKey:AppgroupIndiciesSelect1Key]?:-100;
    self.selectTwo = [self.userdefaults  integerForKey:AppgroupIndiciesSelect2Key]?:-100;
    
    if (-100 == self.selectFirst  && -100 == self.selectTwo) {
        
        self.itemview1.hidden = YES;
        self.itemView2.hidden = YES;
        
        self.tipLabel.hidden = NO;
        
        
        
        
    } else if (-100 != self.selectFirst && -100 != self.selectTwo ){
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ID=%ld",self.selectFirst];
        NSArray *fileterArray =[dataArray filteredArrayUsingPredicate:predicate];
        if (fileterArray.count) {
                   WLAccuIndexModel *model = [fileterArray firstObject];
                   self.itemview1.hidden = NO;
                   [self.itemview1 configIndexModel:model];
                   
        }
        
        NSPredicate *predicate2 = [NSPredicate predicateWithFormat:@"ID=%ld",self.selectTwo];
        NSArray *fileterArray2 =[dataArray filteredArrayUsingPredicate:predicate2];
        if (fileterArray2.count) {
                   WLAccuIndexModel *model = [fileterArray2 firstObject];
                   
                   [self.itemView2 configIndexModel:model];
                   self.itemView2.hidden = NO;
               }
        
        
        self.tipLabel.hidden = YES;
        
        
    } else {
        
        NSInteger selectId = 0;
        if (-100 == self.selectFirst) {
            
            selectId = self.selectTwo;
        } else {
            
            selectId = self.selectFirst;
        }
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"ID=%ld",selectId];
        NSArray *fileterArray =[dataArray filteredArrayUsingPredicate:predicate];
        if (fileterArray.count) {
            WLAccuIndexModel *model = [fileterArray firstObject];
            self.itemview1.hidden = NO;
            [self.itemview1 configIndexModel:model];
            self.itemView2.hidden = YES;
        }
        
        self.tipLabel.hidden = YES;
        
    }
    
    
}
- (UILabel *)tipLabel {
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textAlignment = NSTextAlignmentCenter;
        _tipLabel.textColor = UIColorFromRGB(Themecolor);
        _tipLabel.text = NSLocalizedString(@"select note", nil);
        _tipLabel.font = [UIFont systemFontOfSize:15.f];
        _tipLabel.numberOfLines = 0;
        _tipLabel.hidden = YES;
    }
    return _tipLabel;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
