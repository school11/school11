//
//  gTableViewCell.h
//  product
//
//  Created by tiptimes on 15/12/4.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface gTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIButton *headerPictreBtn;

@property (weak, nonatomic) IBOutlet UILabel *nameLb;

@property (weak, nonatomic) IBOutlet UILabel *distanceLB;
@property (weak, nonatomic) IBOutlet UIView *timeLb;

@property (weak, nonatomic) IBOutlet UILabel *juLiLB;

@property (weak, nonatomic) IBOutlet UILabel *peopleCountLB;

@property (weak, nonatomic) IBOutlet UILabel *cell1Lab;


@end
