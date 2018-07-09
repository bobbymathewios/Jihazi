//
//  WiriteReviewViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 22/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

@interface WiriteReviewViewController : UIViewController
@property(nonatomic,strong)NSString *productID,*fromLogin;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UIButton *btn4;
@property (strong, nonatomic) IBOutlet UIButton *btn5;
@property (strong, nonatomic) IBOutlet UITextField *txtHeadline;
@property (strong, nonatomic) IBOutlet UITextView *txtComments;
@property (strong, nonatomic) IBOutlet UIButton *btnSubmit;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollObj;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *btnAra;
@property (strong, nonatomic) IBOutlet UILabel *lblReiview;
@property (strong, nonatomic) IBOutlet UIButton *btnEng;
@property (weak, nonatomic) IBOutlet UILabel *lblrate;
- (IBAction)rateOneAction:(id)sender;
- (IBAction)rateTWoAction:(id)sender;
- (IBAction)rateThreeAction:(id)sender;
- (IBAction)rateFourAction:(id)sender;
- (IBAction)rateFiveAction:(id)sender;
- (IBAction)submitAction:(id)sender;
- (IBAction)arabicbackAction:(id)sender;
- (IBAction)englishBackAction:(id)sender;
@end
