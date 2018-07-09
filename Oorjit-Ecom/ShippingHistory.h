//
//  ShippingHistory.h
//  MedMart
//
//  Created by Remya Das on 22/02/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Loading.h"
#import "WebService.h"
#import "SHistoryCell.h"
@interface ShippingHistory : UIViewController
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UITableView *tblShip;
@property(nonatomic,strong)NSArray *ShipHistory;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
- (IBAction)backAction:(id)sender;
@end
