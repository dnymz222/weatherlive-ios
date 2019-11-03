//
//  FishMapSelectPositionViewController.m
//  fishinghelper
//
//  Created by mc on 2019/2/12.
//  Copyright © 2019年 xueping. All rights reserved.
//

#import "FishMapSelectPositionViewController.h"
#import "ColorSizeMacro.h"
#import "Masonry.h"
#import <MapKit/MapKit.h>
#import "LBKeyMacro.h"
#import "STLocationModel.h"
#import "GPSCorrect.h"


@interface FishMapSelectPositionViewController ()<MKMapViewDelegate,UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)MKMapView *mapView;
@property(nonatomic, strong)UISearchBar *searchBar;

@property (strong, nonatomic)    NSMutableArray *mapItems;
@property (strong, nonatomic)    MKDirectionsResponse *response;
@property (strong, nonatomic)    MKMapItem *mapItemFrom;
@property (strong, nonatomic)    MKMapItem *mapItemTo;

@property(nonatomic,strong) UITableView *tableView;

@property(nonatomic, strong) UIBarButtonItem *cancelButtonItem;

@end

@implementation FishMapSelectPositionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    MKMapView *mapview = [[MKMapView alloc] init];
    [self.view addSubview:mapview];
    self.mapView = mapview;
    CGFloat bottom  =KIsiPhoneX ?-34:0;
    [self.mapView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view.mas_centerY).offset(60);
        
    }];
    
    
    self.mapView.delegate = self;
    self.mapView.mapType = MKMapTypeStandard;
    self.mapView.zoomEnabled = YES;
    self.mapView.rotateEnabled = YES;
    self.mapView.showsUserLocation = YES;
    
    
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIView alloc] initWithFrame:CGRectZero]];
    
    
    //CGFloat leftSpace = kScreenWidth > 400 ? 17 : 13;
    UIView * view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth  -80 , 44 )];
    
    self.searchBar.frame = view.bounds;
    [view addSubview:self.searchBar];
    self.searchBar.barTintColor =[UIColor whiteColor];
    self.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
//    UITextField *textfield = [self.searchBar valueForKey:@"_searchField"];
//    textfield.font = [UIFont systemFontOfSize:13.f];
//    textfield.textColor = UIColorFromRGB(0x666666);
//    [textfield setValue:UIColorFromRGB(0x999999) forKeyPath:@"_placeholderLabel.textColor"];
// 
//    [textfield setValue:[UIFont systemFontOfSize:12.f] forKeyPath:@"_placeholderLabel.font"];
    
    self.searchBar.placeholder  = NSLocalizedString(@"input tip", nil);
    
    
    self.navigationItem.titleView = view;
    
    [self addSearchButtonItem];
    
    _mapItems = [NSMutableArray array];
    
    
    UITableView *tableView = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
    [self.view addSubview:tableView];
    _tableView = tableView;
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    
    
    
    
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(bottom);
        make.top.equalTo(self.view.mas_centerY).offset(60);
    }];
    
    
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    [self initMapRegion];
    
}


- (void)addSearchButtonItem {
    _cancelButtonItem = [[UIBarButtonItem alloc] initWithTitle:NSLocalizedString(@"cancel", nil) style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction)];
    [_cancelButtonItem setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:[UIFont systemFontOfSize:14.f],NSFontAttributeName,UIColorFromRGB(Themecolor),NSForegroundColorAttributeName,nil] forState:UIControlStateNormal];
    UIBarButtonItem *navigativeSpacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:nil action:nil];
    if ([[UIDevice currentDevice].systemVersion floatValue] > 9.9f) {
        navigativeSpacer.width = [UIScreen mainScreen].bounds.size.width < 375? 6: -6;;
    } else {
        navigativeSpacer.width = [UIScreen mainScreen].bounds.size.width < 375? 3: 5;
    }
    self.navigationItem.rightBarButtonItems = @[navigativeSpacer,_cancelButtonItem];
}

- (void)cancelAction {
    
    [self.navigationController popViewControllerAnimated:YES];
}


- (UISearchBar *)searchBar {
    
    if (!_searchBar) {
        _searchBar = [[UISearchBar alloc] init];
        _searchBar.delegate = self ;
        
    }
    
    return _searchBar;
}

-(void)initMapRegion {
    
    double latitude =  [[NSUserDefaults standardUserDefaults]  doubleForKey:latitudekey]?:28.46617500;
    
    double longtitude = [[NSUserDefaults standardUserDefaults] doubleForKey:longtitudekey]?:115.13831500;
    
    
    
    CLLocationCoordinate2D center = CLLocationCoordinate2DMake(latitude, longtitude);
    
    MKCoordinateSpan span = MKCoordinateSpanMake(10, 10);
    MKCoordinateRegion region = MKCoordinateRegionMake(center, span);
    
    self.mapView.region = region;
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    
    [searchBar resignFirstResponder];
    
    
    MKLocalSearchRequest *request = [[MKLocalSearchRequest alloc] init];
    request.naturalLanguageQuery = searchBar.text;
    request.region = _mapView.region;
    
    MKLocalSearch *search = [[MKLocalSearch alloc] initWithRequest:request];
    
    __weak typeof(self) wself  = self;
    
    
    [search startWithCompletionHandler:^(MKLocalSearchResponse *response, NSError *error) {
        
        [wself.mapItems removeAllObjects];
        [wself.mapView removeAnnotations:[wself.mapView annotations]];
        
        for(MKMapItem *item in response.mapItems) {
            MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
            point.coordinate = item.placemark.coordinate;
            point.title = item.placemark.name;
            point.subtitle = item.phoneNumber;
            
            [wself.mapView addAnnotation:point];
            [wself.mapItems addObject:item];
        }
        [wself.mapView showAnnotations:[wself.mapView annotations] animated:YES];
        wself.mapItemFrom = wself.mapItemTo = nil;
        
        [wself.tableView reloadData];
    }];
    
    
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_mapItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"mapCell" ];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"mapCell"];
        cell.textLabel.font = [UIFont systemFontOfSize:14.f];
        cell.textLabel.textColor  = UIColorFromRGB(0x666666);
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        
    }
    MKMapItem *item = [_mapItems objectAtIndex:indexPath.row];
    cell.textLabel.text = item.placemark.title;
    //cell.detailTextLabel.text = item.placemark.title;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    MKMapItem *item = [self.mapItems objectAtIndex:indexPath.row];
    
//    NSLog(@"location:%@",item.placemark.location);
    
    CLLocation *location = item.placemark.location;
    
    CLLocation *nwLocation =  [GPSCorrect transformLocation:location];
    
    STLocationModel *model  = [[STLocationModel alloc] initWithClLocation:nwLocation];
    
    __weak typeof(self) weakself = self;
    [model reverseGeocodeCompleted:^(NSString * _Nonnull name) {
        if (weakself.delegate ) {
            [weakself.delegate mapSelectPositionViewControllerDidSelected:model];
            [weakself.navigationController popViewControllerAnimated:YES];
        }
    }];
    
    
}




- (void)mapView:(MKMapView *)mapView regionWillChangeAnimated:(BOOL)animated {
    
   
    
    
    
    
}
- (void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    
//     CLLocationCoordinate2D  cenloc     = mapView.centerCoordinate;
//    
//    MKCoordinateSpan span = MKCoordinateSpanMake(10, 10);
//    MKCoordinateRegion region = MKCoordinateRegionMake(cenloc, span);
//    mapView.region = region;
    
    
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
