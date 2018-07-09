//
//  OptionCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 21/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol OptionsDelegate <NSObject>
-(void)optionsPageAction:(int)tag;
@end
@interface OptionCell : UITableViewCell
@property(nonatomic,assign)id<OptionsDelegate>DEL;

@property (strong, nonatomic) IBOutlet UILabel *lblOptionName;
@property (strong, nonatomic) IBOutlet UILabel *lblOptionPrice;
@property (strong, nonatomic) IBOutlet UIImageView *imgSelect;
@property (strong, nonatomic) IBOutlet UIButton *btnView;
- (IBAction)viewOptionAction:(id)sender;

@end
