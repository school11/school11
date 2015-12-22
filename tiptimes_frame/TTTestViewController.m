//
//  TTTestViewController.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/12.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTTestViewController.h"
#import "TTTest2ViewController.h"
#import "TTHttpHanler+HttpHanlerResolver.h"
#import "TTTjjs.h"
#import "gTableViewCell.h"
#import "TTTWeiFinshViewController.h"

#import "UIViewController+XTSideMenu.h"
#import "XTSideMenu.h"
#import "TTHttpHanler+HttpHanlerResolver.h"
#import "TTPassengerModel.h"

#import "TTMapView.h"
#import "TTMessageView.h"
#import "TTSUIModel.h"
#import "TTLoginViewController.h"
#import "TTUrgentView.h"


#define WITH ([[UIScreen mainScreen]bounds].size.width)
#define HIGHt ([UIScreen mainScreen].bounds.size.height)

@interface TTTestViewController ()<UIAlertViewDelegate,UIActionSheetDelegate>{
    NSInteger request_page;
    NSInteger current_page;

    
    TTMapView * _mapView;
    TTMessageView * _messageView;
    
    NSTimer * _timers;
    TTPassengerModel * _model;
    UILabel * timeLabel;
    BOOL _isPlayOn;
    BOOL _isPlayPay;
    BOOL _isPlaySave;
    BOOL _isPlayGo;
}
@property(nonatomic,assign) BOOL isEable;//按钮开始查询订单
@property(nonatomic,assign) BOOL isCircle;//是否走完一圈
@property(nonatomic,assign) BOOL isBack;
@property(nonatomic,assign) BOOL isHua;
@property(nonatomic,assign) BOOL isFinish;//订单是否完成

@property(nonatomic,retain) NSString * startAddStr;//起点的名称
@property(nonatomic,retain) NSString * endAddStr;//终点的名称

@property(nonatomic,retain) NSString * timeStr;//订单时间
@property(nonatomic,retain) NSString * addString;

@property(nonatomic,retain) TTSUIModel * ttsModel;
@property(nonatomic,retain) NSString * orderidStr;

@property(nonatomic,retain) UIButton * topBtn;//顶部导航的按钮
@property(nonatomic,retain) UIButton * bottomBtn;//底部发车的按钮

@property(nonatomic,retain) NSDictionary * infoDic;



@property (nonatomic, strong)UIView *rightView;
@end

@implementation TTTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view setBackgroundColor:[UIColor whiteColor]];

    NSLog(@"沙盒路径：%@",NSHomeDirectory());
    
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _uidStr = [userDefaults objectForKey:@"uid"];
    _typeStr = [userDefaults objectForKey:@"type"];
    NSLog(@"typeuid%@--%@",_uidStr,_typeStr);
    if ([_typeStr isEqualToString:@"2"]) {
        
        [self sijiUI];
        
        
    }else{
        [self chengkeUI];
        
    }
  
}

