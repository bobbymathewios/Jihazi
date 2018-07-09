//
//  OrderItemCell.h
//  Favot
//
//  Created by Remya Das on 03/08/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface OrderItemCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *orderItem;
@property (strong, nonatomic) IBOutlet UILabel *lblItemname;
@property (strong, nonatomic) IBOutlet UILabel *lblQty;
@property (strong, nonatomic) IBOutlet UILabel *lblCount;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblShippingMethod;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderStatus;
@property (strong, nonatomic) IBOutlet UILabel *llll;
@property (strong, nonatomic) IBOutlet UILabel *lb;

@end
