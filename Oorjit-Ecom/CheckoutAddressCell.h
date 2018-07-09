//
//  CheckoutAddressCell.h
//  Favot
//
//  Created by Remya Das on 26/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ChangeAddressDelegate <NSObject>

-(void)changeAddressAction:(NSString *)tag;

@end
@interface CheckoutAddressCell : UITableViewCell
@property(nonatomic,assign)id<ChangeAddressDelegate> ChangEDEl;
@property (weak, nonatomic) IBOutlet UILabel *lblEdit;

@property (strong, nonatomic) IBOutlet UIImageView *imgSelect;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) IBOutlet UILabel *lblAddress;
@property (strong, nonatomic) IBOutlet UIButton *btnChange;

- (IBAction)changeAddressAction:(id)sender;
@end
