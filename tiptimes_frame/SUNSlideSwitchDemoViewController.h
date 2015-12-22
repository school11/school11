//
//  SUNSlideSwitchDemoViewController.h
//  SUNCommonComponent
//
//  Created by 麦志泉 on 13-9-4.
//  Copyright (c) 2013年 中山市新联医疗科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SUNSlideSwitchView.h"
#import "SUNListViewController.h"
#import "SUNViewController.h"
#import "TTBaseViewController.h"




@interface SUNSlideSwitchDemoViewController : TTBaseViewController<SUNSlideSwitchViewDelegate>
{
    SUNSlideSwitchView *_slideSwitchView;
    
}

@property (nonatomic, strong) IBOutlet SUNSlideSwitchView *slideSwitchView;








@end
