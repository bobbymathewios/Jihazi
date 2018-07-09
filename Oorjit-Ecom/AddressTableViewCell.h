//
//  AddressTableViewCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 17/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol EditProtocol <NSObject>

-(void)editAddressDelegate:(int)tag;
-(void)removeAddressDelegate:(int)tag;

@end
@interface AddressTableViewCell : UITableViewCell
{
    int x;
}
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblPhone;
@property (strong, nonatomic) IBOutlet UITextView *addressTxtView;
@property (strong, nonatomic) IBOutlet UIView *editView;
@property (strong, nonatomic) IBOutlet UIButton *btne;
@property (strong, nonatomic) IBOutlet UIButton *btnr;
@property (strong, nonatomic) IBOutlet UIImageView *imgSel;

- (IBAction)editAction:(id)sender;
- (IBAction)editAddrAction:(id)sender;
- (IBAction)removeAction:(id)sender;

@property(nonatomic,assign)id<EditProtocol>EDITDelegate;
@end
