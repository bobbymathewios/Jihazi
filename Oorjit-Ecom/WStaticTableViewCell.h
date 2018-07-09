//
//  WStaticTableViewCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 25/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
@protocol HomeWidDelegate <NSObject>
-(void)viewlistDelMethod:(NSString *)tagBtn second:(NSString *)tagBtnmain;
@end
@interface WStaticTableViewCell : UITableViewCell
@property(nonatomic,assign)id<HomeWidDelegate>ItemDelegate;
@property (strong, nonatomic) IBOutlet UIButton *btn;

@property (strong, nonatomic) IBOutlet UIImageView *imgStatic;
@property (strong, nonatomic) IBOutlet UIWebView *web;
@property (strong, nonatomic) IBOutlet UIButton *btnB1;
@property (strong, nonatomic) IBOutlet UIButton *btnB2;
@property (strong, nonatomic) IBOutlet UICollectionView *colItems;
-(void)loadFirstImg:(NSString *)str;
- (IBAction)viewButtonAction:(id)sender;
@end
