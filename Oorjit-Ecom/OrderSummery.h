//
//  OrderSummery.h
//  MedMart
//
//  Created by Remya Das on 05/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "RESideMenu.h"
#import "AppDelegate.h"
#import "Loading.h"
#import "WebService.h"
#import "Loading.h"

@interface OrderSummery : UIViewController
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *couponH;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *adH;
@property (strong, nonatomic) IBOutlet UIButton *btbAddNew;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *btnAra;
@property (strong, nonatomic) IBOutlet UIImageView *imgAra;
@property (strong, nonatomic) IBOutlet UIImageView *imgEng;
@property (strong, nonatomic) IBOutlet UIButton *btnEng;
@property (strong, nonatomic) IBOutlet UICollectionView *comPrescription;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblAttachPres;
@property (strong, nonatomic) IBOutlet UITableView *tblAddress;
@property (strong, nonatomic) IBOutlet UIView *couponview;
@property (strong, nonatomic) IBOutlet UIView *couponAddView;
@property (strong, nonatomic) IBOutlet UITextField *txtCoupon;
@property (strong, nonatomic) IBOutlet UILabel *lblNo;
@property (strong, nonatomic) IBOutlet UITextField *txtAterEnterPromo;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *colH;

@property(nonatomic,strong)NSArray *prescription;
@property(nonatomic,strong)NSString *URl,*p_order_id;
- (IBAction)backAraAction:(id)sender;
- (IBAction)englishBackAction:(id)sender;
- (IBAction)addnewAddressAction:(id)sender;
- (IBAction)placeOrderAction:(id)sender;
- (IBAction)cancelCouponAction:(id)sender;
- (IBAction)applyAction:(id)sender;
- (IBAction)showCouponView:(id)sender;
- (IBAction)attachAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblatt;
@property (strong, nonatomic) IBOutlet UIImageView *imArr;
@property (strong, nonatomic) IBOutlet UIButton *btnAttach;
@property (strong, nonatomic) IBOutlet UIImageView *imgLarge;
@property (strong, nonatomic) IBOutlet UIView *imgLargeView;
- (IBAction)closeAction:(id)sender;
@end
