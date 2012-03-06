//
//  FetchOperationDelegate.m
//  BackgroundOperationManager
//
//  Created by Borja Arias Drake on 21/06/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import "FetchOperationDelegate.h"


@implementation FetchOperationDelegate

@synthesize calledMethodOperationDidFailWithError;
- (void) operationFailedWithInfoDic:(NSDictionary*)infoDic
{
    self->calledMethodOperationDidFailWithError = YES;
}

@end
