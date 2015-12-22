//
//  TTSConfigViewController.h
//  xunfei
//
//  Created by tiptimes on 15/12/16.
//  Copyright © 2015年 tiptimes. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SAMultisectorControl.h"
#import "AKPickerView.h"
@interface TTSConfigViewController : UIViewController<AKPickerViewDataSource,AKPickerViewDelegate>
@property (strong, nonatomic)  SAMultisectorSector *volumeSec;
@property (strong, nonatomic)  SAMultisectorSector *speedSec;
@property (strong, nonatomic)  SAMultisectorSector *pitchSec;


@property (weak, nonatomic) IBOutlet UIScrollView *backScrollView;

@property (weak, nonatomic) IBOutlet UILabel *speedLabel;
@property (weak, nonatomic) IBOutlet UILabel *volumeLabel;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;
@property (weak, nonatomic) IBOutlet SAMultisectorControl *roundSlider;

@property (weak, nonatomic) IBOutlet AKPickerView *vcnPicker;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sampleRateSeg;

@property (weak, nonatomic) IBOutlet UISegmentedControl *engineTypeSeg;




@end
