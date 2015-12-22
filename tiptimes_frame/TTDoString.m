//
//  TTDoString.m
//  tiptimes_frame
//
//  Created by tiptimes on 15-5-11.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import "TTDoString.h"

static  int slide_num;
static  int ifcollect_num = 0;
static  int drop_num;
static  int hf_num;
static  int ts_num;
static  int id_num;
@implementation TTDoString

//过滤html标签并去除空白
+(NSString *)flattenHTML:(NSString *)html trimWhiteSpace:(BOOL)trim
{
    NSScanner *theScanner = [NSScanner scannerWithString:html];
    NSString *text = nil;
    
    while ([theScanner isAtEnd] == NO) {
        // find start of tag
        [theScanner scanUpToString:@"<" intoString:NULL] ;
        // find end of tag
        [theScanner scanUpToString:@">" intoString:&text] ;
        // replace the found tag with a space
        //(you can filter multi-spaces out later if you wish)
        html = [html stringByReplacingOccurrencesOfString:
                [ NSString stringWithFormat:@"%@>", text]
                                               withString:@""];
    }
    
    return trim ? [html stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]] : html;
}

+(void)setSlidenum:(int)num{
    slide_num = num ;
}
+(int)getSlidenum{
    return slide_num;
}

+(void)setIfCollectnum:(int)num{
    ifcollect_num = num ;
}

+(int)getIfCollectnum{
    return ifcollect_num;
}

+(void)setDropnum:(int)num{
    drop_num = num;
}
+(int)getDropnum{
    return drop_num;
}

+(void)setHfnum:(int)num{
    hf_num = num;
}
+(int)getHfnum{
    return hf_num;
}


+(void)setIfTs:(int)num{
    ts_num = num;
}
+(int)getIfTs{
    return ts_num;
}
+(void)setId:(int)num{
    id_num = num;
}
+(int)getId{
    return id_num;
}

@end
