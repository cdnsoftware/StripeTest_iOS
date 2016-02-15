//
//  CommonUtils.h
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface CommonUtils : NSObject

+ (void)setTextToLabel:(UILabel *)label text:(NSString *)labelText
            fontFamily:(NSString *)labelFontName
              fontSize:(CGFloat)labelFontSize color:(UIColor *)labelTextColor;

+(void)setTextToButton:(UIButton *)button text:(NSString *)btnText backgroundColor:(UIColor*)backColor
                  fontFamily:(NSString *)btnFontName
                  size:(CGFloat)btnFontSize color:(UIColor *)btnTextColor isSetAttributedString:(BOOL)isSet isUnderLined:(BOOL)isLine;

+(void)setTextField:(UITextField *)txtField withPlaceholder:(NSString *)strPlaceholder withFontFamily:(NSString *)fontFamily withFontSize:(CGFloat)fontSize withPlaceholderColor:(UIColor*)color;

+(void)showAlertMessageWithMessage:(NSString *)strMessage withDelegate:(id)delegate withCancelTitle:(NSString *)strCancelTitle isOtherButton:(BOOL)isOtherButton withOtherButtonTitle:(NSString *)strOtherButtonTitle withTag:(NSInteger)tag;

+(void)doSetNSUserDefaultValue:(NSString *)strValue withKey:(NSString *)strKey;

+(void)doDecorateLabelWithLabel:(UILabel *)label withText:(NSString *)strText withMinimumRange:(NSInteger)minRange withMaximumRange:(NSInteger)maxRange withFirstTextColor:(UIColor *)colorFirstText withSecondTextColor:(UIColor *)colorSecondText  withFirstTextFontSize:(CGFloat)firstTextFontSize  withSecondTextFontSize:(CGFloat)secondTextFontSize;

+(NSString *)getDatabasePath;

+(NSString *)checkNullString:(NSString *)str;

+(void)doPopViewWithController:(UIViewController *)viewC withNavController:(UINavigationController *)navCtrl withAppDelegate:(AppDelegate *)appDelegate;

@end
