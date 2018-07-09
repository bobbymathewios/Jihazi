//
//  WishTableViewCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WishListDelegate <NSObject>
-(void)passButtonTagRemove:(NSInteger)tagBtn;
-(void)viewourProducts:(NSInteger)tagBtn;

@end
@interface WishTableViewCell : UITableViewCell
@property(nonatomic,assign)id<WishListDelegate>wishDel;
@property (strong, nonatomic) IBOutlet UIImageView *Imgitem;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblGram;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *notificationDate;
@property (strong, nonatomic) IBOutlet UIButton *btnDel;
@property (strong, nonatomic) IBOutlet UILabel *lblOffer;
@property (strong, nonatomic) IBOutlet UIButton *lblView;
- (IBAction)viewProductsAct:(id)sender;
- (IBAction)deleteAction:(id)sender;

@end
