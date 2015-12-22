//
//  AFViewShaker
//  AFViewShaker
//
//  Created by Philip Vasilchenko on 03.12.13.
//  Copyright (c) 2014 okolodev. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface AFViewShaker : NSObject

- (instancetype)initWithView:(UIView *)view;
- (instancetype)initWithViewsArray:(NSArray *)viewsArray;

- (void)shake;
- (void)shakeWithDuration:(NSTimeInterval)duration completion:(void (^)())completion;

@end


//用法

/*
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.viewShaker = [[AFViewShaker alloc] initWithViewsArray:self.allTextFields];
    
    for (UIButton * button in self.allButtons) {
        button.layer.borderColor = [[UIColor whiteColor] CGColor];
        button.layer.borderWidth = 1;
        button.layer.cornerRadius = 5;
    }
}


- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}


#pragma mark - Actions

- (IBAction)onShakeOneAction:(UIButton *)sender {
    [[[AFViewShaker alloc] initWithView:self.allButtons[0]] shake];
}


- (IBAction)onShakeAllAction:(UIButton *)sender {
    [self.viewShaker shake];
}


- (IBAction)onShakeAllWithBlockAction:(UIButton *)sender {
    [self.viewShaker shakeWithDuration:0.6 completion:^{
        [[[UIAlertView alloc] initWithTitle:@"Hello"
                                    message:@"This is completions block"
                                   delegate:self
                          cancelButtonTitle:@"OK"
                          otherButtonTitles:nil] show];
    }];
}
*/


