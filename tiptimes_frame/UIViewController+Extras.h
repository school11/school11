//
//  UIViewController-ExtrasMB.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-15.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SVProgressHUD/SVProgressHUD.h"
@interface UIViewController (Extras)
-(NSString *)notificationName;

- (void)show;
- (void)showWithMaskType:(SVProgressHUDMaskType)maskType;
- (void)showWithStatus:(NSString*)status;
- (void)showWithStatus:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;

-(void)showProgress:(float)progress;
- (void)showProgress:(float)progress status:(NSString*)status;
- (void)showProgress:(float)progress status:(NSString*)status maskType:(SVProgressHUDMaskType)maskType;

- (void)setStatus:(NSString*)string; // change the HUD loading status while it's showing

// stops the activity indicator, shows a glyph - status, and dismisses HUD 1s later
- (void)showSuccessWithStatus:(NSString*)string;
- (void)showErrorWithStatus:(NSString *)string;
- (void)showImage:(UIImage*)image status:(NSString*)status; // use 28x28 white pngs
@end
