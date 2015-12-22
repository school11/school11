//
//  TTTest3ViewController.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/12.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTTest3ViewController.h"
#import "flyTableViewCell.h"

#import "TTHttpHanler+HttpHanlerResolver.h"
#import "TTTjjs.h"
#import "PiPeiCz.h"
@interface TTTest3ViewController ()<UITextViewDelegate>
{
    NSInteger request_page;
    NSInteger current_page;
    NSMutableArray *peiArray;
    
    UITableView *_table;
    NSString *_price;
    
    UITextField *_textFiled;
    
    
}


@end

@implementation TTTest3ViewController
-(void)viewWillAppear:(BOOL)animated
{
    NSLog(@"--==-=-=-=-%@",self.fanchengStr);
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Position&_A=searchSpot"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:self.fanchengStr,@"coordinate",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"spot" param:dic datatype:[NSMutableArray class] notifName:self.notificationName];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //加载上拉／下拉刷新/缓存管理
  //  [self refreshAndCache];
    self.view.backgroundColor = [UIColor whiteColor];
    
    peiArray = [[NSMutableArray alloc] initWithCapacity:0];
    
    _textFiled = [[UITextField alloc] initWithFrame:CGRectMake(20, 20, [UIScreen mainScreen].bounds.size.width-80, 40)];
    _textFiled.layer.masksToBounds = YES;
    _textFiled.layer.borderColor = [[UIColor orangeColor] CGColor];
    _textFiled.layer.borderWidth = 1.0;
    _textFiled.placeholder = @"请输入。。。。。";
    [self.view addSubview:_textFiled];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-60, 20, 60, 40);
    [button setTitle:@"搜索" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [button addTarget:self action:@selector(sousuo) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
    _table = [[UITableView alloc] initWithFrame:CGRectMake(20, 60, [UIScreen mainScreen].bounds.size.width-20, [UIScreen mainScreen].bounds.size.height-60) style:UITableViewStylePlain];
    _table.delegate = self;
    _table.dataSource = self;
    _table.rowHeight = 60;
    [self.view addSubview:_table];

}
-(void)sousuo
{
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Position&_A=Route"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_textFiled.text,@"key",@"1",@"type",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"routKey" param:dic datatype:[NSMutableArray class] notifName:self.notificationName];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return peiArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    flyTableViewCell *cell =nil;
    cell= [tableView  dequeueReusableCellWithIdentifier:@"cel4"];
    NSArray *xibArray=[[NSBundle mainBundle]loadNibNamed:@"flyTableViewCell" owner:nil options:nil];
    if (!cell)
    {
        cell = xibArray[4];
    }
    PiPeiCz *pipe = peiArray[indexPath.row];
    cell.cell4lab.text  = [NSString stringWithFormat:@"%@-%@",pipe.Faddress,pipe.Taddress];
    cell.cell4lab2.text = [NSString stringWithFormat:@"%@/人",_price];
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    PiPeiCz *p = peiArray[indexPath.row];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"p" object:p userInfo:nil];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
//-(void)refreshAndCache{
//    NSLog(@"触发上下拉刷新事件。");
//    _data = [[NSMutableArray alloc] initWithCapacity:10];
//    request_page = 1 ;
//    current_page = 1;
//    [_myTableview addHeaderWithCallback:^{
//        request_page = 1;
//        current_page = 1;
//        [self loadNetData];
//    }];
//    NSLog(@"触发上拉加载事件。");
//    [_myTableview addFooterWithCallback:^{
//        request_page = current_page+1;
//        current_page = request_page;
//        [self loadNetData];
//    }];
//    [self loadNetData];
//    
//}
//
//加载数据
//-(void)loadNetData{
//    NSString *str = @"http://192.168.99.65/taxi/api.php?";
//    NSString *url = [str  stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Position&_A=searchSpot"];
//    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:[NSString stringWithFormat:@"%ld",(long)request_page],@"coordinate",nil];
//    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"get_xwzx_list" param:dic datatype:[TTTjjs class] notifName:self.notificationName];
//}
//获取数据
-(void) receiveNotif:(NSNotification *)notif
{
    _data = [[NSMutableArray alloc] initWithCapacity:0];
    TTNetResondDate * info = [notif object];
    if([info.action isEqualToString:@"spot"])
    {
        if(info.isNormal)
        {
            if(request_page == 1)
            {//刷新
                [_data removeAllObjects];
            }
            [_data addObjectsFromArray:info.respondObject];
            NSLog(@"111%@",_data);
            for (NSDictionary *dic in _data)
            {
                _price = [dic objectForKey:@"price"];
                NSDictionary *fromDic = [dic objectForKey:@"from"];
                NSDictionary *toDic = [dic objectForKey:@"to"];
                
                PiPeiCz *pipei = [[PiPeiCz alloc] initWithDictionry:fromDic Todic:toDic];
                
                [peiArray addObject:pipei];
            }
            [_table reloadData];
        }//        [_myTableview headerEndRefreshing];
//        [_myTableview footerEndRefreshing];
    }
    else
    {
        [peiArray removeAllObjects];
         [_data addObjectsFromArray:info.respondObject];
        for (NSDictionary *routDic in info.respondObject) {
           
            PiPeiCz *p2 = [[PiPeiCz alloc] init];
            p2.Faddress = [routDic objectForKey:@"fr_name"];
            p2.FLatitude = [routDic objectForKey:@"fr_lat"];
            p2.Flongitude = [routDic objectForKey:@"fr_lon"];
            p2.Taddress = [routDic objectForKey:@"to_name"];
            p2.Tlati = [routDic objectForKey:@"to_lat"];
            p2.Tlong = [routDic objectForKey:@"to_lon"];
            p2.fromId = [routDic objectForKey:@"fr"];
            p2.tId = [routDic objectForKey:@"t_o"];
            p2.Price = [routDic objectForKey:@"price"];
            [peiArray addObject:p2];
            [_table reloadData];
        }
 
    }
}
//- (void)didReceiveMemoryWarning {
//    [super didReceiveMemoryWarning];
//    // Dispose of any resources that can be recreated.
//}
//


-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
