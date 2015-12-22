//
//  TTTNoPayDetileViewController.m
//  tiptimes_frame
//
//  Created by ycf on 15/12/16.
//  Copyright © 2015年 ycf. All rights reserved.
//

#import "TTTNoPayDetileViewController.h"
#import "TTTZhiFuViewController.h"
#import "TTHttpHanler+HttpHanlerResolver.h"
@interface TTTNoPayDetileViewController ()

@end

@implementation TTTNoPayDetileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.navigationController setNavigationBarHidden:YES animated:NO];
    UIImageView *Timage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"状态栏白色"]];
    Timage.frame = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64);
    Timage.userInteractionEnabled = YES;
    [self.view addSubview:Timage];
    UILabel *label = [[UILabel alloc] init];
    label.center = Timage.center;
    label.bounds = CGRectMake(0, 0, 100, 40);
    label.text = @"未完成订单";
    [Timage addSubview:label];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 15, 60, 40);
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBackorder) forControlEvents:UIControlEventTouchUpInside];
    [Timage addSubview:button];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.view addSubview:table];

}
-(void)goBackorder
{
    [self.navigationController popViewControllerAnimated:YES];
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    
    if (!cell) {
        
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    if (indexPath.row == 0)
    {
        cell.textLabel.text = @"订单详情";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    else if (indexPath.row == 1)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"出发地:%@",self.getor.faddress];
    }
    else if (indexPath.row == 2)
    {
        cell.textLabel.text = [NSString stringWithFormat:@"目的地:%@",self.getor.taddress];
    }
    else if (indexPath.row ==3 )
    {
        cell.textLabel.text = [NSString stringWithFormat:@"出发时间:%@",self.getor.time];
    }
    else if (indexPath.row == 4)
    {
       cell.textLabel.text = @"备注:";
    }
    else if (indexPath.row == 5)
    {
       cell.textLabel.text = @"状态:未付款";
    }
    else if (indexPath.row == 6)
    {
       cell.textLabel.text = @"实付:";
    }
    else if (indexPath.row == 7)
    {
       cell.textLabel.text = self.getor.price;
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    else
    {
       cell.textLabel.text = @"付款";
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.backgroundColor = [UIColor orangeColor];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 8) {
        NSLog(@"--------> %@",self.getor.uid);
        NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Passenger&_A=Pay"];
        NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"17",@"uid",self.getor.orderId,@"orderid",self.getor.price,@"money",nil];
        [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"pay" param:dic datatype:[NSDictionary class] notifName:self.notificationName];
        
        TTTZhiFuViewController *zhifu = [[TTTZhiFuViewController alloc] init];
        //    [self.view addSubview:zhifu.view];
        [self presentViewController:zhifu animated:YES completion:nil];

    }
}
-(void) receiveNotif:(NSNotification *)notif
{
    //    _data = [[NSMutableArray alloc] initWithCapacity:0];
    TTNetResondDate * info = [notif object];
    if([info.action isEqualToString:@"pay"]){
        if(info.isNormal){
            
            NSLog(@"-----%@",info.respondDate);
            
            TTTZhiFuViewController *zhifu = [[TTTZhiFuViewController alloc] init];
            [self presentViewController:zhifu animated:YES completion:nil];
            
        }else{
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:info.msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
        
    }
    else
    {
        NSLog(@"----%@",info.respondDate);
    }
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
