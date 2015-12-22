//
//  TTTest2ViewController.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/12.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTTest2ViewController.h"
#import "TTTest3ViewController.h"
#import "TTTest4ViewController.h"
#import "TTText5ViewController.h"

#import "NavPointAnnotation.h"
#import "flyTableViewCell.h"
#import "TTHttpHanler+HttpHanlerResolver.h"
#import "TTaddOrder.h"

#import "TTTest7ViewController.h"
#import "TTTGerCarViewController.h"
#define WITH ([[UIScreen mainScreen]bounds].size.width)
#define HIGHt ([UIScreen mainScreen].bounds.size.height)

@interface TTTest2ViewController ()<MAMapViewDelegate,AMapLocationManagerDelegate,AMapSearchDelegate,AMapNearbySearchManagerDelegate,UIPickerViewDataSource,UIPickerViewDelegate,UIAlertViewDelegate,AMapNaviManagerDelegate>
{
    UITableView *_tableView2;
    UITableView *_tableView3;
    UIDatePicker *_datePicker;
    NSMutableArray *_numArray;
    MAPointAnnotation *_pointAnnotation;
    AMapReGeocodeSearchRequest *_geo;
    NSString * _selectString;
    NSString *_numString;
    UIView *_timeview;
    UIView *_peopleView;
    UIView *_tab3View;
    UIImageView *_imageView;
    NSDate *date;
    UIImageView *jgImage;
    
    int addressIndex;
    
    NSString *daxue;
    
    NSString *yuyue;
    TTaddOrder *getorder;
    
    
}
@end

