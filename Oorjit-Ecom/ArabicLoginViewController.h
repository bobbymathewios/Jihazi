//
//  ArabicLoginViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 18/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789#!_"

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDelegate.h"
#import "CartViewController.h"
#import "JVFloatLabeledTextField.h"

@interface ArabicLoginViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UIButton *btnClose;
@property (strong, nonatomic) IBOutlet UIView *loginView;

@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtEmail;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtPassword;

@property (strong, nonatomic) IBOutlet UIImageView *imgLine1;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine2;
@property (strong, nonatomic) IBOutlet UIButton *btnLogin;
@property (strong, nonatomic) IBOutlet UIButton *btnForgot;
@property (strong, nonatomic) IBOutlet UIButton *btnFB;
@property (strong, nonatomic) IBOutlet UIButton *btnGplus;
@property (strong, nonatomic) IBOutlet UIButton *btnSignUp;
@property (strong, nonatomic) IBOutlet UIView *signupView;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine3;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine4;

@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtEmailAddress;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtname;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtPassword1;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine5;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtConfirm;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtPhone;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtLast;

@property (strong, nonatomic) IBOutlet UIImageView *imgLine6;
@property (strong, nonatomic) IBOutlet UIButton *btnLog;
@property (strong, nonatomic) IBOutlet UIButton *btnSign;
@property (strong, nonatomic) IBOutlet UIView *forgotView;

@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtForgot;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine7;

@property (strong, nonatomic) IBOutlet UIButton *btnForgot1;
@property (strong, nonatomic) IBOutlet UIButton *btnFl;
@property (strong, nonatomic) IBOutlet UIButton *btnAgree;
@property (strong, nonatomic) IBOutlet UIButton *btnkeepmesignin;
- (IBAction)signUpAction1:(id)sender;
- (IBAction)forgotpasswordAction:(id)sender;
- (IBAction)forgotLoginAction:(id)sender;
- (IBAction)agreeAction:(id)sender;

- (IBAction)closeAction:(id)sender;
- (IBAction)loginAction:(id)sender;
- (IBAction)forgotAction:(id)sender;
- (IBAction)fbAction:(id)sender;
- (IBAction)GPlusAction:(id)sender;
- (IBAction)signUpAction:(id)sender;
- (IBAction)login1Acion:(id)sender;
- (IBAction)keepSignInAction:(id)sender;
- (IBAction)termsAction:(id)sender;
- (IBAction)loginTabAction:(id)sender;
- (IBAction)signupTabAction:(id)sender;
@property(nonatomic,strong)NSString *fromWhere,*productID,*productOptID,*qty,*productImg,*productName,*currency,*verifyphone,*MsgPID,*MsgPname,*MsgMessage,*MsgReason,*MsgMerchant;
@property (strong, nonatomic) IBOutlet UILabel *lblagreeee;
@property (weak, nonatomic) IBOutlet UIButton *btnB1;
@property (weak, nonatomic) IBOutlet UIButton *btnB2;
@property (weak, nonatomic) IBOutlet UIButton *btnB3;
@end
