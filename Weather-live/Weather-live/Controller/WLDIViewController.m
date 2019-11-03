//
//  WLDIViewController.m
//  Weather-live
//
//  Created by xueping on 2019/10/30.
//  Copyright © 2019 xueping. All rights reserved.
//

#import "WLDIViewController.h"
#import "Masonry.h"
#import "ColorSizeMacro.h"
#import "WLColor.h"

@interface WLDIViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UILabel *valueLabel;
@property(nonatomic,strong)UILabel *resultLabel;
@property(nonatomic,strong)UILabel *formulabel;
@property(nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,strong)UILabel *tipLabel;


@property(nonatomic,assign)NSInteger selectfirst;
@property(nonatomic,assign)NSInteger selectTwo;


@property(nonatomic,assign)float DI;



@end

@implementation WLDIViewController

- (void)viewDidLoad {
    
  
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.navigationItem.title = NSLocalizedString(@"di title", nil);
    
    [self.view addSubview:self.valueLabel];
    [self.view addSubview:self.resultLabel];
    [self.view addSubview:self.formulabel];
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.tipLabel];
    
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.height.equalTo(@66);
        make.centerX.equalTo(self.view);
        make.width.equalTo(@66);
    }];
    
    [self.resultLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.valueLabel.mas_bottom).offset(5);
        make.height.equalTo(@20);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    
    
    [self.formulabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.resultLabel.mas_bottom).offset(5);
        make.height.equalTo(@40);
        make.centerX.equalTo(self.view);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.formulabel.mas_bottom);
        make.height.equalTo(@160);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.pickerView.mas_bottom);
        make.height.equalTo(@160);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
    }];
    
//    [self.pickerView reloadAllComponents];
    [self.pickerView selectRow:70 inComponent:0 animated:NO];
    [self.pickerView selectRow:50 inComponent:1 animated:NO];
    
    self.selectfirst    =  70;
    self.selectTwo = 50;
    
    [self calculate];
    
    
   
    
    // Do any additional setup after loading the view.
}

- (void)calculate {
    
    int t = self.selectfirst- 50;
    int h = self.selectTwo;
    
    
    float DI = 0.81* t + 0.01*h*(0.99*t-14.3)+46.3;
    
    self.DI = DI;
    self.valueLabel.text = [NSString stringWithFormat:@"%0.1f",DI];
    
    if (self.DI < 55) {
        self.resultLabel.text = NSLocalizedString(@"level 0", nil);
    }
    else if (self.DI < 60){
         self.resultLabel.text = NSLocalizedString(@"level 1", nil);
    }
    else if (self.DI < 65){
         self.resultLabel.text = NSLocalizedString(@"level 2", nil);
    }
    else if (self.DI < 70){
         self.resultLabel.text = NSLocalizedString(@"level 3", nil);
    }
    else if (self.DI < 75){
         self.resultLabel.text = NSLocalizedString(@"level 4", nil);
    }
    else if (self.DI < 80){
         self.resultLabel.text = NSLocalizedString(@"level 5", nil);
    }
    else if (self.DI < 85){
         self.resultLabel.text = NSLocalizedString(@"level 6", nil);
    }
    else {
         self.resultLabel.text = NSLocalizedString(@"level 7", nil);
    }
    
    
    
    
    
}

- (UILabel *)valueLabel {
    if (!_valueLabel) {
        _valueLabel = [[UILabel alloc] init];
        _valueLabel.textAlignment = NSTextAlignmentCenter;
        _valueLabel.font = [UIFont boldSystemFontOfSize:20.f];
        _valueLabel.textColor = UIColorFromRGB(0x333333) ;
        _valueLabel.backgroundColor = [UIColor whiteColor];
        _valueLabel.layer.cornerRadius = 33;
        _valueLabel.layer.masksToBounds = YES;
        
    }
    
    return _valueLabel;
}

- (UILabel *)resultLabel {
    if (!_resultLabel) {
        _resultLabel = [[UILabel alloc] init];
        _resultLabel.textAlignment = NSTextAlignmentCenter;
        _resultLabel.textColor  = [WLColor headercolor];
        _resultLabel.font = [UIFont systemFontOfSize:16.f];
        
        
    }
    
    return _resultLabel;
}


- (UILabel *)formulabel {
    if (!_formulabel) {
        _formulabel  = [[UILabel alloc] init];
        _formulabel.textAlignment = NSTextAlignmentLeft;
        _formulabel.textColor = [WLColor cellTextColor];
        _formulabel.font = [UIFont systemFontOfSize:15.f];
        _formulabel.numberOfLines = 2;
        _formulabel.text = [NSString stringWithFormat: @"DI = 0.81T + 0.01H x (0.99T - 14.3) + 46.3\nT: %@ H: %@", NSLocalizedString(@"temperature use", nil),NSLocalizedString(@"humidity use", nil)];
        
    }
    
    return _formulabel;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView = [[UIPickerView alloc] init];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    return _pickerView;
}

- (UILabel *)tipLabel {
    
    if (!_tipLabel) {
        _tipLabel = [[UILabel alloc] init];
        _tipLabel.textAlignment  = NSTextAlignmentLeft;
        _tipLabel.numberOfLines = 0;
        _tipLabel.font = [UIFont systemFontOfSize:14.f];
        _tipLabel.textColor = UIColorFromRGB(0x888888);
        _tipLabel.text =[NSString stringWithFormat:
                         @"~55:%@\n"
                         @"55~60:%@\n"
                         @"60-65:%@\n"
                         @"65~70:%@\n"
                         @"70~75:%@\n"
                         @"75~80:%@\n"
                         @"80~85:%@\n"
                         @"85~:%@",
                         NSLocalizedString(@"level 0", nil),
                         NSLocalizedString(@"level 1", nil),
                         NSLocalizedString(@"level 2", nil),
                         NSLocalizedString(@"level 3", nil),
                         NSLocalizedString(@"level 4", nil),
                         NSLocalizedString(@"level 5", nil),
                         NSLocalizedString(@"level 6", nil),
                         NSLocalizedString(@"level 7", nil)
                         ];
        
    }
    
    return _tipLabel;
}





- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 2;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return 101;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    CGFloat width = [UIScreen mainScreen].bounds.size.width-20;
    
    return width/2;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.font = [UIFont systemFontOfSize:13.f];
        pickerLabel.textColor = [WLColor boldcolor];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;


}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *string;
    if (0 == component) {
        string  =  [NSString stringWithFormat:@"%@:%d°C",NSLocalizedString(@"temperature", nil),row-50];
    } else  {
        string  = [NSString stringWithFormat:@"%@:%d%@",NSLocalizedString(@"humidity", nil),row,@"%"];
    }
    return string;

}





- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 44;
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (0 == component) {
        self.selectfirst = row;
    } else {
        self.selectTwo = row;
    }
    
    
    [self calculate];
  
    
    
    
}












/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
