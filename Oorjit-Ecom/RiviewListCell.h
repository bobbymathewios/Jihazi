//
//  RiviewListCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 21/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
@protocol ReviewDelegate <NSObject>

-(void)writeReview;

@end
@interface RiviewListCell : UITableViewCell
{
  
}
@property(nonatomic,assign)id<ReviewDelegate>reviewDEL;

@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UILabel *lblDate;
@property (strong, nonatomic) IBOutlet UILabel *lbltitle;
@property (strong, nonatomic) IBOutlet UITextView *txtDes;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate1;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate2;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate3;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate4;
@property (strong, nonatomic) IBOutlet UIImageView *imgrate5;
@property (strong, nonatomic) IBOutlet UILabel *lblLetter;
@property (weak, nonatomic) IBOutlet UIButton *btnR;
- (IBAction)reviewAction:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *already;

@end
