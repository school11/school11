//
//  TTHttpHanler+UpLoadFile.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/11/18.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTHttpHanler+UpLoadFile.h"
#import"TTHttpHanler.h"
#import "TTEncrypt.h"
#import "Constant_Url.h"
#import "TTNoData.h"
@implementation TTHttpHanler (UpLoadFile)

//上传多张图片无action
-(void)httpHanlerWithUrl:(NSString *) url param:(NSDictionary*)param datatype:(id) type notifName :(NSString *) notif files:(NSDictionary *)file{
    [self httpHanlerWithUrl:(NSString *) url param:param action:nil datatype:type notifName:notif files:file];
}
//有action
-(void)httpHanlerWithUrl:(NSString *) url param:(NSDictionary*)param action:(NSString *)ac datatype:(id) type  notifName :(NSString *) notif files:(NSDictionary *)file
{
    //加密
    url = [TTEncrypt parse:url parameterMap:param];
    [self postWithParam:param action:ac  files:file  notifName:notif  url:url dataHandler:
     ^(NSDictionary *json){
         NSLog(@"567%@",json);
         NSNumber * myStatus = [json objectForKey:@"status"];
         if([myStatus intValue] != 0)
         {
             self.respondInfo.isNormal = YES;
             if([type isEqual:[TTNoData class]]){
                 // self.respondInfo.isNormal = YES;
                 //操作类型请求，无返回值
             }else if([type isEqual:[NSString class]]){
                 self.respondInfo.respondDate = json;
             }else if ([type isEqual:[NSMutableArray class]]){
                 //获取无key数组
                 id jsonData = [json objectForKey:@"data"];
                 if([jsonData isKindOfClass:[NSArray class]])
                 {
                     NSLog(@"无key数组");
                     self.respondInfo.respondObject = jsonData;
                 }
                 
             }else{
                 id jsonData = [json objectForKey:@"data"];
                 
                 if ([jsonData isKindOfClass:[NSDictionary class]]) {
                     NSLog(@"字典");
                     
                     self.respondInfo.respondDate = [json valueForKey:@"data"];
                 }
                 else if([jsonData isKindOfClass:[NSArray class]])
                 {
                     NSLog(@"数组");
                     
                     NSArray * dataDict = [[type class] objectArrayWithKeyValuesArray:jsonData];
                     self.respondInfo.respondObject = dataDict;
                 }
                 else
                 {
                     self.respondInfo.respondObject = jsonData;
                 }
             }
         }
         else
         {
             self.respondInfo.isNormal = NO;
             self.respondInfo.msg = [json objectForKey:@"msg"];
         }
     }];
}

@end
