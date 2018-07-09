//
//  SubCell.h
//  MedMart
//
//  Created by Remya Das on 09/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblSID;
@property (strong, nonatomic) IBOutlet UILabel *lbldate;
@property (strong, nonatomic) IBOutlet UILabel *lblStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblItem;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (weak, nonatomic) IBOutlet UIButton *btnDelete;
@property (weak, nonatomic) IBOutlet UIImageView *img;

- (IBAction)pauseAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
@end
