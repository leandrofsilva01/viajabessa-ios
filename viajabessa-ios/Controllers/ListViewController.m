//
//  ListViewController.m
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/1/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import "ListViewController.h"
#import "PromotionsAPIClient.h"
#import "Promotion.h"
#import "NSString+Plus.h"
#import "PromotionCollectionViewCell.h"
#import "DetailViewController.h"
#import "GAITracker.h"

@interface ListViewController ()

@property (nonatomic, strong) NSArray *promotions;
@property (nonatomic, weak) IBOutlet UICollectionView *collectionView;

@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"promo_list_title", nil);
    
    [self fetchPromotions];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    [[GAITracker sharedInstance] openScreen:@"ListView"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detailSegue"])
    {
        DetailViewController* detailViewController = segue.destinationViewController;
        detailViewController.promotion = (Promotion*) sender;
    }
}

#pragma mark - My methods

- (void) fetchPromotions
{
    [[PromotionsAPIClient shareClient] fetchPromotionsListSuccess:^(NSArray *promotions) {
        self.promotions = [NSArray arrayWithArray:promotions];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    } failure:^(NSString *errorMsg) {
        NSLog(@"%@", errorMsg);
    }];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [self.promotions count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Promotion *promotion = [self.promotions objectAtIndex:indexPath.row];
    
    PromotionCollectionViewCell *cell = (PromotionCollectionViewCell *)[self.collectionView dequeueReusableCellWithReuseIdentifier:@"Cell" forIndexPath:indexPath];
    [cell configureCell:promotion];
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(_collectionView.frame.size.width, 91.0f);
}

#pragma mark - UICollectionViewDelegate

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    Promotion *promotion = [self.promotions objectAtIndex:indexPath.row];
    
    [[GAITracker sharedInstance] sendEventWithCategory:@"UX" andAction:promotion.title andLabel:promotion.title];
    
    [self performSegueWithIdentifier:@"detailSegue" sender:promotion];
}

@end
