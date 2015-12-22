//
//  XTAppDelegate.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-14.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MBProgressHUD.h"
#import "TTTestViewController.h"

@interface TTAppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate>

@property (strong, nonatomic) UIWindow *window;
@property(nonatomic, strong) UINavigationController *navtroller;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic) BOOL isLaunchedByNotification;

@property(strong,nonatomic) TTTestViewController * tMainVC;

@end
