//
//  TTTest3ViewController.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/12.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTBaseViewController.h"

@interface TTTest3ViewController : TTBaseViewController

@property (weak, nonatomic) IBOutlet UITableView *myTableview;
//存放数据data
@property (strong,nonatomic) NSMutableArray *data;

@property (nonatomic)float jingD;

@property (nonatomic)float weiD;

@property (nonatomic,strong)NSString *fanchengStr;


@end
