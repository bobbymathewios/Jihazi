//
//  SubscriptionDetailViewController.h
//  MedMart
//
//  Created by Remya Das on 09/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Loading.h"
#import "WebService.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "SubCell.h"
#import "SubDateCell.h"
#import "SubDetCell.h"
#import "SubPauseCell.h"
#import "OrderAddressCell.h"
#import "CheckoutViewController.h"
@interface SubscriptionDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblSid;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblitem;
@property (strong, nonatomic) IBOutlet UILabel *lblrun;
@property (strong, nonatomic) IBOutlet UILabel *lbllast;
@property (strong, nonatomic) IBOutlet UILabel *lblnext;
@property (strong, nonatomic) IBOutlet UITextView *txtShip;
@property (strong, nonatomic) IBOutlet UITextView *txtBill;
@property (strong, nonatomic) IBOutlet UIButton *btnSuscription;
@property (strong, nonatomic) IBOutlet UIButton *btnorder;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine;
@property (strong, nonatomic) IBOutlet UITableView *tblList;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollObj;


@property(nonatomic,strong)NSString *SID;
- (IBAction)pauseAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)yourSubscriptionAction:(id)sender;
- (IBAction)yourorderAction:(id)sender;
- (IBAction)backAction:(id)sender;

@end
