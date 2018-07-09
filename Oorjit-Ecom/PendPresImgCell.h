//
//  PendPresImgCell.h
//  MedMart
//
//  Created by Remya Das on 02/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
@protocol PendingPrescriptionDelegate <NSObject>

-(void)largeImg:(NSString*)str url:(NSString *)urlName;
@end
@interface PendPresImgCell : UITableViewCell
{
    NSArray *colArray;
}
@property(nonatomic,assign)id<PendingPrescriptionDelegate>preDelegateObj;
@property (strong, nonatomic) IBOutlet UICollectionView *col;
-(void)loadPrescription:(NSArray *)array  urlStr:(NSString*)url;

@end
