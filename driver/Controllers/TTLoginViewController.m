//
//  TTLoginViewController.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/17.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTLoginViewController.h"
#import "TTRegisterViewController.h"
#import "TTLeftViewController.h"
#import "TTHttpHanler+HttpHanlerResolver.h"
#import "TTTestViewController.h"
@interface TTLoginViewController ()

@end

@implementation TTLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logInClick:(id)sender {
    NSLog(@"登录");
    
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Login&_A=login"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_teletextfiled.text,@"u",_passwordTextFiled.text,@"p",@"2",@"deviceNum",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"login" param:dic datatype:[NSData class] notifName:self.notificationName];
    
}

//"nickname": "林婉玲",
//        "username": "13820301177",
//获取数据
-(void) receiveNotif:(NSNotification *)notif
{
    TTNetResondDate * info = [notif object];
    if([info.action isEqualToString:@"login"]){
        if(info.isNormal){
            NSLog(@"登陆成功下载数据%@",info.respondDate);
            [self dismissViewControllerAnimated:YES completion:nil];
            
            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:info.respondDate[@"uid"] forKey:@"uid"];
            [user setObject:info.respondDate[@"type"] forKey:@"type"];
            [user setObject:info.respondDate[@"nickname"] forKey:@"nickname"];
            [user setObject:info.respondDate[@"username"] forKey:@"username"];
            [user synchronize];
            
        }else{
            [MyToast showWithText:info.msg];
            NSLog(@"pppppppppp%@",info.respondDate);
            
            
        }
    }
    
}

- (IBAction)registerClick:(id)sender {
    NSLog(@"注册");
    TTRegisterViewController * loginVC=[[TTRegisterViewController alloc] initWithNibName:@"TTRegisterViewController" bundle:nil];
    loginVC.modalTransitionStyle = UIModalTransitionStyleCrossDissolve;
    [self presentViewController:loginVC animated:YES completion:nil];
}

- (IBAction)missPasswordClick:(id)sender {
    NSLog(@"咋还忘记密码了!!!!!");
}
- (IBAction)backClick:(id)sender {
    NSLog(@"返回");
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_teletextfiled isExclusiveTouch] ||![_passwordTextFiled isExclusiveTouch]) {
        [_teletextfiled resignFirstResponder];
        [_passwordTextFiled resignFirstResponder];
    }
}
@end
