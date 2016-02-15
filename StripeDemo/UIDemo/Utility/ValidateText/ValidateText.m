//
//  ValidateText.m
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "ValidateText.h"
#import "Constant.h"
#import "CommonUtils.h"

@implementation ValidateText

/**
 *  This method is used for checking the textfield text whether it is filled or not,if it is totol empty then it shows al alert for the required textfield.
 *
 *  @param textField -- The textfield object passes from the view.
 *  @param message   -- The alert message  comes from the view shows with the alert message.
 *
 *  @return return YES or NO i.e Bool value
 */
+(BOOL)checkTextFieldEmpty:(UITextField*)textField withAlertMessage:(NSString*)message{
    if (!textField.text||[[textField.text stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
    {
        [CommonUtils showAlertMessageWithMessage:message withDelegate:nil withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
        return NO;
    }
    return YES;
}
/**
 *  This method is for checking the given textfeld text is equal to that of the given text or not, if it is then it shows the alert to fill the data becasuse the prefilled text is not changed.
 *
 *  @param textField -- The textfield object passes from the view.
 *  @param message   -- The alert message  comes from the view shows with the alert message.
 *
 *  @return return YES or NO i.e Bool value
 
 */
+(BOOL)checkCustomTextMessage:(UITextField*)textField withText:(NSString*)textMessage withAlertMessage:(NSString*)message
{
    if ([textField.text isEqualToString:textMessage]) {
        [CommonUtils showAlertMessageWithMessage:message withDelegate:nil withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
        return NO;
    }return YES;
}
/**
 *  This method is for checking whether the two text field text are equal or not.If the text are not equal then it show the alert message.
 *
 *  @param firstTextMessage  First Textfield text
 *  @param secondTextMessage Second Textfield text
 *  @param message           Alert Message send by the view.
 *
 *  @return return YES or NO i.e Bool value
 */
+(BOOL)checkEqualText:(NSString*)firstTextMessage withSecondMessage:(NSString*)secondTextMessage withAlertMessage:(NSString*)message
{
    if (![firstTextMessage isEqualToString:secondTextMessage]) {
        [CommonUtils showAlertMessageWithMessage:message withDelegate:nil withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
        return NO;
    }else
    return YES;
}
/**
 *  This method is for check validation of email field i.e it follow the required email type or not.
 *
 *  @param textField Textfield Object
 *  @param text      The emial filled by user in the textfield.
 *  @param message   Alert Message send by the view.
 *
 *  @return return YES or NO i.e Bool value
 */
+(BOOL)checkEmailValidation:(UITextField*)textField withText:(NSString*)text withAlertMessage:(NSString*)message
{
    if (![ValidateText validateEmail:text]) {
        [CommonUtils showAlertMessageWithMessage:message withDelegate:nil withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
        return NO;
    }return YES;
}
/**
 *  This method gives whether the given text is in the correct email format or not.
 *
 *  @param emailText The text given from the above method.
 *
 *  @return return YES or NO i.e Bool value
 */
+(BOOL)validateEmail:(NSString*)emailText
{
    NSString*emailID=emailText;
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:emailID];
}
/**
 *  This method is used for checking the length of the textfield text whether it is equal to the given condition.
 *
 *  @param textfield Textfield Object
 *  @param text      The emial filled by user in the textfield.
 *  @param length    Predefined Length.
 *
 *  @return return YES or NO i.e Bool value
 */
+(BOOL)checkTextLength:(UITextField*)textfield  withText:(NSString*)text withLength:(NSInteger)length withAlertMessage:(NSString*)message
{
    if ([text length] != length) {
        [CommonUtils showAlertMessageWithMessage:message withDelegate:nil withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
        return NO;
    }return YES;
}
+(BOOL)checkMinLength:(UITextField*)textfield  withText:(NSString*)text withLength:(NSInteger)length withAlertMessage:(NSString*)message
{
    if ([text length] < length) {
        [CommonUtils showAlertMessageWithMessage:message withDelegate:nil withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
        return NO;
    }return YES;
}

+(BOOL)checkTextIsEmpty:(NSString *)strText withAlertMessage:(NSString*)message{
    if (!strText ||[[strText stringByReplacingOccurrencesOfString:@" " withString:@""] isEqualToString:@""])
    {
            [CommonUtils showAlertMessageWithMessage:message withDelegate:nil withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
            return NO;
    }return YES;
}
@end
