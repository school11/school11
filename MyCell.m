//
//  MyCell.m
//  product
//
//  Created by ycf on 15/12/12.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "MyCell.h"
#define HIGHt [UIScreen mainScreen].bounds.size.height
#define WITH  [[UIScreen mainScreen]bounds].size.width
@implementation MyCell

-(id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self)
    {
        float cellH = (HIGHt/2-30)/3;
        float cellW = WITH-20;
        UIImageView *TXimage = [[UIImageView alloc] initWithFrame:CGRectMake(5, cellH/2-cellH/4, cellH/2, cellH/2)];
        TXimage.tag = 1;
        TXimage.backgroundColor = [UIColor orangeColor];
        [self.contentView addSubview:TXimage];
        self.TxImage = TXimage;
        
        UILabel *nameLable = [[UILabel alloc] initWithFrame:CGRectMake(TXimage.frame.origin.x+cellH/2, TXimage.frame.origin.y, 60, cellH/4)];
        nameLable.text = @"地铁";
        [self.contentView addSubview:nameLable];
        self.nameLab = nameLable;
        
        for (int i = 0; i<6; i++)
        {
            UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(TXimage.frame.origin.x+cellH/2+20*i,nameLable.frame.origin.y+cellH/4, 10, 20)];
            image.image = [UIImage imageNamed:@"ic_user_empty"];
            [self.contentView addSubview:image];
        }
        
        UILabel *lastLab = [[UILabel alloc] initWithFrame:CGRectMake(5, TXimage.frame.origin.y-cellH-5, 100, 20)];
        lastLab.text = @"还有两分钟";
        [self.contentView addSubview:lastLab];
        
        self.lab2 = lastLab;
        
        UIButton *add = [UIButton buttonWithType:UIButtonTypeCustom];
        [add setBackgroundImage:[UIImage imageNamed:@"ic_join"] forState:UIControlStateNormal];
        add.frame = CGRectMake(cellW-10-cellH/4, cellH/2-cellH/8, cellH/4, cellH/4);
        [self.contentView addSubview:add];
        
        self.addBut = add;
        
        UILabel *priceLab = [[UILabel alloc] initWithFrame:CGRectMake(cellW-cellH/4-90, cellH/2-cellH/8, 80, cellH/4)];
        priceLab.textAlignment = NSTextAlignmentLeft;
        priceLab.text = @"2元／人";
        [self.contentView addSubview:priceLab];
        self.priceLab = priceLab;
        

    
    }
    
    return self;
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
