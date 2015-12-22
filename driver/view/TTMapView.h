//
//  TTMapView.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/16.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <MAMapKit/MAMapKit.h>
#import "APIKey.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import <AMapSearchKit/AMapSearchKit.h>


@interface TTMapView : UIView<MAMapViewDelegate, AMapLocationManagerDelegate,AMapSearchDelegate,AMapNaviManagerDelegate,AMapNearbySearchManagerDelegate>
{
    AMapNearbySearchManager *_nearbyManager;
}

@property (nonatomic, strong) MAMapView *mapView;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property(nonatomic,retain) NSString * numStr;

//创建搜索对象
@property (nonatomic, strong) AMapNaviManager *naviManager;
@property(nonatomic,retain) AMapSearchAPI * searchAPI;
@property (nonatomic, strong) MAPolyline *polyline;

@property(nonatomic,retain) NSMutableArray * peopleArray;
@property(nonatomic,retain) NSMutableArray * addArr;

@property(nonatomic,retain) NSArray * dataSourceArr;

@property(nonatomic,retain) NSString * uidStr;//司机的uid账号


@property(nonatomic,retain) NSString * myLatitude;
@property(nonatomic,retain) NSString * myLongitude;

@property(nonatomic,retain) NSMutableArray * pointArray;




//刷新地图定位
-(void) reloadMap;

//mapview对象初始化
-(instancetype) initWithFrame:(CGRect)frame;
//创建搜索对象
-(void) initSearchAPI;
//起止点线路规划
- (void)routeCal;

-(void) clearMapView;

-(double) distance:(NSMutableArray * )arr ;
@end
