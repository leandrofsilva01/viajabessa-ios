//
//  Promotion.m
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/2/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import "Promotion.h"

@implementation Promotion

+ (NSDictionary *)JSONKeyPathsByPropertyKey
{
    return @{
             @"id_": @"id",
             @"imageurl": @"imageurl",
             @"package_descripton": @"package_descripton",
             @"package_name": @"package_name",
             @"title": @"title",
             @"value": @"value"
             };
}

@end
