//
//  TTLabel.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/8/3.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import "TTLabel.h"

@implementation TTLabel

#define FRONTWITHSIZE(frontSize) [UIFont fontWithName:@"MicrosoftYaHei" size:frontSize]

#define RGB(__r, __g, __b)  [UIColor colorWithRed:(1.0*(__r)/255)\
green:(1.0*(__g)/255)\
blue:(1.0*(__b)/255)\
alpha:1.0]

+(float)getLabelHeight:(NSString *)text  fontsize:(CGFloat)size  labelwidth:(CGFloat)width  UILabel:(UILabel *)label{
    label.text = text;
    //使用自定义字体
    label.font = [UIFont systemFontOfSize:size];
    //设置字体颜色
    label.textColor = RGB(255, 255, 255);
    label.lineBreakMode = NSLineBreakByWordWrapping;
    label.numberOfLines = 0;
    //根据字符串长度和Label显示的宽度计算出customLab的高
    CGSize customLabSize = [text sizeWithFont:label.font constrainedToSize:CGSizeMake(width, MAXFLOAT)  lineBreakMode: label.lineBreakMode];
    float customLabHeight = customLabSize.height;
    return customLabHeight;

}

@end
