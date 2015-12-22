//
//  XTTTest7ViewController.m
//  tiptimes_frame
//
//  Created by ycf on 15/12/14.
//  Copyright © 2015年 ycf. All rights reserved.
//

#import "TTTest7ViewController.h"
#import "TTTGerCarViewController.h"
#import "TTHttpHanler+HttpHanlerResolver.h"

#import "MovingAnnotationView.h"
#import "TracingPoint.h"
#import "Util.h"
@interface TTTest7ViewController ()<UIAlertViewDelegate,AMapNearbySearchManagerDelegate,AMapSearchDelegate,AMapLocationManagerDelegate>
{
  AMapNearbySearchManager *_nearbyManager;
  NSMutableArray * _tracking;
  CFTimeInterval _duration;
    
  NSMutableArray *_moveArray ;

}
@property (nonatomic,strong)UILabel *namelable;

@end

@implementation TTTest7ViewController
- (void)initRoute:(NSMutableArray *)moveArray
{
    _duration = 8.0;
    
    NSUInteger count = moveArray.count;
    CLLocationCoordinate2D * coords = malloc(count * sizeof(CLLocationCoordinate2D));
    for (int i=0; i<moveArray.count; i++)
    {
        AMapNearbyUserInfo *info = [moveArray objectAtIndex:i];
        coords[i] = CLLocationCoordinate2DMake(info.location.latitude, info.location.longitude);
//        NSLog(@"-=-==-=-=-=-===-=%@",info.location);
    }
    
    
//    [self showRouteForCoords:coords count:count];
    [self initTrackingWithCoords:coords count:count];
    
    if (coords) {
        free(coords);
    }
    
}

//- (void)showRouteForCoords:(CLLocationCoordinate2D *)coords count:(NSUInteger)count
//{
//    //show route
//    MAPolyline *route = [MAPolyline polylineWithCoordinates:coords count:count];
//    [self.map addOverlay:route];
//    
//    NSMutableArray * routeAnno = [NSMutableArray array];
//    for (int i = 0 ; i < count; i++)
//    {
//        MAPointAnnotation * a = [[MAPointAnnotation alloc] init];
//        a.coordinate = coords[i];
//        a.title = @"route";
//        [routeAnno addObject:a];
//    }
//    [self.map addAnnotations:routeAnno];
//    [self.map showAnnotations:routeAnno animated:NO];
//    
//}

- (void)initTrackingWithCoords:(CLLocationCoordinate2D *)coords count:(NSUInteger)count
{
    _tracking = [NSMutableArray array];
    for (int i = 0; i<count - 1; i++)
    {
        TracingPoint * tp = [[TracingPoint alloc] init];
        tp.coordinate = coords[i];
        tp.course = [Util calculateCourseFromCoordinate:coords[i] to:coords[i+1]];
        [_tracking addObject:tp];
    }
    
    TracingPoint * tp = [[TracingPoint alloc] init];
    tp.coordinate = coords[count - 1];
    tp.course = ((TracingPoint *)[_tracking lastObject]).course;
    [_tracking addObject:tp];
}
#pragma mark - Action

- (void)mov
{
    MovingAnnotationView * carView = (MovingAnnotationView *)[self.map viewForAnnotation:self.car];
    [carView addTrackingAnimationForPoints:_tracking duration:_duration];
}
- (void)initAnnotation
{
//    [self initRoute];
    self.car = [[MAPointAnnotation alloc] init];
//    TracingPoint * start = [_tracking firstObject];
    self.car.coordinate = CLLocationCoordinate2DMake([self.order.flatitude floatValue], [self.order.flongitude floatValue]);
    NSLog(@"小车标注  %@",[_tracking firstObject]);
    self.car.title = @"Car";
    [self.map addAnnotation:self.car];
    
}
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id<MAAnnotation>)annotation
{
    /* Step 2. */
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndetifier = @"pointReuseIndetifier";
        MovingAnnotationView *annotationView = (MovingAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndetifier];
        if (annotationView == nil)
        {
            annotationView = [[MovingAnnotationView alloc] initWithAnnotation:annotation
                                                              reuseIdentifier:pointReuseIndetifier];
        }
        
        if ([annotation.title isEqualToString:@"Car"])
        {
            UIImage *imge  =  [UIImage imageNamed:@"车"];
            annotationView.image =  imge;
            CGPoint centerPoint=CGPointZero;
            [annotationView setCenterOffset:centerPoint];
        }
        
        return annotationView;
    }
    
    return nil;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.locationManager stopUpdatingLocation];
    self.topimgview.hidden = YES;
    self.backBut.hidden = YES;
    self.tableView1.hidden = YES;
    self.button.hidden = YES;
    
    _moveArray = [[NSMutableArray alloc] initWithCapacity:0];
 
    self.search = [[AMapSearchAPI alloc] init];//  周边搜索
    self.search.delegate = self;
    _nearbyManager = [AMapNearbySearchManager sharedInstance];// 附近管理对象
    _nearbyManager.uploadTimeInterval = 7;
    _nearbyManager.delegate = self;
    [_nearbyManager startAutoUploadNearbyInfo];