@implementation TTTest2ViewController
@synthesize topimgview = _topimgview;
@synthesize backBut = _backBut;
@synthesize tableView1 = _tableView1;
-(void)viewDidAppear:(BOOL)animated
{
    //  请求是否有未完成订单
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Passenger&_A=getMyOrder"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"17",@"uid",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"getorder" param:dic datatype:[NSDictionary class] notifName:self.notificationName];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
   [self.navigationController setNavigationBarHidden:YES animated:NO];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(xuexiao:) name:@"p" object:nil];
}
-(void)xuexiao:(NSNotification *) info
{
    self.p = info.object;
    self.dingdan.fromId = self.p.fromId;
    self.dingdan.toId = self.p.tId;
    daxue = [NSString stringWithFormat:@"%@-%@",self.p.Faddress,self.p.Taddress];
    self.fanchengdt = [NSString stringWithFormat:@"%@-%@",self.p.Taddress,self.p.Faddress];
     [_tableView1 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:1 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    self.fczb = [NSString stringWithFormat:@"%@,%@",self.p.Tlong,self.p.Tlati];
    NSLog(@"------> %@",self.fczb);

}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    self.dingdan = [[XTDiDan alloc] init];
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
    [btn setBackgroundColor:[UIColor blueColor]];
    [self.view addSubview:btn];
    

    [[MAMapServices sharedServices] setApiKey:@"fabbe419765d08ab2b66bcec0180e491"];
    [AMapLocationServices sharedServices].apiKey = @"fabbe419765d08ab2b66bcec0180e491";
    [AMapSearchServices sharedServices].apiKey = @"fabbe419765d08ab2b66bcec0180e491";
    [AMapNaviServices sharedServices].apiKey = @"fabbe419765d08ab2b66bcec0180e491";
     [self creatLocationmanger];
    _nameArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    _locationArray = [NSMutableArray array];
    if (!_map)
    {
        _map = [[MAMapView alloc] initWithFrame:self.view.frame];
        _map.rotateCameraEnabled = NO;
        
        //   取消默认小圆圈
        _map.showsUserLocation = YES;
        [_map setUserTrackingMode:MAUserTrackingModeNone animated:YES];
        _map.allowsBackgroundLocationUpdates = YES;
        //        _map.showsScale = YES;
        [_map setZoomLevel:20 animated:YES];
        // 改变默认的地位的标注
        //        _map.customizeUserLocationAccuracyCircleRepresentation = YES;
        _map.delegate = self;
        [self.view addSubview:_map];
    }
   

    if (_naviManger == nil)
    {
        _naviManger = [[AMapNaviManager alloc] init];
        
    }
    _naviManger.delegate = self;

    
    [self initSearchAPI];

    [self initBtn];
    [self creatTableIvew];
}
- (void)mov
{
    [_map removeAnnotations:_map.annotations];
    _imageView.hidden = NO;
    [_locationManager startUpdatingLocation];
}
-(void)creatTopView
{
    self.topimgview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WITH, 64)];
    self.topimgview.backgroundColor =[UIColor colorWithRed:253/255.0 green:172/255.0 blue:20/255.0 alpha:1];
    self.topimgview.userInteractionEnabled = YES;
    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(WITH*0.4,25, 100, 30)];
    lable.textColor =[UIColor whiteColor];
    lable.text =@"飞到地铁站";
    [self.topimgview addSubview:lable];
    [self.view addSubview:self.topimgview];
    
    self.backBut = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.backBut setTitle:@"返回" forState:UIControlStateNormal];
    self.backBut.frame = CGRectMake(10,25, 50, 30);
    [self.backBut addTarget:self action:@selector(backMain) forControlEvents:UIControlEventTouchUpInside];
    [self.topimgview addSubview:self.backBut];
    
}
-(void)backMain
{
    [self dismissViewControllerAnimated:YES completion:NO];
    
}
//  显示周边位置
-(void)creatTableIvew
{
    [self creatTopView];
    
    _tableView1 =[[UITableView alloc]initWithFrame:CGRectMake(10, HIGHt/3*2-20, WITH-20, HIGHt/3+20) style:UITableViewStylePlain];
    _tableView1 .dataSource =self;
    _tableView1.delegate =self;
    _tableView1 .tag =100;
    
    _tableView1.scrollEnabled = NO;
    [self.view addSubview:_tableView1];
    
    _button = [UIButton buttonWithType:UIButtonTypeCustom];
    _button.frame = CGRectMake(WITH-10-60, _tableView1.frame.origin.y-30, 60, 60);
    _button.layer.cornerRadius = 30;
    _button.clipsToBounds = YES;
    [_button setBackgroundImage:[UIImage imageNamed:@"确认按钮"] forState:UIControlStateNormal];
    [_button addTarget:self action:@selector(finshBut) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_button];
    
    _tab3View = [[UIView alloc] initWithFrame:CGRectMake(10, HIGHt, WITH-20, HIGHt/3)];
    _tab3View.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:_tab3View];
    UILabel *lable3 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WITH-20-60, 40)];
    lable3.text = @"  选择上车点";
    lable3.textColor = [UIColor orangeColor];
    [_tab3View addSubview:lable3];
    UIButton *button3 = [UIButton buttonWithType:UIButtonTypeCustom];
    button3.frame = CGRectMake(WITH-20-60, 0, 60, 40);
    [button3 setTitle:@"确认" forState:UIControlStateNormal];
    [button3 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(sureButton3) forControlEvents:UIControlEventTouchUpInside];
    [_tab3View addSubview:button3];
    _tableView3 =[[UITableView alloc]initWithFrame:CGRectMake(0,40, WITH-20, HIGHt) style:UITableViewStylePlain];
    _tableView3.scrollsToTop = YES;
    _tableView3.dataSource =self;
    _tableView3.delegate =self;
    _tableView3.tag =102;
    [_tab3View addSubview:_tableView3];
}
-(void)creatLocationmanger
{
    self.locationManager = [[AMapLocationManager alloc] init];
    //  地图可滑动
    self.locationManager.distanceFilter =  CLLocationDistanceMax;
    self.locationManager.delegate = self;
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
    [self.locationManager startUpdatingLocation];
    
    _imageView = [[UIImageView alloc] init];
    _imageView.center = CGPointMake(_map.center.x, _map.center.y-18);
    _imageView.bounds = CGRectMake(0, 0, 30, 30);
    _imageView.hidden = YES;
    [_imageView setImage:[UIImage imageNamed:@"icon_location"]];
    [_map addSubview:_imageView];

}
//  创建搜索
-(void)initSearchAPI
{
    self.search = [[AMapSearchAPI alloc] init];
    self.search.delegate = self;
    
    
}
#pragma mark - Map Delegate

- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    /* Step 2. */
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MAAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                          reuseIdentifier:pointReuseIndetifier];
        }
        annotationView.centerOffset = CGPointMake(0, -18);
        annotationView.image = _imageView.image;
        if ([annotation.title isEqualToString:@"zhen"])
        {
            annotationView.image = [UIImage imageNamed:@"icon_location"];
        }
        return annotationView;
    }
    
    return nil;
}

- (MAOverlayView *)mapView:(MAMapView *)mapView viewForOverlay:(id <MAOverlay>)overlay
{
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleView *accuracyCircleView = [[MACircleView alloc] initWithCircle:overlay];
        
        accuracyCircleView.lineWidth    = 2.f;
        accuracyCircleView.strokeColor  = [UIColor colorWithRed:1 green:0 blue:0 alpha:0];
        accuracyCircleView.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:0];
        return accuracyCircleView;
    }
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 5.0f;
        polylineView.strokeColor = [UIColor redColor];
        
        return polylineView;
    }
    return nil;
}
#pragma mark -----------------------naviPointMangerDelegate-----------------------
- (void)configMapView
{
    if (_calRouteSuccess)
    {
        [self.map addOverlay:_polyline];
    }
    
    if (self.annotations.count > 0)
    {
        [self.map addAnnotations:self.annotations];
    }
}

- (void)showRouteWithNaviRoute:(AMapNaviRoute *)naviRoute
{
    if (naviRoute == nil)
    {
        return;
    }
    
    // 清除旧的overlays
    if (_polyline)
    {
        [_map removeOverlay:_polyline];
        self.polyline = nil;
    }
    
    NSUInteger coordianteCount = [naviRoute.routeCoordinates count];
    CLLocationCoordinate2D coordinates[coordianteCount];
    for (int i = 0; i < coordianteCount; i++)
    {
        AMapNaviPoint *aCoordinate = [naviRoute.routeCoordinates objectAtIndex:i];
        coordinates[i] = CLLocationCoordinate2DMake(aCoordinate.latitude, aCoordinate.longitude);
    }
    
    _polyline = [MAPolyline polylineWithCoordinates:coordinates count:coordianteCount];
    [_map addOverlay:_polyline];
}

- (void)initAnnotations
{
    NavPointAnnotation *beginAnnotation = [[NavPointAnnotation alloc] init];
    
    [beginAnnotation setCoordinate:CLLocationCoordinate2DMake(_startPoint.latitude, _startPoint.longitude)];
    beginAnnotation.title        = @"起始点";
    beginAnnotation.navPointType = NavPointAnnotationStart;
    
    NavPointAnnotation *endAnnotation = [[NavPointAnnotation alloc] init];
    
    [endAnnotation setCoordinate:CLLocationCoordinate2DMake(_endPoint.latitude, _endPoint.longitude)];
    
    endAnnotation.title        = @"终点";
    endAnnotation.navPointType = NavPointAnnotationEnd;
    
    self.annotations = @[beginAnnotation, endAnnotation];
}
- (void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
{
    
    [self showRouteWithNaviRoute:[[naviManager naviRoute] copy]];
    _calRouteSuccess = YES;
    
}
#pragma mark --------------- AMapSearchDelegate------------
- (void)onPOISearchDone:(AMapPOISearchBaseRequest *)request response:(AMapPOISearchResponse *)response
{
    if(response.pois.count == 0)
    {
        return;
    }
    
    [_nameArray removeAllObjects];
    [_locationArray removeAllObjects];
    for (int i = 0; i<response.pois.count; i++) {
        AMapPOI *p = [response.pois objectAtIndex:i];
        if (i==0) {
            self.dingdan.locaStr = [NSString stringWithFormat:@"%f,%f",p.location.longitude,p.location.latitude];
        }
        
        [_nameArray addObject:p.name];
        [_locationArray addObject:p.location];

    }
    _selectString = _nameArray[0];
   
    [_tableView3 reloadData];
    
}
//实现逆地理编码的回调函数
- (void)onReGeocodeSearchDone:(AMapReGeocodeSearchRequest *)request response:(AMapReGeocodeSearchResponse *)response
{
    if(response.regeocode != nil)
    {
        //通过AMapReGeocodeSearchResponse对象处理搜索结果
//                NSLog(@"哎哎哎哎   %@",_geo.location);
        [self.map setCenterCoordinate:CLLocationCoordinate2DMake(_geo.location.latitude, _geo.location.longitude) animated:YES];
        _request.location = [AMapGeoPoint locationWithLatitude:_geo.location.latitude longitude: _geo.location.longitude];
        
    }
}
#pragma mark ----------------------- Action Handle ---------------------------
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
    //    CLLocationCoordinate2D MACoordinateConvert(CLLocationCoordinate2D coordinate, MACoordinateType type);;
    
    //  获得实时位置
    NSLog(@"实时位置location:{lat:%f; lon:%f; accuracy:%f}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy);
   //  记录定位的经纬度
    self.l = location;
    _pointAnnotation = [[MAPointAnnotation alloc] init];
    _pointAnnotation.title = @"zhen";
    [_pointAnnotation setCoordinate:location.coordinate];
    [_map addAnnotation:_pointAnnotation];
    [self.map setCenterCoordinate:location.coordinate animated:YES];
    [self.map setZoomLevel:18 animated:NO];
    
    

}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"错误");
}