#pragma mark---乘客---
-(void) chengkeUI{
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(50, 50, 100, 50)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(jump:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    
    UIButton *btn1 = [[UIButton alloc] initWithFrame:CGRectMake(50, 130, 100, 50)];
    [btn1 setBackgroundColor:[UIColor redColor]];
    [btn1 addTarget:self action:@selector(jump1:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn1];
    
    self.rightView = [[UIView alloc] initWithFrame:self.view.frame];
    self.rightView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.rightView];
    
    [self creatRightView];
    

}

-(void)creatRightView
{
    UIImageView *topimgview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WITH, 64)];
    topimgview.backgroundColor =[UIColor colorWithRed:253/255.0 green:172/255.0 blue:20/255.0 alpha:1];
    topimgview.userInteractionEnabled = YES;
    
    UIButton *btn =[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame =CGRectMake(20, 24,30, 30) ;
    
    [btn setImage:[UIImage imageNamed:@"w"] forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    
    [topimgview addSubview:btn];
    
    [self.view addSubview:topimgview];
    
    UITableView *lefttableview =[[UITableView alloc]initWithFrame:CGRectMake(0,260, WITH, HIGHt-260) style:UITableViewStylePlain];
    lefttableview.rowHeight = 120;
    lefttableview.dataSource=self;
    lefttableview.delegate =self;
    
    [self.view addSubview:lefttableview];
    
    self.imgArry =@[@"fddt",@"xc",@"dj",@"pcjc",@"ly",@"pchj"];
    self.titileArray =@[@"飞到地铁",@"拼车回家",@"学车",@"拼车聚餐",@"代驾",@"旅游"];
    for (int  i=0; i<6; i++)
    {
        float a = (WITH-5*30)/4;
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(20+i%4*(a+30), 80+i/4*(a+30), a , a);
        [btn  setBackgroundImage:[UIImage imageNamed:_imgArry[i]] forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(pressBtn:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag = i+1;
        [self.view addSubview:btn];
        
        UILabel *lable =[[UILabel alloc]init];
        //        lable.frame =CGRectMake(35+i%4*(60+40), 147+i/4*(60+25), 80, 20);
        lable.center = CGPointMake(btn.center.x, btn.center.y+(a/2+10));
        lable.bounds = CGRectMake(0, 0, a+20, 20);
        lable.textAlignment = NSTextAlignmentCenter;
        
        lable.font =[UIFont systemFontOfSize:15];
        lable.text=_titileArray[i];
        
        [self.view addSubview:lable];
    }
    UIImageView *imgview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 220, WITH, 40)];
    imgview.userInteractionEnabled = YES;
    imgview.backgroundColor =[UIColor colorWithRed:228/255.0 green:229/255.0 blue:230/255.0 alpha:1];
    [self.view addSubview:imgview];
    
    UILabel *comamdLb=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, WITH/3*2, 40)];
    comamdLb.text =@"  推荐拼车";
    comamdLb.font =[UIFont systemFontOfSize:20];
    comamdLb.textColor =[UIColor orangeColor];
    [imgview addSubview:comamdLb];
    
    UIButton *sXuanBtn =[UIButton buttonWithType:UIButtonTypeCustom];
    sXuanBtn.frame =CGRectMake(WITH/3*2, 0, WITH/3, 40);
    [sXuanBtn setTitle:@" 筛选" forState:UIControlStateNormal];
    [sXuanBtn setTitleColor:[UIColor purpleColor] forState:UIControlStateNormal];
    [sXuanBtn addTarget:self action:@selector(sXuanBtn) forControlEvents:UIControlEventTouchUpInside];
    [imgview addSubview:sXuanBtn];
    
}
-(void)pressBtn:(UIButton *)btn
{
    TTTest2ViewController *text2 = [[TTTest2ViewController alloc] init];
    
    [self presentViewController:text2 animated:YES completion:nil];


     
}

-(void)sXuanBtn
{
    NSLog(@"筛选按钮");
    
}
-(void)btnClick
{
    NSLog(@"返回按钮");
      [self.sideMenuViewController presentLeftViewController];
    
}
#pragma mark ----------tableViewDeletade---------
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSArray *xibArry =[[NSBundle mainBundle]loadNibNamed:@"gTableViewCell" owner:nil options:nil];
    
    gTableViewCell *cell =[tableView  dequeueReusableCellWithIdentifier:@"cell0"];
    if (cell ==nil)
    {
        
        cell =xibArry[0];
        
    }
    
    
    return cell;
    
}

-(IBAction)jump:(id)sender{
    TTSignal *notice = [[[[TTSignalBuild signalBuild] strValue:@"赫建武"]  filterStr:@"Test2ViewController"] build];
    [S sendSignal:notice];
    TTTest2ViewController *t = [[TTTest2ViewController alloc] init];
    [self.navigationController pushViewController:t animated:YES];
}

-(IBAction)jump1:(id)sender{
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Login&_A=login"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"admin",@"u",@"123123",@"p",@"aaaa",@"deviceNum",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"login" param:dic datatype:[NSDictionary class] notifName:self.notificationName];
    
   
}

