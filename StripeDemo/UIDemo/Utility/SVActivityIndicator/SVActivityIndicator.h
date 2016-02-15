//
//  SVActivityIndicator.h
//  HKAir
//
//  Created by Ambuj Shukla on 02/12/14.
//  Copyright (c) 2014 Rahul Gupta, Sr. Software Eng.,  CDN Software Solutions, Indore. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SVActivityIndicator : NSObject

+(void)showLoaderWithMessage:(NSString *)strMessage;

+(void)hideLoader;
@end