- (void)mapView:(MAMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
    CLLocationCoordinate2D touchMapCoordinate =[self.map convertPoint:self.map.center toCoordinateFromView:self.map];//这里touchMapCoordinate就是该点的经纬度了
    //  设置周边请求参数
    if (_request) {
        _request.location = [AMapGeoPoint locationWithLatitude:touchMapCoordinate.latitude longitude:touchMapCoordinate.longitude];
        //        _request.keywords = @"天大";
        // types属性表示限定搜索POI的类别，默认为：餐饮服务|商务住宅|生活服务
        // POI的类型共分为20种大类别，分别为：
        // 汽车服务|汽车销售|汽车维修|摩托车服务|餐饮服务|购物服务|生活服务|体育休闲服务|
        // 医疗保健服务|住宿服务|风景名胜|商务住宅|政府机构及社会团体|科教文化服务|
        // 交通设施服务|金融保险服务|公司企业|道路附属设施|地名地址信息|公共设施
        _request.types = @"地名地址信息";
        _request.requireExtension = YES;
        _request.sortrule = 0;
        //发起周边搜索
        [_search AMapPOIAroundSearch: _request];
        
    }
    else
    {
        _request = [[AMapPOIAroundSearchRequest alloc] init];
        
    }
    
}
#pragma mark ------------------------TableViewDelegate---------------------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 100)
    {
        if (indexPath.row == 0)
        {
            return 80;
        }

    }
    return 40;
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView.tag ==102)
    {
        
        return _nameArray.count;
    }
    
    else
    {
        
        return 4;
    }
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *cellIndentfier = [NSString stringWithFormat:@"cell%ld", (long)indexPath.row];//以indexPath来唯一确定cell
    flyTableViewCell *cell =nil;
    cell= [tableView  dequeueReusableCellWithIdentifier:cellIndentfier];
    NSArray *xibArray=[[NSBundle mainBundle]loadNibNamed:@"flyTableViewCell" owner:nil options:nil];
    
    if (!cell)
    {
        cell = [[flyTableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:cellIndentfier];
    }
    if (tableView .tag == 100)
    {
        if (indexPath.row ==0)
        {
            cell =xibArray[0];
            if (self.zlVc.timeString != nil)
            {
                cell.celloLab.text = self.zlVc.timeString;
                self.dingdan.time = self.zlVc.timeString;
                
            }
            [cell.celloSegment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
        }
        else if (indexPath.row ==1)
        {
            cell= xibArray[1];
            if (daxue != nil) {
                
                [cell.cell1But setTitle:daxue forState:UIControlStateNormal];
            }
            [cell.cell1But addTarget:self action:@selector(cell1But) forControlEvents:UIControlEventTouchUpInside];
            self.dingdan.luxian = cell.cell1But.titleLabel.text;
            
            [cell.fanchengBut addTarget:self action:@selector(fancheng) forControlEvents:UIControlEventTouchUpInside];
            
        }
        else if (indexPath.row ==2)
        {
            
            cell= xibArray[2];
            if (_selectString != nil)
            {
                [cell.cell2But setTitle:_selectString forState:UIControlStateNormal];
                self.dingdan.getcaradress = cell.cell2But.titleLabel.text;
            }
            [cell.cell2But addTarget:self action:@selector(cell2But) forControlEvents:UIControlEventTouchUpInside];
        }
        
        else if (indexPath.row == 3)
        {
            cell =xibArray[3];
            if (_numString != nil)
            {
                [cell.cell3But setTitle:_numString forState:UIControlStateNormal];
                self.dingdan.number = cell.cell3But.titleLabel.text;
            }
            [cell.cell3But addTarget:self action:@selector(cell3But) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    else if (tableView.tag==102)
    {
        if (indexPath.row == 0)
        {
            cell.backgroundColor = [UIColor grayColor];
        }
        cell.textLabel.text = _nameArray[indexPath.row];
        
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag == 102)
    {
        [_tableView3 selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:YES scrollPosition:UITableViewScrollPositionTop];
        
        //        [_map setUserTrackingMode:MAUserTrackingModeFollow animated:YES];
        _selectString = _nameArray[indexPath.row];
        _geo = [[AMapReGeocodeSearchRequest alloc] init];
        _geo.location = _locationArray[indexPath.row];
        //发起逆向地理编码
        _geo.requireExtension = YES;
        _pointAnnotation.coordinate = CLLocationCoordinate2DMake(_geo.location.latitude, _geo.location.longitude);
        self.dingdan.locaStr = [NSString stringWithFormat:@"%f,%f",_geo.location.longitude,_geo.location.latitude];
        j=_geo.location.latitude;
        w=_geo.location.longitude;
        [_search AMapReGoecodeSearch:_geo];
        [_tableView3 reloadData];
    }
}
#pragma mark --------------ButtonClick--------------
-(void)fancheng
{
        //找到单元格
        NSIndexPath* indexPath = [NSIndexPath indexPathForRow:1 inSection:0];
        flyTableViewCell* cell = (flyTableViewCell* )[_tableView1 cellForRowAtIndexPath:indexPath];
        [UIView beginAnimations:nil context:nil];
        [UIView setAnimationDuration:0.5];
        [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:cell.cell1But cache:YES];
        [cell.cell1But setTitle:self.fanchengdt forState:UIControlStateNormal];
        [UIView commitAnimations];

    
}
-(void)segmentClick:(UISegmentedControl *)sender;
{
    NSLog(@"-----%d",sender.selectedSegmentIndex);
    if (sender.selectedSegmentIndex == 1)
    {
            [UIView beginAnimations:nil context:nil];
            [UIView animateWithDuration:1 animations:^{
                _tableView1.frame = CGRectMake(0, HIGHt, WITH-20, HIGHt/30);
                _button.hidden = YES;
                
            } completion:^(BOOL finished) {
                _timeview = [[UIView alloc] initWithFrame:CGRectMake(10, HIGHt-180, WITH-20, 180)];
                _timeview.backgroundColor = [UIColor whiteColor];
                [self.view addSubview:_timeview];
                UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WITH-20-60, 40)];
                lable.text = @"  选择时间";
                lable.textColor = [UIColor orangeColor];
                [_timeview addSubview:lable];
                UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
                button.frame = CGRectMake(WITH-20-60, 0, 60, 40);
                [button setTitle:@"确认" forState:UIControlStateNormal];
                [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
                [button addTarget:self action:@selector(timesureButton) forControlEvents:UIControlEventTouchUpInside];
                [_timeview addSubview:button];
                self.zlVc = [[ZLTimer alloc] initWithFrame:CGRectMake(0, 40, WITH-20, 140)];
                self.zlVc.backgroundColor = [UIColor whiteColor];
                
                [_timeview addSubview:self.zlVc];
            }];
            [UIView commitAnimations];

    }
}
-(void)cell1But
{
    TTTest3ViewController *text3 = [[TTTest3ViewController alloc] init];
    if ([yuyue isEqualToString:@"1"])
    {
        text3.fanchengStr = self.fczb;
    }
    else
    {
       
        text3.fanchengStr = [NSString stringWithFormat:@"%f,%f",self.l.coordinate.longitude,self.l.coordinate.latitude];
         NSLog(@"text3   %@",text3.fanchengStr);

    }
    [self presentViewController:text3 animated:YES completion:nil];
    
}
-(void)cell2But
{
    _button.hidden = YES;
    [self.locationManager stopUpdatingLocation];
    _pointAnnotation = nil;
    [_map removeAnnotations:self.map.annotations];
    _imageView.hidden = NO;
    
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:1 animations:^{
        
        _tableView1.frame = CGRectMake(10, HIGHt, WITH-20, HIGHt/3);
        
    } completion:^(BOOL finished) {
        _tab3View.frame = CGRectMake(10, self.view.center.y+100, WITH-20, HIGHt);
    }];
    [UIView commitAnimations];
    
}
-(void)cell3But
{
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:1 animations:^{
        _tableView1.frame = CGRectMake(0, HIGHt, WITH-20, HIGHt/3);
        _button.hidden = YES;
        
    } completion:^(BOOL finished) {
        [self peopleLab];
        
    }];
    [UIView commitAnimations];
    
}
-(void)sureButton3
{
    _imageView.hidden = YES;
    _pointAnnotation = [[MAPointAnnotation alloc] init];
    _pointAnnotation.title = @"zhen";

    [_map setUserTrackingMode:MAUserTrackingModeNone animated:YES];
    if (addressIndex != 0)
    {
        _pointAnnotation.coordinate = CLLocationCoordinate2DMake(j, w);
         chej = j;
        chew = w;

    }
    else
    {
         AMapGeoPoint *location =  _locationArray[0];
        _pointAnnotation.coordinate = CLLocationCoordinate2DMake(location.latitude, location.longitude);
         chej = location.latitude;
        chew = location.longitude;
    }
    [_map addAnnotation:_pointAnnotation];
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:1 animations:^{
        _tab3View.frame = CGRectMake(10, HIGHt, WITH-20, HIGHt/3);
        _button.hidden = NO;
        
    } completion:^(BOOL finished) {
        _tableView1.frame = CGRectMake(10, HIGHt/3*2, WITH-20, HIGHt/3);
        [_tableView1 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:2 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
        
    }];
    [UIView commitAnimations];
    
    _startPoint = [AMapNaviPoint locationWithLatitude:chej  longitude:chew];
    _endPoint   = [AMapNaviPoint locationWithLatitude:[self.p.FLatitude floatValue] longitude:[self.p.Flongitude floatValue]];
    NSArray *startPoints = @[_startPoint];
    NSArray *endPoints = @[_endPoint];
    [_naviManger calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:0];

}
- (void)naviManager:(AMapNaviManager *)naviManager onCalculateRouteFailure:(NSError *)error
{
    NSLog(@"aiaiaiaia  %@",error);
}
-(void)finshBut
{
    
    // 获取时间戳
    if (self.dingdan.getcaradress == nil) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"请选择上车点" delegate:nil cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
        [alert show];
        
    }
    else
    {
        if (_numString == nil) {
            self.dingdan.number = @"1";
        }
        if ([yuyue isEqualToString:@"1"])
        {
//            NSLog(@"你猜呀    %@",[NSString stringWithFormat:@"%@,%@",self.p.Tlong,self.p.Tlati]);
            NSDateFormatter *format = [[NSDateFormatter alloc] init];
            [format setDateStyle:NSDateFormatterMediumStyle];
            [format setTimeStyle:NSDateFormatterShortStyle];
            [format setDateFormat:@"YYYY-MM-dd HH:mm"];
            NSDate *date1 = [format dateFromString:self.zlVc.timeString];
            NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date1 timeIntervalSince1970]];
            NSLog(@"timeSp:%@------------>>%@==========>>>>>%@",timeSp,date1,self.zlVc.timeString); //时间戳的值
            NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Passenger&_A=advanceOrder"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"17",@"uid",[NSString stringWithFormat:@"%@,%@",self.p.Tlong,self.p.Tlati],@"position",timeSp,@"setOut",self.dingdan.number,@"num",nil];

            [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"advanceOrder" param:dic datatype:[NSDictionary class] notifName:self.notificationName];

        }
        else
        {
            NSTimeInterval time = [[NSDate date] timeIntervalSince1970];
            long long int date1 = (long long int)(time/(60*10)+1)*60*10;
            NSLog(@"-----date\n%lld",date1);
            self.dingdan.time = [NSString stringWithFormat:@"%lld",date1];
            
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
            NSString *datetime = [formatter stringFromDate:[NSDate date]];
            self.dingdan.dateString = datetime;
            
            NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Passenger&_A=searchOrder"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"17",@"uid",self.dingdan.locaStr,@"position",[NSString stringWithFormat:@"%lld",date1],@"setOut",self.dingdan.number,@"num",nil];
            [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"searchOrder" param:dic datatype:[NSDictionary class] notifName:self.notificationName];

        }
    }
}

