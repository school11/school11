//
//  TTUrgentView.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/14.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTMessageView.h"
#import "TTOrderTableViewCell.h"
#import "TTHttpHanler+HttpHanlerResolver.h"
#import "TTPassengerModel.h"
#import "TTHttpHanler+HttpHanlerResolver.h"

#define WITH ([[UIScreen mainScreen]bounds].size.width)
#define HIGHt ([UIScreen mainScreen].bounds.size.height)

static NSString * cellInd = @"cellInd";
@interface TTMessageView ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView * _tableView;
    TTPassengerModel * _model;
    UILabel * timeLabel;
}

@end
@implementation TTMessageView

-(id) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if ( self ) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        [self initTableView];
        
        
        //获取通知中心单例对象
        NSNotificationCenter * center = [NSNotificationCenter defaultCenter];
        //添加当前类对象为一个观察者，name和object设置为nil，表示接收一切通知
        [center addObserver:self selector:@selector(initDateSource:) name:@"123" object:nil];
        
    }
    return self;
}

-(void) initDateSource:(NSNotification * )info{
    _dataSource= [[NSMutableArray alloc] init];
    _addressArr = [[NSMutableArray alloc] init];
    _peopleAddArr = [[NSMutableArray alloc] init];
    
    
    _model = [[TTPassengerModel alloc] init];
    
    NSDictionary * dic = info.object;
    
    NSDictionary * dict = dic[@"order"];
    NSDictionary * routeDic = dict[@"route"];
    NSDictionary * fromDic = routeDic[@"from"];
    NSDictionary * toDic = routeDic[@"to"];
    NSDate *confromTimesp = [NSDate dateWithTimeIntervalSince1970:[dict[@"time"] floatValue]];
    NSLog(@"1450259400  = %@",confromTimesp);
    _timeStr = [[NSString stringWithFormat:@"%@",confromTimesp] substringToIndex:19];
    
    _startAddStr = [NSString stringWithFormat:@"%@" ,fromDic[@"address"]];
    _endAddStr = [NSString stringWithFormat:@"%@" ,toDic[@"address"]];
    _destinationLb.text = [NSString stringWithFormat:@"%@ 到 %@",_startAddStr,_endAddStr];timeLabel.text = [NSString stringWithFormat:@"发车时间:%@",_timeStr];
    _addString = [NSString stringWithFormat:@"订单，%@到%@",_startAddStr,_endAddStr];
   
    NSArray * passengersArr = dict[@"passengers"];
    for (NSDictionary * dic in passengersArr) {
        [_peopleAddArr addObject:dic[@"coord"]];
        _model.nameStr = dic[@"nickname"];
        if ([self isBlankString:_model.nameStr] == YES) {
            _model.nameStr = @"未填写";//@"信文波";
        }
        _model.addressStr = dic[@"coord_name"];
        _model.teleStr = dic[@"phone"];
        if ([self isBlankString:_model.teleStr] == YES) {
            _model.nameStr = @"未填写";
        }
        _model.isPay = dic[@"isPay"];
        _model.uidStr = dic[@"uid"];
        _model.payTimeStr = dic[@"payTime"];
        _model.payMoney = dic[@"payMoney"];
        _model.isOn = (BOOL)dic[@"isOn"];
        
        [_dataSource addObject:_model];
    
    }
    [_tableView reloadData];
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


-(void) createUI{
    
    UILabel * newLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, WITH-20, 60)];
    newLabel.textColor = [UIColor orangeColor];
    newLabel.text = @"新的订单";
    newLabel.font = [UIFont systemFontOfSize:26];
    [self addSubview:newLabel];
    
    _destinationLb = [[UILabel alloc] initWithFrame:CGRectMake(20, 40, WITH-20, 50)];
    _destinationLb.text = @"";
    _destinationLb.font = [UIFont systemFontOfSize:17];
    [self addSubview:_destinationLb];
    
    
    
    timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 80, WITH-20, 40)];
    timeLabel.font = [UIFont systemFontOfSize:16];
    timeLabel.text = @"";
    [self addSubview:timeLabel];
    
    UIView * linView = [[UIView alloc] initWithFrame:CGRectMake(0, 130, WITH, 2)];
    linView.backgroundColor = [UIColor grayColor];
    [self addSubview:linView];
    
    UILabel * lb = [[UILabel alloc] initWithFrame:CGRectMake(WITH/2-20, 125, 40, 10)];
    lb.text = @"乘客";
    lb.font = [UIFont systemFontOfSize:15];
    lb.backgroundColor = [UIColor whiteColor];
    lb.textAlignment = NSTextAlignmentCenter;
    [self addSubview:lb];
    
}
-(void) initTableView{
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 150, WITH, HIGHt-170-50)];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.rowHeight = 140;
    [self addSubview:_tableView];
    
    [_tableView registerNib:[UINib nibWithNibName:@"TTOrderTableViewCell" bundle:nil] forCellReuseIdentifier:cellInd];
}

#pragma mark-----UITableViewDelegate
-(NSInteger) numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}

-(UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    TTOrderTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellInd];
    if ( cell == nil) {
        cell = [[TTOrderTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellInd];
    }
    _model =_dataSource[indexPath.row];
    cell.nameLabel.text = _model.nameStr;//@"信文波";
    cell.addressLabel.text = _model.addressStr;//@"天津市海岸带工程有限公司";
    if ([_model.isPay  isEqualToString:@"0"]) {
        
        cell.stateLabeel.text = @"未付款";
        
    }else{
        
        cell.stateLabeel.text = @"已付款";
        
    }
    
    return cell;
}

-(void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"点击进行拨打电话，不进行页面跳转");
    //NSString *number = @"";// 此处读入电话号码
    // NSString *num = [[NSString alloc]initWithFormat:@"tel://%@",number]; //number为号码字符串 如果使用这个方法结束电话之后会进入联系人列表
    
    _model = _dataSource[indexPath.row];
    NSString *num = [[NSString alloc]initWithFormat:@"telprompt://%@",_model.teleStr]; //而这个方法则打电话前先弹框 是否打电话 然后打完电话之后回到程序中 网上说这个方法可能不合法 无法通过审核
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:num]]; //拨号
    
    
}
@end
