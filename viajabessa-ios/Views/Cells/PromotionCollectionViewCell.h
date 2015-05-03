//
//  PromotionCollectionViewCell.h
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/2/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Promotion.h"

@interface PromotionCollectionViewCell : UICollectionViewCell

- (void) configureCell:(Promotion*) promotion;

@end
