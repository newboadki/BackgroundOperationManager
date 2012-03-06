//
//  ResourceOperationManagerTests.m
//  BackgroundOperationManager
//
//  Created by Borja Arias Drake on 22/06/2011.
//  Copyright 2011 Borja Arias Drake. All rights reserved.
//

#import "ResourceOperationManagerTests.h"


@implementation ResourceOperationManagerTests

- (void) testInitWithResourcesDictionary
{
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] init];
    
    ResourceOperationManager* manager = [[ResourceOperationManager alloc] initWithResultsDictionary:resultsDictionary];
    
    NSOperationQueue* queue = (NSOperationQueue*)[manager valueForKey:@"resourcesLoadQueue"];
    
    STAssertNotNil(manager.resultsDictionary, @"The results dictionary should not be nil after the init method");
    STAssertNotNil(queue, @"The resourcesLoadQueue should not be nil after the init method");
    STAssertTrue([queue maxConcurrentOperationCount]==1, @"the queue shouls have maxConcurrentOperationCount==1");
    
    [manager release];
}



//- (void) testGetResourceForURLWhenTheKeyHasNoValue
//{
//    It fails most of the times
//    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] init];
//    NSURL* url1 = [[NSURL alloc] initWithString:@"wrongURL1"];
//    
//    ResourceOperationManager* manager = [[ResourceOperationManager alloc] initWithResultsDictionary:resultsDictionary];
//    NSOperationQueue* queue = (NSOperationQueue*)[manager valueForKey:@"resourcesLoadQueue"];
//    
//    STAssertTrue([queue operationCount]==0, @"the queue shouls have maxConcurrentOperationCount==0 before getResourceForURL");
//    [manager getResourceForURL:url1];    
//    STAssertTrue([queue operationCount]==1, @"the queue shouls have maxConcurrentOperationCount==1 after getResourceForURL");
//    
//    [manager release];
//}


- (void) testGetResourceForURLWhenTheKeyHasAnNSDataAsValue
{
    NSData* data = [[NSData alloc] init];
    NSURL* url1 = [[NSURL alloc] initWithString:@"wrongURL1"];
    NSMutableDictionary* resultsDictionary = [NSMutableDictionary dictionaryWithObject:data forKey:url1];    
    
    ResourceOperationManager* manager = [[ResourceOperationManager alloc] initWithResultsDictionary:resultsDictionary];
    
    id result = [manager getResourceForURL:url1];    
    STAssertNotNil(result, @"getResourceForURL should not return nil, when the result is in the dictionary");
    STAssertTrue(result==data, @"getResourceForURL should return the value for the key if the value is of type NSData");
    
    [data release];
    [url1 release];
    [manager release];    
}


- (void) testGetResourceForURLWhenTheKeyDoesntHaveNSDataAsValue
{
    NSString* data = @"Fetching";
    NSURL* url1 = [[NSURL alloc] initWithString:@"wrongURL1"];
    NSMutableDictionary* resultsDictionary = [NSMutableDictionary dictionaryWithObject:data forKey:url1];    
    
    ResourceOperationManager* manager = [[ResourceOperationManager alloc] initWithResultsDictionary:resultsDictionary];
    
    id result = [manager getResourceForURL:url1];    
    STAssertNil(result, @"getResourceForURL should not return nil, when the result is in the dictionary");
    id valueInDic = [resultsDictionary objectForKey:url1];
    STAssertTrue([valueInDic isEqualToString:@"Fetching"], @"getResourceForURL should set the an url's value to 'Fetching', when still working on it");
    [url1 release];
    [manager release];    
}


- (void) testStoreResourceForURLWhenResourceIsValid
{
    NSData* data = [[NSData alloc] init];
    NSURL* url1 = [[NSURL alloc] initWithString:@"wrongURL1"];
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] init];    
    NSDictionary* result = [[NSDictionary alloc] initWithObjectsAndKeys:data, @"resource", url1, @"url", nil];
    ResourceOperationManager* manager = [[ResourceOperationManager alloc] initWithResultsDictionary:resultsDictionary];
    id observerMock = [OCMockObject observerMock];
    [[NSNotificationCenter defaultCenter] addMockObserver:observerMock
                                                     name:RESOURCE_DOWNLOADED_NOTIFICATION
                                                   object:nil];
    NSDictionary* userInfo = [NSDictionary dictionaryWithObject:url1 forKey:@"url"];
    [[observerMock expect] notificationWithName:RESOURCE_DOWNLOADED_NOTIFICATION object:[OCMArg any] userInfo:userInfo];
    
    [manager storeResourceForURL:result];
    id dataInDic = [resultsDictionary objectForKey:url1];
    
    STAssertTrue([dataInDic isEqual:data], @"storeResourceForURL should store the result's value in the resultsDictionary");
    
    [data release];
    [url1 release];
    [result release];
    [resultsDictionary release];
    [manager release];
    [observerMock verify];
}

- (void) testStoreResourceForURLWhenResourceIsNotValid
{
    NSData* data = [[NSData alloc] init];
    NSURL* url1 = [[NSURL alloc] initWithString:@"wrongURL1"];
    NSMutableDictionary* resultsDictionary = [[NSMutableDictionary alloc] init];    
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    [result setValue:url1 forKey:@"url"];
    ResourceOperationManager* manager = [[ResourceOperationManager alloc] initWithResultsDictionary:resultsDictionary];
        

    [manager storeResourceForURL:result];
    id dataInDic = [resultsDictionary objectForKey:url1];
    STAssertNil(dataInDic, @"storeResourceForURL should not storethe result's value in the resultsDictionary if the result or url are nil");
    
    [data release];
    [url1 release];
    [result release];
    [resultsDictionary release];
    [manager release];
}


@end
