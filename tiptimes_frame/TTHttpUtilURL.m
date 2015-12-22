//
//  XTHttpUtil.m
//  xiante
//
//  Created by tiptimes on 14-7-5.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTHttpUtilURL.h"

@implementation TTHttpUtilURL

+(void)setURLprefix:(NSString *)pre{
    prefix = pre;
}
+(NSString *)compeletUrl:(NSString *)part{
   return [[NSString alloc] initWithFormat:@"%@%@", prefix, part];
}
@end
