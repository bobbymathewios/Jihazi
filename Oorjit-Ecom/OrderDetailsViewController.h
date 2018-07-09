//
//  OrderDetailsViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
//#import "UIButton+WebCache.h"
//#import <SDWebImage/UIImageView+WebCache.h>
//#import "UIImageView+WebCache.h"
#import "ShippingHistory.h"
#import "Loading.h"
#import "WebService.h"
#import "InvoiceDetailCell.h"
#import "OrderAddressCell.h"
#import "OrderItemCell.h"
#import "orderPriceCell.h"
#import <MessageUI/MessageUI.h>
#import "CancelOrderViewController.h"
#import "UploadPrescription.h"
#import "PreOrderCell.h"

@interface OrderDetailsViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnSh;
@property (strong, nonatomic) IBOutlet UIView *vv;
@property (strong, nonatomic) IBOutlet UIButton *btnOk;
@property (strong, nonatomic) IBOutlet UILabel *lblTi;
@property (strong, nonatomic) IBOutlet UITextView *txt;
@property (strong, nonatomic) IBOutlet UIView *DetailView;
@property (strong, nonatomic) IBOutlet UIView *topViewObj;
@property (strong, nonatomic) IBOutlet UIButton *btnback;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnBack1;
@property (strong, nonatomic) IBOutlet UITableView *tblDetail;
@property (strong, nonatomic) IBOutlet UIButton *btnReorder;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnInvoice;

@property(nonatomic,strong)NSString *orderID,*rid,*url;
@property(nonatomic,strong)NSArray *detailsArray;

- (IBAction)backAction:(id)sender;
- (IBAction)reorderAction:(id)sender;
- (IBAction)cancelOrderAction:(id)sender;
- (IBAction)okayAction:(id)sender;
- (IBAction)historyAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgLarge;
@property (strong, nonatomic) IBOutlet UIView *imgLargeView;
- (IBAction)closeAction:(id)sender;
- (IBAction)invoiceCopyAction:(id)sender;
@end
