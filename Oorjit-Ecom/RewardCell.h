//
//  RewardCell.h
//  MedMart
//
//  Created by Remya Das on 26/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RewardCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblOD;
@property (strong, nonatomic) IBOutlet UILabel *lblS;
@property (strong, nonatomic) IBOutlet UILabel *lblA;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblStatusval;
@property (strong, nonatomic) IBOutlet UILabel *lblAmtVal;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderID;
@property (strong, nonatomic) IBOutlet UILabel *lblExpire;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine2;

@end
