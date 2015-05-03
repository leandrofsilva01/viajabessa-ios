//
//  DetailViewController.m
//  viajabessa-ios
//
//  Created by Leandro Silva on 5/2/15.
//  Copyright (c) 2015 Leandro. All rights reserved.
//

#import "DetailViewController.h"
#import "NSString+Plus.h"
#import <AFNetworking/UIImageView+AFNetworking.h>
#import <QuartzCore/QuartzCore.h>

@interface DetailViewController ()

@property (nonatomic, weak) IBOutlet UIImageView *imgPromotion;
@property (nonatomic, weak) IBOutlet UILabel* lblTitle;
@property (nonatomic, weak) IBOutlet UITextView* tvDescription;
@property (nonatomic, weak) IBOutlet UILabel* lblValue;
@property (nonatomic, weak) IBOutlet UIButton *btnBuy;

- (IBAction) buy:(id) sender;

@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = NSLocalizedString(@"promo_detail_title", nil);
    [self.btnBuy setTitle:NSLocalizedString(@"promo_btn_buy", nil) forState:UIControlStateNormal];
    
    NSURL *url = nil;
    
    if (self.promotion.imageurl != nil)
        url = [NSURL URLWithString:self.promotion.imageurl];
    
    if (url != nil)
        [self.imgPromotion setImageWithURL:url placeholderImage:nil];
    [self.lblTitle setText:[self.promotion.title replacePlus]];
    [self.tvDescription setText:[self.promotion.package_descripton replacePlus]];
    [self.lblValue setText:[NSString stringWithFormat:@"$%@", [self.promotion.value replacePlus]]];
    
    self.btnBuy.layer.cornerRadius = 5;
    self.btnBuy.clipsToBounds = YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark - Actions

- (IBAction) buy:(id) sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:NSLocalizedString(@"alert_title", nil) message:NSLocalizedString(@"alert_msg", nil) delegate:self cancelButtonTitle:NSLocalizedString(@"alert_btn_ok", nil) otherButtonTitles:nil];
    [alert show];
}

#pragma mark - UIAlertViewDelegate

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
