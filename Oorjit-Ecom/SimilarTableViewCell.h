//
//  SimilarTableViewCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 06/11/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "ItemCollectionViewCell.h"
@protocol viewSililarAllDelegate <NSObject>

-(void)productSimilarDetailDel:(NSString *)pid;
-(void)FavouriteAddAction:(NSString *)pid second:(NSString *)sender;

@end
@interface SimilarTableViewCell : UITableViewCell<FavHomeDelegate>
@property(nonatomic,assign)id<viewSililarAllDelegate>ViewDEL;

@property (strong, nonatomic) IBOutlet UILabel *lblItem;
@property (strong, nonatomic) IBOutlet UICollectionView *colItem;
- (void)setCollectionData:(NSArray *)collectionData;
@property (strong, nonatomic) IBOutlet UIImageView *imgline;

@end
