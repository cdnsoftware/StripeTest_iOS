//
//  OrderViewController.m
//  UIDemo
//
//  Created by Ambuj Shukla on 12/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "OrderViewController.h"
#import "CommonUtils.h"
#import "Constant.h"
#import "ActionSheetDatePicker.h"
#import "ValidateText.h"
#import "UIImage+NewImage.h"
#import "DBManager.h"
#import <Stripe/Stripe.h>
#import "SVActivityIndicator.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "HomeViewController.h"

@interface OrderViewController ()<UITextFieldDelegate>
{
    DBManager *dbManager;
    AppDelegate *appDelegate;
    HomeViewController *homeView;
}
//Controls
@property (nonatomic,weak) IBOutlet UITextField *txtFirstName;
@property (nonatomic,weak) IBOutlet UITextField *txtLastName;
@property (nonatomic,weak) IBOutlet UITextField *txtCardNo;
@property (nonatomic,weak) IBOutlet UITextField *txtCVV;
@property (nonatomic,weak) IBOutlet UITextField *txtExpiry;
@property (nonatomic,weak) IBOutlet UITextField *txtAddressLine1;
@property (nonatomic,weak) IBOutlet UITextField *txtAddressLine2;
@property (nonatomic,weak) IBOutlet UITextField *txtCity;
@property (nonatomic,weak) IBOutlet UITextField *txtState;
@property (nonatomic,weak) IBOutlet UITextField *txtZipCode;
@property (nonatomic,weak) IBOutlet UITextField *txtCountry;
@property (nonatomic,weak) IBOutlet UITextView *txtViewComment;

@property (nonatomic,weak) IBOutlet UILabel *lblName;
@property (nonatomic,weak) IBOutlet UILabel *lblCardNo;
@property (nonatomic,weak) IBOutlet UILabel *lblCVV;
@property (nonatomic,weak) IBOutlet UILabel *lblExpDate;
@property (nonatomic,weak) IBOutlet UILabel *lblAddress1;
@property (nonatomic,weak) IBOutlet UILabel *lblAddress2;
@property (nonatomic,weak) IBOutlet UILabel *lblCity;
@property (nonatomic,weak) IBOutlet UILabel *lblState;
@property (nonatomic,weak) IBOutlet UILabel *lblZipCode;
@property (nonatomic,weak) IBOutlet UILabel *lblCountry;
@property (nonatomic,weak) IBOutlet UILabel *lblComment;

@property (nonatomic,strong) IBOutlet NSLayoutConstraint *heightContraint;

@property (nonatomic,weak) IBOutlet UIScrollView *scrollView;
@property (nonatomic,weak) IBOutlet UIView *viewOrder;

@property (nonatomic,strong) NSMutableArray *arrPaymentData;

@property (nonatomic,strong) IBOutlet STPPaymentCardTextField *stripeTextField;

@property (nonatomic,weak) IBOutlet UIButton *btnPay;

@property (nonatomic,weak) IBOutlet UIImageView *imgSuccess;

@end

@implementation OrderViewController

#define mark view life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self decorateUI];
    [self configureInitialParameters];
    [self decorateNavigationBar];
}

#pragma mark - Private Methods
/**
 *  This method is used to decorate the UI controls like labels, textfield, buttons etc...
 *  Decorating them by putting text, images, background color and other stuff according to
 *  UI.
 */
