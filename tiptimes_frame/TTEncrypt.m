//
//  TTEncrypt.m
//  tiptimes_frame
//
//  Created by tiptimes on 15-4-13.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import "TTEncrypt.h"
#import "Constant.h"
#import<CommonCrypto/CommonDigest.h>
#import "TTUser.h"

static NSString * app_key = APPKEY;
static NSMutableDictionary *dic ;
static NSString *sid ;

@interface TTEncrypt ()

@end
@implementation TTEncrypt
//数组转成字典
+(NSMutableDictionary *)parseToNSDictionary:(NSMutableArray *)arr{
    dic = [[NSMutableDictionary alloc] init];
    for(NSUInteger i=0;i<[arr count];i+=2){
        [dic setValue:[arr objectAtIndex:i+1] forKey:[arr objectAtIndex:i]];
        NSLog(@"%@",dic);
    }
    return dic;
}

+(NSString *) parse:(NSString *)url parameterMap:(NSDictionary *)dic{
    NSArray *strArray;
    NSString * getParams;
    NSString * otherParams=[NSString stringWithFormat:@""];
    NSArray *arr;
    long int  realServerTime= 50000;
    url = [url stringByAppendingFormat:@"&_time=%ld",realServerTime];
    if([TTUser getUserSid]!=nil){//用户的sid
        url = [url stringByAppendingFormat:@"&_sid=%@",[TTUser getUserSid]];
    }
    if([TTUser getUserUid]!=nil){//用户的uid
        url = [url stringByAppendingFormat:@"&_uid=%@",[TTUser getUserUid]];
    }
    
    strArray = [url componentsSeparatedByString:@"?"];
    getParams = strArray[1];
    if(dic != nil){
        arr = [dic allKeys];
        for(NSString *key in arr){
            NSString *value = [dic objectForKey:key];
            otherParams = [otherParams stringByAppendingFormat:@"%@=%@&",key,value];
            
        }
        
        if(getParams==nil){
            otherParams = [otherParams substringToIndex:([otherParams length]-1)];
        }
        
    }
    NSString *params = [otherParams stringByAppendingFormat:@"%@%@",getParams,app_key];
    NSLog(@"test%@",params);
    NSString *sign = [TTEncrypt  sign:params];
    url = [url stringByAppendingFormat:@"&_hash=%@",sign];
    
    return url;
}

//sha1加密方式
+(NSString *)sign:(NSString *)srcString{
     const char *cstr = [srcString cStringUsingEncoding:NSUTF8StringEncoding];
     NSData *data = [NSData dataWithBytes:cstr length:srcString.length];
     uint8_t digest[CC_SHA1_DIGEST_LENGTH];
     CC_SHA1(data.bytes, data.length, digest);
     NSMutableString* output = [NSMutableString stringWithCapacity:CC_SHA1_DIGEST_LENGTH * 2];
     for(int i = 0; i < CC_SHA1_DIGEST_LENGTH; i++)
         [output appendFormat:@"%02x", digest[i]];
     return output;
}

@end
