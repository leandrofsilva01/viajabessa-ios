//
//  PromotionsAPIClient.h
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/1/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseAPIClient.h"

typedef void (^SuccessPromotionsListBlock) (NSArray *promotions);
typedef void (^FailurePromotionsBlock) (NSString *errorMsg);

@interface PromotionsAPIClient : BaseAPIClient

+ (PromotionsAPIClient *)shareClient;

- (void)fetchPromotionsListSuccess:(SuccessPromotionsListBlock)success failure:(FailurePromotionsBlock)failure;

@end
