//
//  MenuTableViewCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 15/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@protocol ExpandDelegate <NSObject>
-(void)ExpandAction:(int)tag;
@end
@interface MenuTableViewCell : UITableViewCell
@property(nonatomic,assign)id<ExpandDelegate>ExpDEL;

@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UILabel *lblNme;
@property (strong, nonatomic) IBOutlet UIImageView *imgArrow;
@property (strong, nonatomic) IBOutlet UIImageView *imgline;
@property (strong, nonatomic) IBOutlet UIImageView *imgcheck;
@property (strong, nonatomic) IBOutlet UIImageView *imgArrow1;
@property (strong, nonatomic) IBOutlet UITextField *txtSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnExp;
@property (weak, nonatomic) IBOutlet UILabel *lblCount;

- (IBAction)ExpandAction:(id)sender;
@end
