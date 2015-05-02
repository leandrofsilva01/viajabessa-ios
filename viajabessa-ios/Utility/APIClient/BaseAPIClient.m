//
//  BaseAPIClient.m
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/1/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import "BaseAPIClient.h"
#import <AFNetworkReachabilityManager.h>
#import <AFNetworkActivityIndicatorManager.h>
#import "EnvironmentConstants.h"

@interface BaseAPIClient ()
{
    AFHTTPRequestOperationManager *manager;
}
@end

@implementation BaseAPIClient

#pragma mark - Configure

- (void)configureAPIClient
{
    [self configureRequestOperationManagerWithHttps:YES];
    [self baseConfiguration];
}

- (void)configurePostClient
{
    [self configureRequestOperationManagerWithHttps:YES];
    [self basePostConfiguration];
}

- (void)configureAPIClientWithoutHttps
{
    [self configureRequestOperationManagerWithHttps:NO];
    [self baseConfiguration];
}

- (void)configureAPIClientWithUrl:(NSString *)url
{
    AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    NSURL *baseURL = url ? [NSURL URLWithString:url] : nil;
    
    if (!baseURL)
        return;
    
    manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL];
    
    [self configureReachability];
    [self configureRequestSerializers];
}

- (void)basePostConfiguration
{
    [self configureReachability];
    [self configurePostRequestSerializers];
}

- (void)baseConfiguration
{
    [self configureReachability];
    [self configureRequestSerializers];
}

- (void)configureReachability
{
    NSOperationQueue *operationQueue = manager.operationQueue;
    [manager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        [operationQueue setSuspended:NO];
        
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
            case AFNetworkReachabilityStatusReachableViaWiFi:
                [operationQueue setSuspended:NO];
                break;
            case AFNetworkReachabilityStatusNotReachable:
            default:
                [operationQueue setSuspended:YES];
                break;
        }
    }];
}

- (void)configureRequestOperationManagerWithHttps:(BOOL)isHttps
{
    AFNetworkActivityIndicatorManager.sharedManager.enabled = YES;
    NSURL *baseURL = [NSURL URLWithString:kAPIProductionBaseUrl];
    manager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:baseURL ];
    if(isHttps)
        manager.securityPolicy.allowInvalidCertificates = YES;
}

- (void)configureRequestSerializers
{
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
}

- (void)configurePostRequestSerializers
{
    manager.requestSerializer = [AFHTTPRequestSerializer serializer];
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
}

#pragma mark - Methods

- (void)GET:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [manager GET:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, operation.responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        if ([self hadFailStatusCode:operation]){
            [self handleFailStatusCode:operation];
            failure(operation,error);
        } else
            failure(operation,error);
    }];
}

- (void)POST:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [manager POST:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, operation.responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

- (void)PUT:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [manager PUT:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, operation.responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

- (void)DELETE:(NSString*)url params:(NSDictionary*)params success:(SuccessBlock)success failure:(FailureBlock)failure
{
    [manager DELETE:url parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        success(operation, operation.responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure(operation,error);
    }];
}

#pragma mark - Error Handler

- (BOOL)hadInvalidToken:(AFHTTPRequestOperation *)operation
{
    NSInteger statusCode = operation.response.statusCode;
    if(statusCode == 403)
        return YES;
    return NO;
}

- (BOOL)hadFailStatusCode:(AFHTTPRequestOperation *)operation
{
    NSInteger statusCode = operation.response.statusCode;
    if(statusCode == 500 || statusCode == 404)
        return YES;
    return NO;
}

-(void)handleFailStatusCode:(AFHTTPRequestOperation *)operation
{
}

@end

