//
//  ListViewController.h
//  Favol
//
//  Created by Remya Das on 10/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "AppDelegate.h"
#import "ListTableViewCell.h"
#import "ListDetailViewController.h"
#import "CartViewController.h"
#import "ItemCollectionViewCell.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "RangeSlider.h"
#import "NMRangeSlider.h"
#import "SubstituteViewController.h"
@class RangeSlider;


@interface ListViewController : UIViewController
{
    RangeSlider *slider;
}
@property (weak, nonatomic) IBOutlet UIView *filterPriceView;
@property (weak, nonatomic) IBOutlet UIView *sortFilterView;
@property (strong, nonatomic) IBOutlet UIButton *btnCartObj;
- (IBAction)cartAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *topViewObj;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnMenu;
@property (strong, nonatomic) IBOutlet UIButton *btnSearch;
@property (strong, nonatomic) IBOutlet UIImageView *imgSortFilterBg;
@property (strong, nonatomic) IBOutlet UILabel *lblCountValue;
@property (strong, nonatomic) IBOutlet UIButton *btnCart1;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UIImageView *imgSort;
@property (strong, nonatomic) IBOutlet UILabel *lblSort;
@property (strong, nonatomic) IBOutlet UILabel *lblnewList;
@property (strong, nonatomic) IBOutlet UIImageView *imgFilter;
@property (strong, nonatomic) IBOutlet UILabel *lblFilter;
@property (strong, nonatomic) IBOutlet UILabel *lblnotApply;
@property (strong, nonatomic) IBOutlet UIButton *btnSort;
@property (strong, nonatomic) IBOutlet UIButton *btnFilter;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UICollectionView *colListView;
@property(nonatomic,strong)NSString *catIDFromHome,*sortType,*titleString,*ID,*PID,*keyword,*priMin,*priMax,*cat,*dis,*MinValue,*maxValue,*discount,*businessName,*businessID,*favOrNotMer,*Brate,*review,*isFollowMerchant;
- (IBAction)menuAction:(id)sender;
- (IBAction)searchAction:(id)sender;
- (IBAction)sortAction:(id)sender;
- (IBAction)filterAction:(id)sender;
- (IBAction)cancelSortAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *sortView;
@property (strong, nonatomic) IBOutlet UILabel *lbl1;
@property (strong, nonatomic) IBOutlet UILabel *lbl2;
@property (strong, nonatomic) IBOutlet UILabel *lbl3;
@property (strong, nonatomic) IBOutlet UILabel *lbl4;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIView *merchantView;
@property (strong, nonatomic) IBOutlet UILabel *lblMerchantName;
@property (strong, nonatomic) IBOutlet UIButton *btnaddMerchant;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate1;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate2;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate3;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate4;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate5;
@property (strong, nonatomic) IBOutlet UILabel *lblBrate;

- (IBAction)lowAction:(id)sender;
- (IBAction)poularAction:(id)sender;
- (IBAction)highAction:(id)sender;
- (IBAction)addNewAction:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *topView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollObj;
@property (weak, nonatomic) IBOutlet UITableView *filterTableObj;
@property (weak, nonatomic) IBOutlet UIView *priceViewObj;
@property (weak, nonatomic) IBOutlet UITableView *filterTableObjTwo;
@property (weak, nonatomic) IBOutlet UILabel *lblPriceFilter;
@property (strong, nonatomic) IBOutlet UILabel *lowerLabel;
@property (strong, nonatomic) IBOutlet UILabel *upperLabel;
@property (strong, nonatomic) IBOutlet NMRangeSlider *labelSlider;
@property (strong, nonatomic) IBOutlet UIView *filterViewObj;
- (IBAction)labelSliderChanged:(NMRangeSlider*)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgArrowBack;
@property (strong, nonatomic) IBOutlet UITableView *tblOffer;


- (IBAction)closeAction:(id)sender;

- (IBAction)resetAction:(id)sender;
- (IBAction)viewDealAction:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *txtSearch;
@property (strong, nonatomic) IBOutlet UIButton *btnFilCategory;
@property (strong, nonatomic) IBOutlet UIButton *btnFilBrand;
@property (strong, nonatomic) IBOutlet UIButton *btnFilDisCount;
@property (strong, nonatomic) IBOutlet UIButton *btnFilterprice;
- (IBAction)FilterCategoryAction:(id)sender;
- (IBAction)filterBrandAction:(id)sender;
- (IBAction)filterDiscountAction:(id)sender;
- (IBAction)filterpriceAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblCatTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblBrandTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblDiscountTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imm;
@property (strong, nonatomic) IBOutlet UILabel *lblFtitle;
@property (strong, nonatomic) IBOutlet UIButton *btnFclear;
@property (strong, nonatomic) IBOutlet UIButton *btnfApply;
@property (strong, nonatomic) IBOutlet UILabel *lblSortBy;
@property (strong, nonatomic) IBOutlet UIButton *btnSortCancel;
- (IBAction)addFavMerchantAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *colHeight;
- (IBAction)merchantMailAction:(id)sender;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *merh;

@end
