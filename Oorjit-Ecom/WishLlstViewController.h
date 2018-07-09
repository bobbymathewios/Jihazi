//
//  WishLlstViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "WishTableViewCell.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "ItemCollectionViewCell.h"
#import "WishLlstViewController.h"
@interface WishLlstViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UITableView *tblOrder;
@property (strong, nonatomic) IBOutlet UICollectionView *colListView;
@property(nonatomic,strong)NSString *fromMenu,*type,*fromlogin;
- (IBAction)backAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *b1;
@end
