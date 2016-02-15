
//
//  Constant.h
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#ifndef Constant_h
#define Constant_h


//AppName
#define APP_NAME                                    @"StripeTest"
//Identifiers
#define HOMEVIEWIDENTIFIER                          @"HomeViewIdentifier"
#define SIGNUPVIEWIDENTIFIER                        @"SignUpViewIdentifier"
#define SIGNINVIEWIDENTIFIER                        @"SignInViewIdentifier"
#define PRODUCTVIEWIDENTIFIER                       @"ProductViewIdentifier"
#define ORDERVIEWIDENTIFIER                         @"OrderViewIdentifier"
#define ROOT_NAVIGATION_IDENTIFIER                  @"RootNavigationIdentifier"

//Font Family
#define FONT_FAMILY_ARIAL                           @"Arial"
#define FONT_FAMILY_ARIAL_BOLD                      @"Arial-BoldMT"

//URL
#define BASE_URL                                    @"https://cdnsol.auth0.com/"
#define Stripe_Pub_Key @"pk_test_zlC2tL50rvg9FMwHJEo4mdcH"

#define DBNAME                                      @"PaymentOrder.sqlite"
#define TABLE_PAYMENT                               @"PaymentInfo"

//ColumnConstant
#define COLUMN_UNIQUE_ID                            @"uniqueID"
#define COLUMN_FIRSTNAME                            @"user_FirstName"
#define COLUMN_LASTNAME                             @"user_LastName"
#define COLUMN_CARDNO                               @"user_CardNo"
#define DATA                                        @"data"
#define COLUMN_CVV                                  @"cvvNo"
#define COLUMN_EXPDATE                              @"expDate"
#define COLUMN_ADDRESSLINE1                         @"addressLine1"
#define COLUMN_ADDRESSLINE2                         @"addressLine2"
#define COLUMN_CITY                                 @"city"
#define COLUMN_STATE                                @"state"
#define COLUMN_ZIPCODE                              @"zipcode"
#define COLUMN_COUNTRY                              @"country"
#define COLUMN_COMMENT                              @"comment"

//Font Size
#define FONT_SIZE_4                               4.0
#define FONT_SIZE_6                               6.0
#define FONT_SIZE_7                               7.0
#define FONT_SIZE_8                               8.0
#define FONT_SIZE_9                               9.0
#define FONT_SIZE_10                              10.0
#define FONT_SIZE_11                              11.0
#define FONT_SIZE_12                              12.0
#define FONT_SIZE_13                              13.0
#define FONT_SIZE_14                              14.0
#define FONT_SIZE_15                              15.0
#define FONT_SIZE_16                              16.0
#define FONT_SIZE_17                              17.0
#define FONT_SIZE_18                              18.0
#define FONT_SIZE_19                              19.0
#define FONT_SIZE_20                              20.0
#define FONT_SIZE_21                              21.0
#define FONT_SIZE_22                              22.0
#define FONT_SIZE_23                              23.0
#define FONT_SIZE_24                              24.0
#define FONT_SIZE_25                              25.0
#define FONT_SIZE_26                              26.0
#define FONT_SIZE_27                              27.0
#define FONT_SIZE_28                              28.0
#define FONT_SIZE_29                              29.0
#define FONT_SIZE_30                              30.0
#define FONT_SIZE_31                              31.0
#define FONT_SIZE_32                              32.0
#define FONT_SIZE_34                              34.0
#define FONT_SIZE_36                              36.0
#define FONT_SIZE_37                              37.0
#define FONT_SIZE_38                              38.0
#define FONT_SIZE_39                              39.0
#define FONT_SIZE_40                              40.0
#define FONT_SIZE_42                              42.0
#define FONT_SIZE_43                              43.0
#define FONT_SIZE_44                              44.0
#define FONT_SIZE_45                              45.0
#define FONT_SIZE_47                              47.0
#define FONT_SIZE_48                              48.0
#define FONT_SIZE_49                              49.0
#define FONT_SIZE_50                              50.0
#define FONT_SIZE_51                              51.0
#define FONT_SIZE_54                              54.0
#define FONT_SIZE_78                              78.0
#define FONT_SIZE_90                              90.0
#define FONT_SIZE_104                             104.0
#define FONT_SIZE_180                             180.0

#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)

#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )

#define IS_IPHONE_4 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )480 ) < DBL_EPSILON )

#define IS_IPHONE_6 (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 667.0f)

#define IS_IPHONE_6P (IS_IPHONE && [[UIScreen mainScreen] bounds].size.height == 736.0f)

#define IS_OS_7    ([[[UIDevice currentDevice] systemVersion] floatValue] <= 7.1)

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)

