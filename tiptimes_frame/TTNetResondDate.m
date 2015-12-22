//
//  XTNetResondDate.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-15.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTNetResondDate.h"

@implementation TTNetResondDate

-(id)init{
    self = [super init];
    
    if(self){
        self.isNormal = NO;
        self.msg = @"未知错误！";
    }
    return self;
}
@end
