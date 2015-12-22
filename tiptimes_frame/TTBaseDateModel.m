//
//  XTBaseDateModel.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-16.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTBaseDateModel.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@implementation TTBaseDateModel
/**
 通过json实例化对象
 **/
-(id)initWhitJson:(NSDictionary *)json {
        NSArray *keys =  [json allKeys];
        for (NSString *key in  keys) {
            id  value = [json objectForKey:key];
            NSString *method =[[NSString alloc] initWithFormat:@"set%@", [self setMethodStr:key]];
            SEL setmethod = NSSelectorFromString(method);
            if ([self respondsToSelector:setmethod]){
                [self performSelector:setmethod withObject:value];
            }

        }
    return self;
}
-(NSString *)setMethodStr:(NSString *)str{
    NSString *first = [str substringToIndex:1];
    NSString *after = [str substringFromIndex:1];
    return [[NSString alloc] initWithFormat:@"%@%@:",[first uppercaseString], after];
}
@end
