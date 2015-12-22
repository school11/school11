//
//  TTUser.m
//  tiptimes_frame
//
//  Created by tiptimes on 15-5-8.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import "TTUser.h"

@implementation TTUser

+(void)setUserSid:(NSString *)user_sid{
    sid = user_sid ;
}
+(NSString *)getUserSid{
    //记录用户数据
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    sid = [[userDefaults objectForKey:@"user_info"] objectForKey:@"sid"];
    return sid;
}

+(void)setUserUid:(NSString *)user_sid{
    uid = user_sid ;
}
+(NSString *)getUserUid{
    //记录用户数据
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    uid = [[userDefaults objectForKey:@"user_info"] objectForKey:@"uid"];
    return uid;
}

+(NSDictionary *)getUserInfo{
    //记录用户数据
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    userInfo = [userDefaults objectForKey:@"user_info"];
    return userInfo;
}

+(NSDictionary *)getCategory{
    //记录用户数据
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *  category = [userDefaults objectForKey:@"category"];
    return category;
}

+(NSMutableArray *)getArrayContent:(NSString *)str{
    //记录用户数据
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSMutableArray *  arrayContent = [userDefaults objectForKey:str];
    return arrayContent;
}


//持久化存储数据
+(void)setUserDefaultData:(id)object forKey:(NSString *)key{
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    [user setObject:object forKey:key];
}

//获取某个key值下字典中的某个key值
+(NSString *)getUserDefaultString:(NSString *)key key:(NSString *)name{
    return [self getUserDefaultString:key key:name datatype:nil];
}

//type是存储的数据类型
+(NSString *)getUserDefaultString:(NSString *)key key:(NSString *)name datatype:(id) type{
    NSString *str;
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    if([type isEqual:[NSDictionary class]]){
        NSDictionary *dic = [userDefaults objectForKey:key];
        str = [dic objectForKey:name];
    }else if ([type isEqual:[NSString class]]){
        str = [userDefaults objectForKey:key];
    }else{
        NSDictionary *dic = [userDefaults objectForKey:key];
        str = [dic objectForKey:name];
    }
    return str;
}


@end
