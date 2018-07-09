//
//  addCheckoutAddressView.h
//  Favot
//
//  Created by Remya Das on 27/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

#import "AppDelegate.h"
//#import "UIButton+WebCache.h"
//#import <SDWebImage/UIImageView+WebCache.h>
//#import "UIImageView+WebCache.h"
#import "Loading.h"
#import "WebService.h"
#import "JVFloatLabeledTextField.h"

@interface addCheckoutAddressView : UIViewController

@property (strong, nonatomic) IBOutlet UIView *topView;
@property (strong, nonatomic) IBOutlet UIButton *btnEngBack;
@property (strong, nonatomic) IBOutlet UILabel *lblTitle;
@property (strong, nonatomic) IBOutlet UIButton *btnAraback;
@property (strong, nonatomic) IBOutlet UILabel *lblAddNew;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtName;
@property (weak, nonatomic) IBOutlet UIView *buttonView;
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
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtEmail;
@property (strong, nonatomic) IBOutlet UIButton *btnAraBack1;

@property(nonatomic,strong)NSArray *detailsAry;
@property(nonatomic,strong)NSString *editOrDel,*shipBill;
@property (strong, nonatomic) IBOutlet MKMapView *locationMap;
@property (strong, nonatomic) IBOutlet UIButton *btnEngBack1;
@property (strong, nonatomic) IBOutlet JVFloatLabeledTextField *txtStreetName;


- (IBAction)engBackAction:(id)sender;
- (IBAction)araBackAction:(id)sender;
- (IBAction)cancelAction:(id)sender;
- (IBAction)saveAction:(id)sender;
@property (strong, nonatomic) IBOutlet UIButton *btnPrimary;
- (IBAction)primaryAction:(id)sender;
@property (strong, nonatomic) IBOutlet UILabel *lblprimary;
@end
