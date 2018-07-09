//
//  ContactViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MessageUI/MessageUI.h>
#import "AppDelegate.h"
@interface ContactViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UIView *topViewObj;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lblLabel;
@property (strong, nonatomic) IBOutlet UITextField *txtEmail;
@property (strong, nonatomic) IBOutlet UITextField *txtMessage;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (strong, nonatomic) IBOutlet UIButton *btnSend;
@property (strong, nonatomic) IBOutlet UIButton *btnFaq;
@property (strong, nonatomic) IBOutlet UILabel *lblContact;
@property (strong, nonatomic) IBOutlet UIButton *b1;
@property(strong,nonatomic)NSString *fromwhere;
- (IBAction)backAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)sendAction:(id)sender;
- (IBAction)faqAtion:(id)sender;
@end
