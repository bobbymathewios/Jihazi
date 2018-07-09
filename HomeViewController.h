//
//  HomeViewController.h
//  Favol
//
//  Created by Remya Das on 10/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "RESideMenu.h"
#import "AppDelegate.h"
#import "ListViewController.h"
//#import "CatCollectionViewCell.h"
//#import "BannerCollectionViewCell.h"
#import "LoginViewController.h"
#import "CartViewController.h"
#import "Loading.h"
#import "WebService.h"
#import "LanguageTableViewCell.h"
#import "WidgetTableViewCell.h"
#import "WStaticTableViewCell.h"
#import "bundleDetailViewController.h"
#import "UploadPrescription.h"
#import "AllCategoryView.h"
#import "SubstituteViewController.h"
#import "SearchView.h"
#import "OrderSummery.h"


//#import "StaticCell.h"

@interface HomeViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *bannerCollectionView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *catTblw;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *catWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *carh;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bannerw;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UITextField *txtSearch;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UITableView *tblBanner;
@property (strong, nonatomic) IBOutlet UIView *headderViewObj;
@property (strong, nonatomic) IBOutlet UIView *topViewObj;
@property (strong, nonatomic) IBOutlet UITableView *tblCat;
@property (strong, nonatomic) IBOutlet UIPageControl *page;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *bannerH;
@property (strong, nonatomic) IBOutlet UIImageView *bgImg;

@property (strong, nonatomic) IBOutlet UIView *languageView;

@property (strong, nonatomic) IBOutlet UITableView *tblLang;
@property (strong, nonatomic) IBOutlet UILabel *lblCartCount;

@property (strong, nonatomic) IBOutlet UICollectionView *colSearch;
@property (strong, nonatomic) IBOutlet UIView *categoryView;
@property(nonatomic,strong)NSTimer *timer;
@property (strong, nonatomic) IBOutlet UIButton *btnViewMoewCat;
@property (strong, nonatomic) IBOutlet UIImageView *i1;
@property (strong, nonatomic) IBOutlet UIImageView *i2;
@property (strong, nonatomic) IBOutlet UIImageView *i3;
@property (strong, nonatomic) IBOutlet UIImageView *i4;
@property (strong, nonatomic) IBOutlet UIImageView *i5;
@property (strong, nonatomic) IBOutlet UIImageView *i6;
- (IBAction)menuAction:(id)sender;
- (IBAction)backAction:(id)sender;
- (IBAction)uploadPrescriptionAction:(id)sender;
- (IBAction)viewMoreCatAction:(id)sender;
- (IBAction)catAction:(id)sender;
- (IBAction)wishlistAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblCOD;
@property (weak, nonatomic) IBOutlet UILabel *lblKing;
@property (weak, nonatomic) IBOutlet UILabel *lblvarious;
@property (weak, nonatomic) IBOutlet UILabel *lblCust;
@property (weak, nonatomic) IBOutlet UILabel *lblcomp;
@property (weak, nonatomic) IBOutlet UILabel *lblwarr;

@end
