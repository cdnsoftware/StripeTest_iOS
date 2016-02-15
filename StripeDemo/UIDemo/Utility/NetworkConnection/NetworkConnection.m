//
//  NetworkConnection.m
//  CheerWrap
//
//  Created by Ambuj Shukla on 13/10/14.
//
//

#import "NetworkConnection.h"
#import "Reachability.h"
#import "iToast.h"
#import "Constant.h"

@implementation NetworkConnection

+ (BOOL)connected
{
    Reachability *reachability = [Reachability reachabilityForInternetConnection];
    NetworkStatus networkStatus = [reachability currentReachabilityStatus];
    if (networkStatus == NotReachable) {
      [[[[iToast makeText:NetworkError] setGravity:iToastGravityCenter] setDuration:3000.0] show];
    }
    return !(networkStatus == NotReachable);
}

@end
