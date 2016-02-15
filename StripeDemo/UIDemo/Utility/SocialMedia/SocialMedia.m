//
//  SocialMedia.m
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import "SocialMedia.h"
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>

@implementation SocialMedia

//----------------------------------Facebook Starts-------------------------------------//

-(void)doLoginInFacebook:(UIViewController *)viewController
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login logInWithReadPermissions:@[@"email"] handler:^(FBSDKLoginManagerLoginResult *result, NSError *error)
     {
         if (error)
         {
             // Process error
         }
         else if (result.isCancelled)
         {
             // Handle cancellations
         }
         else
         {
             NSLog(@"result is:%@",result);
             [self fetchUserInfo];
         }
     }];
}
-(void)fetchUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"resultis:%@",result);
                 [self.delegate doGetFacebookUserInfo:result];
             }
             else
             {
                 [self.delegate doGetFacebookUserInfo:nil];
                 NSLog(@"Error %@",error);
             }
         }];
    }
}

//----------------------------------Facebook Ends-------------------------------------//


@end
