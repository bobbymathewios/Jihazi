//
//  OrderAddressCell.h
//  Favot
//
//  Created by Remya Das on 03/08/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderAddressCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblDelivery;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UITextView *txt;
@property (strong, nonatomic) IBOutlet UIImageView *imgl;

@end
