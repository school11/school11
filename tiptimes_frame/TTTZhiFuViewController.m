//
//  TTTZhiFuViewController.m
//  tiptimes_frame
//
//  Created by ycf on 15/12/14.
//  Copyright © 2015年 ycf. All rights reserved.
//

#import "TTTZhiFuViewController.h"

@interface TTTZhiFuViewController ()

@end

@implementation TTTZhiFuViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
   self.view.backgroundColor = [UIColor whiteColor];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"支付方式底框"]];
    image.frame = CGRectMake(0, [[UIScreen mainScreen] bounds].size.height-[[UIScreen mainScreen] bounds].size.height/3, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height/3);
    image.userInteractionEnabled = YES;
    [self.view addSubview:image];
    
    for (int i=0; i<3; i++)
    {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(image.center.x-image.frame.size.width/6*2, 10+((image.frame.size.height-30-40)/3+10)*i, image.frame.size.width/3*2, (image.frame.size.height-30-40)/3);
        button.tag = i+1;
       button.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
        if (i == 0)
        {
            [button setBackgroundImage:[UIImage imageNamed:@"余额支付"] forState:UIControlStateNormal];
            [button setTitle:@"用余额支付" forState:UIControlStateNormal];
        }
        else if (i == 1)
        {
            [button setBackgroundImage:[UIImage imageNamed:@"支付宝支付"] forState:UIControlStateNormal];
            [button setTitle:@"用支付宝支付" forState:UIControlStateNormal];
        }
        else
        {
            [button setBackgroundImage:[UIImage imageNamed:@"微信支付"] forState:UIControlStateNormal];
            [button setTitle:@"用微信支付" forState:UIControlStateNormal];
        }
        
        [image addSubview:button];
        
    }
    
    
    UIButton *But1 = [UIButton buttonWithType:UIButtonTypeSystem];
    But1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    But1.frame = CGRectMake(0, image.frame.size.height-30, image.frame.size.width, 30);
    [But1 setTitle:@"取消" forState:UIControlStateNormal];
    [But1 setTitleColor:[UIColor orangeColor] forState:UIControlStateNormal];
    [But1 addTarget:self action:@selector(cancle) forControlEvents:UIControlEventTouchUpInside];
    [image addSubview:But1];
}
-(void)cancle
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
