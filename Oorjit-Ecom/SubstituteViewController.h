//
//  SubstituteViewController.h
//  MedMart
//
//  Created by Remya Das on 21/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MedicineCell.h"
#import "ItemCollectionViewCell.h"
#import "CartFreeCell.h"

@interface SubstituteViewController : UIViewController<FavHomeDelegate,viewFreeAllDelegate,UITableViewDelegate,UITableViewDataSource>
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UITableView *tblList;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblSeller;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIView *v1;
@property (strong, nonatomic) IBOutlet UICollectionView *col;
@property (strong, nonatomic) IBOutlet UILabel *lbltitle;
@property (strong, nonatomic) IBOutlet UILabel *lblChoose;
@property (strong, nonatomic) IBOutlet UIView *encodeView;
@property (strong, nonatomic) IBOutlet UIImageView *immm;
@property (strong, nonatomic) IBOutlet UILabel *lblnames;
@property (strong, nonatomic) IBOutlet UIView *v3;

@property (strong, nonatomic) IBOutlet UIImageView *imgprescription;
@property (strong, nonatomic) IBOutlet UILabel *lblffreeAdded;
@property(nonatomic , strong)NSString *pid,*pname,*pseller,*pimg,*imgUrl,*freecount,*optID,*from,*dedCount,*PRODUCTID;
@property (strong, nonatomic) IBOutlet UILabel *lblfreeToal;
@property(nonatomic)int count;
@property(nonatomic,strong)NSArray *arrayFree;
@property (strong, nonatomic) IBOutlet UIView *v2;
@property (strong, nonatomic) IBOutlet UITableView *tblEncode;
- (IBAction)canceAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;

- (IBAction)backAction:(id)sender;
- (IBAction)addToCartAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnadd;
- (IBAction)closeAction:(id)sender;
@property (strong, nonatomic) IBOutlet UITableView *tblOption;
@property (strong, nonatomic) IBOutlet UIButton *btnOptCancel;
- (IBAction)otpCancelAction:(id)sender;
- (IBAction)optAddtocartAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnOptAdd;
@property (strong, nonatomic) IBOutlet UILabel *lbloptTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgOpt;
@property (strong, nonatomic) IBOutlet UIView *optV2;
@property (strong, nonatomic) IBOutlet UIView *optView;
@property (strong, nonatomic) IBOutlet UIView *optv1;

@end
