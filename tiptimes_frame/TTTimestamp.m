//
//  TTTimestamp.m
//  tiptimes_frame
//
//  Created by tiptimes on 15-4-28.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import "TTTimestamp.h"

@implementation TTTimestamp
/**
 *  时间戳转化成时间
 *
*/
+(NSString *) parse:(NSString *)timestamp format:(NSString *)format{
    
    NSTimeInterval time=[timestamp doubleValue];//因为时差问题要加8小时 == 28800 sec
    NSDate *detaildate=[NSDate dateWithTimeIntervalSince1970:time];
    //实例化一个NSDateFormatter对象
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    //设定时间格式,这里可以设置成自己需要的格式
    [dateFormatter setDateFormat:format];
    NSString *currentDateStr = [dateFormatter stringFromDate: detaildate];
    return currentDateStr ;
}

/**
 *  时间转时间戳
 */
+(NSString *) parseTimeToTimestamp:(NSString *)time format:(NSString *)format{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init] ;
    [formatter setDateFormat:format];
    NSDate *date = [[NSDate alloc] init];
    date = [formatter dateFromString:time];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[date timeIntervalSince1970]];
    return timeSp;
}

/**
 *  获取当前时间戳
 */
+(NSString *)getNowTimestamp{
    NSDate* dat = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a=[dat timeIntervalSince1970];
    NSString *timeString = [NSString stringWithFormat:@"%ld", (long)a];
    return timeString;
}


@end