#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define UNIVERSAL_WIDTH [[UIScreen mainScreen] bounds].size.width
#define UNIVERSAL_HEIGHT [[UIScreen mainScreen] bounds].size.height

#define WIDTH_FACTOR  UNIVERSAL_WIDTH/320.0f
#define HEIGHT_FACTOR UNIVERSAL_HEIGHT/568.0f


/////RGB color
#define COLOR_RGBA(r, g, b, a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:a]
#define COLOR_CODE(r, g, b) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1]
#define WHITE_COLOR   [UIColor colorWithRed:255/255.0 green:255/255.0 blue:255/255.0 alpha:1.0]
#define BLACK_COLOR   [UIColor colorWithRed:0/255.0 green:0/255.0 blue:0/255.0 alpha:1.0]

#define CLEARCOLOR    [UIColor clearColor]

//Controls Constant
#define TITLE_SIGNIN                            @"Sign In"
#define TITLE_SIGNUP                            @"Sign Up"
#define TITLE_PRODUCTS                          @"Products"
#define TITLE_ORDER                             @"Order"

#define PLACEHOLDER_TXTFIELD_FIRSTNAME          @"Enter First Name"
#define PLACEHOLDER_TXTFIELD_LASTNAME           @"Enter Last Name"
#define PLACEHOLDER_TXTFIELD_ADDRESS1           @"Enter Address Line 1(Optional)"
#define PLACEHOLDER_TXTFIELD_ADDRESS2           @"Enter Address Line 2(Optional)"
#define PLACEHOLDER_TXTFIELD_CITY               @"Enter City"
#define PLACEHOLDER_TXTFIELD_STATE              @"Enter State"
#define PLACEHOLDER_TXTFIELD_ZIPCODE            @"Enter ZipCode"
#define PLACEHOLDER_TXTFIELD_COUNTRY            @"Enter Country"
#define TITLE_BUTTON_PAY                        @"PAY $45"

#define TITLE_LABEL_NAME                        @"YOUR NAME Your first and last name"
#define TITLE_LABEL_CARDNO                      @"CARD NUMBER The long number on your card"
#define TITLE_LABEL_CVV                         @"CVV The 3/4 digit security code on your card"
#define TITLE_LABEL_EXPDATE                     @"EXPIRATION DATE"
#define TITLE_LABEL_ADDRESS1                    @"ADDRESS LINE 1"
#define TITLE_LABEL_ADDRESS2                    @"ADDRESS LINE 2"
#define TITLE_LABEL_CITY                        @"CITY"
#define TITLE_LABEL_STATE                       @"STATE"
#define TITLE_LABEL_ZIPCODE                     @"ZIP CODE"
#define TITLE_LABEL_COUNTRY                     @"COUNTRY"

#define TITLE_LABEL_COMMENT                     @"Comment"

//Images Constant
#define IMG_STARTSCREEN                         @"splashBG"
#define IMG_GOSIGNIN                            @"signIn"
#define IMG_GOSIGNIN_GREEN                      @"goSignIn"
#define IMG_SIGNUP_FACEBOOK                     @"signUp_Facebook"
#define IMG_APPLOGO                             @"appLogo"
#define IMG_SEPARATOR                           @"imgSeparator"
#define IMG_BACK_BUTTON                         @"back"
#define IMG_SUCCESS                             @"Success"

//Alert Message
#define ENTER_FIRST_NAME                        @"Please enter your FirstName."
#define ENTER_LAST_NAME                         @"Please enter your LastName."
#define ENTER_NAME                              @"Please enter your Name."
#define ENTER_EMAIL                             @"Please enter email Address."
#define ENTER_VALID_EMAIL                       @"Please enter valid Email."
#define ENTER_PASSWORD                          @"Please enter Password."
#define ENTER_CARDNO                            @"Please enter Card No."
#define ENTER_CVV                               @"Please enter CVV"
#define ENTER_EXPIRY                            @"Please enter Expiry"
#define ENTER_PASSWORD_LENGTH                   @"Password must be atleast 8 characters."
#define ENTER_CARDNO_LENGTH                     @"Card No. must be of 16 digits"
#define ENTER_CVV_LENGTH                        @"CVV No. must be of  3 digits"
#define NetworkError                              @"Network is currently unreachable. Please check your device internet connection & then try again."
#define ALERT_VALID_CARD_DETAILS                @"Please Enter Valid Card Details"
#define ALERT_ERROR_OCCURED                     @"Some Error Occured."

#define PLEASE_WAIT                             @"Please Wait."
#define ALERT_INVALID_ID_PASSWORD               @"Invalid Email/Password"

#endif /* Constant_h */
