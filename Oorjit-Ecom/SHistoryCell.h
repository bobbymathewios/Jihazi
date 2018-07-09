//
//  SHistoryCell.h
//  MedMart
//
//  Created by Remya Das on 22/02/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SHistoryCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *lblname;
@property (strong, nonatomic) IBOutlet UILabel *lblQty;
@property (strong, nonatomic) IBOutlet UILabel *lblSS;
@property (strong, nonatomic) IBOutlet UILabel *lblSD;
@property (strong, nonatomic) IBOutlet UILabel *lblCary;
@property (strong, nonatomic) IBOutlet UILabel *lblTrack;
@property (strong, nonatomic) IBOutlet UILabel *lblExlTit;
@property (strong, nonatomic) IBOutlet UILabel *lblExpD;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (weak, nonatomic) IBOutlet UILabel *lbl1;
@property (weak, nonatomic) IBOutlet UILabel *lbl2;
@property (weak, nonatomic) IBOutlet UILabel *lbl3;
@property (weak, nonatomic) IBOutlet UILabel *lbl4;

@end
