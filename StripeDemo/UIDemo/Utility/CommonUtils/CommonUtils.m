//
//  CommonUtils.m
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "CommonUtils.h"
#import "Constant.h"

@implementation CommonUtils

/**
 Decorate UILabel with text, custom fonts , font size and textcolor etc...
 */
+ (void)setTextToLabel:(UILabel *)label text:(NSString *)labelText
            fontFamily:(NSString *)labelFontName
              fontSize:(CGFloat)labelFontSize color:(UIColor *)labelTextColor
{
    if([labelText length]>0){
        [label setText:labelText];
    }
    label.textColor = labelTextColor;
    [label setFont:[UIFont fontWithName:labelFontName size:labelFontSize * WIDTH_FACTOR]];
}

/**
 Decorate UIButton with title, font, color, textSize etc...
 */
+(void)setTextToButton:(UIButton *)button text:(NSString *)btnText backgroundColor:(UIColor*)backColor
                  fontFamily:(NSString *)btnFontName
                  size:(CGFloat)btnFontSize color:(UIColor *)btnTextColor isSetAttributedString:(BOOL)isSet isUnderLined:(BOOL)isLine
{
    if ([btnText length]>0) {
        if(isSet==YES)
        {
            UIFont *boldFont = [UIFont fontWithName:FONT_FAMILY_ARIAL size:(WIDTH_FACTOR * 9)];
            NSDictionary *attributes = @{NSFontAttributeName : boldFont,NSForegroundColorAttributeName : btnTextColor};
            NSMutableAttributedString *commentString = [[NSMutableAttributedString alloc] initWithString:btnText attributes:attributes];
            if (isLine==YES) {
                [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, [commentString length])];
            }else{
                [commentString addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleNone] range:NSMakeRange(0, [commentString length])];
            }
            
            [button setAttributedTitle:commentString forState:UIControlStateNormal];
        }else
            [button setTitle:btnText forState:UIControlStateNormal];
    }
    [button setTitleColor:btnTextColor forState:UIControlStateNormal];
    if (backColor!=nil) {
        [button setBackgroundColor:backColor];
    }
    [button.titleLabel setFont:[UIFont fontWithName:btnFontName size:btnFontSize]];
}

+(void)setTextField:(UITextField *)txtField withPlaceholder:(NSString *)strPlaceholder withFontFamily:(NSString *)fontFamily withFontSize:(CGFloat)fontSize withPlaceholderColor:(UIColor*)color
{
    [txtField setPlaceholder:strPlaceholder];
    [txtField setFont:[UIFont fontWithName:fontFamily size:fontSize]];
    txtField.attributedPlaceholder = [[NSAttributedString alloc] initWithString:strPlaceholder attributes:@{NSForegroundColorAttributeName: color}];
}
+(void)showAlertMessageWithMessage:(NSString *)strMessage withDelegate:(id)delegate withCancelTitle:(NSString *)strCancelTitle isOtherButton:(BOOL)isOtherButton withOtherButtonTitle:(NSString *)strOtherButtonTitle withTag:(NSInteger)tag
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:APP_NAME message:strMessage delegate:delegate cancelButtonTitle:strCancelTitle otherButtonTitles:(isOtherButton?strOtherButtonTitle:nil), nil];
    alert.tag = tag;
    [alert show];
}
+(void)doSetNSUserDefaultValue:(NSString *)strValue withKey:(NSString *)strKey
{
    NSUserDefaults *usedDefault = [NSUserDefaults standardUserDefaults];
    [usedDefault setValue:strValue forKey:strKey];
    [usedDefault synchronize];
}

+(void)doDecorateLabelWithLabel:(UILabel *)label withText:(NSString *)strText withMinimumRange:(NSInteger)minRange withMaximumRange:(NSInteger)maxRange withFirstTextColor:(UIColor *)colorFirstText withSecondTextColor:(UIColor *)colorSecondText  withFirstTextFontSize:(CGFloat)firstTextFontSize  withSecondTextFontSize:(CGFloat)secondTextFontSize

{
    NSDictionary *attrs = @{
                            NSFontAttributeName:[UIFont boldSystemFontOfSize:firstTextFontSize],
                            NSForegroundColorAttributeName:colorFirstText
                            };
    NSDictionary *subAttrs = @{
                               NSFontAttributeName:[UIFont systemFontOfSize:secondTextFontSize],
                               NSForegroundColorAttributeName:colorSecondText
                               };
    
    // Range of " 2016/02/11" is (8,12). Ideally it shouldn't be hardcoded
    // This example is about attributed strings in one label
    // not about internationalization, so we keep it simple :)
    const NSRange range = NSMakeRange(minRange,maxRange);
    
    // Create the attributed string (text + attributes)
    NSMutableAttributedString *attributedText =
    [[NSMutableAttributedString alloc] initWithString:strText
                                           attributes:attrs];
    [attributedText setAttributes:subAttrs range:range];
    
    // Set it in our UILabel and we are done!
    [label setAttributedText:attributedText];
}
+(NSString *)getDatabasePath
{
    
    NSString *databasePath = [(AppDelegate *)[[UIApplication sharedApplication] delegate] databasePath];
    return databasePath;
}

+(NSString *)checkNullString:(NSString *)str
{
    if([str isKindOfClass:[NSNull class]])
        return @"";
    if(str==nil)
        return @"";
    if(str==NULL)
        return @"";
    if([str isEqual:[NSNull null]])
        return @"";
    if([str isEqualToString:@"<null>"])
        return @"";
    if([str isEqualToString:@"(null)"])
        return @"";
    return str;
}
+(void)doPopViewWithController:(UIViewController *)viewC withNavController:(UINavigationController *)navCtrl withAppDelegate:(AppDelegate *)appDelegate
{
    for (UIViewController *controller in navCtrl.viewControllers)
    {
        if ([controller isKindOfClass:[viewC class]])
        {
            [navCtrl popToViewController:controller animated:NO];
            break;
        }
        else
        {
            [CommonUtils doSetNSUserDefaultValue:@"" withKey:@"userToken"];
            UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            UINavigationController *controller = (UINavigationController*)[story
                                                                           instantiateViewControllerWithIdentifier: ROOT_NAVIGATION_IDENTIFIER];
            viewC = [story instantiateViewControllerWithIdentifier:HOMEVIEWIDENTIFIER];
            [controller setViewControllers:[NSArray arrayWithObject:viewC] animated:YES];
            appDelegate.window.rootViewController = controller;
        }
    }

}
@end
