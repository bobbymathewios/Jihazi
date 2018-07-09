//
//  ListDetailViewController.h
//  Favol
//
//  Created by Remya Das on 10/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListTableViewCell.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "CartViewController.h"
#import "ArabicLoginViewController.h"
#import "ItemCollectionViewCell.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "AttributeCell.h"
#import "OptionCell.h"
#import "DescriptionCell.h"
#import "ReviewCell.h"
#import "RiviewListCell.h"
#import "CombinationCell.h"
#import "SellerCell.h"
#import "SellMethodCell.h"
#import "WiriteReviewViewController.h"
#import "CusOptCell.h"
#import "BEMAnalogClockView.h"
#import "SelectVarCell.h"
#import "WidgetTableViewCell.h"
#import "SimilarTableViewCell.h"
#import "SellerListCell.h"
#import "OptionViewCell.h"
#import "WishLlstViewController.h"
#import "subscriptionCell.h"
#import "MedicineCell.h"
#import "SubstituteViewController.h"
#import "ListViewController.h"
#import "SpecificationCell.h"
#import "MessageViewController.h"

@interface ListDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *btnM;
@property (weak, nonatomic) IBOutlet UIButton *btnP;
@property (weak, nonatomic) IBOutlet UILabel *lblOut;
@property (strong, nonatomic) IBOutlet UICollectionView *colFree;
@property (strong, nonatomic) IBOutlet UILabel *hidePrice;
@property (strong, nonatomic) IBOutlet UIImageView *codImg;
@property (strong, nonatomic) IBOutlet UILabel *lblofferbottom;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtNameCoun;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtPinCoun;
@property (weak, nonatomic) IBOutlet UILabel *lblSellerTitle;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtFullAddrCoun;
@property (weak, nonatomic) IBOutlet UILabel *lblhot;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtPhoneCoun;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblImageH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblOptionH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblCustomOptionH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblsubstituteMedH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblDescriptionH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblReviewH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblRelatedH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblSubscriptionH;

@property (strong, nonatomic) IBOutlet UIButton *btnCheck;

@property (strong, nonatomic) IBOutlet UILabel *lblqtyLabel;
@property (strong, nonatomic) IBOutlet UILabel *lblcheck;

@property (strong, nonatomic) IBOutlet UIButton *btnAddtoCart;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIView *varientsView;
@property (strong, nonatomic) IBOutlet UITableView *tblDescription;
@property (strong, nonatomic) IBOutlet UILabel *lblchoose;

@property (strong, nonatomic) IBOutlet UIImageView *imgItem;
@property (strong, nonatomic) IBOutlet UIButton *btnFav;
@property (strong, nonatomic) IBOutlet UIButton *btnShare;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblprice;

@property (strong, nonatomic) IBOutlet UIButton *btnBuyNow;

@property (strong, nonatomic) IBOutlet UIView *optionsView;
@property (strong, nonatomic) IBOutlet UITableView *tblOptions;

@property (strong, nonatomic) IBOutlet UILabel *lblOffer;
@property (strong, nonatomic) IBOutlet UIButton *btnOptionChange;
@property (strong, nonatomic) IBOutlet UILabel *lblAvgRate;

- (IBAction)listOptionAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate1;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate2;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate3;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate4;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate5;
@property (strong, nonatomic) IBOutlet UILabel *lblRateper;
@property (strong, nonatomic) IBOutlet UILabel *lblNoProductReviewAvailable;
- (IBAction)optionCancelAction:(id)sender;
- (IBAction)optionApplyAction:(id)sender;

- (IBAction)backAction:(id)sender;
- (IBAction)favouriteAction:(id)sender;
- (IBAction)shareAction:(id)sender;
- (IBAction)buyNowAction:(id)sender;
@property (nonatomic,strong) NSDateFormatter *dateFormatter;
@property (nonatomic,strong) NSCalendar *calendar;
@property (nonatomic,strong) NSDate *date;
@property (strong, nonatomic) IBOutlet UILabel *myLabel;

