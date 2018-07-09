//
//  AccountCell.h
//  MedMart
//
//  Created by Remya Das on 08/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AccountCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *lblCount;
@property (strong, nonatomic) IBOutlet UIButton *btnaed;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine;
@property (strong, nonatomic) IBOutlet UILabel *lblLog;
@property (strong, nonatomic) IBOutlet UIImageView *imgLog;
@property (weak, nonatomic) IBOutlet UILabel *lblNotificationCount;
@end
