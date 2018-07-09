//
//  MessageListViewController.h
//  Jihazi
//
//  Created by Princy on 12/05/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MessageCell.h"
#import "MessageDetailViewController.h"
@interface MessageListViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UITableView *tblMessages;

- (IBAction)backAction:(id)sender;
@end
