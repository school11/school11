//
//  XTinfoButton.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-17.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTinfoButton.h"

@implementation TTinfoButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}
-(void) commonTitle:(NSString *)str{
    [self setTitle:str forState:UIControlStateNormal];
    [self setTitle:str forState:UIControlStateHighlighted];
}

@end
