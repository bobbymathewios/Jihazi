//
//  PreOrderCell.h
//  MedMart
//
//  Created by Remya Das on 28/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
@protocol OrderPrescriptionDelegate <NSObject>
-(void)UploadAction:(int)tagBtn ;
-(void)removeAction:(NSString*)str;
-(void)largeImg:(NSString*)str url:(NSString *)urlName;

@end
@interface PreOrderCell : UITableViewCell
{
    NSArray *colArray;
}
@property(nonatomic,assign)id<OrderPrescriptionDelegate>preDelegateObj;

@property (strong, nonatomic) IBOutlet UIButton *btnPre;
@property (strong, nonatomic) IBOutlet UILabel *lblpre;
@property (strong, nonatomic) IBOutlet UICollectionView *col;
- (IBAction)uploadAction:(id)sender;
-(void)loadPrescription:(NSArray *)array  urlStr:(NSString*)url;
@property (strong, nonatomic) IBOutlet UIImageView *imgDown;

@end
