//
//  MyAccountViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 16/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GoogleSignIn/GoogleSignIn.h>
#import "RESideMenu.h"
#import "AppDelegate.h"
#import "ArabicHomeViewController.h"
#import "HomeViewController.h"
#import "ArabicMenuViewController.h"
#import "MenuViewController.h"
#import "RESideMenu.h"
#import "WalletViewController.h"
#import "AccountViewController.h"
#import "AddressViewController.h"
#import "MyOrderViewController.h"
#import "WishLlstViewController.h"
#import "WebService.h"
#import "LanguageTableViewCell.h"
#import "AboutViewController.h"
#import "ChangepasswordView.h"
#import "UploadPrescription.h"
#import "RewardPointViewController.h"
#import "PendingViewController.h"
#import "ContactViewController.h"
#import "AccountCell.h"
#import "SubscriptionListViewController.h"
#import "ListPrescriptions.h"
#import "MessageListViewController.h"



@interface MyAccountViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrollObj;
@property (strong, nonatomic) IBOutlet UIButton *btnmyorder;
@property (strong, nonatomic) IBOutlet UIButton *btnwish;
@property (strong, nonatomic) IBOutlet UIButton *btnMyAd;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollobj;
@property (strong, nonatomic) IBOutlet UIButton *btnMyAcc;
@property (strong, nonatomic) IBOutlet UILabel *lblSel;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
- (IBAction)pendingAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblcc;
- (IBAction)contactAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIView *lanView;
@property (strong, nonatomic) IBOutlet UITableView *tblAccount;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UIImageView *imgProfile;
@property (strong, nonatomic) IBOutlet UIButton *btnMyOrder;
@property (strong, nonatomic) IBOutlet UIImageView *imgOrder;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UIImageView *imgWishlist;
@property (strong, nonatomic) IBOutlet UILabel *lblWishCount;
@property (strong, nonatomic) IBOutlet UIButton *btnwishList;
@property (strong, nonatomic) IBOutlet UIImageView *imgAddres;
@property (strong, nonatomic) IBOutlet UIButton *btnAddress;
@property (strong, nonatomic) IBOutlet UIImageView *arrow1;
@property (strong, nonatomic) IBOutlet UIImageView *arraow2;
@property (strong, nonatomic) IBOutlet UIImageView *arrow3;
@property (strong, nonatomic) IBOutlet UIImageView *arrow4;
@property (strong, nonatomic) IBOutlet UIImageView *imgLanguage;
@property (strong, nonatomic) IBOutlet UIButton *btnLanguage;
@property (strong, nonatomic) IBOutlet UIImageView *imgWallet;
@property (strong, nonatomic) IBOutlet UIButton *btnad;
@property (strong, nonatomic) IBOutlet UIButton *btnwallet;
@property (strong, nonatomic) IBOutlet UIImageView *imgAccount;
@property (strong, nonatomic) IBOutlet UIButton *btnAccount;
@property (strong, nonatomic) IBOutlet UIImageView *imgHelp;
@property (strong, nonatomic) IBOutlet UIButton *btnHelp;
@property (strong, nonatomic) IBOutlet UIImageView *imglogout;
@property (strong, nonatomic) IBOutlet UIButton *btnLogout;
@property (strong, nonatomic) IBOutlet UILabel *lblLan;
@property (strong, nonatomic) IBOutlet UILabel *lblHelp;
@property (strong, nonatomic) IBOutlet UILabel *lblAccount;
@property (strong, nonatomic) IBOutlet UILabel *lblWallet;
@property (strong, nonatomic) IBOutlet UIView *languageView;
@property (strong, nonatomic) IBOutlet UIImageView *imgStore;
@property (strong, nonatomic) IBOutlet UIImageView *arrow5;

@property (strong, nonatomic) IBOutlet UITableView *tblLang;
@property (strong, nonatomic) IBOutlet UILabel *lblStores;
@property (strong, nonatomic) IBOutlet UIImageView *arrow6;
@property (strong, nonatomic) IBOutlet UIImageView *imgFeedback;
@property (strong, nonatomic) IBOutlet UIButton *btnfeedback;
@property (strong, nonatomic) IBOutlet UIButton *btnMessage;
@property (strong, nonatomic) IBOutlet UIImageView *imgMessage;
@property (strong, nonatomic) IBOutlet UIImageView *arrow7;

@property (strong, nonatomic) IBOutlet UIButton *btnStore;
@property (strong, nonatomic) IBOutlet UILabel *lblFeedback;
@property (strong, nonatomic) IBOutlet UIImageView *arrow8;
@property (strong, nonatomic) IBOutlet UILabel *lblnotifiation;
@property (strong, nonatomic) IBOutlet UIImageView *imgnotification;
@property (strong, nonatomic) IBOutlet UIButton *btnNotification;
@property (strong, nonatomic) IBOutlet UIImageView *arrow9;
@property (strong, nonatomic) IBOutlet UILabel *lblRefferal;
@property (strong, nonatomic) IBOutlet UIImageView *imgrefferal;
@property (strong, nonatomic) IBOutlet UIButton *btnRefferal;
@property (strong, nonatomic) IBOutlet UILabel *lblMessage;
@property (strong, nonatomic) IBOutlet UILabel *lblpass;
@property (strong, nonatomic) IBOutlet UILabel *lblcust;

@property (strong, nonatomic) IBOutlet UIView *forgotView;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtOld;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtNewPass;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtConfirm;
@property (strong, nonatomic) IBOutlet UIButton *btnSavePass;
@property (strong, nonatomic) IBOutlet UILabel *lblCpassTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblW;
@property (strong, nonatomic) IBOutlet UILabel *lblAd;
@property (strong, nonatomic) IBOutlet UILabel *lblM;
@property (strong, nonatomic) IBOutlet UILabel *passEmail;

- (IBAction)backAction:(id)sender;
- (IBAction)orderAction:(id)sender;
- (IBAction)wishListAction:(id)sender;
- (IBAction)addressAction:(id)sender;
- (IBAction)languageAction:(id)sender;
- (IBAction)aedAction:(id)sender;
- (IBAction)walletAction:(id)sender;
- (IBAction)accountAction:(id)sender;
- (IBAction)helpAction:(id)sender;
- (IBAction)logoutAction:(id)sender;
- (IBAction)loginpageAction:(id)sender;
- (IBAction)stotesAction:(id)sender;
- (IBAction)changePasswordAction:(id)sender;
- (IBAction)saveActionPass:(id)sender;
- (IBAction)cancelpassAction:(id)sender;
- (IBAction)uploadPrescriptionAction:(id)sender;
- (IBAction)rewardAction:(id)sender;

@end
