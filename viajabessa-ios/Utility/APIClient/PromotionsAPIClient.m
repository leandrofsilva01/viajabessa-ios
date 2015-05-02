//
//  PromotionsAPIClient.m
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/1/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import "PromotionsAPIClient.h"
#import "EnvironmentConstants.h"
#import "Promotion.h"
#import "MTLJSONAdapter.h"

@implementation PromotionsAPIClient

+ (PromotionsAPIClient *)shareClient
{
    static PromotionsAPIClient *shareClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareClient = [[self alloc] init];
    });
    return shareClient;
}

- (id)init
{
    if (self == [super init])
    {
        [self configureAPIClientWithUrl:kAPIProductionBaseUrl];
    }
    return self;
}

- (void)fetchPromotionsListSuccess:(SuccessPromotionsListBlock)success failure:(FailurePromotionsBlock)failure
{
    [super GET:@"promotions/androidVersion/deviceBrand/deviceModel" params:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *promotionsArr = [(NSDictionary *)responseObject objectForKey:@"promotions"];
        
        NSError *error = nil;
        NSArray *promotions = [MTLJSONAdapter modelsOfClass:[Promotion class] fromJSONArray:promotionsArr error:&error];
        
        success(promotions);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        failure([error localizedDescription]);
    }];
}

@end
