//
//  TTTGerCarViewController.m
//  tiptimes_frame
//
//  Created by ycf on 15/12/14.
//  Copyright © 2015年 ycf. All rights reserved.
//

#import "TTTGerCarViewController.h"
#import "TTTZhiFuViewController.h"
#import "TTHttpHanler+HttpHanlerResolver.h"
#import "TTTestViewController.h"
@interface TTTGerCarViewController ()<UIActionSheetDelegate,UIAlertViewDelegate>

@end

@implementation TTTGerCarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.locationManager stopUpdatingLocation];
    self.topimgview.hidden = YES;
    self.backBut.hidden = YES;
    self.tableView1.hidden = YES;
    self.button.hidden = YES;
    
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
    [button addTarget:self action:@selector(backgetorder) forControlEvents:UIControlEventTouchUpInside];
    [Timage addSubview:button];
    UIButton *clickBut = [UIButton buttonWithType:UIButtonTypeSystem];
    clickBut.frame = CGRectMake([UIScreen mainScreen].bounds.size.width-100, 15, 100, 40);
    [clickBut setTitle:@"取消订单" forState:UIControlStateNormal];
    [clickBut addTarget:self action:@selector(cancleBut) forControlEvents:UIControlEventTouchUpInside];
    [Timage addSubview:clickBut];
    
    [self getCar];

}
-(void)cancleBut
{
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Passenger&_A=revokeOrder"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"17",@"uid",self.payOrder.orderid,@"orderid",self.payOrder.price,@"money",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"cancel" param:dic datatype:[NSDictionary class] notifName:self.notificationName];

   
}
-(void)getCar
{
    UIImageView *jdImaeg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"写下评论输入框"]];
    jdImaeg.frame = CGRectMake(10, 70, [[UIScreen mainScreen] bounds].size.width-20, [[UIScreen mainScreen] bounds].size.height/3+80);
    jdImaeg.userInteractionEnabled = YES;
    [self.view addSubview:jdImaeg];
    
    UIImageView *touXImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
    touXImage.backgroundColor = [UIColor brownColor];
    [jdImaeg addSubview:touXImage];
    UILabel *namelable = [[UILabel alloc] initWithFrame:CGRectMake(68, 10, 180, 30)];
    namelable.text = [NSString stringWithFormat:@"%@-%@",self.payOrder.dname,self.payOrder.dphone];
    [jdImaeg addSubview:namelable];
    for (int i = 0; i<6; i++)
    {
        UIImageView *XXimage = [[UIImageView alloc] initWithFrame:CGRectMake(68+18*i, namelable.frame.origin.y+33, 15, 15)];
        XXimage.image = [UIImage imageNamed:@"ic_star_empty"];
        [jdImaeg addSubview:XXimage];
    }
    
    UILabel *carLab = [[UILabel alloc] initWithFrame:CGRectMake(68, namelable.frame.origin.y+45, 180, 20)];
    carLab.text = @"银色 七座商务车";
    carLab.textColor = [UIColor grayColor];
    [jdImaeg addSubview:carLab];
    
    UILabel *juliLab = [[UILabel alloc] initWithFrame:CGRectMake(jdImaeg.center.x-40, carLab.frame.origin.y+25, 80, 30)];
    juliLab.text = @"上车成功";
    [jdImaeg addSubview:juliLab];
    
    UILabel *xianLab = [[UILabel alloc] initWithFrame:CGRectMake(0, juliLab.frame.origin.y+35, jdImaeg.frame.size.width/2-40, 1)];
    xianLab.backgroundColor = [UIColor grayColor];
    [jdImaeg addSubview:xianLab];
    UILabel *TongCLab = [[UILabel alloc] initWithFrame:CGRectMake(xianLab.frame.size.width, juliLab.frame.origin.y+20, 80, 30)];
    TongCLab.text = @"支付车费";
    TongCLab.textAlignment = NSTextAlignmentCenter;
    TongCLab.textColor = [UIColor grayColor];
    [jdImaeg addSubview:TongCLab];
    UILabel *xianLab1 = [[UILabel alloc] initWithFrame:CGRectMake(TongCLab.frame.origin.x+80, xianLab.frame.origin.y, xianLab.frame.size.width, 1)];
    
    xianLab1.backgroundColor = [UIColor grayColor];
    [jdImaeg addSubview:xianLab1];
    juliLab.text = @"上车成功";
    [jdImaeg addSubview:juliLab];
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(jdImaeg.center.x-30, TongCLab.frame.origin.y+33, 60, 30)];
    numLab.text = self.payOrder.price;
    [jdImaeg addSubview:numLab];
    
    UIImageView *phionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_call"]];
    phionImage.frame = CGRectMake(jdImaeg.frame.size.width-60, touXImage.frame.origin.y, 60, 60);
    [jdImaeg addSubview:phionImage];
    
    UIButton *getCarBut = [UIButton buttonWithType:UIButtonTypeSystem];
    getCarBut.frame = CGRectMake(0, jdImaeg.frame.size.height-70, jdImaeg.frame.size.width, 50);
    [getCarBut setBackgroundImage:[UIImage imageNamed:@"已上车按钮"] forState:UIControlStateNormal];
    [getCarBut setTitle:@"立即支付" forState:UIControlStateNormal];
    [getCarBut addTarget:self action:@selector(zhifu) forControlEvents:UIControlEventTouchUpInside];
    [jdImaeg addSubview:getCarBut];
}
-(void)zhifu
{
    UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"用余额宝支付" otherButtonTitles:@"用支付宝支付",@"用微信支付", nil];
    [sheet showInView:self.view];

}
-(void) receiveNotif:(NSNotification *)notif
{
    //    _data = [[NSMutableArray alloc] initWithCapacity:0];
    TTNetResondDate * info = [notif object];
    if([info.action isEqualToString:@"pay"]){
        if(info.isNormal){
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"支付成功" delegate:self cancelButtonTitle:nil otherButtonTitles:@"确定", nil];
            [alert show];
            
            
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
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Passenger&_A=Pay"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:@"17",@"uid",self.payOrder.orderid,@"orderid",self.payOrder.price,@"money",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"pay" param:dic datatype:[NSDictionary class] notifName:self.notificationName];

}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    TTTestViewController *text = [[TTTestViewController alloc] init];
    [self presentViewController:text animated:YES completion:nil];
}
-(void)backgetorder
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
