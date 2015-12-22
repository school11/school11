//
//  TTSignal.m
//  tiptimes_frame
//
//  Created by tiptimes on 14-9-4.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTSignal.h"

@implementation TTSignal
-(NSString *)filterStr{
    if(_filterStr == nil){
        return @"";
    }
    return _filterStr;
}
@end
