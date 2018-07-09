//
//  MessageViewController.h
//  Jihazi
//
//  Created by Princy on 12/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ArabicLoginViewController.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"

@interface MessageViewController : UIViewController

@property(nonatomic,strong)NSString*fromLogin,*pID,*Pname,*mid,*type,*mname,*from,*reason,*oRID;

@property (weak, nonatomic) IBOutlet UIImageView *arrow;
@property (weak, nonatomic) IBOutlet UILabel *lblAskConnect;
@property (weak, nonatomic) IBOutlet UILabel *lblAskfrom;
@property (weak, nonatomic) IBOutlet UILabel *lblAskEmail;
@property (weak, nonatomic) IBOutlet UILabel *lblAskContact;
@property (weak, nonatomic) IBOutlet UILabel *lblAskTo;
@property (weak, nonatomic) IBOutlet UILabel *lblAskMerchantName;
@property (weak, nonatomic) IBOutlet UILabel *lblAskAbout;
@property (weak, nonatomic) IBOutlet UILabel *lblAskAbouttext;
@property (weak, nonatomic) IBOutlet UILabel *lblAskReason;
@property (weak, nonatomic) IBOutlet UITextField *txtAskReason;
@property (weak, nonatomic) IBOutlet UILabel *lblAskMessageTitle;
@property (weak, nonatomic) IBOutlet UITextView *txtAskMessage;
@property (weak, nonatomic) IBOutlet UIButton *btnASkSend;
- (IBAction)askSendMessageAction:(id)sender;
- (IBAction)askClose:(id)sender;
@end
