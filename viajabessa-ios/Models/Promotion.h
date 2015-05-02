//
//  Promotion.h
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/2/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mantle.h"

@interface Promotion : MTLModel <MTLJSONSerializing>

@property(nonatomic, assign) NSInteger id_;
@property(nonatomic, strong) NSString *imageurl;
@property(nonatomic, strong) NSString *package_descripton;
@property(nonatomic, strong) NSString *package_name;
@property(nonatomic, strong) NSString *title;
@property(nonatomic, strong) NSString *value;

@end
