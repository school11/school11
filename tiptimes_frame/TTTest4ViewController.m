//
//  TTTest4ViewController.m
//  tiptimes_frame
//
//  Created by ycf on 15/12/12.
//  Copyright © 2015年 ycf. All rights reserved.
//

#import "TTTest4ViewController.h"
#import "MyCell.h"
#import <AMapNaviKit/AMapNaviKit.h>
#define WITH [[UIScreen mainScreen]bounds].size.width
#define HIGHt [UIScreen mainScreen].bounds.size.height


@interface TTTest4ViewController ()<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *_table;
    UIView *_view2;
    UIImageView *_jgk;

}
@end

@implementation TTTest4ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.tableView1.hidden = YES;
    self.topview =[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, WITH, 64)];
    self.topview.backgroundColor =[UIColor colorWithRed:253/255.0 green:172/255.0 blue:20/255.0 alpha:1];
    self.topview.userInteractionEnabled = YES;
    [self.view addSubview:self.topview];

    
    [self creatTopView];
    
    _view1 = [[UIView alloc] init];
    _view1.center = self.view.center;
    _view1.bounds = CGRectMake(0, 0, [[UIScreen mainScreen] bounds].size.width-20, [UIScreen mainScreen].bounds.size.height/2);
    [self.view addSubview:_view1];
    _table = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    _table.frame = CGRectMake(0, 0, _view1.frame.size.width, _view1.frame.size.height);
    
    UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, WITH-20, 30)];
    lable.text =@"已为你匹配到以下订单";
    lable.textAlignment = NSTextAlignmentCenter;
    _table.delegate = self;
    _table.dataSource = self;
    _table.tableHeaderView = lable;
    [_view1 addSubview:_table];

}
-(void)creatTopView
{
    UIButton *backBut = [UIButton buttonWithType:UIButtonTypeSystem];
    backBut.frame = CGRectMake(20, 20, 30, 30);
    [backBut setTitle:@"" forState:UIControlStateNormal];
    [backBut setBackgroundImage:[UIImage imageNamed:@"w"] forState:UIControlStateNormal];
    [backBut addTarget:self action:@selector(backButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [self.topview addSubview:backBut];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(WITH-50, 20, 30, 30);
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goMainVc) forControlEvents:UIControlEventTouchUpInside];
    [self.topview addSubview:button];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return (HIGHt/2-30)/3;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MyCell *cell = (MyCell *)[tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
    }
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _view1.hidden = YES;
    if (!_view2) {
        
        _view2 = [[UIView alloc] init];
        _view2.frame = _view1.frame;
        _view2.backgroundColor = [UIColor whiteColor];
        [self.view addSubview:_view2];
    }
    self.touXImage = [[UIImageView alloc] initWithFrame:CGRectMake(5, 10, 60, 60)];
    self.touXImage.backgroundColor = [UIColor brownColor];
    [_view2 addSubview:self.touXImage];
    self.namelable = [[UILabel alloc] initWithFrame:CGRectMake(68, 10, 180, 30)];
    self.namelable.text = @"李师傅－津12355";
    [_view2 addSubview:self.namelable];
    for (int i = 0; i<6; i++)
    {
        self.XXimage = [[UIImageView alloc] initWithFrame:CGRectMake(68+18*i, self.namelable.frame.origin.y+33, 15, 15)];
        self.XXimage.image = [UIImage imageNamed:@"ic_star_empty"];
        [_view2 addSubview:self.XXimage];
    }
    self.carLab = [[UILabel alloc] initWithFrame:CGRectMake(68, self.XXimage.frame.origin.y+17, 180, 20)];
    self.carLab.text = @"银色 七座商务车";
    self.carLab.textColor = [UIColor grayColor];
    [_view2 addSubview:self.carLab];
    
    UIImageView *phionImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"ic_call"]];
    phionImage.frame = CGRectMake(_view2.frame.size.width-60, self.touXImage.frame.origin.y, 60, 60);
    [_view2 addSubview:phionImage];
    
    UILabel *xianLab = [[UILabel alloc] initWithFrame:CGRectMake(0, self.carLab.frame.origin.y+35, _view2.frame.size.width/2-40, 1)];
    xianLab.backgroundColor = [UIColor grayColor];
    [_view2 addSubview:xianLab];
    UILabel *TongCLab = [[UILabel alloc] initWithFrame:CGRectMake(xianLab.frame.size.width, self.carLab.frame.origin.y+20, 80, 30)];
    TongCLab.text = @"同乘拼友";
    TongCLab.textColor = [UIColor grayColor];
    [_view2 addSubview:TongCLab];
    UILabel *xianLab1 = [[UILabel alloc] initWithFrame:CGRectMake(TongCLab.frame.origin.x+80, xianLab.frame.origin.y, xianLab.frame.size.width, 1)];
   
    xianLab1.backgroundColor = [UIColor grayColor];
    [_view2 addSubview:xianLab1];
    
    UILabel *viewLab2 = [[UILabel alloc] initWithFrame:CGRectMake(WITH-20-80, xianLab1.frame.origin.y+20, 80, 30)];
    viewLab2.text = @"2元／人";
    viewLab2.textAlignment = NSTextAlignmentLeft;
    [_view2 addSubview:viewLab2];
    UILabel *getLab = [[UILabel alloc] initWithFrame:CGRectMake(WITH-20-150, viewLab2.frame.origin.y+32, 150, 30)];
    getLab.text = @"预计五分钟到达";
    getLab.textAlignment = NSTextAlignmentLeft;
    [_view2 addSubview:getLab];
    
    for (int i=0; i<2; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake((WITH-20-80*2)/3+(80+(WITH-20-80*2)/3)*i, _view2.frame.size.height-50, 80, 30);
        if (i == 0)
        {
            [button setTitle:@"取消" forState:UIControlStateNormal];
        }
        else
        {
            [button setTitle:@"加入" forState:UIControlStateNormal];
        }
        [button setBackgroundColor:[UIColor orangeColor]];
        button.tag = i+1;
        [button addTarget:self action:@selector(getAdd:) forControlEvents:UIControlEventTouchUpInside];
        [_view2 addSubview:button];
    }

}
-(void)getAdd:(UIButton *)but
{
    if (but.tag == 1)
    {
        NSLog(@"取消");
    }
    else
    {
        if (but.tag == 3)
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"您有未完成订单，请完成订单" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
            [alert show];
            
        }
        _jgk = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"提交成功底框"]];
        _jgk.center = CGPointMake(_view2.center.x, _view2.center.y);
        _jgk.bounds = CGRectMake(0, 0, WITH/3, WITH/3-20);
        UILabel *lable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _jgk.frame.size.width, _jgk.frame.size.height)];
        lable.text = @"已加入该订单";
        lable.textColor = [UIColor whiteColor];
        [_jgk addSubview:lable];
        [_view2 addSubview:_jgk];
        
        [self performSelector:@selector(disAppear) withObject:_jgk afterDelay:2];
    }
}
-(void)disAppear
{
    _jgk.hidden = YES;
}
-(void)goMainVc
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)backButtonClick
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
