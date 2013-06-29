//
//  SEGNetworkMock.h
//  SEGNetworkMock
//
//  Created by Samuel E. Giddins on 6/29/13.
//  Copyright (c) 2013 Samuel E. Giddins. All rights reserved.
//

@interface SEGNetworkMock : NSObject

+ (instancetype)sharedNetworkMock;

@property (nonatomic, strong, readonly) NSOperationQueue *operationQueue;

@property (nonatomic, assign) CGFloat successRate;

@property (nonatomic, assign) CGFloat maxDelay;
@property (nonatomic, assign) CGFloat minDelay;

- (void)mockObjectRequestWithMockObject:(id)mockObject completion:(void (^)(BOOL success, id object))completion;

@end
