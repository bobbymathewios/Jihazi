//
//  RewardPointViewController.h
//  MedMart
//
//  Created by Remya Das on 26/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Loading.h"
#import "WebService.h"
#import "RewardCell.h"
@interface RewardPointViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIButton *btnBalance;
@property (strong, nonatomic) IBOutlet UITableView *tblReward;


- (IBAction)backEngAc:(id)sender;
@end
