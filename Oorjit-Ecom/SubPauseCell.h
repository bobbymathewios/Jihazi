//
//  SubPauseCell.h
//  MedMart
//
//  Created by Remya Das on 11/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SubscribeProtocol <NSObject>

-(void)pauseDelegate:(int)tag second:(NSString *)title;
-(void)cancelDelegate:(int)tag;
-(void)deliveryDelegate:(int)tag;
-(void)orderDelegate:(int)tag;


@end
@interface SubPauseCell : UITableViewCell
@property(nonatomic,assign)id<SubscribeProtocol>SUBDelegate;

@property (strong, nonatomic) IBOutlet UIButton *btnPause;
@property (strong, nonatomic) IBOutlet UIButton *btncancel;
@property (strong, nonatomic) IBOutlet UIButton *btnDeli;
@property (strong, nonatomic) IBOutlet UIButton *btnOrder;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIImageView *ine;

@property (strong, nonatomic) IBOutlet UILabel *lbl;
- (IBAction)pauseAction:(id)sender;
- (IBAction)calcelAction:(id)sender;
- (IBAction)deliveryAction:(id)sender;
- (IBAction)orderAction:(id)sender;
@end
