//
//  GAITracker.m
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/3/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import "GAITracker.h"
#import "GAI.h"
#import "GAIDictionaryBuilder.h"
#import "GAIFields.h"
#import "EnvironmentConstants.h"

@interface GAITracker()

@property (nonatomic, strong) id tracker;

@end

@implementation GAITracker

+ (GAITracker*) sharedInstance
{
    static GAITracker *_sharedInstance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedInstance = [[GAITracker alloc] init];
        [_sharedInstance configureTracker];
    });
    
    return _sharedInstance;
}

#pragma mark - Generic Tracker

- (void)configureTracker
{
    [GAI sharedInstance].trackUncaughtExceptions = YES;
    [GAI sharedInstance].dispatchInterval = 20;
    
    self.tracker = [[GAI sharedInstance] trackerWithTrackingId:kTrackingID];
    
    [self sendEventWithCategory:@"UX" andAction:@"AppStart" andLabel:@"AppStart"];
}

- (void)openScreen:(NSString*)screenName
{
    [self.tracker set:kGAIScreenName value:screenName];
    [self.tracker send:[[GAIDictionaryBuilder createAppView] build]];
}

- (void)sendEventWithCategory:(NSString*)category andAction:(NSString*)action andLabel:(NSString*)label
{
    [self.tracker send:[[GAIDictionaryBuilder createEventWithCategory:category action:action label:label value:nil] build]];
}

@end
