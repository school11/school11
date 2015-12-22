//
//  XTMobilePhoneCheck.m
//  xiante
//
//  Created by wenhuima on 6/28/14.
//  Copyright (c) 2014 wenhuima. All rights reserved.
//

#import "TTMobilePhone.h"

@implementation TTMobilePhone
+ (BOOL) validateEmail:(NSString *)email
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:email];
}
- (BOOL)checkMobilePhoneNumber:(NSString *)mobileNum
{
//    if ([str length] == 0) {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"data_null_prompt", nil) message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        return NO;
//    }
//    
//    NSString *regex = @"^((13[0-9])|(147)|(15[^4,\\D])|(18[0,5-9]))\\d{8}$";
//    NSPredicate *pred = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
//    BOOL isMatch = [pred evaluateWithObject:str];
//    if (!isMatch) {
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
//        return NO;
//    }
//    
//    return YES;
    
    if ([mobileNum length] == 0) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"data_null_prompt", nil) message:NSLocalizedString(@"tel_no_null", nil) delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
    
    /**
     * Mobile phone number
     * China mobile：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * Chine unicom：130,131,132,152,155,156,185,186
     * Chine telecom：133,1349,153,180,189
     */
    NSString * mobile = @"^((/+86)|(86))?1(3[0-9]|5[0-35-9]|8[025-9])\\d{8}$";
    /**
     10         * China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * chinaMobile = @"^((/+86)|(86))?1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * chinaUnicom = @"^((/+86)|(86))?1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * chinaTelecom = @"^((/+86)|(86))?1((33|53|8[09])[0-9]|349)\\d{7}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", mobile];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaMobile];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaUnicom];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", chinaTelecom];
    
    if (([regextestmobile evaluateWithObject:mobileNum] == YES)
        || ([regextestcm evaluateWithObject:mobileNum] == YES)
        || ([regextestct evaluateWithObject:mobileNum] == YES)
        || ([regextestcu evaluateWithObject:mobileNum] == YES)){
        
        return YES;
        
    }else{
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"提示" message:@"请输入正确的手机号码" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return NO;
    }
}

@end
