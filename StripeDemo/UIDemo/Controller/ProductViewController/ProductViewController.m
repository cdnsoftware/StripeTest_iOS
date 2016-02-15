//
//  ProductViewController.m
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "ProductViewController.h"
#import "ProductsView.h"
#import "Constant.h"
#import "OrderViewController.h"
#import "CommonUtils.h"
#import "AppDelegate.h"
#import "HomeViewController.h"

@interface ProductViewController ()<SelectProductDelegate>

{
    AppDelegate *appDelegate;
    HomeViewController *homeView;
}
@property (nonatomic,strong) IBOutlet ProductsView *productsView;
@property (nonatomic,strong) NSDictionary *dictProductData;

@end

@implementation ProductViewController

#pragma mark - view life cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    [self decorateUI];
    [self configureInitialParameters];
    [self decorateNavigationBar];
}

#pragma mark Private Methods

/**
 *  This method is used to decorate the UI controls like labels, textfield, buttons etc...
 *  Decorating them by putting text, images, background color and other stuff according to
 *  UI.
 */
-(void)decorateUI
{
    self.title = TITLE_PRODUCTS;
    self.navigationItem.hidesBackButton = YES;
}

/**
 *  This method is used to configure the initial parameters like allocating memory to some
 *  variable, feeding data like to Dictionary or Array.Settings Delegates to objects so we
 *  get a callback...
 */
-(void)configureInitialParameters
{
    appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    self.dictProductData = @{@"productData": @[@{@"imgProduct": @"product1.png",@"idProduct":@"1"},@{@"imgProduct": @"product2.png",@"idProduct":@"2"},@{@"imgProduct": @"product2.png",@"idProduct":@"3"},@{@"imgProduct": @"product1.png",@"idProduct":@"4"},@{@"imgProduct": @"product1.png",@"idProduct":@"5"},@{@"imgProduct": @"product2.png",@"idProduct":@"6"},@{@"imgProduct": @"product2.png",@"idProduct":@"7"},@{@"imgProduct": @"product1.png",@"idProduct":@"8"}]};
    [self.productsView setDelegate:self];
    [self.productsView doSetData:[self.dictProductData objectForKey:@"productData"]];
}
-(void)decorateNavigationBar
{
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
 *  This methods is used for navigating to OrderView to place order by entering the details 
 *  of the card...
 *
 *  @param dictProduct Data to send
 */
-(void)doSelectProduct:(NSDictionary *)dictProduct
{
    OrderViewController *viewC = [[OrderViewController alloc] initWithNibName:@"OrderViewController" bundle:nil];
    [self.navigationController pushViewController:viewC animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
