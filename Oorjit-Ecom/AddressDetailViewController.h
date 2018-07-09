//
//  AddressDetailViewController.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 17/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "UIButton+WebCache.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "JVFloatLabeledTextField.h"

@interface AddressDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIView *buttonView;
@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *btnEngBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnAraback;
@property (strong, nonatomic) IBOutlet UILabel *lblAddNew;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtName;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtPincode;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtAddress;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtlandmark;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtCity;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtState;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtPhone;
@property (strong, nonatomic) IBOutlet UIScrollView *scrollobj;
@property (strong, nonatomic) IBOutlet UIButton *btnCancel;
@property (strong, nonatomic) IBOutlet UIButton *btnSave;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtLast;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtCountry;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtStreetAddr;
@property (strong, nonatomic) IBOutlet UILabel *lblprimary;

@property(nonatomic,strong)NSArray *detailsAry;
@property(nonatomic,strong)NSString *editOrDel,*fromPrescription,*type;
@property (strong, nonatomic) IBOutlet UILabel *lblmake;


- (IBAction)engBackAction:(id)sender;
- (IBAction)araBackAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)saveAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *b2;
@property (strong, nonatomic) IBOutlet UIButton *b1;
@property (strong, nonatomic) IBOutlet UIButton *btnPrimary;
- (IBAction)primaryAction:(id)sender;
@end

