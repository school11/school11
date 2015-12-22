//
//  TTLeftViewController.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/17.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTLeftViewController.h"
#import "TTLoginViewController.h"
#import "TTHttpHanler+HttpHanlerResolver.h"

@interface TTLeftViewController ()

@end

@implementation TTLeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.view.backgroundColor = [UIColor whiteColor];

    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    _uidStr = [userDefaults objectForKey:@"uid"];
    _typeStr = [userDefaults objectForKey:@"type"];
    _nameLabel.text = [userDefaults objectForKey:@"nickname"];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)settingClick:(id)sender {
    NSLog(@"设置");
}

- (IBAction)cencelClick:(id)sender {
    NSLog(@"注销");
    //设置出车状态
    [UIView commitAnimations];
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Driver&_A=setWork"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_uidStr,@"uid",@"0",@"status",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"setNotWork" param:dic datatype:[NSData class] notifName:self.notificationName];
    //-------------------------------- 退出程序 -----------------------------------------//
    
    
    [UIView beginAnimations:@"exitApplication" context:nil];
    
    [UIView setAnimationDuration:0.5];
    
    [UIView setAnimationDelegate:self];
    
    // [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:self.view.window cache:NO];
    
    TTAppDelegate * appDele = (TTAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [UIView setAnimationTransition:UIViewAnimationCurveEaseOut forView:appDele.window cache:NO];
    
    [UIView setAnimationDidStopSelector:@selector(animationFinished:finished:context:)];
    
    //self.view.window.bounds = CGRectMake(0, 0, 0, 0);
    
    appDele.window.bounds = CGRectMake(0, 0, 0, 0);
    
    
    
}

- (IBAction)loginClick:(id)sender {
    NSLog(@"登录");
    TTLoginViewController * loginVC=[[TTLoginViewController alloc] initWithNibName:@"TTLoginViewController" bundle:nil];
    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:loginVC animated:YES completion:nil];
    

}
//获取数据
-(void) receiveNotif:(NSNotification *)notif
{
    TTNetResondDate * info = [notif object];
    if([info.action isEqualToString:@"setNotWork"]){
        if(info.isNormal){
            NSLog(@"出车状态为0---不出车");
            
        }else{
            [MyToast showWithText:info.msg];
            NSLog(@"pppppppppp%@",info.respondDate);
        }
    }
}


- (void)animationFinished:(NSString *)animationID finished:(NSNumber *)finished context:(void *)context {
    
    if ([animationID compare:@"exitApplication"] == 0) {
        
        exit(0);
        
    }
    
}


@end
