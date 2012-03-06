//
//  TableViewControllerImageDownloader.m
//  Farmacy
//
//  Created by Borja Arias Drake on 16/02/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import "ResourceOperationManager.h"


@interface ResourceOperationManager()
- (void) storeResourceForURL:(NSDictionary*)result;
@end



@implementation ResourceOperationManager

@synthesize resultsDictionary;



#pragma mark - Initialisers

- (id) initWithResultsDictionary:(NSMutableDictionary*)dic
{
    /***********************************************************************************************/
	/* Create and configure the queue.															   */
	/***********************************************************************************************/
	if((self = [super init]))
	{
		resourcesLoadQueue = [[NSOperationQueue alloc] init];
		[resourcesLoadQueue setMaxConcurrentOperationCount:1];
        [self setResultsDictionary:dic];
	}
	
	return self;
}



#pragma mark - Operation Methods

- (NSData*) getResourceForURL:(NSURL*)url
{
	/***********************************************************************************************/
	/* If we haven't started downloading the resource, create and start an NSOperation for it.     */
    /* TODO: receive new argument 'index'. sometimes the user of this class will call this medhod
     repitedly, so when the result is ready it'd be nice to retrieve that index to avoid a search
     process in the user of this class. The get the result, the know the index, they update that.  
     Possibly the main application of this would be related with tableViews.                       */
	/***********************************************************************************************/						
	id object = [resultsDictionary objectForKey:url];

	if(object == nil)
	{
		// we don't have a resource yet so store a temporary NSString object for the url		
		[resultsDictionary setObject:@"Fetching" forKey:url];
		
		FetchResourceOperation* fetchResourceOp = [[FetchResourceOperation alloc] initWithResourceURL:url 
                                                                                               target:self 
                                                                                         targetMethod:@selector(storeResourceForURL:)];
		[resourcesLoadQueue addOperation:fetchResourceOp];
		
		[fetchResourceOp release];
	}
	else
	{
		// we have an object but need to determine what kind of object
		if(![object isKindOfClass:[NSData class]])
		{
			// object is the 'Fetching' string, not our final data.
			object = nil;
		}
	}

	return object;
}


- (void) storeResourceForURL:(NSDictionary*)result
{
	/***********************************************************************************************/
	/* This method gets called when a FetchResourceOperation finishes.                             */
    /* We receive a dictionary that has two keys {'url', 'resource'}                               */
	/***********************************************************************************************/
	NSURL* url = [result objectForKey:@"url"];
	NSData* resource = [result objectForKey: @"resource"];
    
	if(url && resource)
	{
		[resultsDictionary setObject:resource forKey:url];	
        NSDictionary* userInfo = [NSDictionary dictionaryWithObject:url forKey:@"url"];
        NSNotification* notif = [NSNotification notificationWithName:RESOURCE_DOWNLOADED_NOTIFICATION object:nil userInfo:userInfo];
		[[NSNotificationCenter defaultCenter] postNotification:notif];
	}
}



#pragma mark - FetchResourceOperationDelegateProtocol

- (void) operationFailedWithInfoDic:(NSDictionary*)infoDic
{
    NSLog(@"operationFailedWithInfoDic");
}


- (void) operationFailedForResourceAtURL:(NSURL*)url withError:(NSError*)error
{
	/***********************************************************************************************/
	/* Handle the operation error.                                                                 */
	/***********************************************************************************************/							

}



#pragma mark - Memory Management

- (void) dealloc
{
	/***********************************************************************************************/
	/* Tidy-up                                                                                     */
	/***********************************************************************************************/							
	[resourcesLoadQueue release];
    [self setResultsDictionary:nil];
    
	[super dealloc];
	
}

@end
