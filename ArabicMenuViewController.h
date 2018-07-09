//
//  ArabicMenuViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MyAccountViewController.h"
#import "CartViewController.h"
#import "AccountViewController.h"
#import "ContactViewController.h"
#import "MyOrderViewController.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "AboutViewController.h"
#import "ArabicLoginViewController.h"
#import "MenuTableViewCell.h"
#import "AllCategoryView.h"

@interface ArabicMenuViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITableView *tblLang;
@property (strong, nonatomic) IBOutlet UIView *lanView;
@property (strong, nonatomic) IBOutlet UIImageView *profileImg;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnCart;
@property (strong, nonatomic) IBOutlet UITableView *tblmenu;
@property (strong, nonatomic) IBOutlet UIButton *btnlogout;
@property (strong, nonatomic) IBOutlet UIView *viewbg;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollobj;
@property (strong, nonatomic) IBOutlet UIButton *btnMyAcc;
@property (strong, nonatomic) IBOutlet UILabel *lblCatTitle;
- (IBAction)accountPageAction:(id)sender;

- (IBAction)englishAction:(id)sender;
- (IBAction)arabicAction:(id)sender;
- (IBAction)cartAction:(id)sender;
- (IBAction)logoutAction:(id)sender;
- (IBAction)MyAccountAction:(id)sender;

- (IBAction)bundleAction:(id)sender;
- (IBAction)dealAction:(id)sender;
- (IBAction)viewhomeAction:(id)sender;
- (IBAction)allCategory:(id)sender;
@end
