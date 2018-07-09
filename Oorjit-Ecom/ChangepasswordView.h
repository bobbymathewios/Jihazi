//
//  ChangepasswordView.h
//  MedMart
//
//  Created by Remya Das on 07/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789#!_"
#import <UIKit/UIKit.h>
#import "RESideMenu.h"
#import "AppDelegate.h"
#import "WebService.h"
@interface ChangepasswordView : UIViewController
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtOld;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtNewPass;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtConfirm;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *bE1;
@property (strong, nonatomic) IBOutlet UILabel *lbl;
@property (strong, nonatomic) IBOutlet UIButton *bA1;
@property (strong, nonatomic) IBOutlet UIButton *bE2;
@property (strong, nonatomic) IBOutlet UIButton *bA2;
@property (strong, nonatomic) IBOutlet UILabel *lblEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnc;
@property (strong, nonatomic) IBOutlet UIButton *btns;
- (IBAction)backEngAc:(id)sender;
- (IBAction)backAraAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)saveAction:(id)sender;
@end