-(void) receiveNotif:(NSNotification *)notif
{
    TTNetResondDate * info = [notif object];
    if([info.action isEqualToString:@"searchOrder"])
    {
        if(info.isNormal)
        {
            NSLog(@"111%@",info.respondDate);
            jgImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"已加入该订单底框"]];
            jgImage.center = self.view.center;
            jgImage.bounds = CGRectMake(0, 0, WITH/2-60, WITH/6);
            [self.view addSubview:jgImage];
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WITH/2-60, WITH/6)];
            label.text = @"已匹配到合适订单";
            label.textColor = [UIColor whiteColor];
            [jgImage addSubview:label];
            
            [self performSelector:@selector(disAppear) withObject:jgImage afterDelay:1.5];

        }
        else
        {
            NSLog(@"222%@",info.respondDate);
//            [MyToast showWithText:info.msg];
            if ([info.respondObject objectForKey:@"msg"] == NULL)
            {
                
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"暂无合适订单，是否新建" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];

                
            }
        }
    }
    else
    {
        NSLog(@"111%@",info.respondDate);
        getorder = [[TTaddOrder alloc] init];
        NSDictionary *routeDic = [info.respondDate objectForKey:@"route"];
        getorder.dname = [[info.respondDate objectForKey:@"driver"] objectForKey:@"nickname"];
        getorder.dphone = [[info.respondDate objectForKey:@"driver"] objectForKey:@"phone"];
        getorder.duid = [[info.respondDate objectForKey:@"driver"] objectForKey:@"uid"];
        getorder.faddress = [[routeDic objectForKey:@"from"] objectForKey:@"address"];
        getorder.taddress = [[routeDic objectForKey:@"to"] objectForKey:@"address"];
        getorder.time = [info.respondDate objectForKey:@"time"];
        getorder.price = [[info.respondDate objectForKey:@"route"] objectForKey:@"price"];
        getorder.passIspay = [[info.respondDate objectForKey:@"passenger"] objectForKey:@"isPay"];
        getorder.passIson = [[info.respondDate objectForKey:@"passenger"] objectForKey:@"isOn"];
        getorder.orderid = [info.respondDate objectForKey:@"orderid"];
        getorder.passuid = [[info.respondDate objectForKey:@"passengers"] objectForKey:@"uid"];
        if (info.respondDate) {
            NSLog(@"-----------%@========%@",getorder.passIspay,getorder.passIson);
            if (![getorder.passIson isEqualToString:@"2"] && [getorder.passIspay isEqualToString:@"0"])
            {
                TTTest7ViewController *text7 = [[TTTest7ViewController alloc] init];
                text7.order = getorder;
                [self presentViewController:text7 animated:YES completion:nil];
            }else if ([getorder.passIson isEqualToString:@"2"] && [getorder.passIspay isEqualToString:@"0"]) {
                
                TTTGerCarViewController *getcar = [[TTTGerCarViewController alloc] init];
                getcar.payOrder = getorder;
                [self presentViewController:getcar animated:YES completion:nil];
            }

        }

    }
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        if (_numString == nil) {
            self.dingdan.number = @"1";
        }
        TTText5ViewController *text5 = [[TTText5ViewController alloc] init];
        text5.xtd = self.dingdan;

        [self presentViewController:text5 animated:YES completion:nil];
    }
}
-(void)disAppear
{
    jgImage.hidden = YES;
    TTTest4ViewController *text4 = [[TTTest4ViewController alloc] init];
    [self presentViewController:text4 animated:YES completion:nil];
}
-(void)timesureButton
{
    yuyue = @"1";
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:1 animations:^{
        _timeview.frame = CGRectMake(0, HIGHt, WITH-20, 0);
    } completion:^(BOOL finished) {
        _tableView1.frame = CGRectMake(10, HIGHt/3*2, WITH-20, HIGHt/3);
        _button.hidden = NO;
    }];
    [UIView commitAnimations];
    [_tableView1 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:0 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
    
}
-(void)sureButton
{
    [UIView beginAnimations:nil context:nil];
    [UIView animateWithDuration:1 animations:^{
        _peopleView.frame = CGRectMake(10, HIGHt, WITH-20, HIGHt/3);
    } completion:^(BOOL finished) {
        _tableView1.frame = CGRectMake(10, HIGHt/3*2, WITH-20, HIGHt/3);
        _button.hidden = NO;
    }];
    [UIView commitAnimations];
    
}

