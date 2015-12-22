//
//  TTDoString.h
//  tiptimes_frame
//
//  Created by tiptimes on 15-5-11.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface TTDoString : NSObject


+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim;
+(void)setSlidenum:(int)num;
+(int)getSlidenum;

+(void)setIfCollectnum:(int)num;
+(int)getIfCollectnum;

//判断下拉框
+(void)setDropnum:(int)num;
+(int)getDropnum;

//判断回复入口
+(void)setHfnum:(int)num;
+(int)getHfnum;



//判断是否推送以及id
+(void)setIfTs:(int)num;
+(int)getIfTs;
+(void)setId:(int)num;
+(int)getId;

@end
