//
//  DescriptionCell.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 20/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol DetailDelegate <NSObject>
-(void)detailPageAction:(int)tag;
@end
@interface DescriptionCell : UITableViewCell<UIWebViewDelegate>
@property(nonatomic,assign)id<DetailDelegate>DEL;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIImageView *imgPlus;
@property (strong, nonatomic) IBOutlet UIWebView *detail;
@property (strong, nonatomic) IBOutlet UIButton *btnViewMore;
- (IBAction)viewMoreAction:(id)sender;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *act;

@end
