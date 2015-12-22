//
//  TTOrderTableViewCell.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/14.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTOrderTableViewCell : UITableViewCell
//@property(nonatomic,retain) UIImageView * leftImageView;
//@property(nonatomic,retain) UILabel * nameLabel;
//@property(nonatomic,retain) UILabel * addressLabel;
//@property(nonatomic,retain) UIImageView * teleImageView;
//@property(nonatomic,retain) UILabel * stateLabeel;

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *teleImageView;
@property (weak, nonatomic) IBOutlet UILabel *stateLabeel;


@end
