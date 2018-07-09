//
//  MessageCell.h
//  Jihazi
//
//  Created by Princy on 12/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MessageCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblMessage;
@property (weak, nonatomic) IBOutlet UILabel *lblDate;

@end
