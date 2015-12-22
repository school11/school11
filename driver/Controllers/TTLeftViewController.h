//
//  TTLeftViewController.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/17.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTBaseViewController.h"

@interface TTLeftViewController : TTBaseViewController

@property(nonatomic,retain) NSString * sidStr;
@property(nonatomic,retain) NSString * nickNameStr;
@property(nonatomic,retain) NSString * userNameStr;
@property(nonatomic,retain) NSString * typeStr;
@property(nonatomic,retain) NSString * uidStr;
@property(nonatomic,retain) NSString * headStr;
@property(nonatomic,retain) NSString * deviceNumStr;


@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
- (IBAction)settingClick:(id)sender;

- (IBAction)cencelClick:(id)sender;
- (IBAction)loginClick:(id)sender;

@end
