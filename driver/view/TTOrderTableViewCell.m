//
//  TTOrderTableViewCell.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/14.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTOrderTableViewCell.h"

@implementation TTOrderTableViewCell

- (void)awakeFromNib {
    // Initialization code
    self.stateLabeel.textColor = [UIColor orangeColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