//
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self.locationManager startUpdatingLocation];
    
    [self initAnnotation];
    
    self.uselocation = [[MAUserLocation alloc] init];
    UIImageView *Timage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"状态栏白色"]];
    Timage.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64);
    Timage.userInteractionEnabled = YES;
    [self.view addSubview:Timage];
    UILabel *label = [[UILabel alloc] init];
    label.center = Timage.center;
    label.bounds = CGRectMake(0, 0, 80, 40);
    label.text = @"已接单";
    [Timage addSubview:label];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 15, 60, 40);
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
    [Timage addSubview:button];
    UIButton *clickBut = [UIButton buttonWithType:UIButtonTypeSystem];
    clickBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, 15, 100, 40);
    [clickBut setTitle:@"取消订单" forState:UIControlStateNormal];
    [Timage addSubview:clickBut];
    
    [self jiedan];
    
}
-(void)jiedan
{
        UIImageView *jdImaeg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"写下评论输入框"]];
    jdImaeg.frame = CGRectMake(10, 70, [[UIScreen mainScreen] bounds].size.width-20, [[UIScreen mainScreen] bounds].size.height/3);
    jdImaeg.userInteractionEnabled = YES;
    [self.view addSubview:jdImaeg];
    
     UIImageView *touXImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
     touXImage.backgroundColor = [UIColor brownColor];
    [jdImaeg addSubview:touXImage];
    self.namelable = [[UILabel alloc] initWithFrame:CGRectMake(68, 10, 180, 30)];
    self.namelable.text = [NSString stringWithFormat:@"%@-%@",self.order.dname,self.order.dphone];
    [jdImaeg addSubview:self.namelable];
    for (int i = 0; i<6; i++)
    {
        UIImageView *XXimage = [[UIImageView alloc] initWithFrame:CGRectMake(68+18*i, self.namelable.frame.origin.y+33, 15, 15)];
        XXimage.image = [UIImage imageNamed:@"ic_star_empty"];
        [jdImaeg addSubview:XXimage];
    }
    
    UILabel *carLab = [[UILabel alloc] initWithFrame:CGRectMake(68, self.namelable.frame.origin.y+45, 180, 20)];
    carLab.text = @"银色 七座商务车";
    carLab.textColor = [UIColor grayColor];
    [jdImaeg addSubview:carLab];
    
    UILabel *juliLab = [[UILabel alloc] initWithFrame:CGRectMake(10, carLab.frame.origin.y+23, 200, 30)];
    juliLab.text = @"距我500米，预计三分钟后到达";
    [jdImaeg addSubview:juliLab];
    
    UIImageView *phionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_call"]];
    phionImage.frame = CGRectMake(jdImaeg.frame.size.width-60, touXImage.frame.origin.y, 60, 60);
    [jdImaeg addSubview:phionImage];

    UIButton *getCarBut = [UIButton buttonWithType:UIButtonTypeSystem];
    getCarBut.frame = CGRectMake(0, jdImaeg.frame.size.height-80, jdImaeg.frame.size.width, 50);
    [getCarBut setBackgroundImage:[UIImage imageNamed:@"已上车按钮"] forState:UIControlStateNormal];
    [getCarBut setTitle:@"已上车" forState:UIControlStateNormal];
    [getCarBut addTarget:self action:@selector(getcar11) forControlEvents:UIControlEventTouchUpInside];
    [jdImaeg addSubview:getCarBut];
}
-(void)getcar11
{

    //  发起周边搜索
    
    [self mov];
    
    AMapNearbySearchRequest *nearRequest;
    if (!nearRequest) {
        nearRequest = [[AMapNearbySearchRequest alloc] init];
    }
    nearRequest.center = [AMapGeoPoint locationWithLatitude:self.uselocation.coordinate.latitude longitude:self.uselocation.coordinate.longitude];
    nearRequest.radius = 100;//搜索半径
    nearRequest.timeRange = 1000;// 查询时间
    nearRequest.searchType = AMapNearbySearchTypeLiner; //  表示直线距离
    [self.search AMapNearbySearch:nearRequest];

    NSLog(@"========》》》%@",self.order.orderid);
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Passenger&_A=getOn"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"17",@"uid",self.order.orderid,@"orderid",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"geton" param:dic datatype:[NSDictionary class] notifName:self.notificationName];

}
-(void) receiveNotif:(NSNotification *)notif
{
    //    _data = [[NSMutableArray alloc] initWithCapacity:0];
    TTNetResondDate * info = [notif object];

    if([info.action isEqualToString:@"geton"]){
        if(info.isNormal){
            NSLog(@"-=-------->>>>>>>%@",info.msg);
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"上车成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];

            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:info.msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    TTTGerCarViewController *getCar = [[TTTGerCarViewController alloc] init];
    getCar.payOrder = self.order;
    [self presentViewController:getCar animated:YES completion:nil];


}
- (void)mapView:(MAMapView *)mapView didUpdateserLocation:(MAUserLocation *)userLocation updatingLocation:(BOOL)updatingLocation
{
    if(updatingLocation)
    {
        //取出当前位置的坐标
//        NSLog(@"latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
        
//       self.uselocation.coordinate = userLocation.coordinate;
//        //构造上传数据对象
//        self.info = [[AMapNearbyUploadInfo alloc] init];
//        self.info.userID = @"17";//业务逻辑id
//        self.info.coordinateType = AMapSearchCoordinateTypeAMap;//坐标系类型
//        self.info.coordinate = CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude);//用户位置信息

    }
}
//- (void)onNearbyInfoUploadedWithError:(NSError *)error
//{
//    NSLog(@"============%@",error);
//}
- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location
{
     //取出当前位置的坐标
//    NSLog(@"当前位置latitude : %f,longitude: %f",location.coordinate.latitude,location.coordinate.longitude);
    [self.map setCenterCoordinate:location.coordinate animated:YES];
    [self.map setZoomLevel:18 animated:NO];

    
}
- (AMapNearbyUploadInfo *)nearbyInfoForUploading:(AMapNearbySearchManager *)manager
{
//    NSLog(@"guxiangaaaa   %@",self.info.userID);
    AMapNearbySearchRequest *nearRequest;
    if (!nearRequest) {
        nearRequest = [[AMapNearbySearchRequest alloc] init];
    }
    nearRequest.center = [AMapGeoPoint locationWithLatitude:self.uselocation.coordinate.latitude longitude:self.uselocation.coordinate.longitude];
    nearRequest.radius = 100;//搜索半径
    nearRequest.timeRange = 1000;// 查询时间
    nearRequest.searchType = AMapNearbySearchTypeLiner; //  表示直线距离
    [self.search AMapNearbySearch:nearRequest];

    return self.info;
}
- (MAPolylineView *)mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        
        polylineView.lineWidth   = 3.f;
        polylineView.strokeColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
        
        return polylineView;
    }
    
    return nil;
}

#pragma mark -----------------------AMapNearbySearchManagerDelegate---------------
//附近周边搜索回调
- (void)onNearbySearchDone:(AMapNearbySearchRequest *)request response:(AMapNearbySearchResponse *)response
{
    if(response.infos.count == 0)
    {
        return;
    }
    
    for (AMapNearbyUserInfo *info in response.infos)
    {
        NSLog(@"-=-=-=-=-=-=-=-=-=-=-=-=-=-=-==-=%@",info.userID);
        if ([info.userID isEqualToString:self.order.duid]) {
            NSLog(@"())(()()()()()(     %@",info.location);
            [_moveArray addObject:info];
            [self initRoute:_moveArray];
        }
        
    }
}

-(void)goBack
{
    [self dismissViewControllerAnimated:YES completion:nil ];
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

@end
