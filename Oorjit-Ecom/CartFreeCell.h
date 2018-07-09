//
//  CartFreeCell.h
//  Jihazi
//
//  Created by Remya Das on 14/03/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ItemCollectionViewCell.h"
@protocol viewFreeAllDelegate <NSObject>

-(void)productSimilarDetailDel:(NSString *)pid;
-(void)FavouriteAddAction:(NSString *)pid second:(NSString *)sender;
-(void)productaddCart:(NSArray *)array second:(NSString *)colID;
-(void)productRemoveCart:(NSArray *)array second:(NSString *)colID;


@end
@interface CartFreeCell : UITableViewCell<FavHomeDelegate>
@property(nonatomic,assign)id<viewFreeAllDelegate>ViewDEL;
@property (strong, nonatomic) IBOutlet UIView *v1;

@property (strong, nonatomic) IBOutlet UILabel *lblItem;
@property (strong, nonatomic) IBOutlet UICollectionView *colItem;
- (void)setCollectionData:(NSArray *)collectionData second:(NSString*)isAddFullGift;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) IBOutlet UILabel *lblTotSel;
@property (strong, nonatomic) IBOutlet UIImageView *imgline;
@end
