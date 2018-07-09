//
//  SubDateCell.h
//  MedMart
//
//  Created by Remya Das on 11/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SubscribeCancelProtocol <NSObject>
-(void)CancelSubItemDelegate:(int)tag second:(NSString *)title;
-(void)detailOrderDelegate:(int)tag;
@end
@interface SubDateCell : UITableViewCell
@property(nonatomic,assign)id<SubscribeCancelProtocol>SUBCANDelegate;

@property (weak, nonatomic) IBOutlet UILabel *lblDay;
@property (weak, nonatomic) IBOutlet UILabel *lblYear;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderSub;
@property (weak, nonatomic) IBOutlet UILabel *lblOrderTota;
@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UILabel *lblNmae;
@property (weak, nonatomic) IBOutlet UILabel *lblDis;
@property (weak, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIView *viewObj;
- (IBAction)cancelAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblShip;
- (IBAction)orderDetailAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnOD;

@end