@property(nonatomic,strong)NSString *productID,*productName;

@property (strong, nonatomic) IBOutlet UIView *timeView;

@property (strong, nonatomic) IBOutlet UILabel *lblDefaultOption;
@property (strong, nonatomic) IBOutlet UITableView *tblCustomoptions;
@property (strong, nonatomic) IBOutlet UIButton *btnCloseClock;
@property (strong, nonatomic) IBOutlet BEMAnalogClockView *clockView;
- (IBAction)closeClockAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblVarients;
@property (strong, nonatomic) IBOutlet UITableView *tblSeller;
@property (strong, nonatomic) IBOutlet UIView *sellerView;
@property (strong, nonatomic) IBOutlet UIImageView *imgSellerLogo;
@property (strong, nonatomic) IBOutlet UILabel *lblSellerName;
@property (strong, nonatomic) IBOutlet UILabel *lblSellerAvgRate;
@property (strong, nonatomic) IBOutlet UILabel *lblSellerAvg;
@property (strong, nonatomic) IBOutlet UIImageView *star1;
@property (strong, nonatomic) IBOutlet UIImageView *star2;
@property (strong, nonatomic) IBOutlet UIImageView *star3;
@property (strong, nonatomic) IBOutlet UIImageView *star4;
@property (strong, nonatomic) IBOutlet UIImageView *star5;
@property (strong, nonatomic) IBOutlet UIView *codView;
@property (strong, nonatomic) IBOutlet UIView *returnView;
@property (strong, nonatomic) IBOutlet UILabel *lblReturnDay;
@property (strong, nonatomic) IBOutlet UIView *shippingView;
@property (strong, nonatomic) IBOutlet UILabel *lblShipMethod;
@property (strong, nonatomic) IBOutlet UIView *AllSellerView;
@property (strong, nonatomic) IBOutlet UILabel *lblAllSellers;
@property (strong, nonatomic) IBOutlet UITableView *tblReview;
@property (strong, nonatomic) IBOutlet UITableView *tblRelated;
@property (strong, nonatomic) IBOutlet UITableView *tblSimilar;
//@property (strong, nonatomic) IBOutlet UIView *sellerView;
@property (strong, nonatomic) IBOutlet UIView *sellerTop;
//@property (strong, nonatomic) IBOutlet UITableView *tblSeller;
@property (strong, nonatomic) IBOutlet UILabel *lblQtySelected;
@property (strong, nonatomic) IBOutlet UITableView *tblOptionsView;
@property (strong, nonatomic) IBOutlet UILabel *lblSoldBy;
@property (strong, nonatomic) IBOutlet UIImageView *imgFree;
@property (strong, nonatomic) IBOutlet UILabel *lblCartCount;
@property (strong, nonatomic) IBOutlet UIButton *btnCart1;
@property (strong, nonatomic) IBOutlet UIButton *btnCart2;
@property (strong, nonatomic) IBOutlet UITableView *tblImages;
@property (strong, nonatomic) IBOutlet UIPageControl *pager;
@property (strong, nonatomic) IBOutlet UILabel *lblBusinessName1;
@property (strong, nonatomic) IBOutlet UIImageView *largeImage;
@property (strong, nonatomic) IBOutlet UIButton *btnFavMer;
@property (strong, nonatomic) IBOutlet UIView *viewStore;

