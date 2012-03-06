#import "Kiwi.h"
#import "FetchResourceOperation.h"

SPEC_BEGIN(FetchResourceOperationSpec)

describe(@"initWithResourceURL:target:targetMethod", ^{
    
    __block FetchResourceOperation* operation;
    __block id <FetchResourceOperationDelegateProtocol> delegateMock;
    __block id url;
    
    beforeEach(^{
        url = [NSURL URLWithString:@"www.apple.com"];
        delegateMock = [KWMock nullMockForProtocol:@protocol(FetchResourceOperationDelegateProtocol)];
        operation = [[FetchResourceOperation alloc] initWithResourceURL:url 
                                                                 target:delegateMock 
                                                           targetMethod:@selector(actionToCallInDelegate)];
    });
    
    afterEach(^{
        [operation release];
    });    
    
    it(@"should set the resourceURL to the passed argument", ^{
        [[operation.resourceURL should] equal:url];
    });
    
    it(@"should set the targetObject to the passed argument", ^{
        [[operation.targetObject should] equal:delegateMock];
    });
    
    it(@"should set the resourceURL to the passed argument", ^{
        STAssertTrue(operation.targetMethod == @selector(actionToCallInDelegate), @"");
    });
});


describe(@"init", ^{
        
    it(@"should throw an exception", ^{
        STAssertThrows([[[FetchResourceOperation alloc] init] autorelease], @"");        
    });
    
});


/*describe(@"main", ^{
    
    __block FetchResourceOperation* operation;
    __block id <FetchResourceOperationDelegateProtocol> delegateMock;
    __block id url;
    
    beforeEach(^{
        url = [NSURL URLWithString:@"www.apple.com"];
        delegateMock = [KWMock nullMockForProtocol:@protocol(FetchResourceOperationDelegateProtocol)];
        operation = [[FetchResourceOperation alloc] initWithResourceURL:url 
                                                                 target:delegateMock 
                                                           targetMethod:@selector(actionToCallInDelegate)];
    });
    
    afterEach(^{
        [operation release];
    });    
    
    it(@"should send the targetMethod to the delegate if the data was sucessfully created from the url", ^{
        url = [NSURL URLWithString:@"www.apple.com"];
        delegateMock = [KWMock nullMockForProtocol:@protocol(FetchResourceOperationDelegateProtocol)];
        operation = [[FetchResourceOperation alloc] initWithResourceURL:url 
                                                                 target:delegateMock 
                                                           targetMethod:@selector(actionToCallInDelegate)];

        [[delegateMock shouldEventually] receive:@selector(performSelectorOnMainThread:withObject:waitUntilDone:)];
        [operation start];

    });
    
    it(@"should send operationFailedWithInfoDic: if the data failed to be created from the url", ^{

    });
    
});*/

SPEC_END