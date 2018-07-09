//
//  DescriptionCell.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 20/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "DescriptionCell.h"

@implementation DescriptionCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.detail.scrollView.scrollEnabled=NO;
    self.detail.delegate=self;
    [self.act startAnimating];
}
-(void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.act stopAnimating];
    self.act.alpha=0;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)viewMoreAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    [self.DEL detailPageAction:(int)btn.tag];
}
@end
