//
//  XTJumpViewController.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-17.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "TTJumpViewController.h"
#import "Consistas_VC_Iden.h"
#import "TTBaseViewController.h"
#import "XTSideMenu.h"
#import "TTTestViewController.h"

#import "XTSideMenu.h"
#import "TTLeftViewController.h"

static NSString *storyName;
@interface TTJumpViewController ()

@end

@implementation TTJumpViewController

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
    // Do any additional setup after loading the view.
    NSLog(@"1");
    CGSize screenSize = [[UIScreen mainScreen] bounds].size;
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone){
        NSLog(@"111%F",screenSize.height);
        if (screenSize.height == 480){
            double version = [[UIDevice currentDevice].systemVersion doubleValue];
            if (version >= 7.0) {
                storyName = @"oamain";
            }
            else
            {
                storyName = @"oamain";
            }
//            storyName = @"adapter";
//            NSLog(@"111%F",screenSize.height);
        }else{
            storyName = @"oamain";
        }
    }
    //适配
    self.navigationController.navigationBarHidden=YES;
    [TTBaseViewController setNav:self.navigationController];
    TTLeftViewController *left =  [[TTLeftViewController alloc] init];
    
//    TTTestViewController *center = [[TTTestViewController alloc] init];

    TTAppDelegate *appDelegate = (TTAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    
    XTSideMenu *root = [[XTSideMenu alloc] initWithContentViewController:appDelegate.tMainVC leftMenuViewController:left rightMenuViewController:nil];
    [self.navigationController pushViewController:root animated:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    
    //[self pushViewController:@"DengluViewController" if_animated:NO];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(NSString *)storyName{
    return  storyName;
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

@end
