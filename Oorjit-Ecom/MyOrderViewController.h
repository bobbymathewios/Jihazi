//
//  MyOrderViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "OrderTableViewCell.h"
#import "OrderDetailsViewController.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "AboutViewController.h"
#import "CancelOrderViewController.h"
#import "OrderCancelViewController.h"
#import "CartViewController.h"
@interface MyOrderViewController : UIViewController<OrderDelegate>
@property (strong, nonatomic) IBOutlet UIButton *b1;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UITableView *tblOrder;
@property(nonatomic,strong)NSString *fromMenu,*type;
- (IBAction)backAction:(id)sender;
@end
