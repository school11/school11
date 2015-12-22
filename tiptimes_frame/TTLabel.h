//
//  TTLabel.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/8/3.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTLabel : NSObject
//计算label高度
+(float)getLabelHeight:(NSString *)text  fontsize:(CGFloat)size  labelwidth:(CGFloat)width UILabel:(UILabel *)label;

@end
