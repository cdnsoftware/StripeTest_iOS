//
//  HomeViewController.m
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "HomeViewController.h"
#import "Constant.h"
#import "CommonUtils.h"
#import "UIImage+NewImage.h"
#import "SignUpViewController.h"
#import "SignInViewController.h"

@interface HomeViewController ()

//Controls
@property (nonatomic,weak) IBOutlet UIButton *btnSignUp;
@property (nonatomic,weak) IBOutlet UIButton *btnSignIn;

@property (nonatomic,weak) IBOutlet UIImageView *imgBg;

@end

@implementation HomeViewController

#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self decorateUI];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self .navigationController setNavigationBarHidden:YES];
}

#pragma mark Private Methods
/**
 *  This method is used to decorate the UI controls like labels, textfield, buttons etc...
 *  Decorating them by putting text, images, background color and other stuff according to
 *  UI.
 */
-(void)decorateUI
{
    [self.imgBg setImage:[UIImage universalImageName:IMG_STARTSCREEN]];
    
    [self.btnSignIn setImage:[UIImage universalImageName:IMG_GOSIGNIN] forState:UIControlStateNormal];
    
    [CommonUtils setTextToButton:self.btnSignUp text:[TITLE_SIGNUP uppercaseString] backgroundColor:CLEARCOLOR fontFamily:FONT_FAMILY_ARIAL size:FONT_SIZE_10 color:BLACK_COLOR isSetAttributedString:NO isUnderLined:NO];
}

#pragma mark - IBActions
/**
 *  This method is used to push to signUp screen if user don't have an account.
 *
 *  @param sender SignUp Button
 */
-(IBAction)doClickSignUp:(id)sender
{
    SignUpViewController *viewC = [self.storyboard instantiateViewControllerWithIdentifier:SIGNUPVIEWIDENTIFIER];
    [self.navigationController pushViewController:viewC animated:YES];
}
/**
 *  This method is used to push to signIn screen if user have an account.
 *
 *  @param sender SignIn Button
 */

-(IBAction)doClickSignIn:(id)sender
{
    SignInViewController *viewC = [self.storyboard instantiateViewControllerWithIdentifier:SIGNINVIEWIDENTIFIER];
    [self.navigationController pushViewController:viewC animated:YES];

}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