-(void)peopleLab
{
    _numArray = [NSMutableArray array];
    for (int i = 1; i<8; i++)
    {
        NSString *numStr = [NSString stringWithFormat:@"%d人",i];
        [_numArray addObject:numStr];
        
    }
    
    _peopleView = [[UIView alloc] initWithFrame:CGRectMake(10, HIGHt/3*2, WITH-20, HIGHt/3)];
    _peopleView.backgroundColor  = [UIColor whiteColor];
    [self.view addSubview:_peopleView];
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WITH-20-60, 40)];
    lable.text = @"  选择人数";
    lable.textColor = [UIColor orangeColor];
    [_peopleView addSubview:lable];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(WITH-20-60, 0, 60, 40);
    [button setTitle:@"确认" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sureButton) forControlEvents:UIControlEventTouchUpInside];
    [_peopleView addSubview:button];
    
    
    UIPickerView *picView = [[UIPickerView alloc] initWithFrame:CGRectMake(10, 40, WITH-20, 140)];
    picView.dataSource =self;
    picView.delegate = self;
    picView.backgroundColor = [UIColor whiteColor];
    
    [_peopleView addSubview:picView];
    
    
    
}
#pragma mark --------------------- UIPickerViewDelegate ---------------
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return 7;
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    
    
    return _numArray[row];
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    _numString = _numArray[row];
    [_tableView1 reloadRowsAtIndexPaths:[NSArray arrayWithObjects:[NSIndexPath indexPathForRow:3 inSection:0], nil] withRowAnimation:UITableViewRowAnimationNone];
}

- (void)initBtn
{
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(WITH-50, self.view.frame.size.height * 0.5, 50, 30);
    btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"move" forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(mov) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:btn];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
//获取上一页数据
filter(@"Test2ViewController")
-(TTSignalHandleType)handleSignal:(TTSignal *)signal{
    //区别是消息还是正常跳转
    NSLog(@"数据%@",signal.strValue);
    return handleRemove;
}

- (void)AMapSearchRequest:(id)request didFailWithError:(NSError *)error{
    NSLog(@"PPP%@",error.userInfo);
}



@end
