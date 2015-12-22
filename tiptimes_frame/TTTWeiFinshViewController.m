//
//  TTTWeiFinshViewController.m
//  tiptimes_frame
//
//  Created by ycf on 15/12/14.
//  Copyright © 2015年 ycf. All rights reserved.
//

#import "TTTWeiFinshViewController.h"
#import "TTTNoPayDetileViewController.h"
@interface TTTWeiFinshViewController ()

@end

@implementation TTTWeiFinshViewController

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
    label.text = @"我的订单";
    [Timage addSubview:label];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.frame = CGRectMake(0, 15, 60, 40);
    [button setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
    [button setTitle:@"返回" forState:UIControlStateNormal];
    [button addTarget:self action:@selector(goBackbut) forControlEvents:UIControlEventTouchUpInside];
    [Timage addSubview:button];
    
    UITableView *table = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height-64) style:UITableViewStylePlain];
    table.delegate = self;
    table.dataSource = self;
    table.rowHeight = 60;
    [self.view addSubview:table];

}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        UIImageView *LdwImage = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"icon_location"]];
        LdwImage.frame = CGRectMake(10, 5, 20, 20);
        [cell.contentView addSubview:LdwImage];
        UIImageView *dwImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon_location"]];
        dwImage.frame = CGRectMake(10, LdwImage.frame.origin.y+22, 20, 20);
        [cell.contentView addSubview:dwImage];
        UILabel *timeLab = [[UILabel alloc] initWithFrame:CGRectMake(10, dwImage.frame.origin.y+20, 200, 10)];
        
        timeLab.tag = 1;
        [cell.contentView addSubview:timeLab];
        UILabel *qidianLab = [[UILabel alloc] initWithFrame:CGRectMake(30, 5, 120, 10)];
        
        qidianLab.tag = 2;
        [cell.contentView addSubview:qidianLab];
        UILabel *zhongdianLab = [[UILabel alloc] initWithFrame:CGRectMake(qidianLab.frame.origin.x, dwImage.frame.origin.y, 100, 10)];
        
        zhongdianLab.tag = 3;
        [cell.contentView addSubview:zhongdianLab];
        
        UILabel *zhuantaiLab = [[UILabel alloc] initWithFrame:CGRectMake([[UIScreen mainScreen] bounds].size.width-90, 15, 80, 30)];
        zhuantaiLab.tag = 4;
        [cell.contentView addSubview:zhuantaiLab];
    }
    
    UILabel *Tlab = (UILabel *)[cell viewWithTag:1];
    Tlab.text = self.getorder.time;
    Tlab.textColor = [UIColor groupTableViewBackgroundColor];
    
    UILabel *Qlan =(UILabel *)[cell viewWithTag:2];
    Qlan.text = self.getorder.faddress;
    
    UILabel *Zlab = (UILabel *)[cell viewWithTag:3];
    Zlab.text = self.getorder.taddress;
    
    UILabel *nolab = (UILabel *)[cell viewWithTag:4];
    if ([self.getorder.ispay isEqualToString:@"1"]) {
        nolab.text = @"未完成";
    }
    else
    {
       nolab.text = @"完成";
    }
    
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TTTNoPayDetileViewController *nopay = [[TTTNoPayDetileViewController alloc] init];
    nopay.getor = self.getorder;
    [self.navigationController pushViewController:nopay animated:YES];
}
-(void)goBackbut
{
    [self.navigationController popViewControllerAnimated:YES ];
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
