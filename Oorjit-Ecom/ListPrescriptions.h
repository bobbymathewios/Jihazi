//
//  ListPrescriptions.h
//  MedMart
//
//  Created by Remya Das on 05/12/17.
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
#import "MyPreCell.h"

@interface ListPrescriptions : UIViewController<DeleteMyPrescriptionProtocol>
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *btnAra;
@property (strong, nonatomic) IBOutlet UIImageView *imgAra;
@property (strong, nonatomic) IBOutlet UIImageView *imgEng;
@property (strong, nonatomic) IBOutlet UIButton *btnEng;
@property (strong, nonatomic) IBOutlet UICollectionView *comPrescription;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnDone;
@property(nonatomic,strong)NSString *fromcart,*fromMyAccount;
- (IBAction)backAraAction:(id)sender;
- (IBAction)englishBackAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)doneAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblList;
@property (strong, nonatomic) IBOutlet UIImageView *imgLarge;
@property (strong, nonatomic) IBOutlet UIView *imgLargeView;
- (IBAction)closeAction:(id)sender;
@end
