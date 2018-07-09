//
//  bundleDetailViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 16/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "AppDelegate.h"
#import "BundleCollectionViewCell.h"
#import "ListTableViewCell.h"
#import "SpecificationCell.h"

@interface bundleDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollObj;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *btbAraBack;
@property (strong, nonatomic) IBOutlet UIButton *btnEngback;
@property (strong, nonatomic) IBOutlet UIImageView *imgProDuct;
@property (strong, nonatomic) IBOutlet UILabel *lblBunBleName;
@property (strong, nonatomic) IBOutlet UILabel *lblBundleItemCount;
@property (strong, nonatomic) IBOutlet UILabel *lblRegPriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *lblRegPriceValue;
@property (strong, nonatomic) IBOutlet UILabel *lblYouSave;
@property (strong, nonatomic) IBOutlet UILabel *lblYouSaveValue;
@property (strong, nonatomic) IBOutlet UILabel *lblBundlePriceLabel;
@property (strong, nonatomic) IBOutlet UILabel *lblBundlePriceValue;
@property (strong, nonatomic) IBOutlet UIButton *btnBuyNow;
@property (strong, nonatomic) IBOutlet UITableView *tblItems;
@property (strong, nonatomic) IBOutlet UICollectionView *colView;
@property (strong, nonatomic) IBOutlet UILabel *lbltitle;
@property (weak, nonatomic) IBOutlet UILabel *lbloff;
@property (weak, nonatomic) IBOutlet UILabel *lblinclude;
@property (weak, nonatomic) IBOutlet UILabel *llinclude1;
@property (weak, nonatomic) IBOutlet UILabel *lbltot;
@property (weak, nonatomic) IBOutlet UIButton *btnbuy;


@property (nonatomic,strong)NSString *bundleKey;
@property (weak, nonatomic) IBOutlet UILabel *lblold;

- (IBAction)arabicbackAction:(id)sender;
- (IBAction)engBackAction:(id)sender;
- (IBAction)buyNowAction:(id)sender;
@end
