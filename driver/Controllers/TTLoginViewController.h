//
//  TTLoginViewController.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/17.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseViewController.h"
@interface TTLoginViewController : TTBaseViewController

- (IBAction)backClick:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *teletextfiled;
@property (weak, nonatomic) IBOutlet UITextField *passwordTextFiled;
- (IBAction)logInClick:(id)sender;

- (IBAction)registerClick:(id)sender;

- (IBAction)missPasswordClick:(id)sender;

@end
