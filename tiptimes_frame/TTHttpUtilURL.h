//
//  XTHttpUtil.h
//  xiante
//
//  Created by tiptimes on 14-7-5.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>
//static NSString * prefix = @"http://953445224lihao.xicp.net:81/zmjh/api.php?";
//static NSString * img_prefix = @"http://953445224lihao.xicp.net:81";


//static NSString * prefix = @"http://192.168.99.48/yqxxb/api.php?";
//static NSString * img_prefix = @"http://192.168.99.48";


//本地路径
//static NSString * prefix = @"http://192.168.99.53/tyj_oa/index.php/";
//static NSString * img_prefix = @"http://192.168.99.53/tyj_oa";
////图片前缀
//static NSString * img_prefix1 = @"http://192.168.99.53/tyj_oa/Data/Files/";

//http://192.168.99.65/taxi/api.php?_R=Modules&_M=JDI&_C=Position&_A=searchSpot

//主服务器地址
static NSString * prefix = @"http://211.68.113.122/taxi/api.php?";
static NSString * img_prefix = @"http://192.168.99.65";
static NSString * img_prefix1 = @"http://192.168.99.65/taxi";

//获取创新创业大赛接口
//static NSString * re_prefix = @"http://www.tjqncxcyds.com/api.php?";
//static NSString * re_img_prefix = @"http://www.tjqncxcyds.com";



//static NSString * prefix = @"http://www.tjzmjh.com/api.php?";
//static NSString * img_prefix = @"http://www.tjzmjh.com";


//static NSString * prefix = @"http://172.29.78.3/qnxxb/api.php?";
//static NSString * img_prefix = @"http://172.29.78.3";

//保存用户sid
static NSString *sid;

@interface TTHttpUtilURL : NSObject
+(void)setURLprefix:(NSString *)prefix;
+(NSString *) compeletUrl:(NSString *)part;
@end
