//
//  ThankYouViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 12/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface ThankYouViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIImageView *imgLogo;
@property (strong, nonatomic) IBOutlet UIButton *btnClose;
@property (strong, nonatomic) IBOutlet UIButton *btnFb;
@property (strong, nonatomic) IBOutlet UIButton *btnGPlus;
@property (strong, nonatomic) IBOutlet UIButton *btnTwitter;
@property (strong, nonatomic) IBOutlet UIButton *btn;
@property (strong, nonatomic) IBOutlet UIButton *btnLinkedin;
@property (strong, nonatomic) IBOutlet UIButton *btnCountinue;
@property (strong, nonatomic) IBOutlet UITextView *txtOrderresponse;
@property (strong, nonatomic) IBOutlet UILabel *lblThank;
@property (strong, nonatomic) IBOutlet UILabel *lblorder;

@property(nonatomic,strong)NSString *strResponse,*frompre;
@property(nonatomic,strong)NSDictionary *dic;
- (IBAction)followAction:(id)sender;
- (IBAction)closeAction:(id)sender;
- (IBAction)countinueAction:(id)sender;
@end
