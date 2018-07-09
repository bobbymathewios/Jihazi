//
//  WalletViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 16/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "AppDelegate.h"
#import "WalletTableViewCell.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "WalletCouponCell.h"
@interface WalletViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblc;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *height;
@property (strong, nonatomic) IBOutlet UIView *cardview;
@property (strong, nonatomic) IBOutlet UIImageView *imglines;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIView *couponView;
@property (strong, nonatomic) IBOutlet UIView *headderView;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *lblWalletBalance;
@property (strong, nonatomic) IBOutlet UILabel *lblGiftCards;
@property (strong, nonatomic) IBOutlet UILabel *lblHave;
@property (strong, nonatomic) IBOutlet UIButton *btnAddGift;
@property (strong, nonatomic) IBOutlet UILabel *lblTrans;
@property (strong, nonatomic) IBOutlet UITableView *tblWallet;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollObj;
@property (strong, nonatomic) IBOutlet UILabel *lblaed;
@property (strong, nonatomic) IBOutlet UITextField *txtCode;
@property (strong, nonatomic) IBOutlet UIButton *btnRedeem;
@property (strong, nonatomic) IBOutlet UIImageView *imgwallet;
@property (strong, nonatomic) IBOutlet UIButton *btnApply;
@property (strong, nonatomic) IBOutlet UIImageView *imgEngAdd;
@property (strong, nonatomic) IBOutlet UIImageView *imgAraAdd;
@property (strong, nonatomic) IBOutlet UILabel *lblAddGiftCard;
@property (strong, nonatomic) IBOutlet UIButton *b1;
- (IBAction)backAction:(id)sender;
- (IBAction)addGiftAction:(id)sender;
- (IBAction)RedeemAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)applyAction:(id)sender;

@end
