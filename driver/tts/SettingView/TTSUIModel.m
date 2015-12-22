//
//  TTSUIModel.m
//  tiptimes_frame
//
//  Created by tiptimes on 15/12/17.
//  Copyright © 2015年 tiptimes. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "TTSUIModel.h"
#import <QuartzCore/QuartzCore.h>
#import <AVFoundation/AVAudioSession.h>
#import <AudioToolbox/AudioSession.h>
#import "Definition.h"
#import "PopupView.h"
#import "AlertView.h"
#import "TTSConfig.h"

@interface TTSUIModel ()<IFlySpeechSynthesizerDelegate,UIActionSheetDelegate>

@end

@implementation TTSUIModel

-(instancetype ) init{
    if (self == [super init]) {
        [self initSynthesizer];
        
        
    }
    return self;
}

- (BOOL)shouldAutorotate
{
    return NO;
}

#pragma mark------科大讯飞语音模块------

-(void) player:(NSString *)str{
    
    if (_audioPlayer != nil && _audioPlayer.isPlaying == YES) {
        [_audioPlayer stop];
    }
    
    _synType = NomalType;
    
    self.hasError = NO;
    [NSThread sleepForTimeInterval:0.05];
    [_popUpView removeFromSuperview];
    self.isCanceled = NO;
    
    _iFlySpeechSynthesizer.delegate = self;
    [_iFlySpeechSynthesizer startSpeaking:str];
    if (_iFlySpeechSynthesizer.isSpeaking) {
        _state = Playing;
    }
    
}

#pragma mark - 合成回调 IFlySpeechSynthesizerDelegate

/**
 开始播放回调
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)onSpeakBegin
{
    self.isCanceled = NO;
    if (_state  != Playing) {
        [_popUpView showText:@"开始播放"];
    }
    
    
    _state = Playing;
}



/**
 缓冲进度回调
 
 progress 缓冲进度
 msg 附加信息
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)onBufferProgress:(int) progress message:(NSString *)msg
{
    NSLog(@"buffer progress %2d%%. msg: %@.", progress, msg);
}




/**
 播放进度回调
 
 progress 缓冲进度
 
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)onSpeakProgress:(int) progress
{
    NSLog(@"speak progress %2d%%.", progress);
}


/**
 合成暂停回调
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)onSpeakPaused
{
    [_popUpView showText:@"播放暂停"];
    
    _state = Paused;
}



/**
 恢复合成回调
 注：
 对通用合成方式有效，
 对uri合成无效
 ****/
- (void)onSpeakResumed
{
    [_popUpView showText:@"播放继续"];
    _state = Playing;
}

/**
 合成结束（完成）回调
 
 对uri合成添加播放的功能
 ****/
- (void)onCompleted:(IFlySpeechError *) error
{
    
    if (error.errorCode != 0) {
        [_popUpView showText:[NSString stringWithFormat:@"错误码:%d",error.errorCode]];
        return;
    }
    NSString *text ;
    if (self.isCanceled) {
        text = @"合成已取消";
    }else if (error.errorCode == 0) {
        text = @"合成结束";
    }else {
        text = [NSString stringWithFormat:@"发生错误：%d %@",error.errorCode,error.errorDesc];
        self.hasError = YES;
        NSLog(@"%@",text);
    }
    
    [_popUpView showText:text];
    
    _state = NotStart;
}




/**
 取消合成回调
 ****/
- (void)onSpeakCancel
{
    if (_isViewDidDisappear) {
        return;
    }
    self.isCanceled = YES;
    
    if (_synType == UriType) {
        
    }else if (_synType == NomalType) {
    }
    
    [_popUpView removeFromSuperview];
    
}


#pragma mark - 设置合成参数
- (void)initSynthesizer
{
    TTSConfig *instance = [TTSConfig sharedInstance];
    if (instance == nil) {
        return;
    }
    
    //合成服务单例
    if (_iFlySpeechSynthesizer == nil) {
        _iFlySpeechSynthesizer = [IFlySpeechSynthesizer sharedInstance];
    }
    
    _iFlySpeechSynthesizer.delegate = self;
    
    //设置语速1-100
    [_iFlySpeechSynthesizer setParameter:instance.speed forKey:[IFlySpeechConstant SPEED]];
    
    //设置音量1-100
    [_iFlySpeechSynthesizer setParameter:instance.volume forKey:[IFlySpeechConstant VOLUME]];
    
    //设置音调1-100
    [_iFlySpeechSynthesizer setParameter:instance.pitch forKey:[IFlySpeechConstant PITCH]];
    
    //设置采样率
    [_iFlySpeechSynthesizer setParameter:instance.sampleRate forKey:[IFlySpeechConstant SAMPLE_RATE]];
    
    
    //设置发音人
    [_iFlySpeechSynthesizer setParameter:instance.vcnName forKey:[IFlySpeechConstant VOICE_NAME]];
    
}

@end
