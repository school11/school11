//
//  Consistas_Url.h
//  if_XianTeBanGong
//
//  Created by tiptimes on 14-6-15.
//  Copyright (c) 2014年 tiptimes. All rights reserved.
//

typedef enum
{
    ResultType_normal = 0,//正常数据
    ResultType_connectionError,//网络连接错误
    ResultType_requestError,//请求错误
    ResultType_noData,//没有数据
    ResultType_errorMsg,//错误信息
    ResultType_picUploadfailed,//头像上传失败
}ResultType;

#define BASE_URL

#define NET_ERROR_NONET @"网络连接出问题了"

#define URL_TEST @"http://www.tiptimes.com/hhy/getMovie.php?type=list"