-(void)decorateUI
{
    [CommonUtils doDecorateLabelWithLabel:self.lblName withText:TITLE_LABEL_NAME withMinimumRange:10 withMaximumRange:24 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    [CommonUtils doDecorateLabelWithLabel:self.lblCardNo withText:TITLE_LABEL_CARDNO withMinimumRange:11 withMaximumRange:29 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    [CommonUtils doDecorateLabelWithLabel:self.lblCVV withText:TITLE_LABEL_CVV withMinimumRange:3 withMaximumRange:41 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    [CommonUtils doDecorateLabelWithLabel:self.lblExpDate withText:TITLE_LABEL_EXPDATE withMinimumRange:8 withMaximumRange:0 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    [CommonUtils doDecorateLabelWithLabel:self.lblAddress1 withText:TITLE_LABEL_ADDRESS1 withMinimumRange:14 withMaximumRange:0 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    [CommonUtils doDecorateLabelWithLabel:self.lblAddress2 withText:TITLE_LABEL_ADDRESS2 withMinimumRange:14 withMaximumRange:0 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    [CommonUtils doDecorateLabelWithLabel:self.lblCity withText:TITLE_LABEL_CITY withMinimumRange:4 withMaximumRange:0 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    [CommonUtils doDecorateLabelWithLabel:self.lblState withText:TITLE_LABEL_STATE withMinimumRange:5 withMaximumRange:0 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    [CommonUtils doDecorateLabelWithLabel:self.lblZipCode withText:TITLE_LABEL_ZIPCODE withMinimumRange:7 withMaximumRange:0 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    [CommonUtils doDecorateLabelWithLabel:self.lblCountry withText:TITLE_LABEL_COUNTRY withMinimumRange:7 withMaximumRange:0 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    [CommonUtils doDecorateLabelWithLabel:self.lblComment withText:TITLE_LABEL_COMMENT withMinimumRange:7 withMaximumRange:0 withFirstTextColor:BLACK_COLOR withSecondTextColor:[UIColor grayColor] withFirstTextFontSize:FONT_SIZE_12 withSecondTextFontSize:FONT_SIZE_10];
    
    for (int i = 101; i < 113; i++)
    {
        UIImageView *imgSep = (UIImageView *)[self.view viewWithTag:i];
        [imgSep setImage:[UIImage universalImageName:IMG_SEPARATOR]];
    }

    [CommonUtils setTextField:self.txtFirstName withPlaceholder:[PLACEHOLDER_TXTFIELD_FIRSTNAME uppercaseString] withFontFamily:FONT_FAMILY_ARIAL withFontSize:FONT_SIZE_12 withPlaceholderColor:BLACK_COLOR];
    
    [CommonUtils setTextField:self.txtLastName withPlaceholder:[PLACEHOLDER_TXTFIELD_LASTNAME uppercaseString] withFontFamily:FONT_FAMILY_ARIAL withFontSize:FONT_SIZE_12 withPlaceholderColor:BLACK_COLOR];
    
    
    [CommonUtils setTextField:self.txtAddressLine1 withPlaceholder:[PLACEHOLDER_TXTFIELD_ADDRESS1 uppercaseString] withFontFamily:FONT_FAMILY_ARIAL withFontSize:FONT_SIZE_12 withPlaceholderColor:BLACK_COLOR];
    
    [CommonUtils setTextField:self.txtAddressLine2 withPlaceholder:[PLACEHOLDER_TXTFIELD_ADDRESS2 uppercaseString] withFontFamily:FONT_FAMILY_ARIAL withFontSize:FONT_SIZE_12 withPlaceholderColor:BLACK_COLOR];
    
    [CommonUtils setTextField:self.txtCity withPlaceholder:[PLACEHOLDER_TXTFIELD_CITY uppercaseString] withFontFamily:FONT_FAMILY_ARIAL withFontSize:FONT_SIZE_12 withPlaceholderColor:BLACK_COLOR];
    
    [CommonUtils setTextField:self.txtState withPlaceholder:[PLACEHOLDER_TXTFIELD_STATE uppercaseString] withFontFamily:FONT_FAMILY_ARIAL withFontSize:FONT_SIZE_12 withPlaceholderColor:BLACK_COLOR];
    
    [CommonUtils setTextField:self.txtZipCode withPlaceholder:[PLACEHOLDER_TXTFIELD_ZIPCODE uppercaseString] withFontFamily:FONT_FAMILY_ARIAL withFontSize:FONT_SIZE_12 withPlaceholderColor:BLACK_COLOR];
    
    [CommonUtils setTextField:self.txtCountry withPlaceholder:[PLACEHOLDER_TXTFIELD_COUNTRY uppercaseString] withFontFamily:FONT_FAMILY_ARIAL withFontSize:FONT_SIZE_12 withPlaceholderColor:BLACK_COLOR];
    
    [CommonUtils setTextToButton:self.btnPay text:TITLE_BUTTON_PAY  backgroundColor:COLOR_RGBA(21, 56, 255, 1.0) fontFamily:FONT_FAMILY_ARIAL size:FONT_SIZE_12 color:WHITE_COLOR isSetAttributedString:NO isUnderLined:NO];
    
    [self.imgSuccess setImage:[UIImage universalImageName:IMG_SUCCESS]];
    
    [self.stripeTextField setBorderColor:CLEARCOLOR];
    [self viewDidLayoutSubviews];
}

/**
 *  This method is used to decorate the navigation bar by setting its title, image ,
 *  tintColor , barButton etc.
 */
-(void)decorateNavigationBar
{
    [self.navigationController setNavigationBarHidden:NO];
    
    self.title = TITLE_ORDER;
    UIImage* imageBack = [UIImage imageNamed:IMG_BACK_BUTTON];
    CGRect frameimg = CGRectMake(15,5, 13 * WIDTH_FACTOR, 12 * HEIGHT_FACTOR);
    
    UIButton *backButton = [[UIButton alloc] initWithFrame:frameimg];
    [backButton setBackgroundImage:imageBack forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(popView)
         forControlEvents:UIControlEventTouchUpInside];
    [backButton setShowsTouchWhenHighlighted:YES];
    
    UIBarButtonItem *backBarbutton =[[UIBarButtonItem alloc] initWithCustomView:backButton];
    self.navigationItem.leftBarButtonItem =backBarbutton;
    
    UIBarButtonItem *btnLogout = [[UIBarButtonItem alloc]
                                  initWithTitle:@"Log Out"
                                  style:UIBarButtonItemStylePlain
                                  target:self
                                  action:@selector(popToHomeScreen)];
    [btnLogout setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                       [UIFont fontWithName:FONT_FAMILY_ARIAL size:FONT_SIZE_12], NSFontAttributeName,
                                       BLACK_COLOR, NSForegroundColorAttributeName,
                                       nil]
                             forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = btnLogout;
}
-(void)popToHomeScreen
{
    [CommonUtils doPopViewWithController:homeView withNavController:self.navigationController withAppDelegate:appDelegate];
}
/**
 *  This method is used to pop the view from the stack i.e the most recent view in the stack to pop.
 */
-(void)popView
{
    [self.navigationController popViewControllerAnimated:YES];
}
/**
 *  This method is used to layout the view after laying out all the subviews in ScrollView..
 */
- (void)viewDidLayoutSubviews {
    
    CGRect contentRect = CGRectZero;
    for (UIView *view in self.scrollView.subviews) {
        contentRect = CGRectUnion(contentRect, view.frame);
    }
    self.scrollView.contentSize = contentRect.size;
}
/**
 *  This method is used to configure the initial parameters like allocating memory to some
 *  variable, feeding data like to Dictionary or Array.Settings Delegates to objects so we
 *  get a callback...
 */
-(void)configureInitialParameters
{
    [self.txtExpiry setDelegate:self];
    [self.txtCardNo setDelegate:self];
    [self.txtCVV setDelegate:self];
    
    [self.txtZipCode setKeyboardType:UIKeyboardTypeNumberPad];
    
    dbManager = [DBManager new];
    
    self.arrPaymentData = [NSMutableArray new];
    
    self.arrPaymentData = [dbManager doGetData:COLUMN_UNIQUE_ID WithValue:[[NSUserDefaults standardUserDefaults] objectForKey:COLUMN_UNIQUE_ID] WithTableName:TABLE_PAYMENT ];
    [self doFillData];
    [self doDecorateAfterSucces:YES];
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
}
-(void)doDecorateAfterSucces:(BOOL)isSuccess
{
    [self.imgSuccess setHidden:isSuccess];
}

/**
 *  This method is used to fill the fields if data is already save in database...
 */
-(void)doFillData
{
    if ([self.arrPaymentData count] > 0) {
        [self.txtFirstName setText:[[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_FIRSTNAME]];
        [self.txtLastName setText:[[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_LASTNAME]];
        [self.txtAddressLine1 setText:[[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_ADDRESSLINE1]];
        [self.txtAddressLine2 setText:[[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_ADDRESSLINE2]];
        [self.txtCity setText:[[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_CITY]];
        [self.txtState setText:[[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_STATE]];
        [self.txtZipCode setText:[[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_ZIPCODE]];
        [self.txtCountry setText:[[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_COUNTRY]];
        [self.txtViewComment setText:[[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_COMMENT]];
        
        STPCardParams *cardParams = [STPCardParams new];
        
        cardParams.number = [[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_CARDNO];
        cardParams.cvc = [[self.arrPaymentData objectAtIndex:0]objectForKey:COLUMN_CVV];
        cardParams.expMonth = [[[[[self.arrPaymentData objectAtIndex:0] objectForKey:COLUMN_EXPDATE] componentsSeparatedByString:@"/"]objectAtIndex:0] integerValue];
        cardParams.expYear =  [[[[[self.arrPaymentData objectAtIndex:0] objectForKey:COLUMN_EXPDATE] componentsSeparatedByString:@"/"]objectAtIndex:1] integerValue];
        self.stripeTextField.cardParams = cardParams;
    }
}
#pragma mark - IBActions
/**
 *  This is the IBAction method to check the fields and get the token of the Stripe payment.
 *
 *  @param sender Payment Button
 */
-(IBAction)doSaveCardDetails:(id)sender
{
    if([self validateText]){
        [self.view endEditing:YES];
        [SVActivityIndicator showLoaderWithMessage:PLEASE_WAIT];
        [[STPAPIClient sharedClient]
         createTokenWithCard:self.stripeTextField.cardParams
         completion:^(STPToken *token, NSError *error) {
             if (error) {
                 [SVActivityIndicator hideLoader];
                 [CommonUtils showAlertMessageWithMessage:[error.userInfo objectForKey:@"NSLocalizedDescription"] withDelegate:nil withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
             } else {
                 [self doValidateFilledData];
             }
         }];
    }else{
        
    }
}
/**
 *  This method is used to logout from the app and come back to main view controller by resetting the user data.
 *
 *  @param sender Log Out button.
 */
-(IBAction)doLogout:(id)sender
{
    HomeViewController *view;
    [CommonUtils doPopViewWithController:view withNavController:self.navigationController withAppDelegate:appDelegate];
}
/**
 *  This is the method to validate the textField data by checking the predefined rules on
 *  them. After validating save the data to database.
 */
-(void)doValidateFilledData
{
    [self.scrollView setUserInteractionEnabled:NO];
    [SVActivityIndicator hideLoader];
    [dbManager deleteDatawithTablename:TABLE_PAYMENT withDeleteColumnName:COLUMN_UNIQUE_ID withValue:[[NSUserDefaults standardUserDefaults] objectForKey:COLUMN_UNIQUE_ID]];
    NSDictionary *dictData = @{DATA: @[@{COLUMN_UNIQUE_ID:[[NSUserDefaults standardUserDefaults] objectForKey:COLUMN_UNIQUE_ID], COLUMN_FIRSTNAME: [CommonUtils checkNullString:self.txtFirstName.text],COLUMN_LASTNAME:[CommonUtils checkNullString:self.txtLastName.text],COLUMN_CARDNO:[CommonUtils checkNullString:self.stripeTextField.cardNumber],COLUMN_CVV:[CommonUtils checkNullString:self.stripeTextField.cvc],COLUMN_EXPDATE:[CommonUtils checkNullString:[NSString stringWithFormat:@"%lu/%lu",(unsigned long)self.stripeTextField.expirationMonth,(unsigned long)self.stripeTextField.expirationYear]],COLUMN_ADDRESSLINE1:[CommonUtils checkNullString:self.txtAddressLine1.text],COLUMN_ADDRESSLINE2:[CommonUtils checkNullString:self.txtAddressLine2.text],COLUMN_CITY:[CommonUtils checkNullString:self.txtCity.text],COLUMN_STATE:[CommonUtils checkNullString:self.txtState.text],COLUMN_ZIPCODE:[CommonUtils checkNullString:self.txtZipCode.text],COLUMN_COUNTRY:[CommonUtils checkNullString:self.txtCountry.text],COLUMN_COMMENT:[CommonUtils checkNullString:self.txtViewComment.text]}]};
    
    if ([dbManager saveDatawithTablename:TABLE_PAYMENT withDatabaseName:DBNAME withColumnarray:[NSMutableArray arrayWithObjects:COLUMN_UNIQUE_ID,COLUMN_FIRSTNAME,COLUMN_LASTNAME,COLUMN_CARDNO,COLUMN_CVV,COLUMN_EXPDATE,COLUMN_ADDRESSLINE1,COLUMN_ADDRESSLINE2,COLUMN_CITY,COLUMN_STATE,COLUMN_ZIPCODE,COLUMN_COUNTRY,COLUMN_COMMENT, nil] withValues:[dictData objectForKey:DATA]]) {
    };
    [self doDecorateAfterSucces:NO];
}
/**
 *  This method is used to validate the textfield data i.e. all the mandatory fields are
 *  filled, whether valid email format is followed or not and so on.
 *
 *  @return YES or NO.
 */
-(BOOL)validateText
{
    if (!([ValidateText checkTextFieldEmpty:self.txtFirstName withAlertMessage:ENTER_FIRST_NAME]) || !([ValidateText checkTextFieldEmpty:self.txtLastName withAlertMessage:ENTER_LAST_NAME]))
    {
        return NO;
    }else if (![self.stripeTextField isValid])
    {
        [CommonUtils showAlertMessageWithMessage:ALERT_VALID_CARD_DETAILS withDelegate:nil withCancelTitle:@"Ok" isOtherButton:NO withOtherButtonTitle:@"" withTag:0];
        return NO;
    }
    return YES;
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
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
