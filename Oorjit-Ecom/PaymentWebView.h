//
//  PaymentWebView.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 13/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaymentWebView : UIViewController
@property (strong, nonatomic) IBOutlet UIView *topView;
- (IBAction)backAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnback;
@property(nonatomic,strong)NSMutableURLRequest *request;
@property (strong, nonatomic) IBOutlet UIWebView *webObj;
@property(nonatomic,strong)NSString *strUrl,*strSuccess,*strFail,*strPost;
@property(nonatomic,strong)NSArray *array;
@property(nonatomic,strong)NSDictionary *dic;
@end
