//
//  NSString+info.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-19.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (info)
+(NSNumber *) userID;
+(NSString *)userName;
+(NSString *)getNewsLabel:(NSString *)class1  class2:(NSString *)class2;
//解析html
+(NSAttributedString *)parseToHtml:html;
-(NSString *)annexName:anndexId;
-(BOOL)isNumber;

@end
