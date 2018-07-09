//
//  WidgetTableViewCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 25/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ItemCollectionViewCell.h"
@protocol viewAllDelegate <NSObject>

-(void)viewAllActionDel:(int)tag;
-(void)productDetailDel:(NSString *)pid;
-(void)productDetailBundleDelegate:(NSString *)pid;
-(void)FavouriteAddAction:(NSString *)pid second:(NSString *)sender;
-(void)productaddCart:(NSArray *)array second:(NSString *)colID;

@end
@interface WidgetTableViewCell : UITableViewCell<FavHomeDelegate>

@property(nonatomic,assign)id<viewAllDelegate>ViewDEL;

@property (strong, nonatomic) IBOutlet UIImageView *widgetImage;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UIButton *btnViewAll;
@property (strong, nonatomic) IBOutlet UICollectionView *colItem;

- (IBAction)viewAllAction:(id)sender;

- (void)setCollectionData:(NSArray *)collectionData;

@end
