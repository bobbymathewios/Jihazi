//
//  AccountViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 17/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import <AssetsLibrary/AssetsLibrary.h>


@interface AccountViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextView *billingTxt;
@property (strong, nonatomic) IBOutlet UIButton *btnback1;
@property (strong, nonatomic) IBOutlet UIButton *btnBack2;
@property (strong, nonatomic) IBOutlet UIImageView *imgprofile;
@property (strong, nonatomic) IBOutlet UIButton *btnedit;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UILabel *lblmale1;
@property (strong, nonatomic) IBOutlet UIButton *btnMale1;
@property (strong, nonatomic) IBOutlet UILabel *lblFemale1;
@property (strong, nonatomic) IBOutlet UIButton *btnFemale1;
- (IBAction)mySwitch:(id)sender;
@property (strong, nonatomic) IBOutlet UISwitch *mySwitchObj;
@property (strong, nonatomic) IBOutlet UILabel *lblFemale2;
@property (strong, nonatomic) IBOutlet UILabel *lblMale2;
@property (strong, nonatomic) IBOutlet UIButton *btnFemale2;
@property (strong, nonatomic) IBOutlet UIButton *btnMale2;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtFirstName;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtLastNmae;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtDOB;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtMobileNumber;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtEmailAddress;

@property (strong, nonatomic) IBOutlet UIButton *btnSave;

@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@property (strong, nonatomic) IBOutlet UILabel *lbltitle;
@property(nonatomic,strong)NSString *fromMenu;

@property (strong, nonatomic) IBOutlet UIDatePicker *picDate;

- (IBAction)backOneAction:(id)sender;
- (IBAction)backTwoAction:(id)sender;
- (IBAction)editAction:(id)sender;
- (IBAction)maleEngAction:(id)sender;
- (IBAction)femaleEngAction:(id)sender;
- (IBAction)femaleAraAction:(id)sender;
- (IBAction)maleAraAction:(id)sender;
- (IBAction)saveAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgEngFemaleSel;
@property (strong, nonatomic) IBOutlet UIImageView *imgEngMaleSel;
@property (strong, nonatomic) IBOutlet UIButton *b2;
@property (strong, nonatomic) IBOutlet UIImageView *imgArmaleSel;
@property (strong, nonatomic) IBOutlet UIButton *b1;
@property (strong, nonatomic) IBOutlet UIImageView *imgAraFemaleSel;
@property (strong, nonatomic) IBOutlet UILabel *lbbb;
@property (strong, nonatomic) IBOutlet UIButton *btned;
@property (strong, nonatomic) IBOutlet UILabel *lblge;
@property (weak, nonatomic) IBOutlet UILabel *lblNoti;
- (IBAction)editActionAddress:(id)sender;
@end

