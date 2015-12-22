//
//  XTText5ViewController.m
//  tiptimes_frame
//
//  Created by ycf on 15/12/12.
//  Copyright © 2015年 ycf. All rights reserved.
//


#import "TTText5ViewController.h"
#import "TTTest6ViewController.h"
#import "TTTest7ViewController.h"
#import "TTTWeiFinshViewController.h"
#import "TTHttpHanler+HttpHanlerResolver.h"

#import "TTgetOrder.h"
@interface TTText5ViewController ()<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic,strong)NSArray *array;
@end

@implementation TTText5ViewController
-(void)viewWillAppear:(BOOL)animated
{
    [self.navigationController setNavigationBarHidden:NO animated:NO];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self creatTopView];
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-144) style:UITableViewStyleGrouped];
    table.scrollEnabled = NO;
    table.delegate =self;
    table.dataSource = self;
    [self.view addSubview:table];
    
    self.array = @[@"选择校区",@"选择上车点",@"时间",@"同乘人数",@"留言"];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    [button setTitle:@"提交" forState:UIControlStateNormal];
    button.frame = CGRectMake(10, [[UIScreen mainScreen] bounds].size.height-70, [[UIScreen mainScreen] bounds].size.width-20, 60);
    [button addTarget:self action:@selector(xiaDan) forControlEvents:UIControlEventTouchUpInside];
    button.backgroundColor = [UIColor orangeColor];
    [self.view addSubview:button];
    
}
-(void)xiaDan
{
    NSLog(@"-------------------%@",self.xtd.toId);
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Passenger&_A=addOrder"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"17",@"uid",self.xtd.number,@"people",self.xtd.toId,@"dest",self.xtd.fromId,@"departure",self.xtd.locaStr,@"coord",self.xtd.getcaradress ,@"coord_name",self.xtd.time,@"setOut",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"addOrder" param:dic datatype:[NSDictionary class] notifName:self.notificationName];

}
-(void)creatTopView
{
    UIImageView *topimgview1 =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 64)];
    topimgview1.userInteractionEnabled = YES;
    topimgview1.image = [UIImage imageNamed:@"状态栏白色"];
    
    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width*0.4,20, 100, 30)];
    lable.textColor =[UIColor blackColor];
    lable.text =@"订单";
    [topimgview1 addSubview:lable];
    [self.view addSubview:topimgview1];
    
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeSystem];
    [btn setTitle:@"返回" forState:UIControlStateNormal];
    [btn setTintColor:[UIColor blueColor]];
    btn.frame = CGRectMake(10,20, 60, 40);
    btn.titleLabel.font = [UIFont systemFontOfSize:17];
    [btn addTarget:self action:@selector(backMain) forControlEvents:UIControlEventTouchUpInside];
    [topimgview1 addSubview:btn];
    
}

-(void)backMain
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 5;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 4) {
        
        return 60;
    }
    return  44;
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
   
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, [[UIScreen mainScreen] bounds].size.width, ([[UIScreen mainScreen] bounds].size.height-160)/9)];
    lable.text = [NSString stringWithFormat:@"   %@",self.array[section]];
    return lable;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        
    }
    if (indexPath.section ==0) {
        
        cell.textLabel.text = self.xtd.luxian;
        
    }
   else if (indexPath.section == 1)
   {
      cell.textLabel.text = self.xtd.getcaradress;
   }
    else if (indexPath.section == 2)
    {
       cell.textLabel.text = self.xtd.dateString;
    }
    else if (indexPath.section == 3)
    {
       cell.textLabel.text = self.xtd.number;
    }
    else
    {
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width, 60)];
        lable.text = @"   留言";
        lable.numberOfLines = 0;
        [cell.contentView addSubview:lable];
      
    }
    
    return cell;
}
-(void) receiveNotif:(NSNotification *)notif
{
//    _data = [[NSMutableArray alloc] initWithCapacity:0];
    TTNetResondDate * info = [notif object];
    if([info.action isEqualToString:@"addOrder"]){
        if(info.isNormal){
            self.order = [[TTaddOrder alloc] init];
            NSDictionary *driveDic = [info.respondDate  objectForKey:@"driver"];
            self.order.dname = [driveDic objectForKey:@"nickname"];
            self.order.dphone = [driveDic objectForKey:@"phone"];
            self.order.duid = [driveDic objectForKey:@"uid"];
            self.order.orderid = [info.respondDate  objectForKey:@"orderid"];
            for (NSDictionary *passDic in [info.respondDate  objectForKey:@" passengers"])
            {
                self.order.passIson = [passDic objectForKey:@"isOn"];
                self.order.passIspay = [passDic objectForKey:@"isPay"];
                self.order.passName = [passDic objectForKey:@"nickname"];
                self.order.passuid = [passDic objectForKey:@"uid"];
            }
            NSDictionary *routeDic = [info.respondDate  objectForKey:@"route"];
            self.order.faddress = [[routeDic objectForKey:@"from"] objectForKey:@"address"];
            self.order.flatitude = [[routeDic objectForKey:@"from"] objectForKey:@"latitude"];
            self.order.flongitude = [[routeDic objectForKey:@"from"] objectForKey:@"longitude"];
            self.order.price = [routeDic objectForKey:@"price"];
            self.order.taddress = [[routeDic objectForKey:@"to"] objectForKey:@"adress"];
            self.order.tlati = [[routeDic objectForKey:@"to"] objectForKey:@"latitude"];
            self.order.tlogi = [[routeDic objectForKey:@"to"] objectForKey:@"longitude"];
            self.order.time = [info.respondDate objectForKey:@"time"];
            
            NSLog(@"%@---%@---%@",self.order.dname,self.order.dphone,self.order.duid);
            
            if(info.isNormal == 1)
            {
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"订单完成" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
                [alert show];
            }
            

        }else
        {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:info.msg delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];

        }
        
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 1)
    {
        TTTest7ViewController *text7 = [[TTTest7ViewController alloc] init];
        text7.order = self.order;
        [self presentViewController:text7 animated:YES completion:nil];

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
