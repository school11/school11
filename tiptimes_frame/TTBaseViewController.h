//
//  XTBaseViewController.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-15.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTSignal.h"
#import "TTSignalManager.h"
#import "TTSignalBuild.h"

@interface TTBaseViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

-(void)receiveNotif:(NSNotification *)notif;

-(TTSignalHandleType)handleSignal:(TTSignal *)signal;

//@property (nonatomic,weak)IBOutlet UITableView *tableView;

@property (nonatomic,assign) BOOL isForeground;
-(IBAction)back:(id) sender;
-(void)back;
-(IBAction)dismiss:(id) sender;

@property (nonatomic, assign) BOOL booleanValue;
@property(nonatomic, strong, readonly) TTBaseViewController *pv;
-(UIViewController *)getViewController:(NSString *)iden;

+(void)setNav:(UINavigationController *)nav;
+(UINavigationController *)getNav;

//跳转
-(void)pushViewController:(NSString *)viewIdentifier;
-(void)pushViewController:(NSString *)viewIdentifier if_animated:(BOOL)if_animated;

-(void)popToViewController:(NSString *)viewIdentifier;

+(void)setUserLoginSid;


//日期控件
-(void)select_date:(NSDate *)date;
@end
