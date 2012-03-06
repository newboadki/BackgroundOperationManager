//
//  FetchThumbnailOperation.h
//  Farmacy
//
//  Created by Borja Arias Drake on 06/01/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "FetchResourceOperationDelegateProtocol.h"

@interface FetchResourceOperation : NSOperation
{
	NSURL* resourceURL; 
	id <FetchResourceOperationDelegateProtocol>	targetObject; 
	SEL	   targetMethod;
}

- (id)initWithResourceURL:(NSURL *)url target:(id)targClass targetMethod:(SEL)targClassMethod;

@property (nonatomic, retain) NSURL* resourceURL; 
@property (nonatomic, assign) id <FetchResourceOperationDelegateProtocol>	targetObject; 
@property (nonatomic, assign) SEL	   targetMethod;



@end
