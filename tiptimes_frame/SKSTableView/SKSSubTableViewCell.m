//
//  SKSSubTableViewCell.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/10/24.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "SKSSubTableViewCell.h"

@implementation SKSSubTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _head_img = [[UIImageView alloc] initWithFrame:CGRectMake(8, 5, 50, 50)];
        //姓名
        _name_label = [[UILabel alloc] initWithFrame:CGRectMake(66, 26, 56, 21)];
        [_name_label setFont:[UIFont fontWithName:@"Helvetica" size:14.0]];
        //职位
        _position_label = [[UILabel alloc] initWithFrame:CGRectMake(125, 28, 100, 18)];
        [_position_label setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
        _position_label.textColor = [UIColor darkGrayColor];
        
        _message_btn = [[TTinfoButton alloc] initWithFrame:CGRectMake(233, 11, 36, 36)];
        [_message_btn setImage:[UIImage imageNamed:@"mail_send.png"] forState:UIControlStateNormal];
        
        _tel_btn = [[TTinfoButton alloc] initWithFrame:CGRectMake(276, 11, 36, 36)];
        [_tel_btn setImage:[UIImage imageNamed:@"telephone.png"] forState:UIControlStateNormal];
        [self.contentView addSubview:_head_img];
        [self.contentView addSubview:_name_label];
        [self.contentView addSubview:_position_label];
        [self.contentView addSubview:_message_btn];
        [self.contentView addSubview:_tel_btn];
    }
    return self;
}

@end
