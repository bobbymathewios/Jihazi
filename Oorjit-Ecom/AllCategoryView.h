//
//  AllCategoryView.h
//  MedMart
//
//  Created by Remya Das on 07/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "AppDelegate.h"
#import "WebService.h"
@interface AllCategoryView : UIViewController
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *bE1;
@property (strong, nonatomic) IBOutlet UIButton *bA1;
@property (strong, nonatomic) IBOutlet UIButton *bE2;
@property (strong, nonatomic) IBOutlet UIButton *bA2;
@property (strong, nonatomic) IBOutlet UITableView *tblCat;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
- (IBAction)backEngAc:(id)sender;
- (IBAction)backAraAction:(id)sender;
@end
