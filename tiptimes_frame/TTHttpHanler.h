//
//  XTHttpHanler.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-14.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "Reachability.h"


@interface TTHttpHanler : NSObject
@property(strong, nonatomic) TTNetResondDate *respondInfo;
@property (nonatomic,strong) ASIHTTPRequest* request;
@property (nonatomic,strong) ASIFormDataRequest* postRequest;

+(TTHttpHanler *)httpHandler;


//网络连接状态
-(NetworkStatus)netWorkConnectionType;
-(NSDictionary*)nsjsonParser:(NSData*)data;
-(BOOL) isConnection;

-(void)postWithParam:(NSDictionary *)param action:(NSString *)action files:(NSDictionary *)files notifName:(NSString *)nf url:(NSString*)url  dataHandler:
(void(^)(NSDictionary *json)) BackProcess;

-(void)postWithParam:(NSDictionary *)param action:(NSString *)action notifName:(NSString *)nf url:(NSString*)url  dataHandler:
(void(^)(NSDictionary *json)) BackProcess;
//-(void)getWithParam:(NSDictionary *)param notifName:(NSString *)nf url:(NSString*)url  dataHandler:
//(void(^)(NSDictionary *json)) BackProcess;

@end
