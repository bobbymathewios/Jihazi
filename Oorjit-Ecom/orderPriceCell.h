//
//  orderPriceCell.h
//  Favot
//
//  Created by Remya Das on 03/08/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface orderPriceCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblSubtotal;
@property (strong, nonatomic) IBOutlet UILabel *lblTotal;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine;

@end
