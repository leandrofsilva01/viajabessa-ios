//
//  BaseAPIClient.h
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/1/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AFNetworking/AFNetworking.h>

typedef void (^SuccessBlock)(AFHTTPRequestOperation *operation, id responseObject);
typedef void (^FailureBlock)(AFHTTPRequestOperation *operation, NSError *error);

@interface BaseAPIClient : NSObject

- (void)configureAPIClient;
- (void)configurePostClient;
- (void)configureAPIClientWithoutHttps;
- (void)configureAPIClientWithUrl:(NSString *)url;

- (void)GET:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success failure:(FailureBlock)failure;
- (void)POST:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success failure:(FailureBlock)failure;
- (void)PUT:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success failure:(FailureBlock)failure;
- (void)DELETE:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success failure:(FailureBlock)failure;

@end

