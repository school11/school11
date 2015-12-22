//
//  XTinfoButton.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-17.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTinfoButton : UIButton
@property (strong, nonatomic)NSNumber * index;
@property (assign, nonatomic) int intValue;
@property (strong, nonatomic)id  object;
@property (strong, nonatomic)UIImageView *img;
@property (strong, nonatomic)UILabel *label;
@property (strong, nonatomic)NSString *strValue;


-(void) commonTitle:(NSString *)str;
@end
