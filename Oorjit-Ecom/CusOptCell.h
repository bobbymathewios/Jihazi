//
//  CusOptCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 31/10/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol InformationDelegates <NSObject>
- (void)informationAbout:(int)tag;
- (void)timeSelect:(int)tag;
-(void)varientsSelection:(int)tag;
-(void)uploadFile:(int)tag;

@end
@interface CusOptCell : UITableViewCell<UITextFieldDelegate,UITextViewDelegate>
@property (strong, nonatomic) IBOutlet UIImageView *img1;
@property (weak, nonatomic) IBOutlet UIImageView *infoIm;
@property (weak, nonatomic) IBOutlet UIImageView *linr;
@property(nonatomic,assign)id<InformationDelegates>INFODelegate;
@property (strong, nonatomic) IBOutlet UITextField *txtHour;
@property (strong, nonatomic) IBOutlet UITextField *txtDay;
@property (strong, nonatomic) IBOutlet UIButton *btnInfo;
@property (strong, nonatomic) IBOutlet UILabel *lblName;
@property (strong, nonatomic) IBOutlet UIButton *btnClock;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
@property (strong, nonatomic) IBOutlet UITextView *text;

- (IBAction)infoAction:(id)sender;
- (IBAction)clockAction:(id)sender;
- (IBAction)selectionAction:(id)sender;
- (IBAction)uploadaction:(id)sender;
@end
