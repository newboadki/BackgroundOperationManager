//
//  TableViewControllerImageDownloader.h
//  Farmacy
//
//  Created by Borja Arias Drake on 16/02/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FetchResourceOperation.h"
#import "FetchResourceOperationDelegateProtocol.h"

#define RESOURCE_DOWNLOADED_NOTIFICATION @"ResourceDownloadedNotification"

@interface ResourceOperationManager : NSObject <FetchResourceOperationDelegateProtocol>
{
	NSOperationQueue*    resourcesLoadQueue;
    NSMutableDictionary* resultsDictionary; // Where we store the results
}

@property (retain, nonatomic) NSMutableDictionary* resultsDictionary;

- (NSData*) getResourceForURL:(NSURL*)url;
- (id) initWithResultsDictionary:(NSMutableDictionary*)dic;

@end
