//
//  InvoiceDetailCell.h
//  Favot
//
//  Created by Remya Das on 03/08/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OrderReturnDelegate <NSObject>
-(void)ReturnDetails;
@end
@interface InvoiceDetailCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lbl1;
@property (strong, nonatomic) IBOutlet UILabel *lbl2;
@property (strong, nonatomic) IBOutlet UILabel *lbl3;
@property (strong, nonatomic) IBOutlet UILabel *lbl4;
@property (strong, nonatomic) IBOutlet UILabel *lbl5;
@property (weak, nonatomic) IBOutlet UILabel *lblVat;
@property (weak, nonatomic) IBOutlet UILabel *lbl6;

@property(nonatomic,assign)id<OrderReturnDelegate>returnDelegateObj;
@property (strong, nonatomic) IBOutlet UILabel *lblin;

@property (strong, nonatomic) IBOutlet UILabel *lblOrderID;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderAt;
@property (strong, nonatomic) IBOutlet UILabel *lblOrderStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblPaymentStatus;
@property (strong, nonatomic) IBOutlet UILabel *lblChoosenDeliDate;
@property (strong, nonatomic) IBOutlet UILabel *lblAmt;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine;
@property (strong, nonatomic) IBOutlet UIButton *btnPrescription;
- (IBAction)uploadPrescription:(id)sender;
@property (strong, nonatomic) IBOutlet UIImageView *imgLine1;
@property (strong, nonatomic) IBOutlet UIButton *btnReturn;
- (IBAction)returnAction:(id)sender;

@end
