//
//  SellerCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 21/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SellerCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgSellerLogo;
@property (strong, nonatomic) IBOutlet UILabel *lblAvg;
@property (strong, nonatomic) IBOutlet UILabel *lblAvgCount;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate1;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate2;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate3;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate4;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate5;
@property (strong, nonatomic) IBOutlet UILabel *lblSelNAme;
@property (weak, nonatomic) IBOutlet UILabel *lblNewPrice;
@property (weak, nonatomic) IBOutlet UILabel *lblOldPrice;
@property (weak, nonatomic) IBOutlet UIButton *btnBuy;
@property (weak, nonatomic) IBOutlet UILabel *lbloffer;
@property (weak, nonatomic) IBOutlet UIView *rateView;

- (IBAction)buyProduct:(id)sender;
@end
