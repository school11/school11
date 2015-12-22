//
//  UIViewController-ExtrasMB.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-15.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "UIViewController+Extras.h"
@implementation UIViewController (Extras)
//添加属性扩展set方法

//通知名称
-(NSString *)notificationName{
    return [[NSString alloc] initWithFormat:@"%d",self.hash];
}
- (void)show{
    [SVProgressHUD show];
}
- (void)showWithMaskType:(SVProgressHUDMaskType)maskType{
    [SVProgressHUD showWithMaskType:maskType];
}
- (void)showWithStatus:(NSString*)status{
    [SVProgressHUD showWithStatus:status];
}
- (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType{
    [SVProgressHUD showWithStatus:status maskType:maskType];
}

- (void)showProgress:(float)progress{
    [SVProgressHUD showProgress:progress];
}
- (void)showProgress:(float)progress status:(NSString*)status{
     [SVProgressHUD showProgress:progress status:status];
}
- (void)showProgress:(float)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskTyp{
    [SVProgressHUD showProgress:progress status:status maskType:maskTyp];
    
}
- (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing
{
    [SVProgressHUD setStatus:string];
}

// stops the activity indicator, shows a glyph - status, and dismisses HUD 1s later
- (void)showSuccessWithStatus:(NSString*)string{
    [SVProgressHUD showSuccessWithStatus:string];
}
- (void)showErrorWithStatus:(NSString *)string{
    [SVProgressHUD showErrorWithStatus:string];
}
- (void)showImage:(UIImage*)image status:(NSString*)status; // use 28x28 white pngs@end
{
    [SVProgressHUD showImage:image status:status];
}
@end
