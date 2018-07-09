//
//  ArabicHomeViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "AppDelegate.h"
#import "ListViewController.h"
//#import "CatCollectionViewCell.h"
#import "ArabicLoginViewController.h"
#import "CartViewController.h"
#import "Loading.h"
#import "WebService.h"
#import "LanguageTableViewCell.h"
#import "WidgetTableViewCell.h"
#import "WStaticTableViewCell.h"
#import "SubstituteViewController.h"
#import "SearchView.h"
@interface ArabicHomeViewController : UIViewController
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *catTblw;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *catWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *carh;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bannerw;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bannerH;
@property (strong, nonatomic) IBOutlet UIImageView *bgImg;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UISearchBar *searchBarObj;
@property (strong, nonatomic) IBOutlet UITableView *tblBanner;
@property (strong, nonatomic) IBOutlet UIView *headderViewObj;
@property (strong, nonatomic) IBOutlet UIView *topViewObj;
@property (strong, nonatomic) IBOutlet UITextField *txtSearch;
@property (strong, nonatomic) IBOutlet UICollectionView *colViewObj;
@property (strong, nonatomic) IBOutlet UIView *shareViewObj;
@property (strong, nonatomic) IBOutlet UIButton *btnFb;
@property (strong, nonatomic) IBOutlet UIButton *btnGPlus;
@property (strong, nonatomic) IBOutlet UIButton *btnTwitter;
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UIButton *btnLinkedin;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UITableView *tblCat;
@property (strong, nonatomic) IBOutlet UILabel *lblCatTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnEng;
@property (strong, nonatomic) IBOutlet UIButton *btnAra;
@property (strong, nonatomic) IBOutlet UIView *languageView;
@property (strong, nonatomic) IBOutlet UIButton *btnConfirm;
@property (strong, nonatomic) IBOutlet UIPageControl *page;
@property (strong, nonatomic) IBOutlet UILabel *lblCartCount;
@property (strong, nonatomic) IBOutlet UICollectionView *colSearch;
@property(nonatomic,strong)NSTimer *timer;
- (IBAction)menuAction:(id)sender;
- (IBAction)backAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *categoryView;
@property (strong, nonatomic) IBOutlet UIButton *btnViewmoreCat;

- (IBAction)uploadpresAction:(id)sender;
- (IBAction)viewmoreCatAction:(id)sender;
- (IBAction)catAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblCOD;
@property (weak, nonatomic) IBOutlet UILabel *lblKing;
@property (weak, nonatomic) IBOutlet UILabel *lblvarious;
@property (weak, nonatomic) IBOutlet UILabel *lblCust;
@property (weak, nonatomic) IBOutlet UILabel *lblcomp;
@property (weak, nonatomic) IBOutlet UILabel *lblwarr;
@end