#pragma mark---数据获取---
//获取数据
-(void) receiveNotif:(NSNotification *)notif
{
    TTNetResondDate * info = [notif object];
    if([info.action isEqualToString:@"getorder"]){
        if(info.isNormal){

//            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"完成未支付订单" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
//            [alert show];
            
        }else{
                TTTest2ViewController *text2 = [[TTTest2ViewController alloc] init];
            
                [self.navigationController pushViewController:text2 animated:YES];
        }
    }
    
    //++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++//
    _isOnArr = [[NSMutableArray alloc] init];
    _isPayArr = [[NSMutableArray alloc] init];
    _infoDic = [[NSDictionary alloc] init];
    _schoolArr = [[NSMutableArray alloc] init];
    _subwayArr = [[NSMutableArray alloc] init];
    

    _infoDic = info.respondDate;
    if([info.action isEqualToString:@"refreshTo"]){
        if(info.isNormal){
            NSLog(@"ffffff%@",info.respondDate);
            NSDictionary * direDic = _infoDic[@"myRoute"];
            [_schoolArr addObject:direDic[@"from"][@"latitude"]];
            [_schoolArr addObject:direDic[@"from"][@"longitude"]];
            [_subwayArr addObject:direDic[@"to"][@"latitude"]];
            [_subwayArr addObject:direDic[@"to"][@"longitude"]];
            NSLog(@"distance---%f----%f",[_mapView distance:_schoolArr],[_mapView distance:_subwayArr]);
            if ([_mapView distance:_schoolArr]>[_mapView distance:_subwayArr]) {
                _directionStr = @"0";
                NSLog(@"默认0");
            }else{
                _directionStr = @"1";
                NSLog(@"默认1");
            }
            NSLog(@"_directionStr%@",_directionStr);
            if (_infoDic[@"order"] == NULL) {
                NSLog(@"没有订单信息，继续轮查");
                
            }else{
                NSLog(@"有订单信息");
                NSDictionary * dict = _infoDic[@"order"];
                
                _orderidStr = dict[@"orderid"];
                
                NSDictionary * routeDic = dict[@"route"];
                NSDictionary * fromDic = routeDic[@"from"];
                NSDictionary * toDic = routeDic[@"to"];
                
                NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dict[@"time"] floatValue]];
                NSLog(@"1450148400  = %@",confromTimesp);
                _timeStr = [[NSString stringWithFormat:@"%@",confromTimesp] substringToIndex:19];
                
                _startAddStr = [NSString stringWithFormat:@"%@" ,fromDic[@"address"]];
                _endAddStr = [NSString stringWithFormat:@"%@" ,toDic[@"address"]];
                
                NSString * str= [NSString stringWithFormat:@"您有新的订单，%@到%@",_startAddStr,_endAddStr];
                NSArray * passengersArr = dict[@"passengers"];
                for (NSDictionary * dic in passengersArr) {
                    
                    [_isPayArr addObject: dic[@"isPay"]];
                    [_isOnArr addObject: dic[@"isOn"]];
                    
                }
                
                //创建一个消息对象
                NSNotification * notice = [NSNotification notificationWithName:@"123" object:_infoDic userInfo:nil];
                //发送消息
                [[NSNotificationCenter defaultCenter]postNotification:notice];
                
                
                
                NSLog(@"按钮文字%@",_topBtn.titleLabel.text);
                if (_isPlaySave == YES) {
                    [NSThread detachNewThreadSelector:@selector(threadMain1:) toTarget:self withObject:str];
                    _isPlaySave = NO;
                }
                if ([_topBtn.titleLabel.text isEqualToString:@"接单"]) {
                    [self handlePan];
                    
                }else {
                    //开始显示乘客的信息/或者开始画线
                    NSLog(@"按钮文字1%@",_topBtn.titleLabel.text);
                    [_mapView initSearchAPI];
                    
                    //乘客是否全部上车
                    BOOL isOKOn = YES;
                    NSLog(@"isOnArr%@",_isOnArr);
                    for (NSString * s in _isOnArr) {
                        if ([s isEqualToString:@"0"] || [s isEqualToString:@"1"]) {
                            isOKOn = NO;
                            break;
                        }
                    }

                    if (isOKOn) {//如果乘客全部上车，开始画线
                        NSLog(@"如果乘客全部上车，开始画线");
                        if (_isHua == YES) {
                            [_mapView routeCal];
                            _isHua = NO;
                        }
                        
                        if (_isPlayOn == YES) {
                            NSLog(@"乘客已全部上车");
                            NSString * str = @"乘客已全部上车";
                            [NSThread detachNewThreadSelector:@selector(threadMain1:) toTarget:self withObject:str];
                            _isPlayOn = NO;
                        }
                    }
                    
                    //乘客是否全部付款
                    BOOL isOKPay = YES;
                    
                    for (NSString * s in _isPayArr) {
                        if ([s isEqualToString:@"0"]) {
                            isOKPay = NO;
                            break;
                        }
                    }
                    
                    if (isOKPay == YES) {//如果乘客全部付款，接下一单
                        NSLog(@"如果乘客全部付款，接下一单");
                        if (_isPlayPay == YES) {
                            NSString * str = @"订单已结束";
                            [NSThread detachNewThreadSelector:@selector(threadMain1:) toTarget:self withObject:str];
                            _isPlayPay = NO;
                            [self orderOverTo];
                            
                        }
                        
                    }
                }
                
                
            }
            
        }else{
            
            [MyToast showWithText:info.msg];
            NSLog(@"pppppppppp%@",info.respondDate);
            
        }
    }
    
    //发车成功
    if([info.action isEqualToString:@"startCar"]){
        if(info.isNormal){
            NSLog(@"ffffff%@",info.respondDate);
            if (_isPlayGo == YES) {
                NSString * str = @"开始发车";
                [NSThread detachNewThreadSelector:@selector(threadMain1:) toTarget:self withObject:str];
                _isPlayGo = NO;
            }
            [_bottomBtn setTitle:@"订单完成" forState:UIControlStateNormal];
            
        }else{
            [MyToast showWithText:info.msg];
            NSLog(@"pppppppppp%@",info.respondDate);
            
            
        }
    }
    //一个订单成功
    if([info.action isEqualToString:@"orderOver"]){
        NSLog(@"订单结束%@",info.respondDate);
        //       if([info.msg rangeOfString:@"成功"].location != NSNotFound){
        if(info.isNormal){
            NSLog(@"输出normal%@",info.respondDate);
            [_topBtn setTitle:@"接单" forState:UIControlStateNormal];
            _isFinish = NO;
            _messageView = nil;
            [self initDataS];
            [_mapView clearMapView];
            [self initMessageView];
            
        }else{
            [MyToast showWithText:info.msg];
            
        }
    }
    
    //设置出车状态
    if([info.action isEqualToString:@"setwork"]){
        NSLog(@"订单结束%@",info.respondDate);
        //       if([info.msg rangeOfString:@"成功"].location != NSNotFound){
        if(info.isNormal){
            NSLog(@"输出normal%@",info.respondDate);
            NSLog(@"设置出车状态");
            
        }else{
            [MyToast showWithText:info.msg];
             NSLog(@"设置出车");
        }
    }


    
    
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
//    TTTWeiFinshViewController *noView = [[TTTWeiFinshViewController alloc] init];
//    noView.getorder = getorder;
//    [self.navigationController pushViewController:noView animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark---司机----

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [_mapView reloadMap];
    //    [_mapView.locationManager startUpdatingLocation];//提前开始
}

