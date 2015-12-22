//
//  TTSUIModel.h
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/17.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVFoundation/AVFoundation.h>
#import "iflyMSC/iflyMSC.h"
#import "PcmPlayer.h"

@class AlertView;
@class PopupView;
@class IFlySpeechSynthesizer;


typedef NS_OPTIONS(NSInteger, SynthesizeType) {
    NomalType           = 5,//普通合成
    UriType             = 6, //uri合成
};


typedef NS_OPTIONS(NSInteger, Status) {
    NotStart            = 0,
    Playing             = 2, //高异常分析需要的级别
    Paused              = 4,
};


@interface TTSUIModel : NSObject

@property (nonatomic, strong) IFlySpeechSynthesizer * iFlySpeechSynthesizer;

@property (nonatomic, strong) PopupView *popUpView;

@property (nonatomic, assign) BOOL isCanceled;
@property (nonatomic, assign) BOOL hasError;
@property (nonatomic, assign) BOOL isViewDidDisappear;


@property (nonatomic, strong) NSString *uriPath;
@property (nonatomic, strong) PcmPlayer *audioPlayer;

@property (nonatomic, assign) Status state;
@property (nonatomic, assign) SynthesizeType synType;
-(void) player:(NSString *)str;
@end
