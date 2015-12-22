//
//  TTTableView.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/11/9.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import "TTTableView.h"

@implementation TTTableView

+(void)refreshTableViewCell:(UITableView *)tableView  row:(NSInteger)rowNum{
    NSIndexPath *indexPath=[NSIndexPath indexPathForRow:rowNum inSection:0];
    [tableView reloadRowsAtIndexPaths:[NSArray arrayWithObjects:indexPath,nil] withRowAnimation:UITableViewRowAnimationNone];
}

@end
