//
//  BundleViewController.h
//  Jihazi
//
//  Created by Princy on 11/04/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "AppDelegate.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "BundleCell.h"
#import "bundleDetailViewController.h"
@interface BundleViewController : UIViewController
@property (weak, nonatomic) IBOutlet UICollectionView *colList;
@property (weak, nonatomic) IBOutlet UIView *topView;
- (IBAction)backAction:(id)sender;
- (IBAction)cartAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *lblCartCount;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imgLine;

@end
