//
//  TTHttpHanler+HttpHanlerResolver.m
//  tiptimes_frame
//
//  Created by tiptimes on 14-11-19.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTHttpHanler+HttpHanlerResolver.h"
#import "TTNoData.h"
#import "TTEncrypt.h"


@implementation TTHttpHanler (HttpHanlerResolver)

-(void) httpHanlerWithUrl:(NSString *) url  param:(NSDictionary *)param datatype:(id) type notifName:(NSString *)notif{
    [self httpHanlerWithUrl:url action:nil param:param datatype:type notifName:notif];
}

-(void) httpHanlerWithUrl:(NSString *) url action:(NSString *)ac param:(NSDictionary *)param datatype:(id) type notifName:(NSString *)notif
{
    //加密
    url = [TTEncrypt parse:url parameterMap:param];
    [self postWithParam:param action:ac notifName:notif url:url dataHandler:^(NSDictionary *json) {
        NSNumber * myStatus = [json objectForKey:@"status"];
        if ([myStatus intValue] != 0) {
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
        }else{
            self.respondInfo.isNormal = NO;
            self.respondInfo.msg = [json objectForKey:@"msg"];
        }
    }];
}


@end
