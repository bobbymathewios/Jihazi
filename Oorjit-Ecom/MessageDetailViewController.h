//
//  MessageDetailViewController.h
//  Jihazi
//
//  Created by Princy on 12/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MessageDetailViewController.h"
#import "MessageDetailCell.h"

@interface MessageDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lbltitle;

@property(nonatomic,strong)NSString *MID,*MName,*OID;
@property (weak, nonatomic) IBOutlet UILabel *lblPname;
@property (weak, nonatomic) IBOutlet UILabel *lblReason;
@property (weak, nonatomic) IBOutlet UIWebView *web;
@property (weak, nonatomic) IBOutlet UILabel *lblMaintitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMerchant;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UITableView *tbl;

- (IBAction)backAction:(id)sender;
- (IBAction)replayAction:(id)sender;
@end
