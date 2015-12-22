//
//  TTMapView.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/16.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTMapView.h"
#import "APIKey.h"
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapNaviKit/AMapNaviKit.h>
#import "TTHttpHanler+HttpHanlerResolver.h"

@interface TTMapView ()

@property (nonatomic, copy) AMapLocatingCompletionBlock completionBlock;

@property (nonatomic, strong) UISegmentedControl *showSegment;
@property(nonatomic,retain) MAPinAnnotationView * pointAnnotation;

@end

@implementation TTMapView
@synthesize mapView = _mapView;
@synthesize locationManager = _locationManager;

@synthesize showSegment = _showSegment;

// [self.locationManager startUpdatingLocation];//提前开始
-(void) reloadMap{
    [self.locationManager startUpdatingLocation];//提前开始
}

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self ) {
        [self configureAPIKey];
        
        [self initMapView];
        
        [self initLocationManager];
        
        [self configLocationManager];
        
        [self initNaviManager];
        
        //获取通知中心单例对象
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
        [center addObserver:self selector:@selector(initDateSource:) name:@"123" object:nil];
        
        
        
        _mapView.customizeUserLocationAccuracyCircleRepresentation = YES;
        
        //    //带逆地理定位（返回坐标和地址信息）
        [self.mapView removeAnnotations:self.mapView.annotations];
        
        [self.locationManager requestLocationWithReGeocode:YES completionBlock:self.completionBlock];
        
        // Annotations
        //    [_mapView addAnnotations:[self generateAnnotations]];
    }
    return self;
}

- (void)configureAPIKey
{
//    [MAMapServices sharedServices].apiKey = (NSString *)APIKey;
//    [AMapLocationServices sharedServices].apiKey = (NSString *)APIKey;
//    [AMapSearchServices sharedServices].apiKey = (NSString *)APIKey;
    [[MAMapServices sharedServices] setApiKey:@"462cd9b5e750e10be4a7ea5f30007552"];
    [AMapLocationServices sharedServices].apiKey = @"462cd9b5e750e10be4a7ea5f30007552";
    [AMapSearchServices sharedServices].apiKey = @"462cd9b5e750e10be4a7ea5f30007552";
    [AMapNaviServices sharedServices].apiKey = @"462cd9b5e750e10be4a7ea5f30007552";//fabbe419765d08ab2b66bcec0180e491
}

#pragma mark - Initialization

- (void)initMapView
{
    self.mapView = [[MAMapView alloc] initWithFrame:self.bounds];
    
    self.mapView.delegate = self;
    
    [self addSubview:self.mapView];
    _nearbyManager = [AMapNearbySearchManager sharedInstance];
    _nearbyManager.delegate = self;
    _nearbyManager.uploadTimeInterval = 7;
    [_nearbyManager startAutoUploadNearbyInfo];//开启自动上传
    self.mapView.showsScale = YES;
    [self.mapView setZoomLevel:14 animated:YES];
    [_mapView setUserTrackingMode: MAUserTrackingModeFollow animated:YES]; //地图跟着位置移动

}


- (void)initLocationManager
{
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.distanceFilter = CLLocationDistanceMax;//地图可滑动kCLDistanceFilterNone
    self.locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters;//定位的默认精度
}

#pragma mark - mapView:viewForAnnotation
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = NO;        //设置标注动画显示，默认为NO
        annotationView.draggable = NO;        //设置标注可以拖动，默认为NO
        annotationView.image = [UIImage imageNamed:@"icon_location@2x.png"];
        return annotationView;
    }
    return nil;
}



#pragma mark - Action Handle

- (void)configLocationManager
{
    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
    
    [self.locationManager setAllowsBackgroundLocationUpdates:YES];
}



#pragma mark - Initialization


- (void)addAnnotationToMapView:(id<MAAnnotation>)annotation
{
    [self.mapView addAnnotation:annotation];
    
    [self.mapView selectAnnotation:annotation animated:YES];
    [self.mapView setZoomLevel:15.1 animated:NO];
    [self.mapView setCenterCoordinate:annotation.coordinate animated:YES];
}


#pragma mark--- 创建搜索对象----
-(void) initSearchAPI{
    //1.创建搜索对象
    self.searchAPI = [[AMapSearchAPI alloc] init];
    self.searchAPI.delegate = self;
}

#pragma mark  MAMapViewDelegate


//获取数据
-(void) initDateSource:(NSNotification *)info
{
    _addArr = [[NSMutableArray alloc]init];
    _peopleArray = [[NSMutableArray alloc] init];
    _pointArray = [[NSMutableArray alloc] init];
    
    
    NSDictionary * dic = info.object;
    NSDictionary * dict = dic[@"order"];
    NSDictionary * routeDic = dict[@"route"];
    NSDictionary * fromDic = routeDic[@"from"];
    NSDictionary * toDic = routeDic[@"to"];
    NSArray * passengersArr = dict[@"passengers"];
    NSMutableArray * nameArr = [[NSMutableArray alloc] init];
    for (NSDictionary * dic in passengersArr) {
        [_peopleArray addObject:dic[@"coord"]];
        [nameArr addObject:dic[@"coord_name"]];
    }
    [_addArr addObject:fromDic];
    [_addArr addObject:toDic];
   
    if (self.peopleArray.count != 0) {
        for (int i=0; i<self.peopleArray.count; i++) {
            NSLog(@"%@",self.peopleArray[i]);
            NSLog(@"%d",self.peopleArray.count);
            
            NSArray *arr = [self.peopleArray[i] componentsSeparatedByString:@","]; //从字符,中分隔成2个元素的数组
            //获取一个结果就将结果内容放在大头针上
            MAPointAnnotation * point = [[MAPointAnnotation alloc] init];
            point.title =nameArr[i];
            point.coordinate = CLLocationCoordinate2DMake([arr[1] floatValue], [arr[0] floatValue]);
            
            //将大头针添加到地图上
            [self.mapView addAnnotation:point];
            
            //将大头针添加到数组中
            [_pointArray addObject:point];
        }
        
    }

}


