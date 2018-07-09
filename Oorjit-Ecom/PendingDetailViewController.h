//
//  PendingDetailViewController.h
//  MedMart
//
//  Created by Remya Das on 29/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loading.h"
#import "WebService.h"
#import "AppDelegate.h"
#import "OrderTableViewCell.h"
#import "PendPresImgCell.h"
#import "PendingDetailCell.h"
#import "PendingPaymentView.h"
@interface PendingDetailViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UITableView *tblDetail;
@property (strong, nonatomic) IBOutlet UIButton *btnCheck;
@property(nonatomic,strong)NSString *strID,*strStatus;
@property (strong, nonatomic) IBOutlet UIImageView *btnLine;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
- (IBAction)backAction:(id)sender;
- (IBAction)checkoutAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgLarge;
@property (strong, nonatomic) IBOutlet UIView *imgLargeView;
- (IBAction)closeAction:(id)sender;


@end
