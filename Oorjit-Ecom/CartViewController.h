//
//  CartViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "CheckoutViewController.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "CartCell.h"
#import "PriceCell.h"
#import "PromoCell.h"
#import "GiftCell.h"
#import "CartFreeCell.h"


@interface CartViewController : UIViewController<GiftViewDelegate,viewFreeAllDelegate>
@property (strong, nonatomic) IBOutlet UIView *giftView;
@property (strong, nonatomic) IBOutlet UIButton *brnEmptyShop;
@property (strong, nonatomic) IBOutlet UILabel *lblEmptyCart;
@property (strong, nonatomic) IBOutlet UITableView *tblGift;
@property (strong, nonatomic) IBOutlet UIButton *btnCan;
@property (strong, nonatomic) IBOutlet UILabel *lblPromoTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblTotLbl;
@property (strong, nonatomic) IBOutlet UIButton *btnApp;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *pW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *cH;
@property (strong, nonatomic) IBOutlet UIView *redeemPromoView;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UIView *topHeadView;
@property (strong, nonatomic) IBOutlet UILabel *lblCount;
@property (strong, nonatomic) IBOutlet UIButton *btnClose;
@property (strong, nonatomic) IBOutlet UILabel *lblAmt;
@property (strong, nonatomic) IBOutlet UITableView *tblCart;
@property (strong, nonatomic) IBOutlet UIView *promoView;
@property (strong, nonatomic) IBOutlet UITextField *txtPromocode;
@property (strong, nonatomic) IBOutlet UIButton *btnTick;
@property (strong, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIButton *btnCheckout;
@property (strong, nonatomic) IBOutlet UILabel *lblprice;
@property (strong, nonatomic) IBOutlet UILabel *lblSub;
@property (strong, nonatomic) IBOutlet UILabel *lblSubPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblTax;
@property (strong, nonatomic) IBOutlet UILabel *lblTaxPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblTotalPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblSave;
@property (strong, nonatomic) IBOutlet UIView *priceView;
@property (strong, nonatomic) IBOutlet UIView *totalAmtPayView;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblcatH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *tblpriceh;

@property(nonatomic,strong)NSString *fromDetail,*fromMenu,*fromlogin,*emptyCart;
@property (strong, nonatomic) IBOutlet UITextField *txtPromoCodeValue;
@property (strong, nonatomic) IBOutlet UILabel *lblpromoAmountlabel;
@property (strong, nonatomic) IBOutlet UILabel *lblpromoAmountValue;
@property (strong, nonatomic) IBOutlet UILabel *lblWalletAmountLabel;
@property (strong, nonatomic) IBOutlet UILabel *lblWalletAmountValue;
@property (strong, nonatomic) IBOutlet UILabel *lblshippinfAmtLabel;
@property (strong, nonatomic) IBOutlet UILabel *lblShippingAmtValue;

- (IBAction)closeAction:(id)sender;
- (IBAction)tickAction:(id)sender;
- (IBAction)checkoutAction:(id)sender;
- (IBAction)ApplyAction:(id)sender;
- (IBAction)canCelPromoAction:(id)sender;
- (IBAction)proMoView:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *emptyView;
@property (strong, nonatomic) IBOutlet UITableView *tblPrice;
- (IBAction)shopNowAction:(id)sender;
- (IBAction)closeActionGift:(id)sender;
@end
