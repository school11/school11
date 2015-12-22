//
//  TTTableView.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/11/9.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTableView : NSObject

//刷新某一行 row行号 tableview
+(void)refreshTableViewCell:(UITableView *)tableView  row:(NSInteger)rowNum;


@end
