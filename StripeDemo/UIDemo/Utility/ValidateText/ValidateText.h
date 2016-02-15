//
//  ValidateText.h
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>


@interface ValidateText : NSObject

+(BOOL)checkTextFieldEmpty:(UITextField*)textField withAlertMessage:(NSString*)message;

+(BOOL)checkEqualText:(NSString*)firstTextMessage withSecondMessage:(NSString*)secondTextMessage withAlertMessage:(NSString*)message;

+(BOOL)checkCustomTextMessage:(UITextField*)textField withText:(NSString*)textMessage withAlertMessage:(NSString*)message;

+(BOOL)checkEmailValidation:(UITextField*)textField withText:(NSString*)text withAlertMessage:(NSString*)message;

+(BOOL)checkTextLength:(UITextField*)textfield  withText:(NSString*)text withLength:(NSInteger)length withAlertMessage:(NSString*)message;

+(BOOL)checkMinLength:(UITextField*)textfield  withText:(NSString*)text withLength:(NSInteger)length withAlertMessage:(NSString*)message;

+(BOOL)checkTextIsEmpty:(NSString *)strText withAlertMessage:(NSString*)message;

@end
