//
//  SUNSlideSwitchDemoViewController.m
//  SUNCommonComponent
//
//  Created by 麦志泉 on 13-9-4.
//  Copyright (c) 2013年 中山市新联医疗科技有限公司. All rights reserved.
//

#import "SUNSlideSwitchDemoViewController.h"
#import "UIViewController+MMDrawerController.h"
#import "SUNListViewController.h"
#import "TTDoString.h"
@interface SUNSlideSwitchDemoViewController ()

@end

@implementation SUNSlideSwitchDemoViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    _slideSwitchView.parent = self;
    int x = [TTDoString getSlidenum];
    if ([self respondsToSelector:@selector(edgesForExtendedLayout)]) {
        self.edgesForExtendedLayout = UIRectEdgeNone;
    }
    
    self.title = @"滑动切换视图";
    self.slideSwitchView.tabItemNormalColor = [UIColor colorWithRed:(255.0/255) green:(255.0/255) blue:(255.0/255) alpha:1.0];
    self.slideSwitchView.tabItemSelectedColor = [UIColor colorWithRed:(255.0/255) green:(255.0/255) blue:(255.0/255) alpha:1.0];
    self.slideSwitchView.shadowImage = [[UIImage imageNamed:@"bottom_line1"]
                                        stretchableImageWithLeftCapWidth:59.0f topCapHeight:10.0f];
    
    
    
//    UIButton *rightSideButton = [UIButton buttonWithType:UIButtonTypeCustom];
//    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"] forState:UIControlStateNormal];
//    [rightSideButton setImage:[UIImage imageNamed:@"icon_rightarrow.png"]  forState:UIControlStateHighlighted];
//    rightSideButton.frame = CGRectMake(0, 0, 20.0f, 44.0f);
//    rightSideButton.userInteractionEnabled = NO;
//    self.slideSwitchView.rigthSideButton = rightSideButton;
    
    [self.slideSwitchView buildUI];
}

#pragma mark - 滑动tab视图代理方法

- (NSUInteger)numberOfTab:(SUNSlideSwitchView *)view
{
    int x = [TTDoString getSlidenum];
    switch (x) {
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        case 3:
            return 13;
            break;
        case 4:
            return 3;
            break;
        case 5:
            return 17;
            break;
        case 6:
            return 3;
            break;
        default:
            break;
    }
    return 2;
}

- (UIViewController *)slideSwitchView:(SUNSlideSwitchView *)view viewOfTab:(NSUInteger)number
{
    
    return nil;
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view panLeftEdge:(UIPanGestureRecognizer *)panParam
{
    SUNViewController *drawerController = (SUNViewController *)self.navigationController.mm_drawerController;
    [drawerController panGestureCallback:panParam];
}

- (void)slideSwitchView:(SUNSlideSwitchView *)view didselectTab:(NSUInteger)number
{
    
}

#pragma mark - 内存报警

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
