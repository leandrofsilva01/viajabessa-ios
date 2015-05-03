//
//  NSString+Plus.m
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/2/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import "NSString+Plus.h"

@implementation NSString (Plus)

- (NSString*) replacePlus
{
    return [[self stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding] stringByReplacingOccurrencesOfString:@"+" withString:@" "];
}

@end
