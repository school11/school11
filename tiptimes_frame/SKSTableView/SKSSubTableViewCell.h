//
//  SKSSubTableViewCell.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/10/24.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TTinfoButton.h"
@interface SKSSubTableViewCell : UITableViewCell

@property (nonatomic, strong) UIImageView *head_img;
@property (nonatomic, strong) UILabel *name_label;
@property (nonatomic, strong) UILabel *position_label;
@property (nonatomic, strong) TTinfoButton *message_btn;
@property (nonatomic, strong) TTinfoButton *tel_btn;



@end
