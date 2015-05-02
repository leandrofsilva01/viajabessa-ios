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

@interface ListViewController ()

@property (nonatomic, strong) NSArray *promotions;

@end

@implementation ListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self fetchPromotions];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - My methods

- (void) fetchPromotions
{
    [[PromotionsAPIClient shareClient] fetchPromotionsListSuccess:^(NSArray *promotions) {
        self.promotions = [NSArray arrayWithArray:promotions];
        dispatch_async(dispatch_get_main_queue(), ^{
            //[self.collectionView reloadData];
        });
    } failure:^(NSString *errorMsg) {
        NSLog(@"%@", errorMsg);
    }];
}

@end
