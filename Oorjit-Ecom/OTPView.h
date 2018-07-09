//
//  OTPView.h
//  Jihazi
//
//  Created by Remya Das on 13/03/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WebService.h"
#import "Loading.h"
#import "MessageViewController.h"
@interface OTPView : UIViewController<UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblSMS;
@property (strong, nonatomic) IBOutlet UILabel *lblMessage;
@property (strong, nonatomic) IBOutlet UITextField *txtPhone;
@property (strong, nonatomic) IBOutlet UITextField *txtOtp;
@property (strong, nonatomic) IBOutlet UIButton *btnVerify;
@property (strong, nonatomic) IBOutlet UIView *v;
@property (strong, nonatomic) IBOutlet UILabel *lbl;
@property (weak, nonatomic) IBOutlet UILabel *lblsms1;

@property (weak, nonatomic) IBOutlet UILabel *lblVerify;
@property(nonatomic,strong)NSString *mobile,*fromWhere,*productID,*status,*loginType;
@property(nonatomic,strong)NSDictionary *result;
@property (strong, nonatomic) IBOutlet UILabel *mtTimer;
@property (weak, nonatomic) IBOutlet UIButton *btnResend;
@property (weak, nonatomic) IBOutlet UIImageView *imgPhone;

- (IBAction)backAction:(id)sender;
- (IBAction)verifyAction:(id)sender;
- (IBAction)ResendAction:(id)sender;
- (IBAction)closeAction:(id)sender;
@end