-(void) sijiUI{
    //    _uidStr = @"13";
    
    //    NSString * idStr = [NSBundle mainBundle].bundleIdentifier;
    //    NSLog(@"[NSBundle mainBundle].bundleIdentifier = %@",idStr);
    _directionStr = @"0";
    [self initDataS];
    [self initMapView];
    [self CreateBottomBtn];
    [self createMyUI];
    [self initMessageView];
    self.ttsModel = [[TTSUIModel alloc] init];

    _isCircle = YES;
    _isEable = NO;
    _isBack = YES;
    _isFinish = YES;
    
    
}

-(void) initDataS{
    _model = [[TTPassengerModel alloc] init];
    _isPlayOn = YES;
    _isPlayPay = YES;
    _isPlaySave = YES;
    _isPlayGo = YES;
    _isHua = YES;
   
}

-(void) initMapView{
    
    _mapView = [[TTMapView alloc] initWithFrame:CGRectMake(0, 60, WITH, HIGHt-110)];
    [self.view addSubview:_mapView];
    
}
#pragma mark---创建发车按钮-----
-(void) CreateBottomBtn{
    
    //发车按钮
    _bottomBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _bottomBtn.frame = CGRectMake(0, HIGHt-50, WITH, 50);
    [_bottomBtn setTitle:@"发车" forState:UIControlStateNormal];
    [_bottomBtn addTarget:self action:@selector(CreateBottomClick:) forControlEvents:UIControlEventTouchUpInside];
    [_bottomBtn setBackgroundColor:[UIColor orangeColor]];
    [self.view addSubview:_bottomBtn];
    
}

