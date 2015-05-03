//
//  PromotionCollectionViewCell.m
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/2/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import "PromotionCollectionViewCell.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import "NSString+Plus.h"

@interface PromotionCollectionViewCell()

@property (nonatomic, weak) IBOutlet UIImageView *imgPromotion;
@property (nonatomic, weak) IBOutlet UILabel* lblTitle;
@property (nonatomic, weak) IBOutlet UILabel* lblValue;

@end

@implementation PromotionCollectionViewCell

- (void) configureCell:(Promotion*) promotion
{
    NSURL *url = nil;
    
    if (promotion.imageurl != nil)
        url = [NSURL URLWithString:promotion.imageurl];
        
    if (url != nil)
        [self.imgPromotion setImageWithURL:url placeholderImage:nil];
    [self.lblTitle setText:[promotion.title replacePlus]];
    [self.lblValue setText:[NSString stringWithFormat:@"$%@", [promotion.value replacePlus]]];
}

@end
