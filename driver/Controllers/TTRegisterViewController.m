//
//  TTRegisterViewController.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/17.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTRegisterViewController.h"

#import "TTHttpHanler+HttpHanlerResolver.h"
#import "TTUser.h"
#import "TTTestViewController.h"
@interface TTRegisterViewController ()

@end

@implementation TTRegisterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backClick:(id)sender {
    NSLog(@"返回");
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)testClick:(id)sender {
    NSLog(@"获取验证码");
}
- (IBAction)registerClick:(id)sender {
    NSString  *content2 = [ASIHTTPRequest base64forData:[_nameTextFiled.text dataUsingEncoding:NSUTF8StringEncoding]];
    NSString  *content3 = [ASIHTTPRequest base64forData:[_passwordTextFiled.text dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSLog(@"注册");
    NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Login&_A=register"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_teleTextFiled.text,@"phone",content2,@"nickname",content3,@"password",@"2",@"type",nil];
    [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"register" param:dic datatype:[NSDictionary class] notifName:self.notificationName];
}
//获取数据
-(void) receiveNotif:(NSNotification *)notif
{
    TTNetResondDate * info = [notif object];
    if([info.action isEqualToString:@"register"]){
        if(info.isNormal){
            NSLog(@"register%@",info.respondDate);
            
            NSString  *content3 = [ASIHTTPRequest base64forData:[_passwordTextFiled.text dataUsingEncoding:NSUTF8StringEncoding]];
            NSString *url = [prefix stringByAppendingFormat:@"_R=Modules&_M=JDI&_C=Login&_A=login"];
            NSDictionary *dic = [NSDictionary dictionaryWithObjectsAndKeys:_teleTextFiled.text,@"u",content3,@"p",@"0",@"deviceNum",nil];
            [[TTHttpHanler httpHandler] httpHanlerWithUrl:url action:@"login" param:dic datatype:[NSDictionary class] notifName:self.notificationName];
//            [TTUser setUserDefaultData:dic forKey:@"user_info"];
//            
//            [TTUser getUserUid];
        }else{
            [MyToast showWithText:info.msg];
            NSLog(@"pppppppppp%@",info.respondDate);
            
            
        }
    }
    if([info.action isEqualToString:@"login"]){
        if(info.isNormal){
            NSLog(@"ffffff%@",info.respondDate);

            NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
            [user setObject:info.respondDate[@"uid"] forKey:@"uid"];
            [user setObject:info.respondDate[@"type"] forKey:@"type"];
            [user setObject:info.respondDate[@"nickname"] forKey:@"nickname"];
            [user setObject:info.respondDate[@"username"] forKey:@"username"];
            [user synchronize];
            
            [self dismissViewControllerAnimated:YES completion:nil];

        }else{
            [MyToast showWithText:info.msg];
            NSLog(@"pppppppppp%@",info.respondDate);
            
            
        }
    }

}
//{
//    "status": 1,
//    "data": {
//        "sid": "MDAwMDAwMDAwMH62enM",
//        "nickname": "林婉玲",
//        "username": "13820301177",
//        "type": "2",
//        "uid": "12",
//        "head": "",
//        "deviceNum": "867068020018304"
//    }, 
//    "msg": "登陆成功!", 
//    "code": "0"
//}
- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_teleTextFiled isExclusiveTouch] ||![_testTextFiled isExclusiveTouch]||![_nameTextFiled isExclusiveTouch]||![_passwordTextFiled isExclusiveTouch]) {
        [_teleTextFiled resignFirstResponder];
        [_testTextFiled resignFirstResponder];
        [_nameTextFiled resignFirstResponder];
        [_passwordTextFiled resignFirstResponder];

        
    }
}

@end
