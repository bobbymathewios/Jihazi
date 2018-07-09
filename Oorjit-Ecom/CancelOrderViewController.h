//
//  CancelOrderViewController.h
//  Favot
//
//  Created by Remya Das on 03/08/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loading.h"
#import "WebService.h"
#import "AppDelegate.h"
#import "CancelCell.h"

@interface CancelOrderViewController : UIViewController
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *orderH;
@property (strong, nonatomic) IBOutlet UIView *actionView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollObj;
@property (strong, nonatomic) IBOutlet UIView *topObj;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnBack1;
@property (strong, nonatomic) IBOutlet UITextField *txtReason;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderID;
@property (strong, nonatomic) IBOutlet UITextView *txtText;
@property (strong, nonatomic) IBOutlet UILabel *lblReasonForCancel;
@property (strong, nonatomic) IBOutlet UILabel *lblCmtText;
@property (strong, nonatomic) IBOutlet UITableView *tblOrder;
@property (strong, nonatomic) IBOutlet UITextView *txtYourComment;
@property(nonatomic,strong)NSString *OrderID,*rid,*cancel,*type,*url,*fromDetail;
@property (strong, nonatomic) IBOutlet UITextField *txtAction;
@property (strong, nonatomic) IBOutlet UILabel *lblReason;
@property(nonatomic,strong)NSArray *array;
- (IBAction)backAction:(id)sender;
- (IBAction)submitAction:(id)sender;
@end
