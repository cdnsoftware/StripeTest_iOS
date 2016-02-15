//
//  SignInViewController.m
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "SignInViewController.h"
#import "Constant.h"
#import "CommonUtils.h"
#import "UIImage+NewImage.h"
#import "ProductViewController.h"
#import "SocialMedia.h"
#import "ValidateText.h"
#import "CommunicationManager.h"
#import "NetworkConnection.h"
#import "SVActivityIndicator.h"
#import "UINavigationBar+Addition.h"

@interface SignInViewController ()<SocialMediaDelegates,CommunicationDelegate>

//Controls
@property (nonatomic,weak) IBOutlet UIImageView *imgLogo;

@property (nonatomic,weak) IBOutlet UITextField *txtEmail;
@property (nonatomic,weak) IBOutlet UITextField *txtPassword;

@property (nonatomic,weak) IBOutlet UIButton *btnSignUpFacebook;
@property (nonatomic,weak) IBOutlet UIButton *btnSignIn;

@property (nonatomic,strong) SocialMedia *socialMedia;

@end

@implementation SignInViewController

#pragma mark - view life cycle
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self decorateUI];
    [self decorateNavigationBar];
    [self configureInitialParameters];
}

#pragma mark Private Methods

/**
 *  This method is used to decorate the UI controls like labels, textfield, buttons etc...
 *  Decorating them by putting text, images, background color and other stuff according to
 *  UI.
 */
-(void)decorateUI
{
    [self.btnSignUpFacebook setImage:[UIImage universalImageName:IMG_SIGNUP_FACEBOOK] forState:UIControlStateNormal];
    
    [self.btnSignIn setImage:[UIImage universalImageName:IMG_GOSIGNIN_GREEN] forState:UIControlStateNormal];
    
    
    [self.imgLogo setImage:[UIImage universalImageName:IMG_APPLOGO]];
    
    for (int i = 101; i < 103; i++) {
        UIImageView *imgSep = (UIImageView *)[self.view viewWithTag:i];
        [imgSep setImage:[UIImage universalImageName:IMG_SEPARATOR]];
    }
    
    [CommonUtils setTextField:self.txtEmail withPlaceholder:[@"Email" uppercaseString] withFontFamily:FONT_FAMILY_ARIAL withFontSize:FONT_SIZE_14 withPlaceholderColor:BLACK_COLOR];
    
    [CommonUtils setTextField:self.txtPassword withPlaceholder:[@"Password" uppercaseString] withFontFamily:FONT_FAMILY_ARIAL withFontSize:FONT_SIZE_14 withPlaceholderColor:BLACK_COLOR];
    
    [self.txtPassword setSecureTextEntry:YES];
}

/**
 *  This method is used to configure the initial parameters like allocating memory to some
 *  variable, feeding data like to Dictionary or Array.Settings Delegates to objects so we
 *  get a callback...
 */
-(void)configureInitialParameters
{
    self.socialMedia = [SocialMedia new];
    [self.socialMedia setDelegate:self];
}

/**
 *  This method is used to decorate the navigation bar by setting its title, image ,
 *  tintColor , barButton etc.
 */
