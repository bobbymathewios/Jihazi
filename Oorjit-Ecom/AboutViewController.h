//
//  AboutViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 05/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "Loading.h"

@interface AboutViewController : UIViewController
@property (strong, nonatomic) IBOutlet UIScrollView *scrollViewObj;
@property (strong, nonatomic) IBOutlet UIView *topViewObj;
@property (strong, nonatomic) IBOutlet UIButton *btnBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIWebView *web;
- (IBAction)backAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *b1;


@property(nonatomic,strong)NSString *cms,*fromMenu,*titleText,*desc;
@end
