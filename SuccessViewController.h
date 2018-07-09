//
//  SuccessViewController.h
//  Demo
//
//  Created by Martin Prabhu on 9/14/16.
//  Copyright © 2016 test. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThankYouViewController.h"
#import "Loading.h"
#import "WebService.h"

@interface SuccessViewController : UIViewController
{

}
@property(nonatomic,retain)IBOutlet UIScrollView *scroll;

@property(nonatomic,retain)NSMutableDictionary *jsondict;

@end
