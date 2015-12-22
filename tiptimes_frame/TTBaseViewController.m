//
//  XTBaseViewController.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-15.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//



#import "TTBaseViewController.h"
#import "TTSignalManager.h"
#import "TTJumpViewController.h"
#import "TTUser.h"
#import "TTDoString.h"
static UINavigationController *nav;
@interface TTBaseViewController ()<TTSignalListener>

@end

@implementation TTBaseViewController{
    

}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)receiveNotif:(NSNotification *)notif{
    
}

-(TTSignalHandleType)handleSignal:(TTSignal *)signal{
    return handleRemove;
}

-(TTSignalHandleType)filterSignal:(TTSignal *)signal{
    return unhandle;
}






-(void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    self.isForeground = YES;
}
-(void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    self.booleanValue =NO;
    self.isForeground = NO;
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveNotif:) name:[self notificationName] object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(handleApns:) name:NOTIF_APNS object:nil];
    [[TTSignalManager sharedManager] addSignalListener:self];
    NSLog(@"viewDidLoad");

}

-(void) handleApns:(NSNotification *)notif{
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}


 - (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
 {

 
 return nil;
 }

+(void)setNav:(UINavigationController *)n{
    nav = n;
}
+(UINavigationController *)getNav{
    UINavigationController *nav1 = nav;
    return nav1;
}
//保存用户登录的sid
+(void)setUserLoginSid{
    NSUserDefaults *userDefaults=[NSUserDefaults standardUserDefaults];
    NSDictionary *u_info = [userDefaults objectForKey:@"stu_info"];
    [TTUser setUserSid:[u_info objectForKey:@"sid"]];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/


-(void) dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self ];
    [[TTSignalManager sharedManager] removeSignalListener:self];
    NSLog(@"%@dealloc",[self.class description]);
}
-(IBAction)back:(id) sender{
    [[TTSignalManager sharedManager] removeSignalListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

-(IBAction)dissmiss:(id) sender{
    [[TTSignalManager sharedManager] removeSignalListener:self];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void)back{
    [[TTSignalManager sharedManager] removeSignalListener:self];
    [self.navigationController popViewControllerAnimated:YES];
}

//跳转到identifier的页面
-(void)pushViewController:(NSString *)viewIdentifier{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[TTJumpViewController storyName] bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:viewIdentifier];
    if(nav == nil){
        NSLog(@"没有配置导航控制器!");
        return ;
    }
    [nav pushViewController:viewController animated:YES];
}

//跳转到identifier的页面,无动画
-(void)pushViewController:(NSString *)viewIdentifier if_animated:(BOOL)if_animated {
    NSLog(@"432%@",[TTJumpViewController storyName]);
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[TTJumpViewController storyName] bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:viewIdentifier];
    if(nav == nil){
        NSLog(@"没有配置导航控制器!");
        return ;
    }
    [nav pushViewController:viewController animated:if_animated];
}

//回退到指定identifier的页面
-(void)popToViewController:(NSString *)viewIdentifier{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[TTJumpViewController storyName] bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:viewIdentifier];
    if(nav == nil){
        NSLog(@"没有配置导航控制器!");
        return ;
    }
    [nav popToViewController:viewController  animated:YES];
}

-(UIViewController *)getViewController:(NSString *)iden{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:[TTJumpViewController storyName] bundle:nil];
    UIViewController *viewController = [storyboard instantiateViewControllerWithIdentifier:iden];
    return viewController;
}

-(TTBaseViewController *)pv{
    if(self.parentViewController == nil){
        return  nil;
    }
    NSArray *array =  self.navigationController.viewControllers;
    int i;
    for(i=0; i<[array count]; i++){
        if([array objectAtIndex:i]==self){
            break;
        }
    }
    if(i==0){
        return  nil;
    }
    return array[i-1];
}





@end
