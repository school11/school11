//
//  TTRegisterViewController.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/17.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseViewController.h"
@interface TTRegisterViewController : TTBaseViewController
- (IBAction)backClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *teleTextFiled;
- (IBAction)testClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *testTextFiled;
- (IBAction)registerClick:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *nameTextFiled;

@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;

@end