-(void)CreateBottomClick:(UIButton *)btn{
    if ([btn.titleLabel.text isEqualToString:@"发车"]) {
        [_bottomBtn setTitle:@"订单完成" forState:UIControlStateNormal];
        
        NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Driver&_A=startCar"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_orderidStr,@"orderid",nil];
        [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"startCar" param:dic datatype:[NSDictionary class] notifName:self.notificationName];
        
    }else if (([btn.titleLabel.text isEqualToString:@"订单完成"]) && (_isFinish == NO)){
        [_bottomBtn setTitle:@"发车" forState:UIControlStateNormal];
        
        UILabel * lb1 = (UILabel *)[self.view viewWithTag:998];
        UILabel * lb2 = (UILabel *)[self.view viewWithTag:999];
        lb1.frame = CGRectMake(0, HIGHt-150, WITH, 50);
        lb2.frame = CGRectMake(0, HIGHt-100, WITH, 50);
        
        _bottomBtn.frame = CGRectMake(0, HIGHt, WITH, 50);
        UIButton * btn = [self.view viewWithTag:110];
        btn.frame = CGRectMake(0, HIGHt-50, WITH, 50);
        
        [btn setTitle:@"停止接单" forState:UIControlStateNormal];
        _isEable = YES;
        
        _messageView = nil;
        [self initDataS];
        [_mapView clearMapView];
        [self initMessageView];
        
        _isFinish = YES;
    }
    
}
-(void) createMyUI{
    
    UIView * topView  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, WITH, 60)];
    topView.tag = 120;//顶部view的tag值为120
    topView.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:topView];
    
    //侧滑按钮
    UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(5, 15, 45, 45)];
    [btn setBackgroundColor:[UIColor redColor]];
    [btn addTarget:self action:@selector(jumpS:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
    //导航button
    _topBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    _topBtn.frame = CGRectMake(WITH/2-100, 10, 200, 50);
    _topBtn.backgroundColor = [UIColor orangeColor];
    [_topBtn setTitle:@"接单" forState:UIControlStateNormal];
    [_topBtn addTarget:self action:@selector(changeBtn:) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:_topBtn];
    
    UILabel * label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, HIGHt-50, WITH, 50)];
    label1.tag = 998;
    label1.backgroundColor = [UIColor whiteColor];
    label1.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label1];
    
    UILabel * label2 = [[UILabel alloc] initWithFrame:CGRectMake(0, HIGHt-50, WITH, 50)];
    label2.tag = 999;
    label2.backgroundColor = [UIColor whiteColor];
    label2.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:label2];
    
    label1.text = @"在线0小时";
    label2.text = @"接单0单";
    
    UIButton * orderBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    orderBtn.frame = CGRectMake(0, HIGHt-50, WITH, 50);
    orderBtn.tag = 110;//按钮的tag值为110
    orderBtn.backgroundColor = [UIColor orangeColor];
    [orderBtn setTitle:@"开始接单" forState:UIControlStateNormal];
    [orderBtn addTarget:self action:@selector(hasOrder:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:orderBtn];
    
    //紧急收车按钮
    UIButton * urgentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    urgentBtn.frame = CGRectMake(WITH-60, 15, 40, 45 );
    [urgentBtn setTitle:@"紧急" forState:UIControlStateNormal];
    [topView addSubview:urgentBtn];
    [urgentBtn addTarget:self action:@selector(urgentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
}
-(void)jumpS:(UIButton *)btn
{
    NSLog(@"打印");
    [self.sideMenuViewController presentLeftViewController];
    
}

-(void) changeBtn:(UIButton *) btn{
    NSLog(@"导航按钮的标题:::%@",btn.titleLabel.text);
    if ([btn.titleLabel.text isEqualToString:@"接单"]) {
        NSLog(@"接单不让点");
    }else if ([btn.titleLabel.text isEqualToString:@"点击收起订单详情"]){
        [btn setTitle:@"点击查看订单详情" forState:UIControlStateNormal];
        _messageView.frame = CGRectMake(0, -HIGHt, WITH, HIGHt-100);
        [self hidenBottom];
        
        
        
    }else if ([btn.titleLabel.text isEqualToString:@"点击查看订单详情"]){
        [btn setTitle:@"点击收起订单详情" forState:UIControlStateNormal];
        _messageView.frame = CGRectMake(0, 50, WITH, HIGHt-100);
        [self hidenBottom];
    }
    
}
-(void) initMessageView{
    _messageView = [[TTMessageView alloc] initWithFrame:CGRectMake(0, -HIGHt, WITH, HIGHt-100)];
    _messageView.uidStr = self.uidStr;
    [self.view addSubview:_messageView];
}


-(void) refreshTo{
    
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Driver&_A=searchOrder"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_uidStr,@"uid",_directionStr,@"direction",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"refreshTo" param:dic datatype:[NSDictionary class] notifName:self.notificationName];
}


-(void) orderOverTo{
    [_topBtn setTitle:@"接单" forState:UIControlStateNormal];
    _messageView.frame = CGRectMake(0, -HIGHt, WITH, HIGHt-100);
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Driver&_A=completeOrder"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_orderidStr,@"orderid",_uidStr,@"uid",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"orderOver" param:dic datatype:[NSDictionary class] notifName:self.notificationName];
    
    
    
}


#pragma mark----数据获取------

-(void) threadMain1:(NSString *)str{
    NSLog(@"线程1完成");
    [_ttsModel player:str];
}
-(void) handlePan{
    
    NSLog(@"有订单接入，滑下一个界面");
    _messageView.frame = CGRectMake(0, 50, WITH, HIGHt-100);
    [self hidenBottom];
    [_topBtn setTitle:@"点击收起订单详情" forState:UIControlStateNormal];
    [_bottomBtn setTitle:@"发车" forState:UIControlStateNormal];
    _bottomBtn.frame =CGRectMake(0, HIGHt-50, WITH, 50);
    [self hidenBottom];
}
-(void) hidenBottom{
    NSLog(@"获取订单");
    UILabel * lb1 = (UILabel *)[self.view viewWithTag:998];
    UILabel * lb2 = (UILabel *)[self.view viewWithTag:999];
    UIButton * btn = (UIButton *)[self.view viewWithTag:110];
    
    lb1.frame = CGRectMake(0, HIGHt , WITH, 50);
    lb2.frame = CGRectMake(0, HIGHt , WITH, 50);
    btn.frame = CGRectMake(0, HIGHt , WITH, 50);
    
}
//判断字符串是否为空
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

//获取订单的点击事件
-(void) hasOrder:(UIButton *)btn{
    
    if([self isBlankString:_uidStr] == YES){
        
        TTLoginViewController * login = [[TTLoginViewController alloc] initWithNibName:@"TTLoginViewController" bundle:nil];
        login.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
        [self presentViewController:login animated:YES completion:nil];
        
    }else{
        NSLog(@"获取订单");
        [self setWork];
        
        UILabel * lb1 = (UILabel *)[self.view viewWithTag:998];
        UILabel * lb2 = (UILabel *)[self.view viewWithTag:999];
        
        if (_isEable == NO) {
            
            lb1.frame = CGRectMake(0, HIGHt-150, WITH, 50);
            lb2.frame = CGRectMake(0, HIGHt-100, WITH, 50);
            [btn setTitle:@"停止接单" forState:UIControlStateNormal];
            
            _timers = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(refreshTo) userInfo:nil repeats:YES];
            _isEable = YES;
            
        }else{
            
            lb1.frame = CGRectMake(0, HIGHt-50, WITH, 50);
            lb2.frame = CGRectMake(0, HIGHt-50, WITH, 50);
            [btn setTitle:@"开始接单" forState:UIControlStateNormal];
            
            //取消定时器
            [_timers invalidate];
            _timers = nil;
            _isEable = NO;
        }
    }
}


-(void) urgentClick:(UIButton *)btn{
    NSLog(@"紧急收车按钮点击了。。。。。");
    UIActionSheet *actionSheet = [[UIActionSheet alloc]
                                  initWithTitle:@"紧急收车"
                                  delegate:self
                                  cancelButtonTitle:@"取消"
                                  destructiveButtonTitle:@"发生意外交通事件"
                                  otherButtonTitles: @"发生意外的非人为事件",@"其他",nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [actionSheet showInView:self.view];
    //
    //    UIView * newView = [[UIView alloc] initWithFrame:self.view.bounds];
    //    newView.backgroundColor = [UIColor colorWithRed:125 green:125 blue:125 alpha:0.6];
    //    [self.view addSubview:newView];
    //    TTUrgentView * urgenView = [[TTUrgentView alloc] initWithFrame:CGRectMake(20, 150, self.view.frame.size.width-40, self.view.frame.size.height-300)];
    //    urgenView.backgroundColor = [UIColor whiteColor];
    //    [newView addSubview:urgenView];
    
}
-(void) setWork{
    NSLog(@"setWork");
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Driver&_A=setWork"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_uidStr,@"uid",@"1",@"status",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"setWork" param:dic datatype:[NSDictionary class] notifName:self.notificationName];
    
}

@end
