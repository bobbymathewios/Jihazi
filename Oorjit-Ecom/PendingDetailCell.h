//
//  PendingDetailCell.h
//  MedMart
//
//  Created by Remya Das on 29/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PendingDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblOrderedAt;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UITextView *txtAddres;
@property (strong, nonatomic) IBOutlet UILabel *lblSpe;

@end
