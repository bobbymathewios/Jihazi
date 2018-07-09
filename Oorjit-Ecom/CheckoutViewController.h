//
//  CheckoutViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

#import <CommonCrypto/CommonDigest.h>  //No need to import it in production app
#import "AppDelegate.h"
#import "ThankYouViewController.h"
#import "MethodCollectionViewCell.h"

#import "Loading.h"
#import "WebService.h"
#import "ShipCell.h"
#import "PaymentWebView.h"
#import "CheckoutAddressCell.h"
#import "addCheckoutAddressView.h"
#import <SystemConfiguration/SystemConfiguration.h>
#import <netdb.h>
#import "MRMSDevFPiOS.h"
#import "PaymentModeViewController.h"
#import "CheckoutCell.h"

@interface CheckoutViewController : UIViewController//<PayFortDelegate>
{
    int btnIndex;
}
@property (strong, nonatomic) IBOutlet UIButton *btnpayforpply;

@property (strong, nonatomic) IBOutlet UIButton *btnRewardCancel;
@property (strong, nonatomic) IBOutlet UIButton *btncouponCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnCouponApply;
@property (strong, nonatomic) IBOutlet UILabel *lblCouponTitle;

@property(nonatomic,strong)NSString *fromSubscription,*master,*fromLogin,*pCARTID,*PPRICE;
@property (strong, nonatomic) IBOutlet UILabel *lblcodValue;
@property (strong, nonatomic) IBOutlet UIButton *skippp1;

@property (strong, nonatomic) IBOutlet UITableView *tblCartDetails;
@property (strong, nonatomic) IBOutlet UIView *giftcouponView;
@property (strong, nonatomic) IBOutlet UITextField *txtCouponCodeValueEntered;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *scrollW;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *uploadH;




@property (strong, nonatomic) IBOutlet UICollectionView *colPaymentMethod;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UIView *paymentView;

@property (strong, nonatomic) IBOutlet UIView *tioView;
@property (strong, nonatomic) IBOutlet UIButton *btnback;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@property (strong, nonatomic) IBOutlet UILabel *lblPay;


@property (strong, nonatomic) IBOutlet UIButton *btnPayNowBtn;
@property (strong, nonatomic) IBOutlet UIView *payFortView;
@property (strong, nonatomic) IBOutlet UIView *viewE;
@property (strong, nonatomic) IBOutlet UIView *viewA;
@property (strong, nonatomic) IBOutlet UITableView *tblShippingAdress;

- (IBAction)backAction:(id)sender;
- (IBAction)payNowAction:(id)sender;
- (IBAction)agreeAction:(id)sender;
- (IBAction)payAction:(id)sender;
- (IBAction)sameAsButtonAction:(id)sender;



@property (strong, nonatomic) IBOutlet UIButton *btnCountinueBtn;

@property (strong, nonatomic) IBOutlet UIButton *btnBack1;

- (IBAction)addNewAddressAction:(id)sender;
- (IBAction)goNextAction:(id)sender;

@property(nonatomic,strong)NSString *totalPriceValue;
@property (strong, nonatomic) IBOutlet UITextField *txtCardNum;
@property (strong, nonatomic) IBOutlet UITextField *txtholderName;
@property (strong, nonatomic) IBOutlet UITextField *txtExp;
@property (strong, nonatomic) IBOutlet UITextField *txtCVVpay;
@property (strong, nonatomic) IBOutlet UITableView *tblShipInfo;

- (IBAction)payForyEngAction:(id)sender;
- (IBAction)payFortArabicAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtAraCvv;
@property (strong, nonatomic) IBOutlet UIButton *cancelPayFortAction;
@property (strong, nonatomic) IBOutlet UITextField *txtAraExp;
- (IBAction)canCelFortAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITextField *txtAraCardnum;
@property (strong, nonatomic) IBOutlet UITextField *txtAraHolder;
@property(nonatomic,strong)NSArray *array;

- (IBAction)subBackAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *uploadView;
@property (strong, nonatomic) IBOutlet UIImageView *imgUploadSel;
- (IBAction)cameraAction:(id)sender;
- (IBAction)galleryAction:(id)sender;
- (IBAction)myPrescrptionAction:(id)sender;
@property (strong, nonatomic) IBOutlet UICollectionView *colPrescription;
@property (strong, nonatomic) IBOutlet UIView *sampleView;
@property (strong, nonatomic) IBOutlet UILabel *lblShowSample;
- (IBAction)showSampleAction:(id)sender;
- (IBAction)skipPrescriptionAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgSample;
@property (strong, nonatomic) IBOutlet UIButton *btnSkippres;
@property (strong, nonatomic) IBOutlet UILabel *lbls;

- (IBAction)redeemViewEnableAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblRewarTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblRewardpointValue;
@property (strong, nonatomic) IBOutlet UITextField *txtRedeempointValue;
@property (strong, nonatomic) IBOutlet UILabel *lblRewardpointmin;
- (IBAction)redeemAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnR;
@property (strong, nonatomic) IBOutlet UIView *redeemViewPoint;
- (IBAction)cancelPointAction:(id)sender;
- (IBAction)cancelCouponAction:(id)sender;
- (IBAction)applyCouponAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgLarge;
@property (strong, nonatomic) IBOutlet UIView *imgLargeView;
- (IBAction)closeAction:(id)sender;

@end
