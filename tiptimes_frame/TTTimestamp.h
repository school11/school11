//
//  TTTimestamp.h
//  tiptimes_frame
//
//  Created by tiptimes on 15-4-28.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTimestamp : NSObject
//timestamp 时间戳    format : yy-mm-dd
+(NSString *) parse:(NSString *)timestamp format:(NSString *)format ;
//时间转时间戳
+(NSString *) parseTimeToTimestamp:(NSString *)time format:(NSString *)format;
//获取当前时间戳
+(NSString *)getNowTimestamp;
@end
