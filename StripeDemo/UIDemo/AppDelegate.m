//
//  AppDelegate.m
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKShareKit/FBSDKShareKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "Constant.h"
#import <Stripe/Stripe.h>
#import "ProductViewController.h"

@interface AppDelegate ()

@property (nonatomic,strong) ProductViewController *productView;

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    //-------------------------------Facebook
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    //-------------------------------Facebook
    //Stripe Publish Key
    [Stripe setDefaultPublishableKey:Stripe_Pub_Key];
    //Stripe Publish Key
    
    [self checkAndCreateDatabase];
    
    [self doCheckAutoLogin];
    return YES;
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

-(void)checkAndCreateDatabase
{
    self.databaseName = DBNAME;
    NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [documentPaths objectAtIndex:0];
    self.databasePath = [documentDir stringByAppendingPathComponent:self.databaseName];
    
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    success = [fileManager fileExistsAtPath:self.databasePath];
    
    NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:self.databaseName];
    NSError * err;
    [fileManager copyItemAtPath:databasePathFromApp toPath:self.databasePath error:&err];
}

-(void)doCheckAutoLogin
{
    if ([[[NSUserDefaults standardUserDefaults] objectForKey:@"userToken"] length]>0) {
        UIStoryboard *story;
            story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ProductViewController *channelView=[story instantiateViewControllerWithIdentifier:PRODUCTVIEWIDENTIFIER];
        
        UINavigationController *c = (UINavigationController*)[story
                                                              instantiateViewControllerWithIdentifier: ROOT_NAVIGATION_IDENTIFIER];
        [c setViewControllers:[NSArray arrayWithObject:channelView] animated:NO];
        self.productView = channelView;
        self.window.rootViewController=c;
    }
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
