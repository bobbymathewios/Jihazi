//
//  ListTableViewCell.h
//  Favol
//
//  Created by Remya Das on 10/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//
#import <UIKit/UIKit.h>
@protocol itemQuantityDelegate <NSObject>

-(void)itemCount:(NSString *)countValueDel;
-(void)passButtonTag:(int)tagBtn;

@end

@interface ListTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UILabel *price;
@property (weak, nonatomic) IBOutlet UILabel *lblPl;


@property (strong, nonatomic) IBOutlet UIImageView *Imgitem;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblGram;
@property (strong, nonatomic) IBOutlet UILabel *lblPrice;
@property (strong, nonatomic) IBOutlet UIButton *btnIncrement;
@property (strong, nonatomic) IBOutlet UILabel *lblQty;
@property (strong, nonatomic) IBOutlet UIButton *btnDecrement;
@property (strong, nonatomic) IBOutlet UILabel *lblsub;

@property(nonatomic,assign)id<itemQuantityDelegate>ItemDelegate;

- (IBAction)incrementAction:(id)sender;
- (IBAction)decrementAction:(id)sender;
@end
