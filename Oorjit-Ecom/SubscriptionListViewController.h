//
//  SubscriptionListViewController.h
//  MedMart
//
//  Created by Remya Das on 09/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Loading.h"
#import "WebService.h"
#import "SubCell.h"
#import "SubscriptionDetailViewController.h"
@interface SubscriptionListViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UITableView *tblList;

- (IBAction)backAction:(id)sender;
@end
