//
//  CommunicationManager.h
//  ClockenFlap
//
//  Created by Ambuj Shukla on 15/09/15.
//  Copyright (c) 2015 Test. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol CommunicationDelegate <NSObject>

@optional
- (void) setParsedData:(NSDictionary *)jsonData;

@end

@interface CommunicationManager : NSObject
@property (nonatomic, assign) id<CommunicationDelegate> delegate;

-(void)postResponseWithParameter:(id)parameters withMethodName:(NSString*)methodName;

+ (CommunicationManager*)sharedInstance;

@end
