//
//  MenuViewController.h
//  Favol
//
//  Created by Remya Das on 10/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MenuTableViewCell.h"
#import "ListViewController.h"
#import "MyAccountViewController.h"
#import "AccountViewController.h"
#import "ContactViewController.h"
#import "MyOrderViewController.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "AboutViewController.h"
#import "UploadPrescription.h"
#import "BundleViewController.h"
#import "AllCategoryView.h"
#import "MessageListViewController.h"

@interface MenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *lblCatTitle;
@property (strong, nonatomic) IBOutlet UILabel *countCart;
@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@property (strong, nonatomic) IBOutlet UITableView *tblmenu;
@property (strong, nonatomic) IBOutlet UIButton *btnlogout;
@property (strong, nonatomic) IBOutlet UIView *viewbg;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollObj;
@property (strong, nonatomic) IBOutlet UIButton *btnMyAcc;
@property (strong, nonatomic) IBOutlet UIView *lanView;
@property (strong, nonatomic) IBOutlet UITableView *tbllang;

- (IBAction)myAccountAction:(id)sender;
- (IBAction)HomeViewAction:(id)sender;

- (IBAction)englishAction:(id)sender;
- (IBAction)arabicAction:(id)sender;
- (IBAction)cartAction:(id)sender;
- (IBAction)logoutAction:(id)sender;
- (IBAction)accountPageAction:(id)sender;
- (IBAction)uploadprescriptionAction:(id)sender;
- (IBAction)bundleAction:(id)sender;
- (IBAction)dealAction:(id)sender;
- (IBAction)allCategoryAction:(id)sender;
@end
