//
//  TTTest6ViewController.m
//  tiptimes_frame
//
//  Created by ycf on 15/12/12.
//  Copyright © 2015年 ycf. All rights reserved.
//

#import "TTTest6ViewController.h"
#import "TTTest7ViewController.h"
#define WITH ([[UIScreen mainScreen]bounds].size.width)
#define HIGHt ([UIScreen mainScreen].bounds.size.height)

@interface TTTest6ViewController ()

@end

@implementation TTTest6ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"-=-=-=-=-=%@",self.od.dname);
    self.topimgview.hidden = YES;
    self.view1.hidden = YES;
    self.button.hidden = YES;
    self.title = @"未接单";
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self creatTopView];
    
    UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(10, 70, WITH-20, 100)];
    image.image = [UIImage imageNamed:@"写下评论输入框"];
    [self.view addSubview:image];
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(image.center.x-40, 0, 80, 30)];
    lab1.text = @"下单成功";
    [image addSubview:lab1];
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(0, lab1.frame.origin.y+30+10, WITH-20, 30)];
    lab2.text = @"我们正在飞快的为您联系司机师傅，请稍后";
    [image addSubview:lab2];
    
    [self performSelector:@selector(text7) withObject:nil afterDelay:2];
    
    
}
-(void)text7
{
    TTTest7ViewController *text7 = [[TTTest7ViewController alloc] init];
    text7.order = self.od;
    [self.navigationController pushViewController:text7 animated:YES];
}
-(void)creatTopView
{
    UIImageView *topimgview1 =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WITH, 64)];
    topimgview1.userInteractionEnabled = YES;
    topimgview1.image = [UIImage imageNamed:@"状态栏白色"];

    UILabel *lable =[[UILabel alloc]initWithFrame:CGRectMake(WITH*0.4,20, 100, 30)];
    lable.textColor =[UIColor blackColor];
    lable.text =@"飞到地铁站";
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
    [self.navigationController popViewControllerAnimated:YES];
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
