//
//  FetchThumbnailOperation.m
//  Farmacy
//
//  Created by Borja Arias Drake on 06/01/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import "FetchResourceOperation.h"


@implementation FetchResourceOperation

@synthesize resourceURL, targetMethod, targetObject;


#pragma mark - Initialisers

- (id) initWithResourceURL:(NSURL *)url target:(id <FetchResourceOperationDelegateProtocol>)targClass targetMethod:(SEL)targClassMethod
{
    /***********************************************************************************************/
    /* Designated init method.                                                                     */
    /***********************************************************************************************/
	if((self = [super init]))
	{
		resourceURL = [url retain];
		targetObject = targClass;
		targetMethod = targClassMethod;
	}
	
	return self;
}


- (id) init
{
    /***********************************************************************************************/
    /* init method.                                                                                */
    /***********************************************************************************************/
    @throw @"Use initWithResourceURL:target:targetMethod: instead.";
}




#pragma mark - Operation Methods

- (void)main
{
    /***********************************************************************************************/
    /* Do the job usgin Asynchronous calls, that will be run in the background as we inherit    */
    /* from NSOperation.                                                                           */
    /***********************************************************************************************/
	NSAutoreleasePool* localPool;
	
    localPool = [[NSAutoreleasePool alloc] init];
    
    if([self isCancelled])
        return;
        
    NSError* err = nil;
    NSData*       resourceData = [[NSData alloc] initWithContentsOfURL:resourceURL options:nil error:&err];
    NSDictionary* result = [[NSDictionary alloc] initWithObjectsAndKeys:resourceData, @"resource", resourceURL, @"url", nil];				
    
    if (!err)
    {
        [(NSObject*)targetObject performSelectorOnMainThread:targetMethod withObject:result waitUntilDone:NO];
    }
    else
    {
        [targetObject operationFailedForResourceAtURL:resourceURL withError:err];
    }
    
    [resourceData release];
    [result release];
    [localPool release];
}



#pragma mark - Memory Management

- (void) dealloc
{
    /***********************************************************************************************/
    /* Tidy-up                                                                                     */
    /***********************************************************************************************/
	[resourceURL release];
    
	[super dealloc];
}

@end
