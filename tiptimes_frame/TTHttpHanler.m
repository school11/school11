//
//  XTHttpHanler.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-14.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTHttpHanler.h"


@implementation TTHttpHanler

-(id)init{
    self = [super init];
    
    if(self){
        self.respondInfo = [[TTNetResondDate alloc] init];
    }
    return self;
}

#pragma mark dealloc
//////////////////////////////////////////////////////////////////

- (void)dealloc
{
    [self.request cancel];
    self.request = nil;
    //self.nc = nil;
}

/**
 *当前网络连接状况
 */
-(NetworkStatus)netWorkConnectionType
{
    Reachability* reach = [Reachability reachabilityWithHostName:@"www.baidu.com"];
    NetworkStatus status = [reach currentReachabilityStatus];
    NSLog(@"connectionType==%i",status);
    return status;
}

+(TTHttpHanler *)httpHandler
{
    TTHttpHanler * handler=[[TTHttpHanler alloc]init];
    return handler;
}
-(void)postWithParam:(NSDictionary *)param action:(NSString *)action files:(NSDictionary *)files notifName:(NSString *)nf url:(NSString*)url  dataHandler:
(void(^)(NSDictionary *json)) BackProcess{
    NSLog(@"url:%@", url);
    NSLog(@"param:%@", param);
    NSLog(@"files:%@", files);
    if(param != nil){
        NSArray *keys =  [param allKeys];
        for (NSString *key in keys){
            id value = [param valueForKey:key];
            [self.postRequest setPostValue:value forKey:key];
        }
    }
    if (![self isConnection]) {
        self.respondInfo.isNormal = false;
        self.respondInfo.msg = @"网络连接出问题了";
        [[NSNotificationCenter defaultCenter] postNotificationName:nf object:self.respondInfo userInfo:nil];
        return;
    }
    
    self.postRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]] ;
    [self.postRequest setRequestMethod:@"POST"];
    if(files != nil){
        NSArray *keys =  [files allKeys];
        NSFileManager *fm = [NSFileManager defaultManager];
        for (NSString *key in keys){
            id value = [files valueForKey:key];
            
            if([value isKindOfClass:[NSArray class]]){
                for(id mvalue in  value){
                    NSString *path = [TTFileUntil defaultFilePathWithName:mvalue];
                    NSData *data = [fm contentsAtPath:path];
                    NSLog(@"%@",[TTFileUntil fileType:path] );
                    [self.postRequest addData:data withFileName:[TTFileUntil lastFileName:path] andContentType:[TTFileUntil fileType:path]  forKey:key];
                }
            }else{
                NSString *path = [TTFileUntil defaultFilePathWithName:value];
                NSLog(@"图片路径2:%@",path);
                NSData *data = [fm contentsAtPath:path];
//                NSLog(@"图片路径3:%@",[TTFileUntil lastFileName:path]);
//                CGFloat dataLen = (CGFloat)([data length]);
//                CGFloat len = (CGFloat)((200.0*1024.0)/dataLen);
//                NSLog(@"缩放比例是: %.2lf, 数据流长度为：%lf",len,dataLen);
                [self.postRequest addData:data withFileName:[TTFileUntil lastFileName:path] andContentType:[TTFileUntil fileType:path]  forKey:key];
            }
        }
    }
    
    
    __weak ASIFormDataRequest* weakRequest = self.postRequest;
    __block TTHttpHanler* weakSelf = self;
    [self.postRequest setCompletionBlock:^
     {
         NSLog(@"请求完成");
         NSData* data = [weakRequest responseData];
         id dataDic = [weakSelf nsjsonParser:data];
         NSDictionary *dic = nil;
         //返回json数组
         if ([dataDic isKindOfClass:[NSArray class]]){
             dic = [[NSDictionary alloc ]initWithObjectsAndKeys:dataDic,@"array", nil];
             
         }else{
             dic = dataDic;
         }
         if (dic == nil ){
             weakSelf.respondInfo.isNormal = NO;
             weakSelf.respondInfo.msg = @"数据解析错误!";
         }else{
             if ([dic isKindOfClass:[NSDictionary class]] && [dic valueForKey:@"errormsg"] != nil){
                 weakSelf.respondInfo.isNormal = NO;
                 weakSelf.respondInfo.msg = [dataDic valueForKey:@"errormsg"];
             }else{
                 weakSelf.respondInfo.isNormal = YES;
                 BackProcess(dic);
             }
         }
         if(action !=nil){
             weakSelf.respondInfo.action = action;
         }
         [[NSNotificationCenter defaultCenter] postNotificationName:nf object:weakSelf.respondInfo userInfo:nil];
         weakSelf = nil;
     }];
    [self.postRequest setFailedBlock:^
     {
         NSError* error = [weakRequest error];
         NSLog(@"ASIHttpRequest请求失败:%@",[error description]);
         weakSelf.respondInfo.isNormal = NO;
         weakSelf.respondInfo.msg = @"服务器连接超时!";
         if(action !=nil){
             weakSelf.respondInfo.action = action;
         }
         [[NSNotificationCenter defaultCenter] postNotificationName:nf object:weakSelf.respondInfo userInfo:nil];
         weakSelf = nil;
     }];
    [self.postRequest startAsynchronous];

}


