//
//  XTHttpHanler+Personal.m
//  xiante
//
//  Created by tiptimes on 14-7-31.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTHttpHanler+Personal.h"
#import"TTHttpHanler.h"

#import "Constant_Url.h"
#import "TTEncrypt.h"
#import "TTUser.h"

@implementation TTHttpHanler (Personal)

-(void)personalWith:(NSDictionary*)param notifName :(NSString *) notif ;
{
//    @"http://211.68.112.117/nkgnapp/clientapi.php/account/ShowUserInfo"
    NSString * path = [NSString stringWithFormat:@"%@",img_prefix];
    path = [path stringByAppendingString:@"/clientapi.php/account/ShowUserInfo"];
    [self postWithParam:param action:nil  notifName:notif  url:path  dataHandler:
     ^(NSDictionary *json){
         sleep(1.5);
         NSNumber * myStatus = [json objectForKey:@"status"];
         if([myStatus intValue] == 1)
         {
             NSDictionary * data = [json objectForKey:@"data"];
             self.respondInfo.isNormal = YES;
            
         }
         else
         {
             self.respondInfo.isNormal = NO;
             NSString * getMessage = [json objectForKey:@"msg"];
             self.respondInfo.msg = getMessage;
             NSLog(@"error :%@",getMessage);
         }
         
         
     }];
}


-(void) personalNicknameWith:(NSDictionary *)param  notifName : (NSString *) notif
{
//    @"http://211.68.112.117/nkgnapp/clientapi.php/account/UpdateNickname"
    NSString * path = [NSString stringWithFormat:@"%@",img_prefix];
    path = [path stringByAppendingString:@"/clientapi.php/account/UpdateNickname"];
    [self postWithParam:param action:nil notifName:notif  url:path dataHandler:
     ^(NSDictionary *json){
         
         NSNumber * myStatus = [json objectForKey:@"status"];
         if([myStatus intValue] == 2)
         {
             self.respondInfo.isNormal = YES;
             NSString * getMessage = [json objectForKey:@"msg"];
             self.respondInfo.msg = getMessage;
         }
         else
         {
             self.respondInfo.isNormal = NO;
             NSString * getMessage = [json objectForKey:@"msg"];
             self.respondInfo.msg = getMessage;
             NSLog(@"error :%@",getMessage);
         }
         
         
         }];
}

-(void)personalHeadPictureWith:(NSDictionary*)param notifName :(NSString *) notif files:(NSDictionary *)file
{
//    @"http://192.168.1.10/nkgn/clientapi.php/account/UpdateUserPic"
    NSString * path = [NSString stringWithFormat:@"%@",prefix];
    path = [path stringByAppendingString:@"_R=Modules&_M=JDI&_C=Person&_A=headPic"];
//    NSString * path = [NSString stringWithFormat:@"http://192.168.1.10/nkgn/clientapi.php/account/UpdateUserPic"];
    //加密
    path = [TTEncrypt parse:path parameterMap:param];
    [self postWithParam:param action:nil  files:file  notifName:notif  url:path dataHandler:
     ^(NSDictionary *json){
         NSNumber * myStatus = [json objectForKey:@"status"];
         if([myStatus intValue] == 1)
         {
             self.respondInfo.isNormal = YES;
             NSString * getMessage = [json objectForKey:@"msg"];
             NSDictionary *userinfo1 = [TTUser getUserInfo];
             NSMutableDictionary *userinfo = [NSMutableDictionary dictionaryWithDictionary:userinfo1];
             [userinfo setValue:[json objectForKey:@"data"] forKey:@"head"];
             //记录用户数据
             NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
             [userDefaults setObject:userinfo forKey:@"user_info"];
             self.respondInfo.msg = getMessage;
             [MyToast showWithText:@"头像上传成功"];
         }
         else
         {
             self.respondInfo.isNormal = NO;
             NSString * getMessage = [json objectForKey:@"msg"];
             self.respondInfo.msg = getMessage;
             NSLog(@"error :%@",getMessage);
             [MyToast showWithText:[json objectForKey:@"msg"]];
         }
         
         
     }];
}


@end
