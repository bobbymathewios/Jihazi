//
//  OrderTableViewCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 19/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol OrderDelegate <NSObject>
-(void)cancelDelAction:(int)tagBtn second:(NSString*)title;
-(void)helpDelAction:(int)tagBtn;


@end
@interface OrderTableViewCell : UITableViewCell
@property(nonatomic,assign)id<OrderDelegate>orderDelegateObj;

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *lblname;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderID;
@property (strong, nonatomic) IBOutlet UILabel *lblDeliverdDate;
@property (strong, nonatomic) IBOutlet UIButton *btnHelp;
@property (strong, nonatomic) IBOutlet UIImageView *imgDot;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UILabel *lblViewmore;
@property (strong, nonatomic) IBOutlet UILabel *lblo;

- (IBAction)helpAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
@end