-(void)postWithParam:(NSDictionary *)param action:(NSString *)action notifName:(NSString *)nf url:(NSString*)url  dataHandler:
        (void(^)(NSDictionary *json)) BackProcess{
    
    NSLog(@"%@",url);
    NSLog(@"%@",param);
    if (![self isConnection]) {
        self.respondInfo.isNormal = false;
        self.respondInfo.msg = @"网络连接出问题了";
        [[NSNotificationCenter defaultCenter] postNotificationName:nf object:self.respondInfo userInfo:nil];
        return;
    }
    
    self.postRequest = [[ASIFormDataRequest alloc] initWithURL:[NSURL URLWithString:url]];
    [self.postRequest setRequestMethod:@"POST"];
 
    if(param != nil){
        NSArray *keys =  [param allKeys];
        for (NSString *key in keys){
            id value = [param valueForKey:key];
            [self.postRequest setPostValue:value forKey:key];
            NSLog(@"post,key:%@,value:%@", key, value);
        }
    }
    __weak ASIFormDataRequest* weakRequest = self.postRequest;
    __block TTHttpHanler* weakSelf = self;
    [self.postRequest setCompletionBlock:^
     {
         NSLog(@"请求完成");
         NSData* data = [weakRequest responseData];
         id dataDic = [weakSelf nsjsonParser:data];
         NSDictionary *dic = nil;
         
//         NSArray * array = [weakRequest responseCookies] ;
//         if(array !=nil && array.count>0)
//         {
//             XTAppDelegate *myDelegate = [[UIApplication sharedApplication] delegate];
//             myDelegate.cookies = [weakRequest responseCookies];
//         }
         
         //返回json数组
         if ([dataDic isKindOfClass:[NSArray class]]){
           dic = [[NSDictionary alloc ]initWithObjectsAndKeys:dataDic,@"array", nil];
             
         }else{
             dic = dataDic;
         }
         if (dic == nil ){
             weakSelf.respondInfo.isNormal = NO;
             weakSelf.respondInfo.msg = @"数据解析错误!";
         }else{
             if ([dic isKindOfClass:[NSDictionary class]] && [dic valueForKey:@"errormsg"] != nil){
                 weakSelf.respondInfo.isNormal = NO;
                 weakSelf.respondInfo.msg = [dataDic valueForKey:@"errormsg"];
             }else{
                 weakSelf.respondInfo.isNormal = YES;
                 BackProcess(dic);
             }
         }
     
         
         if(action !=nil){
             weakSelf.respondInfo.action = action;
         }
  
        [[NSNotificationCenter defaultCenter] postNotificationName:nf object:weakSelf.respondInfo userInfo:nil];
         weakSelf = nil;
     }];
    [self.postRequest setFailedBlock:^
     {
         NSError* error = [weakRequest error];
         NSLog(@"ASIHttpRequest请求失败:%@",[error description]);
         weakSelf.respondInfo.isNormal = NO;
         weakSelf.respondInfo.msg = @"服务器连接超时!";
         if(action !=nil){
            weakSelf.respondInfo.action = action;
         }
      
         [[NSNotificationCenter defaultCenter] postNotificationName:nf object:weakSelf.respondInfo userInfo:nil];
         weakSelf = nil;
     }];
    [self.postRequest startAsynchronous];

    
}
-(void)getWithParam:(NSDictionary *)param notifName:(NSString *)nf dataHandler:
(void(^)(NSDictionary *json)) BackProcess{
    
}



-(NSDictionary*)nsjsonParser:(NSData*)datas
{
    //gbk 转码
//    NSStringEncoding gbkEncoding =
//    CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
//    
//    NSString *respondStr = [[NSString alloc] initWithData:datas encoding:gbkEncoding] ;
//    
//    NSData *data  = [respondStr dataUsingEncoding:NSUTF8StringEncoding];
    
    NSString *string = [[NSString alloc] initWithData:datas encoding:NSUTF8StringEncoding];
    NSLog(@"需要解析的数据========%@",string);
    
    NSError *error;
    NSDictionary *json = [NSJSONSerialization JSONObjectWithData:datas options:kNilOptions error:&error];
    
    if (error) {
        NSLog(@"解析错误！！error ==== %@",error);
        return nil;
    }
    
    NSLog(@"解析后的数据 ===== %@",json);
    return json;
}

-(BOOL) isConnection{
    if ([self netWorkConnectionType] == NotReachable)
    {
        //网络连接失败
        self.respondInfo.isNormal = NO;
        self.respondInfo.msg = NET_ERROR_NONET;
        return NO;
    }else{
        return  YES;
    }
}




@end
