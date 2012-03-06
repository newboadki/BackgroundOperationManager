//
//  FetchResourceOperationDelegateProtocol.h
//  BackgroundOperationManager
//
//  Created by Borja Arias Drake on 21/06/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>


@protocol FetchResourceOperationDelegateProtocol <NSObject>
//- (void) operationFailedForResourceAtURL:(NSURL*)url withError:(NSError*)error;
- (void) operationFailedWithInfoDic:(NSDictionary*)infoDic;
@end
