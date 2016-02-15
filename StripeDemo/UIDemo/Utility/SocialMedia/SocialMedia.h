//
//  SocialMedia.h
//  UIDemo
//
//  Created by Ambuj Shukla on 11/02/16.
//  Copyright © 2016 CDN. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol SocialMediaDelegates <NSObject>

-(void)doGetFacebookUserInfo:(NSDictionary *)dictInfo;

@end

@interface SocialMedia : NSObject

@property (nonatomic,weak) id <SocialMediaDelegates> delegate;

-(void)doLoginInFacebook:(UIViewController *)viewController;

@end
