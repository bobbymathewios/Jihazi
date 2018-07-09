//
//  UploadPrescription.h
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
#import "PrescriptionConfirmation.h"
#import "ListPrescriptions.h"
#import "Loading.h"

@interface UploadPrescription : UIViewController
@property (strong, nonatomic) IBOutlet UIView *firstView;
@property (strong, nonatomic) IBOutlet UIScrollView *scroll;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIView *prescriptionGuideView;
@property (strong, nonatomic) IBOutlet UIButton *btnAra;
@property (strong, nonatomic) IBOutlet UIImageView *imgAra;
@property (strong, nonatomic) IBOutlet UIImageView *imgEng;
@property (strong, nonatomic) IBOutlet UIButton *btnEng;
@property (strong, nonatomic) IBOutlet UILabel *lblGuideTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbl1;
@property (strong, nonatomic) IBOutlet UILabel *lbl2;
@property (strong, nonatomic) IBOutlet UILabel *lbl3;
@property (strong, nonatomic) IBOutlet UILabel *lbl4;
@property (strong, nonatomic) IBOutlet UILabel *lblShowSample;
@property (strong, nonatomic) IBOutlet UIButton *btnSample;
@property (strong, nonatomic) IBOutlet UIImageView *imgSample;
@property (strong, nonatomic) IBOutlet UICollectionView *comPrescription;
@property (strong, nonatomic) IBOutlet UILabel *lblCamera;
@property (strong, nonatomic) IBOutlet UILabel *lblGallery;
@property (strong, nonatomic) IBOutlet UILabel *lblmyPres;
@property (strong, nonatomic) IBOutlet UIImageView *imgPrescription;
@property (strong, nonatomic) IBOutlet UIButton *btnproceed;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;

@property(nonatomic,strong)NSString *fromlogin,*frommenu,*fromMyAccount,*order;
@property (strong, nonatomic) IBOutlet UIImageView *selImg;

- (IBAction)backAraAction:(id)sender;
- (IBAction)englishBackAction:(id)sender;
- (IBAction)showSampleAction:(id)sender;
- (IBAction)cameraAction:(id)sender;
- (IBAction)galleryAction:(id)sender;
- (IBAction)prescriptionAction:(id)sender;
- (IBAction)proceedAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgLarge;
@property (strong, nonatomic) IBOutlet UIView *imgLargeView;
- (IBAction)closeAction:(id)sender;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *colH;
@end
