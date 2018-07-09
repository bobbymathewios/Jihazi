//
//  NotificationDetailViewController.h
//  Jihazi
//
//  Created by Apple on 12/04/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Loading.h"
#import "WebService.h"
@interface NotificationDetailViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UILabel *titleLbl;
@property (strong, nonatomic) IBOutlet UIImageView *imgView;
@property (strong, nonatomic) IBOutlet UILabel *lblone;
@property (strong, nonatomic) IBOutlet UILabel *lblNoti;
@property (strong, nonatomic) IBOutlet UILabel *lbldate;
- (IBAction)backAct:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *b1;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) NSString *notiId,*imgUrl,*title,*detail,*date;
@end
