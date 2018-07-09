//
//  MyPreCell.h
//  MedMart
//
//  Created by Remya Das on 18/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DeleteMyPrescriptionProtocol <NSObject>

-(void)removePrescriptionDelegate:(int)tag;

@end
@interface MyPreCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UIButton *btnDel;

@property(nonatomic,assign)id<DeleteMyPrescriptionProtocol>DeletePresDelegate;


- (IBAction)deleteAction:(id)sender;
@end
