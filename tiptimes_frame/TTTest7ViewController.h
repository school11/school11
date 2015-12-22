//
//  XTTTest7ViewController.h
//  tiptimes_frame
//
//  Created by ycf on 15/12/14.
//  Copyright © 2015年 ycf. All rights reserved.
//

#import "TTTest2ViewController.h"
#import "TTaddOrder.h"
@interface TTTest7ViewController : TTTest2ViewController
{
    float nowJ;
    float nowW;

}
@property (nonatomic,strong)MAUserLocation *uselocation;
@property (nonatomic,strong)TTaddOrder *order;
@property (nonatomic,strong)AMapNearbySearchRequest *nearRequest;
@property (nonatomic,strong)AMapNearbyUploadInfo *info;
@property (nonatomic, strong) MAPointAnnotation * car;
@end
