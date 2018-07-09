//
//  PrescriptionConfirmation.h
//  MedMart
//
//  Created by Remya Das on 04/12/17.
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
#import "OrderSummery.h"


@interface PrescriptionConfirmation : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *btnAra;
@property (strong, nonatomic) IBOutlet UIImageView *imgAra;
@property (strong, nonatomic) IBOutlet UIImageView *imgEng;
@property (strong, nonatomic) IBOutlet UIButton *btnEng;
@property (strong, nonatomic) IBOutlet UICollectionView *comPrescription;
@property (strong, nonatomic) IBOutlet UIButton *btnproceed;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgE1;
@property (strong, nonatomic) IBOutlet UIImageView *imgA1;
@property (strong, nonatomic) IBOutlet UIImageView *imgE2;
@property (strong, nonatomic) IBOutlet UIImageView *imgA2;
@property (strong, nonatomic) IBOutlet UIImageView *imgE3;
@property (strong, nonatomic) IBOutlet UIImageView *imgA3;
@property (strong, nonatomic) IBOutlet UIButton *btn3;
@property (strong, nonatomic) IBOutlet UITextField *txtMedicine;
@property (strong, nonatomic) IBOutlet UIButton *btn1;
@property (strong, nonatomic) IBOutlet UIButton *btn2;
@property (strong, nonatomic) IBOutlet UITextField *txtCall;
@property (strong, nonatomic) IBOutlet UILabel *lbl;
@property (strong, nonatomic) IBOutlet UILabel *lbl1;
@property (strong, nonatomic) IBOutlet UILabel *lbl2;
@property (strong, nonatomic) IBOutlet UILabel *lbl3;
@property (strong, nonatomic) IBOutlet UIButton *btn;

@property(nonatomic,strong) NSArray *colArray;
@property(nonatomic,strong)NSString *URl;
@property (strong, nonatomic) IBOutlet UITextField *txtView;

- (IBAction)backAraAction:(id)sender;
- (IBAction)englishBackAction:(id)sender;
- (IBAction)proceedAction:(id)sender;
- (IBAction)allMedicineAction:(id)sender;
- (IBAction)SpecifyAction:(id)sender;
- (IBAction)callAction:(id)sender;
- (IBAction)attachedAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgLarge;
@property (strong, nonatomic) IBOutlet UIView *imgLargeView;
- (IBAction)closeAction:(id)sender;
@end
