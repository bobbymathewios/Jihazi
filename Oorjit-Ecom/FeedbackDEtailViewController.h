//
//  FeedbackDEtailViewController.h
//  Jihazi
//
//  Created by Apple on 18/04/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedbackDEtailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UILabel *prodctqlty;
@property (strong, nonatomic) IBOutlet UIScrollView *scrlView;
@property (strong, nonatomic) IBOutlet UILabel *orderDateLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderdateresLbl;
@property (strong, nonatomic) IBOutlet UILabel *shipingrt;
@property (strong, nonatomic) IBOutlet UILabel *shipngcost;
@property (strong, nonatomic) IBOutlet UILabel *merchantFeedbackLbl;
@property (strong, nonatomic) IBOutlet UILabel *ratemerchntLbl;
@property (strong, nonatomic) IBOutlet UILabel *ovrallrt;
@property (weak, nonatomic) IBOutlet UIImageView *imgborder;
- (IBAction)s23act:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *s23;
@property (strong, nonatomic) IBOutlet UIButton *s32;
@property (strong, nonatomic) IBOutlet UIButton *s33;
@property (strong, nonatomic) IBOutlet UILabel *prodctRwlbl;
@property (strong, nonatomic) IBOutlet UIButton *s34;
@property (strong, nonatomic) IBOutlet UITextView *prodctRwrTxt;
@property (strong, nonatomic) IBOutlet UIButton *s35;
@property (strong, nonatomic) IBOutlet UILabel *expLbl;
@property (strong, nonatomic) IBOutlet UITextView *expTxt;
- (IBAction)s35act:(id)sender;
- (IBAction)s33act:(id)sender;
- (IBAction)s34act:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *merchantFeedbckRestxt;
- (IBAction)s32act:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *s25;
@property (strong, nonatomic) IBOutlet UIButton *s31;
- (IBAction)s25act:(id)sender;
- (IBAction)s31act:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *s24;
- (IBAction)s24act:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *ImageFeedback;
@property (strong, nonatomic) IBOutlet UILabel *titleLabel;
@property (strong, nonatomic) IBOutlet UILabel *youPaidLbl;
@property (strong, nonatomic) IBOutlet UILabel *youPaidresLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderIdLbl;
@property (strong, nonatomic) IBOutlet UIButton *s14;
@property (strong, nonatomic) IBOutlet UIButton *s22;
- (IBAction)s22act:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *s15;
@property (strong, nonatomic) IBOutlet UIButton *s21;
- (IBAction)s21act:(id)sender;

- (IBAction)s15act:(id)sender;
- (IBAction)s14act:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *s12;
- (IBAction)s13act:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *s13;
- (IBAction)s12act:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *s4;
@property (strong, nonatomic) IBOutlet UIButton *s5;
- (IBAction)s11act:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *headerTitle;
@property (strong, nonatomic) IBOutlet UIButton *s11;
- (IBAction)s5act:(id)sender;
- (IBAction)s4act:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *orderidresLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderStsLbl;
@property (strong, nonatomic) IBOutlet UILabel *orderstsresLbl;
@property (strong, nonatomic) IBOutlet UILabel *proRatLbl;
@property (strong, nonatomic) IBOutlet UIButton *s1;
@property (strong, nonatomic) IBOutlet UIButton *s3;
@property (strong, nonatomic) IBOutlet UIButton *bacKbtn;
@property (strong, nonatomic) IBOutlet UIButton *backBtnImg;
- (IBAction)back:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *r5;
@property (strong, nonatomic) IBOutlet UILabel *reviewTitle;
@property (strong, nonatomic) IBOutlet UILabel *expProdctLbl;
@property (strong, nonatomic) IBOutlet UITextView *expProTxt;
@property (strong, nonatomic) IBOutlet UIButton *submitBtn;
- (IBAction)submitAct:(id)sender;
@property (strong, nonatomic) IBOutlet UITextView *reviewTitleTxt;
- (IBAction)r5act:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *r4;
- (IBAction)r4act:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *r2;
@property (strong, nonatomic) IBOutlet UIButton *r3;
- (IBAction)r3act:(id)sender;
- (IBAction)r1act:(id)sender;
- (IBAction)r2act:(id)sender;
- (IBAction)s3act:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *s2;
@property (strong, nonatomic) IBOutlet UIButton *r1;
- (IBAction)s2act:(id)sender;
- (IBAction)s1Act:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *productView;
@property (strong, nonatomic)NSString *imgUrl,*orderId,*paid,*date,*status,*imgPath,*titleStr,*pid,*bid,*masterOderid,*enableProductReview,*haveProRev,*haveMerRev;
@property (weak, nonatomic) IBOutlet UIView *merchantView;
@end
