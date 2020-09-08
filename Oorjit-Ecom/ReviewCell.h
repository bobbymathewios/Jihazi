//
//  ReviewCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 20/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
//@protocol ReviewDelegate <NSObject>
//-(void)writeReview;
//@end

@interface ReviewCell : UITableViewCell


@property (strong, nonatomic) IBOutlet UILabel *lblrate;
@property (strong, nonatomic) IBOutlet UILabel *lblCount;
@property (strong, nonatomic) IBOutlet UIButton *btnReview;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UILabel *lbl5;
@property (strong, nonatomic) IBOutlet UILabel *lbl4;
@property (strong, nonatomic) IBOutlet UILabel *lbl3;
@property (strong, nonatomic) IBOutlet UILabel *lbl2;
@property (strong, nonatomic) IBOutlet UILabel *lbl1;
@property (strong, nonatomic) IBOutlet UIImageView *imm;

- (IBAction)writeReviewAction:(id)sender;

@end