@property (strong, nonatomic) IBOutlet UIView *sleereAllView;
@property (strong, nonatomic) IBOutlet UIView *prescriptionneedView;
- (IBAction)viewAllSellerAction:(id)sender;
- (IBAction)sellerBackAction:(id)sender;
- (IBAction)viewCartAction:(id)sender;
- (IBAction)pickerAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *nameView;
@property (strong, nonatomic) IBOutlet UIView *shipView;
@property (strong, nonatomic) IBOutlet UIView *priceView;
@property (strong, nonatomic) IBOutlet UIView *subscribeView;
@property (strong, nonatomic) IBOutlet UIImageView *imgOneSel;
@property (strong, nonatomic) IBOutlet UIImageView *imgSubscribeSel;
@property (strong, nonatomic) IBOutlet UILabel *lblOnetime;
@property (strong, nonatomic) IBOutlet UILabel *lblSubscribe;
@property (strong, nonatomic) IBOutlet UITextField *txtSelSubscription;
@property (strong, nonatomic) IBOutlet UITableView *tblSubscription;
@property (strong, nonatomic) IBOutlet UILabel *lblSubscribeSave;
- (IBAction)onetimeAction:(id)sender;
- (IBAction)subsCribeAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnSuscribeData;
@property (strong, nonatomic) IBOutlet UIView *checkDeliveryView;
- (IBAction)subscribeDataAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtCheckdelivery;
@property (strong, nonatomic) IBOutlet UITableView *tblSubstituteMedicine;
- (IBAction)checkDeliveryAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *shipBg1;
@property (strong, nonatomic) IBOutlet UIImageView *shipBg2;
@property (strong, nonatomic) IBOutlet UIImageView *imgShipReturnable;
@property (strong, nonatomic) IBOutlet UILabel *lblReturhun;
@property (strong, nonatomic) IBOutlet UIImageView *imgShipEarn;
@property (strong, nonatomic) IBOutlet UILabel *lblreturnTitlelbl;
@property (strong, nonatomic) IBOutlet UILabel *lblEarn;
@property (strong, nonatomic) IBOutlet UILabel *lblRewards;
- (IBAction)consultingAction:(id)sender;
- (IBAction)closeConsutViewAction:(id)sender;
- (IBAction)showConsView:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *consultView;
@property (strong, nonatomic) IBOutlet UILabel *lblBottomPrice;
@property (strong, nonatomic) IBOutlet UIImageView *displayConsultViewAction;
@property (strong, nonatomic) IBOutlet UILabel *lblbottomoffer;
@property (strong, nonatomic) IBOutlet UICollectionView *col;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtregionCon;
@property (strong, nonatomic) IBOutlet UILabel *lblCodAvlNot;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtCountryCoun;
@property (strong, nonatomic) IBOutlet UIView *freeView1;
@property (strong, nonatomic) IBOutlet UIView *freeView2;
@property (strong, nonatomic) IBOutlet UILabel *lblNameFree;
- (IBAction)closeFree:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblBusinessFree;
@property (strong, nonatomic) IBOutlet UIImageView *imgFreeimg;
@property (strong, nonatomic) IBOutlet UICollectionView *colFreeLarge;
@property (strong, nonatomic) IBOutlet UILabel *lblfreecount;
@property (strong, nonatomic) IBOutlet UILabel *selfreeCount;
@property (strong, nonatomic) IBOutlet UIView *FreeView;
@property (strong, nonatomic) IBOutlet UITableView *tblFreeOption;
@property (strong, nonatomic) IBOutlet UIButton *btnallstore;
- (IBAction)favMerchantAction:(id)sender;
- (IBAction)allStoreAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblAvalGiftsLabel;
@property (strong, nonatomic) IBOutlet UILabel *lblCashOnDeli;
@property (strong, nonatomic) IBOutlet UILabel *lblCOD;
@property (strong, nonatomic) IBOutlet UIImageView *imgReturn;
@property (strong, nonatomic) IBOutlet UILabel *lblReturnPolicy;
@property (strong, nonatomic) IBOutlet UIImageView *imgShipping;
@property (strong, nonatomic) IBOutlet UILabel *lblShipping;
@property (strong, nonatomic) IBOutlet UILabel *lblJihazhiDeli;
@property (strong, nonatomic) IBOutlet UIImageView *imgCOD;
@property (strong, nonatomic) IBOutlet UIView *dealView;
@property (strong, nonatomic) IBOutlet UILabel *lblDailyDeal;
@property (strong, nonatomic) IBOutlet UILabel *dealTime;
@property (weak, nonatomic) IBOutlet UIButton *btnViewReviewList;
- (IBAction)viewReviewListAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblShortDes;
- (IBAction)askMerchantAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAskMerchant;

@end
