//
//  TTTest2ViewController.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/12.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTTest2ViewController.h"
#import <AMapNaviKit/AMapNaviKit.h>
#import <AMapSearchKit/AMapSearchKit.h>
#import <AMapLocationKit/AMapLocationKit.h>


#import "ZLTimer.h"
#import "XTDiDan.h"
#import "PiPeiCz.h"
@interface TTTest2ViewController : TTBaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    NSMutableArray * _tracking;
    CFTimeInterval _duration;
    NSTimer *_time;
    float j;
    float w;
    
    float chej;
    float chew;
    
    
}
@property (nonatomic,strong)UIImageView *topimgview;

@property (nonatomic,strong)UIButton *backBut;

@property (nonatomic,strong)UITableView *tableView1;

@property (nonatomic, strong) ZLTimer *zlVc;

@property (nonatomic, strong)UIButton *button;

@property (nonatomic,strong)XTDiDan *dingdan;
@property (nonatomic, strong) MAMapView *map;

@property (nonatomic, strong) AMapLocationManager *locationManager;

@property (nonatomic, strong) AMapSearchAPI *search;

@property (nonatomic ,strong) AMapNaviManager *naviManger;

@property (nonatomic,strong) NSMutableArray *nameArray;

@property (nonatomic,strong) NSMutableArray *locationArray;

@property (nonatomic, strong) AMapNaviPoint* startPoint;

@property (nonatomic, strong) AMapNaviPoint* endPoint;

@property (nonatomic, strong) MAPolyline *polyline;

@property (nonatomic, strong) NSArray *annotations;

@property (nonatomic) BOOL calRouteSuccess; // 指示是否算路成功

@property (nonatomic,strong)AMapNearbySearchManager *nearbyManger;

@property (nonatomic,strong)AMapPOIAroundSearchRequest *request;

@property (nonatomic,strong)PiPeiCz *p;

@property (nonatomic,strong)NSString *fanchengdt;

@property (strong, nonatomic)CLLocation *l;

@property (strong,nonatomic)NSString *fczb;
@end
