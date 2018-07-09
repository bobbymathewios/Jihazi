//
//  AddressViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 17/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "AddressTableViewCell.h"
#import "AddressDetailViewController.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"

@interface AddressViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblno;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *h;
@property (strong, nonatomic) IBOutlet UIView *noView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *btnEngBack;
@property (strong, nonatomic) IBOutlet UIButton *btnAraBack;
@property (strong, nonatomic) IBOutlet UITableView *tblAddress;
@property (strong, nonatomic) IBOutlet UILabel *lblSaves;
@property (strong, nonatomic) IBOutlet UIButton *btnAddEng;
@property (strong, nonatomic) IBOutlet UIImageView *imgEngAdd;
@property (strong, nonatomic) IBOutlet UILabel *lblAraSaves;
@property (strong, nonatomic) IBOutlet UIButton *btnAraAdd;
@property (strong, nonatomic) IBOutlet UIImageView *imgAraAdd;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewobj;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

- (IBAction)backEngAction:(id)sender;
- (IBAction)backAraAction:(id)sender;
- (IBAction)addEngAddrAction:(id)sender;
- (IBAction)addAraAddAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *b2;
@property (strong, nonatomic) IBOutlet UIButton *c1;
@end
