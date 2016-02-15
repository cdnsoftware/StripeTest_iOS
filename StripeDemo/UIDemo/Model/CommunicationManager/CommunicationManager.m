//
//  CommunicationManager.m
//  ClockenFlap
//
//  Created by Ambuj Shukla on 15/09/15.
//  Copyright (c) 2015 Test. All rights reserved.
//

#import "CommunicationManager.h"
#import <AFNetworking/AFHTTPSessionManager.h>
#import "Constant.h"

@implementation CommunicationManager

static CommunicationManager *_sharedInstance = nil;

+ (CommunicationManager*)sharedInstance
{
    if (_sharedInstance != nil) {
        return _sharedInstance;
    }
    @synchronized(self) {
        if (_sharedInstance == nil) {
            _sharedInstance = [[self alloc] init];
        }
    }
    return _sharedInstance;
}

-(id)init
{
    if (self) {
    }
    return self;
}
-(void)postResponseWithParameter:(id)parameters withMethodName:(NSString*)methodName
{
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",BASE_URL,methodName]];

    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    [manager setRequestSerializer:[AFJSONRequestSerializer serializer]];
    [manager setResponseSerializer:[AFJSONResponseSerializer serializer]];

    [manager POST:url.absoluteString parameters:parameters progress:nil success:^(NSURLSessionTask *task, id responseObject){
        [self.delegate setParsedData:responseObject];
    } failure:^(NSURLSessionTask *operation, NSError *error)
     {
         [self.delegate setParsedData:nil];
     }];
}
@end
