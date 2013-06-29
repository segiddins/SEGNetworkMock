//
//  SEGNetworkMock.m
//  SEGNetworkMock
//
//  Created by Samuel E. Giddins on 6/29/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

#import "SEGNetworkMock.h"

@implementation SEGNetworkMock

+ (instancetype)sharedNetworkMock
{
    static id sharedNetworkMock;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedNetworkMock = [[self alloc] init];
    });
    return sharedNetworkMock;
}

- (id)init
{
    if (self = [super init]) {
        _operationQueue = [[NSOperationQueue alloc] init];
        _operationQueue.name = @"SEGNetworkMock Queue";
        _operationQueue.maxConcurrentOperationCount = 5;
        _successRate = .80;
        _maxDelay = 5.0;
        _minDelay = 1.0;
    }
    return self;
}

- (void)mockObjectRequestWithMockObject:(id)mockObject completion:(void (^)(BOOL, id))completion
{
    NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
        double delayInSeconds = (CGFloat)arc4random()/RAND_MAX * self.maxDelay + self.minDelay;
        dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayInSeconds * NSEC_PER_SEC));
        dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
            if ([self isSuccess]) {
                completion(YES, mockObject);
            } else {
                completion(NO, nil);
            }
        });
    }];
    [self.operationQueue addOperation:operation];
}

- (BOOL)isSuccess
{
    CGFloat random = (float)rand() / RAND_MAX;
    return random < self.successRate;
}

@end