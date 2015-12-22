//
//  TTUser.h
//  tiptimes_frame
//
//  Created by tiptimes on 15-5-8.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>
//保存用户sid
static NSString *sid = nil;
static NSString *uid = nil;
static NSDictionary *userInfo = nil;

@interface TTUser : NSObject
+(void)setUserSid:(NSString *)sid;
+(NSString *)getUserSid;

+(void)setUserUid:(NSString *)uid;
+(NSString *)getUserUid;
+(NSDictionary *)getUserInfo;
+(NSDictionary *)getCategory;
+(NSMutableArray *)getArrayContent:(NSString *)str;

+(NSString *)getUserDefaultString:(NSString *)key key:(NSString *)name;
+(NSString *)getUserDefaultString:(NSString *)key key:(NSString *)name datatype:(id) type;

+(void)setUserDefaultData:(id)object forKey:(NSString *)key;

@end