#pragma ---线路规划---
- (void)initNaviManager
{
    if (_naviManager == nil)
    {
        _naviManager = [[AMapNaviManager alloc] init];
        
    }
    _naviManager.delegate = self;
}
/*!
 @brief 驾车路径规划成功后的回调函数
 */

- (void)naviManagerOnCalculateRouteSuccess:(AMapNaviManager *)naviManager
{
    
    [self showRouteWithNaviRoute:[[naviManager naviRoute] copy]];
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
        [self.mapView removeOverlay:_polyline];
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
    [self.mapView addOverlay:_polyline];
}
//起止点线路规划
- (void)routeCal
{
    if (_addArr != nil) {
        NSDictionary * dic0 = _addArr[0];
        NSDictionary * dic1 = _addArr[1];
        AMapNaviPoint * startPoint = [AMapNaviPoint locationWithLatitude:[dic0[@"latitude"] floatValue] longitude:[dic0[@"longitude"] floatValue] ];//[AMapNaviPoint locationWithLatitude: 39.100542 longitude:117.182751];//117.182751,39.100542
        AMapNaviPoint * endPoint = [AMapNaviPoint locationWithLatitude:[dic1[@"latitude"] floatValue] longitude:[dic1[@"longitude"] floatValue]];//[AMapNaviPoint locationWithLatitude:39.09971 longitude:117.186162];//117.186162,39.09971
        
        NSArray *startPoints = @[startPoint];
        NSArray *endPoints   = @[endPoint];
        
        //驾车路径规划（未设置途经点、导航策略为速度优先）
        [_naviManager calculateDriveRouteWithStartPoints:startPoints endPoints:endPoints wayPoints:nil drivingStrategy:0];
    }
    
    
}

-(MAOverlayView *) mapView:(MAMapView *)mapView viewForOverlay:(id<MAOverlay>)overlay{
    if ([overlay isKindOfClass:[MAPolyline class]])
    {
        MAPolylineView *polylineView = [[MAPolylineView alloc] initWithPolyline:overlay];
        polylineView.tag = 200;
        
        polylineView.lineWidth   = 5.0f;
        polylineView.strokeColor = [UIColor redColor];
        
        return polylineView;
    }
    /* 自定义定位精度对应的MACircleView. */
    if (overlay == mapView.userLocationAccuracyCircle)
    {
        MACircleView *accuracyCircleView = [[MACircleView alloc] initWithCircle:overlay];
        
        accuracyCircleView.lineWidth    = 2.f;
        accuracyCircleView.strokeColor  = [UIColor lightGrayColor];
        accuracyCircleView.fillColor    = [UIColor colorWithRed:1 green:0 blue:0 alpha:.3];
        
        return accuracyCircleView;
    }
    return nil;
}

#pragma mark ---连续上传----

//当位置更新时，会进定位回调，通过回调函数，能获取到定位点的经纬度坐标，示例代码如下：

-(void)mapView:(MAMapView *)mapView didUpdateUserLocation:(MAUserLocation *)userLocation
updatingLocation:(BOOL)updatingLocation
{
    //取出当前位置的坐标
    NSLog(@"咔咔咔latitude : %f,longitude: %f",userLocation.coordinate.latitude,userLocation.coordinate.longitude);
    _myLatitude = [NSString stringWithFormat:@"%f",userLocation.coordinate.latitude];
    _myLongitude = [NSString stringWithFormat:@"%f",userLocation.coordinate.longitude];
    

    
}
- (AMapNearbyUploadInfo *)nearbyInfoForUploading:(AMapNearbySearchManager *)manager
{
    AMapNearbyUploadInfo *info = [[AMapNearbyUploadInfo alloc] init];
    info.userID = _uidStr;
    info.coordinate = CLLocationCoordinate2DMake([_myLatitude floatValue],[_myLongitude floatValue]);
    NSLog(@"傻傻%f----%f",[_myLatitude floatValue],[_myLongitude floatValue]);
    return info;
}

-(void) clearMapView{
    _addArr = nil;
    _peopleArray =nil;
    
    [self.mapView removeAnnotations:self.mapView.annotations];
    
    [self.mapView removeOverlay:_polyline];
    self.polyline = nil;
    NSLog(@"清除");

}
//计算距离的方法
-(double) distance:(NSMutableArray * )arr {
           //1.将两个经纬度点转成投影点
        MAMapPoint point1 = MAMapPointForCoordinate(CLLocationCoordinate2DMake([arr[0] floatValue],[arr[1] floatValue]));
        MAMapPoint point2 = MAMapPointForCoordinate(CLLocationCoordinate2DMake([_myLatitude floatValue],[_myLongitude floatValue]));
        //2.计算距离
        CLLocationDistance distance = MAMetersBetweenMapPoints(point1,point2);
        return distance;
}

@end
