//
//  SVActivityIndicator.m
//  HKAir
//
//  Created by Ambuj Shukla on 02/12/14.
//  Copyright (c) 2014 Rahul Gupta, Sr. Software Eng.,  CDN Software Solutions, Indore. All rights reserved.
//

#import "SVActivityIndicator.h"
#import "AppDelegate.h"
#import "SVProgressHUD.h"

@implementation SVActivityIndicator

+(void)showLoaderWithMessage:(NSString *)strMessage
{
        [SVProgressHUD showWithStatus:strMessage maskType:SVProgressHUDMaskTypeBlack];
}

+(void)hideLoader
{
    [SVProgressHUD dismiss];
}

@end
