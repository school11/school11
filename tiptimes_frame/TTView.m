//
//  TTView.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/10/22.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTView.h"

@implementation TTView

+(void)initView:(UIView *)view cornerRadius:(float)radius borderWidth:(float)width{
    view.layer.cornerRadius = radius;
    view.layer.masksToBounds = YES;
    view.layer.borderWidth = width;
    view.layer.borderColor = [[UIColor lightGrayColor] CGColor];
}
@end
