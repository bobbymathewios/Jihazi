//
//  MedicineCell.h
//  MedMart
//
//  Created by Remya Das on 14/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@protocol SubDetailDelegate <NSObject>
-(void)ViewMoreSubAction:(int)tag;
@end
@interface MedicineCell : UITableViewCell
@property(nonatomic,assign)id<SubDetailDelegate>DEL;

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblSeller;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UILabel *lblSave;
@property (strong, nonatomic) IBOutlet UIImageView *imgSel;
@property (strong, nonatomic) IBOutlet UIButton *btnview;

- (IBAction)compareAction:(id)sender;
- (IBAction)viewMoreSubstitute:(id)sender;
@end
