//
//  SellerListCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 07/11/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BuyBoxDelegate <NSObject>
-(void)buyBoxAction:(int)tag;
@end
@interface SellerListCell : UITableViewCell
@property(nonatomic,assign)id<BuyBoxDelegate>BuyDEL;
@property (weak, nonatomic) IBOutlet UILabel *lblNew;
@property (weak, nonatomic) IBOutlet UILabel *lblold;
@property (weak, nonatomic) IBOutlet UILabel *lbloffer;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;
- (IBAction)BuyAction:(id)sender;

@end
