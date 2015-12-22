//
//  TTView.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/10/22.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTView : NSObject
//给view加边框和弧角
+(void)initView:(UIView *)view cornerRadius:(float)radius borderWidth:(float)width;


@end