-(void)decorateNavigationBar
{
    [self.navigationController setNavigationBarHidden:NO];
    
    self.title = TITLE_SIGNIN;
    
    UIImage* imageBack = [UIImage imageNamed:IMG_BACK_BUTTON];
    CGRect frameimg = CGRectMake(15,5, 13 * WIDTH_FACTOR, 12 * HEIGHT_FACTOR);
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:frameimg];
    [backButton setBackgroundImage:imageBack forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popView)
         forControlEvents:UIControlEventTouchUpInside];
    [backButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backBarbutton =[[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem =backBarbutton;
    
    [self.navigationController.navigationBar hideBottomHairline];
}

/**
 *  This method is used to pop the view from the stack i.e the most recent view in the stack to pop.
 */
-(void)popView
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma  mark - IBActions
/**
 *  This button action is used to signIn the user by entering the details and checking the
 *  mandatory fields are filled or not and also whether they are following the norms defined
 *  for them.
 *
 *  @param sender SignUp Button
 */
-(IBAction)doClickSignIn:(id)sender
{
    if ([self validateText]) {
        if ([NetworkConnection connected]) {
            [SVActivityIndicator showLoaderWithMessage:PLEASE_WAIT];
            NSDictionary *params = [NSDictionary dictionaryWithObjectsAndKeys:self.txtEmail.text ,@"username",self.txtPassword.text,@"password", @"Username-Password-Authentication",@"connection",@"KbFc7UO0OgmUHvZtOy0cPcdks9V1BMPW",@"client_id",@"iOS",@"device",@"openid",@"scope",@"password",@"grant_type",nil];
            [[CommunicationManager sharedInstance] setDelegate:self];
            [[CommunicationManager sharedInstance] postResponseWithParameter:params withMethodName:@"oauth/ro"];
        }
    }
}
/**
 *  This button action is used to signIn to facebook account by redirecting them to facebook
 *  site through its SDK and handle the response properly.And after getting the response
 *  redirect the user to Product Screen.
 *
 *  @param sender Facebook Button
 */
-(IBAction)doClickFacebookSignUp:(id)sender
{
    if ([NetworkConnection connected]) {
        [SVActivityIndicator showLoaderWithMessage:PLEASE_WAIT];
        [self.socialMedia doLoginInFacebook:self];
    }
}

/**
 *  This method is used to validate the textfield data i.e. all the mandatory fields are
 *  filled, whether valid email format is followed or not and so on.
 *
 *  @return YES or NO.
 */
-(BOOL)validateText
{
    if (!([ValidateText checkTextFieldEmpty:self.txtEmail withAlertMessage:ENTER_EMAIL]) || !([ValidateText checkTextFieldEmpty:self.txtPassword withAlertMessage:ENTER_PASSWORD]))
    {
        return NO;
    }
    else if (!([ValidateText checkEmailValidation:self.txtEmail withText:self.txtEmail.text withAlertMessage:ENTER_VALID_EMAIL]))
    {
        return NO;
    }
    return YES;
}

/**
 *  This is the SocialMedia Delegate for facebook login to handle the response of the user
 *  data and redirect user to Product Screen.
 *
 *  @param dictInfo UserInfo will come in Dictionary format which inlcuded as many data provided by facebook...
 */
#pragma mark - SocialMedia Delegates
-(void)doGetFacebookUserInfo:(NSDictionary *)dictInfo
{
    [SVActivityIndicator hideLoader];
    if (dictInfo) {
        [CommonUtils doSetNSUserDefaultValue:[dictInfo objectForKey:@"id"] withKey:COLUMN_UNIQUE_ID];
        [self doPushProductViewController];
    }else{
        [CommonUtils showAlertMessageWithMessage:ALERT_ERROR_OCCURED withDelegate:nil withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
    }
}

#pragma mark - Default Methods
/**
 *  This is the predefined method of iOS to handle the touch event on the View..We
 *  implemented this to resign the keyboard.
 *
 *  @param touches UITouch Object in NSSet.
 *  @param event Represent event in iOS.
 */
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

#pragma mark - Delegates
/**
 *  This is the delegate method for the Communication Manager class when the response comes
 *  from server whehter it is success or failure it comes in this method and handled.
 *
 *  @param jsonData is the data coming from server and do stuffs like saving the user id to usedDefault and use it along the app...
 */
-(void)setParsedData:(NSDictionary *)jsonData
{
    [SVActivityIndicator hideLoader];
    if (jsonData == nil) {
        [CommonUtils showAlertMessageWithMessage:ALERT_INVALID_ID_PASSWORD withDelegate:nil  withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
    }else{
        [self doPushProductViewController];
        [CommonUtils doSetNSUserDefaultValue:self.txtEmail.text withKey:COLUMN_UNIQUE_ID];
        [CommonUtils doSetNSUserDefaultValue:[jsonData objectForKey:@"id_token"] withKey:@"userToken"];
    }
}

#pragma Other Methods
/**
 *  This method is for navigating to Product View to see the products available.
 */
-(void)doPushProductViewController
{
    [SVActivityIndicator hideLoader];
    ProductViewController *viewC = [self.storyboard instantiateViewControllerWithIdentifier:PRODUCTVIEWIDENTIFIER];
    [self.navigationController pushViewController:viewC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
