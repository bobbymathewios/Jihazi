//
//  PendingViewController.h
//  MedMart
//
//  Created by Remya Das on 29/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loading.h"
#import "WebService.h"
#import "AppDelegate.h"
#import "PendingCell.h"
#import "PendingDetailViewController.h"

@interface PendingViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tblOrder;
@property (strong, nonatomic) IBOutlet UICollectionView *colList;

- (IBAction)backAction:(id)sender;
@end
