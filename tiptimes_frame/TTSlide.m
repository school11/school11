//
//  TTSlide.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/6/29.
//  Copyright (c) 2015年 tiptimes. All rights reserved.
//

#import "TTSlide.h"
#import "TTBaseViewController.h"
#import "SUNTextFieldDemoViewController.h"
#import "SUNLeftMenuViewController.h"
#import "MMDrawerController.h"
#import "MMDrawerVisualState.h"
#import "SUNSlideSwitchDemoViewController.h"
static const CGFloat kPublicLeftMenuWidth = 180.0f;
@implementation TTSlide

+(SUNViewController *)initSlide{
    TTBaseViewController *bs = [[TTBaseViewController alloc] init];
    SUNViewController * drawerController = (SUNViewController *)[bs getViewController:@"ViewController123"];
    SUNSlideSwitchDemoViewController *slideSwitchVC = [[SUNSlideSwitchDemoViewController alloc] init];
    drawerController = [drawerController
                        initWithCenterViewController:slideSwitchVC
                        leftDrawerViewController:nil
                        rightDrawerViewController:nil];
    [drawerController setMaximumLeftDrawerWidth:kPublicLeftMenuWidth];
    [drawerController setOpenDrawerGestureModeMask:MMOpenDrawerGestureModeAll];
    [drawerController setCloseDrawerGestureModeMask:MMCloseDrawerGestureModeAll];
    [drawerController setDrawerVisualStateBlock:^(MMDrawerController *drawerController, MMDrawerSide drawerSide, CGFloat percentVisible) {
        MMDrawerControllerDrawerVisualStateBlock block;
        block = [MMDrawerVisualState parallaxVisualStateBlockWithParallaxFactor:2.0];
        block(drawerController, drawerSide, percentVisible);
    }];
    return drawerController;

}

@end
