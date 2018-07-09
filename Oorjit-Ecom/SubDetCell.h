//
//  SubDetCell.h
//  MedMart
//
//  Created by Remya Das on 11/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubDetCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblsid;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lblstatus;
@property (strong, nonatomic) IBOutlet UILabel *lblitem;
@property (strong, nonatomic) IBOutlet UILabel *lblrun;
@property (strong, nonatomic) IBOutlet UILabel *lbllast;
@property (strong, nonatomic) IBOutlet UILabel *lblnext;
@property (strong, nonatomic) IBOutlet UIImageView *line;

@end
