//
//  CombinationCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 22/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@protocol combinationDelegate <NSObject>

-(void)combinationAction:(NSString *)com1 second:(NSString *)com2;

@end
@interface CombinationCell : UITableViewCell<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,assign)id<combinationDelegate>ComDel;

@property (strong, nonatomic) IBOutlet UILabel *lblComboname;
@property (strong, nonatomic) IBOutlet UICollectionView *colCombo;
@property (strong, nonatomic) IBOutlet UIImageView *itemImg;

- (void)setCollectionData:(NSArray *)collectionData;


@end
