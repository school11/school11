//
//  NSString+info.m
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-19.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

#import "NSString+info.h"
static NSDictionary *newsLabel;
@implementation NSString (info)
+(NSNumber *) userID{
   NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSInteger result =[ud integerForKey:@"userId"];
    return [NSNumber numberWithInt:result];


}
+(NSString *)userName{
    NSUserDefaults *ud = [NSUserDefaults standardUserDefaults];
    
    NSString * result =[ud objectForKey:@"userName"];
    return result;

}

-(NSString *)annexName:anndexId{
    return [[NSString alloc]initWithFormat:@"%d_%@",[anndexId integerValue],self];
}

-(BOOL)isNumber{
    BOOL flag = YES;
    for(int i=0; i<self.length; i++){
        unichar ch = [self characterAtIndex:i];
        if('0'>ch || ch>'9'){
            flag = NO;
        }
    }
    return flag;
}
//解析html
+(NSAttributedString *)parseToHtml:(NSString *)html{
    NSAttributedString * attrStr = [[NSAttributedString alloc] initWithData:[html dataUsingEncoding:NSUnicodeStringEncoding] options:@{ NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType } documentAttributes:nil error:nil];
    return  attrStr;
}


+(NSString *)getNewsLabel:(NSString *)class1 class2:(NSString *)class2{
    if(newsLabel ==nil){
        [NSString initNewsLabel];
    }
    
    return [[newsLabel objectForKey:class1] objectForKey:class2];
}

+(void) initNewsLabel{
    //新闻
    NSMutableDictionary *newsDic = [[NSMutableDictionary alloc] initWithCapacity:5];
    [newsDic setObject:@"新闻发布-公司新闻" forKey:@"001" ];
    [newsDic setObject:@"新闻发布-部门新闻" forKey:@"002"];
    [newsDic setObject:@"新闻发布-国内新闻" forKey:@"003"];
    [newsDic setObject:@"新闻发布-集团新闻" forKey:@"004"];
    [newsDic setObject:@"新闻发布-行业新闻" forKey:@"005"];
    //公司公告
    NSMutableDictionary *gonggaoDic = [[NSMutableDictionary alloc] initWithCapacity:3];
    [gonggaoDic setObject:@"公司公告-职务任免" forKey:@"001"];
    [gonggaoDic setObject:@"公司公告-放假通知" forKey:@"002"];
    [gonggaoDic setObject:@"公司公告-内部公告" forKey:@"003"];
    
    //电子期刊
    NSMutableDictionary *qikanDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [qikanDic setObject:@"电子期刊-调研报告" forKey:@"001"];
    [qikanDic setObject:@"电子期刊-类型2" forKey:@"002"];
    
    //政策法规
    NSMutableDictionary *faguisDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [faguisDic setObject:@"政策法规-类型1" forKey:@"001"];
    [faguisDic setObject:@"政策法规-类型2" forKey:@"002"];
    
    //管理制度
    NSMutableDictionary *zhiduDic = [[NSMutableDictionary alloc] initWithCapacity:2];
    [zhiduDic setObject:@"管理制度-现行管理制度" forKey:@"001"];
    [zhiduDic setObject:@"管理制度-废止管理制度" forKey:@"002"];
    
    //办事指南
    NSMutableDictionary *zhinanDic = [[NSMutableDictionary alloc] initWithCapacity:16];
    [zhinanDic setObject:@"办事指南-其它" forKey:@"001"];
    [zhinanDic setObject:@"办事指南-资金审批流程" forKey:@"002"];
    [zhinanDic setObject:@"办事指南-法规类" forKey:@"003"];
    [zhinanDic setObject:@"办事指南-合同审批流程" forKey:@"004"];
    [zhinanDic setObject:@"办事指南-施工许可证办件流程" forKey:@"005"];
    [zhinanDic setObject:@"办事指南-售房许可证办件流程" forKey:@"006"];
    [zhinanDic setObject:@"办事指南-规划许可证办件流程" forKey:@"007"];
    [zhinanDic setObject:@"办事指南-竣工备案工作流程" forKey:@"008"];
    [zhinanDic setObject:@"办事指南-配套办件流程" forKey:@"009"];
    [zhinanDic setObject:@"办事指南-ＯＡ办公平台操作指南" forKey:@"010"];
    [zhinanDic setObject:@"办事指南-部门及部门间流程" forKey:@"011"];
    [zhinanDic setObject:@"办事指南-图纸变更申请、审批流程" forKey:@"012"];
    [zhinanDic setObject:@"办事指南-招标文件审批流程" forKey:@"013"];
    [zhinanDic setObject:@"办事指南-结算审批流程" forKey:@"014"];
    [zhinanDic setObject:@"办事指南-设计方案流程" forKey:@"015"];
    [zhinanDic setObject:@"办事指南-平台新增审批流程" forKey:@"016"];
    
    newsLabel = [[NSDictionary alloc] initWithObjectsAndKeys:newsDic,@"041",gonggaoDic ,@"042",qikanDic,@"043",faguisDic,@"044",zhiduDic,@"045",
                 zhinanDic, @"046",nil];
    
}


@end
