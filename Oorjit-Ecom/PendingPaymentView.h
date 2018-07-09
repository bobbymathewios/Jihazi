//
//  PendingPaymentView.h
//  MedMart
//
//  Created by Remya Das on 02/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loading.h"
#import "WebService.h"
#import "AppDelegate.h"
#import "MethodCollectionViewCell.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "MRMSDevFPiOS.h"
#import "PaymentModeViewController.h"
#import "CheckoutViewController.h"

@interface PendingPaymentView : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblYouPay;
@property (strong, nonatomic) IBOutlet UICollectionView *col;
@property (strong, nonatomic) IBOutlet UIButton *btnpay;
@property(nonatomic,strong)NSString *strID,*strAmt;
@property(nonatomic,strong)NSArray *selectedBillAdr;

- (IBAction)backAction:(id)sender;
- (IBAction)payNowAction:(id)sender;
@end
