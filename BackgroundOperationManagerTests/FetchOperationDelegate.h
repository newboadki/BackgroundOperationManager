//
//  FetchOperationDelegate.h
//  BackgroundOperationManager
//
//  Created by Borja Arias Drake on 21/06/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//
//  See Also: http://developer.apple.com/iphone/library/documentation/Xcode/Conceptual/iphone_development/135-Unit_Testing_Applications/unit_testing_applications.html

//  Application unit tests contain unit test code that must be injected into an application to run correctly.
//  Define USE_APPLICATION_UNIT_TEST to 0 if the unit test code is designed to be linked into an independent test executable.

#import "FetchResourceOperationDelegateProtocol.h"
#import <UIKit/UIKit.h>



@interface FetchOperationDelegate : NSObject <FetchResourceOperationDelegateProtocol>
{
    BOOL calledMethodOperationDidFailWithError;
}

@property BOOL calledMethodOperationDidFailWithError;

@end
