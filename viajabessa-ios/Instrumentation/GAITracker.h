//
//  GAITracker.h
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/3/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GAITracker : NSObject

+ (GAITracker*) sharedInstance;

- (void)openScreen:(NSString*) screenName;
- (void)sendEventWithCategory:(NSString*)category andAction:(NSString*)action andLabel:(NSString*)label;

@end
