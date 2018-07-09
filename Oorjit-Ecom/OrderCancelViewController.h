//
//  OrderCancelViewController.h
//  Favot
//
//  Created by Remya Das on 07/08/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "reasonCell.h"
#import "CancelCCell.h"
#import "OrderAddressCell.h"

@interface OrderCancelViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tblCancel;
@property (strong, nonatomic) IBOutlet UIView *topObj;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIButton *btnBack1;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property(nonatomic,strong)NSString *rid,*oid,*img;
- (IBAction)backAction:(id)sender;
@end
