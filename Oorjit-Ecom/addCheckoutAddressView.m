//
//  addCheckoutAddressView.m
//  Favot
//
//  Created by Remya Das on 27/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "addCheckoutAddressView.h"
#define ACCEPTABLE_CHARACTERS @" +0123456789"
#define ACCEPTABLE_CHARACTERS1 @"0123456789"


@interface addCheckoutAddressView ()<passDataAfterParsing,UITextFieldDelegate,UIPickerViewDelegate,UIPickerViewDataSource,MKMapViewDelegate,CLLocationManagerDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSString *sID,*cID,*sName,*cName;
    int textfield;
    NSArray *picAry;
    CLGeocoder *ceo;
    CLLocationManager *locationManager;
    NSString *latitideSelected,*longitudeSelected,*primary;
}


@end

@implementation addCheckoutAddressView

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    locationManager = [[CLLocationManager alloc]init];
    locationManager.delegate = self;
    [locationManager startUpdatingLocation];
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.lblTitle.textColor=appDelObj.textColor;
    primary=@"no";
    if(appDelObj.isArabic)
    {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"الاسم الاول *"];
        
        [string beginEditing];
        [string addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string.length-1, 1)];
        
        [string endEditing];
        
        [self.txtName setAttributedPlaceholder:string floatingTitle:@"الاسم الاول "];
        NSMutableAttributedString *stringL = [[NSMutableAttributedString alloc] initWithString:@"الاسم الاخير*"];
        
        [stringL beginEditing];
        [stringL addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringL.length-1, 1)];
        
        [stringL endEditing];
        
        [self.txtLast setAttributedPlaceholder:stringL floatingTitle:@"الاسم الاخير"];
        
        NSMutableAttributedString *stringA = [[NSMutableAttributedString alloc] initWithString:@"الحي/المنطقة*"];
        NSMutableAttributedString *stringAA = [[NSMutableAttributedString alloc] initWithString:@"العنوان 2*"];
        
        [stringA beginEditing];
        [stringA addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringA.length-1, 1)];
        
        [stringA endEditing];
        
        [self.txtAddress setAttributedPlaceholder:stringA floatingTitle:@"الحي/المنطقة"];
        
        
        NSMutableAttributedString *stringC = [[NSMutableAttributedString alloc] initWithString:@" الدولة *"];
        
        [stringC beginEditing];
        [stringC addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringC.length-1, 1)];
        
        [stringC endEditing];
        
        [self.txtCountry setAttributedPlaceholder:stringC floatingTitle:@" الدولة "];
        NSMutableAttributedString *stringS = [[NSMutableAttributedString alloc] initWithString:@"المدينة*"];
        
        [stringS beginEditing];
        [stringS addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringS.length-1, 1)];
        
        [stringS endEditing];
        
        [self.txtState setAttributedPlaceholder:stringS floatingTitle:@"المدينة"];
        NSMutableAttributedString *stringP = [[NSMutableAttributedString alloc] initWithString:@"رقم الجوال *"];
        
        [stringP beginEditing];
        [stringP addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringP.length-1, 1)];
        
        [stringP endEditing];
        
        [self.txtPhone setAttributedPlaceholder:stringP floatingTitle:@"رقم الجوال "];
        NSMutableAttributedString *stringPH = [[NSMutableAttributedString alloc] initWithString:@"رمز البريد *"];
        
        [stringPH beginEditing];
        [stringPH addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]  range:NSMakeRange(stringPH.length-1, 1)];
        
        [stringPH endEditing];
        
        [self.txtPincode setAttributedPlaceholder:stringPH floatingTitle:@"رمز البريد "];
        NSMutableAttributedString *stringPa = [[NSMutableAttributedString alloc] initWithString:@"اسم/رقم الشارع*"];
        
        [stringPa beginEditing];
        [stringPa addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]  range:NSMakeRange(stringPa.length-1, 1)];
        
        [stringPa endEditing];
        
        [self.txtCity setAttributedPlaceholder:stringPa floatingTitle:@"اسم/رقم الشارع"];
        self.txtCountry.text=@"المملكة العربية السعودية";

    }
    else
    {
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"First Name*"];
        
        [string beginEditing];
        [string addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string.length-1, 1)];
        
        [string endEditing];
        
        [self.txtName setAttributedPlaceholder:string floatingTitle:@"First Name"];
        NSMutableAttributedString *stringL = [[NSMutableAttributedString alloc] initWithString:@"Last Name*"];
        
        [stringL beginEditing];
        [stringL addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringL.length-1, 1)];
        
        [stringL endEditing];
        
        [self.txtLast setAttributedPlaceholder:stringL floatingTitle:@"Last Name"];
        
        NSMutableAttributedString *stringA = [[NSMutableAttributedString alloc] initWithString:@"Address *"];
        
        [stringA beginEditing];
        [stringA addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringA.length-1, 1)];
        
        [stringA endEditing];
        
        [self.txtAddress setAttributedPlaceholder:stringA floatingTitle:@"Address"];
        NSMutableAttributedString *stringC = [[NSMutableAttributedString alloc] initWithString:@"Country*"];
        
        [stringC beginEditing];
        [stringC addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringC.length-1, 1)];
        
        [stringC endEditing];
        
        [self.txtCountry setAttributedPlaceholder:stringC floatingTitle:@"Country"];
        NSMutableAttributedString *stringS = [[NSMutableAttributedString alloc] initWithString:@"City*"];
        
        [stringS beginEditing];
        [stringS addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringS.length-1, 1)];
        
        [stringS endEditing];
        
        [self.txtState setAttributedPlaceholder:stringS floatingTitle:@"City"];
        NSMutableAttributedString *stringPa = [[NSMutableAttributedString alloc] initWithString:@"Location*"];
        
        [stringPa beginEditing];
        [stringPa addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]  range:NSMakeRange(stringPa.length-1, 1)];
        
        [stringPa endEditing];
        
        [self.txtCity setAttributedPlaceholder:stringPa floatingTitle:@"Location"];
        NSMutableAttributedString *stringP = [[NSMutableAttributedString alloc] initWithString:@"Phone*"];
        
        [stringP beginEditing];
        [stringP addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(stringP.length-1, 1)];
        
        [stringP endEditing];
        
        [self.txtPhone setAttributedPlaceholder:stringP floatingTitle:@"Phone"];
        NSMutableAttributedString *stringPH = [[NSMutableAttributedString alloc] initWithString:@"Pincode*"];
        
        [stringPH beginEditing];
        [stringPH addAttribute:NSForegroundColorAttributeName
                         value:[UIColor redColor]  range:NSMakeRange(stringPH.length-1, 1)];
        
        [stringPH endEditing];
        
        [self.txtPincode setAttributedPlaceholder:stringPH floatingTitle:@"Pincode"];
        self.txtCountry.text=@"Saudi Arabia";
    }
    cID=@"184";
}
-(void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden=YES;
    self.view.backgroundColor=appDelObj.menubgtable;
    self.topView.backgroundColor=appDelObj.headderColor;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    if(appDelObj.isArabic)
    {
        self.lblAddNew.textAlignment=NSTextAlignmentRight;
        self.txtName.textAlignment=NSTextAlignmentRight;
        self.txtCity.textAlignment=NSTextAlignmentRight;
        self.txtPhone.textAlignment=NSTextAlignmentRight;
        self.txtState.textAlignment=NSTextAlignmentRight;
        self.txtAddress.textAlignment=NSTextAlignmentRight;
        self.txtPincode.textAlignment=NSTextAlignmentRight;
        self.txtEmail.textAlignment=NSTextAlignmentRight;
        self.txtLast.textAlignment=NSTextAlignmentRight;
        self.txtCountry.textAlignment=NSTextAlignmentRight;
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.buttonView.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblAddNew.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtName.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtCity.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtPhone.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtState.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtAddress.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtPincode.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtEmail.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtLast.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtCountry.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
       // self.btnSave.transform=CGAffineTransformMakeScale(-1, 1);
       //self.btnCancel.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnPrimary.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblprimary.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblAddNew.transform=CGAffineTransformMakeScale(-1, 1);
        

       
        [self.btnCancel setTitle:@"إلغاء" forState:UIControlStateNormal];
        [self.btnSave setTitle:@"حفظ" forState:UIControlStateNormal];
        self.lblprimary.text=@"اجعل هذا العنوان عنوان الشحن الرئيسي ";
        self.lblprimary.textAlignment=NSTextAlignmentRight;
    }
    
    
    if ([self.shipBill isEqualToString:@"Ship"])
    {
        self.lblprimary.alpha=1;
        self.btnPrimary.alpha=1;
    }
    else
    {
        self.lblprimary.alpha=0;
        self.btnPrimary.alpha=0;
    }
    self.btnCancel.layer.borderWidth=1;
    self.btnCancel.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    if ([self.editOrDel isEqualToString:@"edit"])
    {
        if(appDelObj.isArabic)
        {
            if ([_shipBill isEqualToString:@"Bill"]) {
                  self.lblTitle.text=@" يرجى تحديث عنوان الدفع  ";
            }
            else
            {
                  self.lblTitle.text=@"تحديث";
            }
        
        }
        else
        {
            self.lblTitle.text=@"Update address";
            self.lblAddNew.text=@"Update Address";
        }
        if (self.detailsAry.count==0)
        {
        }
        else
        {
            if ([self.shipBill isEqualToString:@"Ship"])
            {
                if ([[self.detailsAry valueForKey:@"shippingFname"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    self.txtName.text=[self.detailsAry valueForKey:@"shippingFname"];
                    
                }
                if ([[self.detailsAry valueForKey:@"shippingLname"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    self.txtLast.text=[self.detailsAry valueForKey:@"shippingLname"];
                    
                }
//                if ([[self.detailsAry valueForKey:@"shippingZip"] isKindOfClass: [NSNull class]]) {
//                }
//                else
//                {
//
//                    self.txtPincode.text=[self.detailsAry valueForKey:@"shippingZip"];
//                }
                if ([[self.detailsAry valueForKey:@"shippingAddress1"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    
                    self.txtAddress.text=[self.detailsAry valueForKey:@"shippingAddress1"];
                }
//                if ([[self.detailsAry valueForKey:@"shippingAddress2"] isKindOfClass: [NSNull class]]) {
//                }
//                else
//                {
//
//                    self.txtStreetName.text=[self.detailsAry valueForKey:@"shippingAddress2"];
//                }
                
                if ([[self.detailsAry valueForKey:@"shippingCity"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    self.txtCity.text=[self.detailsAry valueForKey:@"shippingCity"];
                }
                if ([[self.detailsAry valueForKey:@"stateName"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    self.txtState.text=[self.detailsAry valueForKey:@"stateName"];
                    
                }
                if ([[self.detailsAry valueForKey:@"shippingPhone"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    
                    self.txtPhone.text=[self.detailsAry valueForKey:@"shippingPhone"];
                }
               
                if ([[self.detailsAry valueForKey:@"countryName"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    
                    self.txtCountry.text=[self.detailsAry valueForKey:@"countryName"];
                }
                if ([[self.detailsAry valueForKey:@"stateID"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    
                    sID=[self.detailsAry valueForKey:@"stateID"];
                }
                if ([[self.detailsAry valueForKey:@"countryID"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    cID=[self.detailsAry valueForKey:@"countryID"];
                }
                
            }
            else
            {
                if ([[self.detailsAry valueForKey:@"billingFirstName"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    self.txtName.text=[self.detailsAry valueForKey:@"billingFirstName"];
                    
                }
                if ([[self.detailsAry valueForKey:@"billingLastName"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    self.txtLast.text=[self.detailsAry valueForKey:@"billingLastName"];
                    
                }
//                if ([[self.detailsAry valueForKey:@"billingZip"] isKindOfClass: [NSNull class]]) {
//                }
//                else
//                {
//
//                    self.txtPincode.text=[self.detailsAry valueForKey:@"billingZip"];
//                }
                if ([[self.detailsAry valueForKey:@"billingAddress"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    
                    self.txtAddress.text=[self.detailsAry valueForKey:@"billingAddress"];
                }
//                if ([[self.detailsAry valueForKey:@"billingAddress1"] isKindOfClass: [NSNull class]]) {
//                }
//                else
//                {
//
//                    self.txtStreetName.text=[self.detailsAry valueForKey:@"billingAddress1"];
//                }
                
                if ([[self.detailsAry valueForKey:@"billingCity"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    self.txtCity.text=[self.detailsAry valueForKey:@"billingCity"];
                }
                if ([[self.detailsAry valueForKey:@"billingState"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    self.txtState.text=[self.detailsAry valueForKey:@"billingState"];
                    
                }
                if ([[self.detailsAry valueForKey:@"billingPhone"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    
                    self.txtPhone.text=[self.detailsAry valueForKey:@"billingPhone"];
                }
                
                if ([[self.detailsAry valueForKey:@"billingCountry"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    
                    self.txtCountry.text=[self.detailsAry valueForKey:@"billingCountry"];
                }
                if ([[self.detailsAry valueForKey:@"billingStateID"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    
                    sID=[self.detailsAry valueForKey:@"billingStateID"];
                }
                if ([[self.detailsAry valueForKey:@"billingCountryID"] isKindOfClass: [NSNull class]]) {
                }
                else
                {
                    cID=[self.detailsAry valueForKey:@"billingCountryID"];
                }
                
            }
            
            
            
        }
        NSString * primary=[self.detailsAry valueForKey:@"addressPrimary"];
        if ([primary isKindOfClass:[NSNull class]]) {
            [self.btnPrimary setBackgroundImage:[UIImage imageNamed:@"login-select-2.png"] forState:UIControlStateNormal];
            primary=@"No";
        }
        else
        {
            if ([primary isEqualToString:@"Yes"])
            {
                [self.btnPrimary setBackgroundImage:[UIImage imageNamed:@"login-select.png"] forState:UIControlStateNormal];
                primary=@"Yes";
            }
            else
                
            {
                [self.btnPrimary setBackgroundImage:[UIImage imageNamed:@"login-select-2.png"] forState:UIControlStateNormal];
                primary=@"No";
            }
        }
        //self.txtEmail.text= [[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"];
    }
    else
    {
        if(appDelObj.isArabic)
        {
            self.lblTitle.text=@"إضافة عنوان جديد";
            self.lblAddNew.text=@"إضافة عنوان جديد";
        }
        else
        {
            self.lblTitle.text=@"Add address";
            self.lblAddNew.text=@"Add Address";
        }
        if ([self.shipBill isEqualToString:@"Ship"])
        {
            self.lblTitle.text=@"Shipping address";
            if(appDelObj.isArabic)
            {
                 self.lblTitle.text=@"معلومات الشحن";
            }
        }
        else
        {
            self.lblTitle.text=@"Billing address";
            if(appDelObj.isArabic)
            {
                self.lblTitle.text=@"عنوان الدفع";
            }
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"No billing address available now! so please add one address." preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
//            [self presentViewController:alertController animated:YES completion:nil];
        }
        self.txtName.text=@"";
        self.txtLast.text=@"";
        self.txtPincode.text=@"";
        self.txtAddress.text=@"";
        self.txtCity.text=@"";
        self.txtState.text=@"";
        self.txtPhone.text=@"";
    }
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        self.scrollobj.contentSize=CGSizeMake(0, self.buttonView.frame.origin.y+600);
        
    }
    else{
        self.scrollobj.contentSize=CGSizeMake(0, self.buttonView.frame.origin.y+100);
    }
    UIPickerView *picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
    picker.delegate=self;
    picker.dataSource=self;
  //  [self.txtCountry setInputView:picker];
    [self.txtState setInputView:picker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [toolBar setTintColor:appDelObj.redColor];
    UIBarButtonItem *doneBtn;
    if (appDelObj.isArabic) {
       // toolBar.transform = CGAffineTransformMakeScale(-1, 1);
      // picker.transform = CGAffineTransformMakeScale(-1, 1);
        doneBtn=[[UIBarButtonItem alloc]initWithTitle:@" تم " style:UIBarButtonItemStyleDone target:self action:@selector(chooseData)];
    }
    else
    {
        doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(chooseData)];
    }
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    //[self.txtCountry setInputAccessoryView:toolBar];
    [self.txtState setInputAccessoryView:toolBar];
    cID=@"184";
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField==self.txtPhone)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if ([string isEqualToString:filtered])
        {
            return newLength <= 10;
        }
        else{
            NSString *msg=@"Please enter a valid phone number";
            NSString *ok=@"Ok";
            if (appDelObj.isArabic) {
                msg=@"يرجى إدخال رقم هاتف صالح";
                ok=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return [string isEqualToString:filtered];
            
        }
    }
    if (textField==self.txtPincode)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS1] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        if ([string isEqualToString:filtered])
        {
            return newLength <= 6;
        }
        else{
            NSString *msg=@"Please enter a valid pincode";
            NSString *ok=@"Ok";
            if (appDelObj.isArabic) {
                msg=@"يرجى إدخال رمز سري صالح";
                ok=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return [string isEqualToString:filtered];
            
        }
    }
    if (textField==self.txtAddress)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
       
            return newLength <= 25;
        
            
       
    }
    return YES;
}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    if (textField==self.txtCountry)
    {
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }     textfield=1;
        NSString *restMessage = [NSString stringWithFormat:@"%@mobileapp/Deal/countriesList/languageID/%@",appDelObj.baseURL,appDelObj.languageId];
        NSURL *url = [NSURL URLWithString:restMessage];
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
        NSURLResponse  *res;
        NSError *err;
        NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&res error:&err];
        //[connection start];
        
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        picAry =[dic objectForKey:@"result"];
        cID=[[picAry objectAtIndex:0]valueForKey:@"countryID"];
        cName  =[[picAry objectAtIndex:0]valueForKey:@"countryName"];
    }
    else if (textField==self.txtState)
    {
        if (cID.length==0)
        {
            NSString *msg=@"Please select country";
            NSString *ok=@"Ok";
            if (appDelObj.isArabic) {
                msg=@"يرجى اختيار المدينة  ";
                ok=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else{
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }       textfield=2;
        
        NSString *postUrl = [NSString stringWithFormat:@"%@mobileapp/Deal/stateList/languageID/%@",appDelObj.baseURL,appDelObj.languageId];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
        [request setHTTPMethod:@"POST"];
        
        NSMutableData *body = [NSMutableData data];
        
        NSString *boundary = @"---------------------------14737809831466499882746641449";
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
        
        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"countryID"] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithString:cID] dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // set request body
        [request setHTTPBody:body];
        NSURLResponse  *res;
        NSError *err;
        
        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
        //[connection start];
        
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        picAry =[dic objectForKey:@"result"];
        sID=[[picAry objectAtIndex:0]valueForKey:@"stateID"];
        sName  =[[picAry objectAtIndex:0]valueForKey:@"stateName"];
        }
        
    }
    if (picAry.count==0) {
        [Loading dismiss];
    }
}
-(void)chooseData
{
    if (textfield==1)
    {
        self.txtCountry.text=cName;
    }
    else
    {
        self.txtState.text=sName;
    }
    [self.txtState resignFirstResponder];
    [self.txtCountry resignFirstResponder];
}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return picAry.count;
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    NSString *str;
    if (textfield==1)
    {
        if ([[[picAry objectAtIndex:row]valueForKey:@"countryName"] isKindOfClass:[NSNull class]])
        {
            str=@"nil";
        }
        else
        {
            str=[[picAry objectAtIndex:row]valueForKey:@"countryName"];
        }
    }
    else
    {
        if ([[[picAry objectAtIndex:row]valueForKey:@"stateName"] isKindOfClass:[NSNull class]])
        {
            str=@"nil";
        }
        else
        {
            str=[[picAry objectAtIndex:row]valueForKey:@"stateName"];
        }
    }
    [Loading dismiss];
    return str;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (textfield==1)
    {
        cID=[[picAry objectAtIndex:row]valueForKey:@"countryID"];
        cName  =[[picAry objectAtIndex:row]valueForKey:@"countryName"];
        
    }
    else
    {
        sID=[[picAry objectAtIndex:row]valueForKey:@"stateID"];
        sName  =[[picAry objectAtIndex:row]valueForKey:@"stateName"];
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

-(void)getDataFromService
{
    
    NSLog(@"%@",self.detailsAry);
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }    NSString *urlStr;
    NSMutableDictionary *dicPost;

        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateAddress/languageID/",appDelObj.languageId];
    if ([self.editOrDel isEqualToString:@"edit"])
    {
        if ([self.shipBill isEqualToString:@"Bill"])
        {
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"update_billing",@"mode",self.txtName.text,@"shippingFname",self.txtLast.text,@"shippingLname",self.txtAddress.text,@"shippingAddress1",@"",@"shippingAddress2",cID,@"shippingCountry",cID,@"shippingCountryID",sID,@"shippingState",@"",@"shippingProvince",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail",self.txtPhone.text,@"shippingPhone",sID,@"shippingStateID",self.txtCity.text,@"shippingCity",@"",@"shippingZip",@"Billing",@"adrsType",@"",@"shippingSaveToList",[self.detailsAry  valueForKey:@"userShippingID"],@"selAddress", nil];

        }
        else{
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"update_shipping",@"mode",@"edit",@"action",self.txtName.text,@"shippingFname",self.txtLast.text,@"shippingLname",self.txtAddress.text,@"shippingAddress1",@"",@"shippingAddress2",cID,@"shippingCountry",cID,@"shippingCountryID",sID,@"shippingState",@"",@"shippingProvince",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail",self.txtPhone.text,@"shippingPhone",sID,@"shippingStateID",self.txtCity.text,@"shippingCity",@"",@"shippingZip",@"Shipping",@"adrsType",primary,@"makeAddressAsPrimary",[self.detailsAry valueForKey:@"userShippingID"],@"address",@"",@"shippingSaveToList",[self.detailsAry  valueForKey:@"userShippingID"],@"selAddress", nil];

        }
    }
    else
    {
        if ([self.shipBill isEqualToString:@"Bill"])
        {
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"update_billing",@"mode",self.txtName.text,@"shippingFname",self.txtLast.text,@"shippingLname",self.txtAddress.text,@"shippingAddress1",@"",@"shippingAddress2",cID,@"shippingCountry",cID,@"shippingCountryID",sID,@"shippingState",@"",@"shippingProvince",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail",self.txtPhone.text,@"shippingPhone",sID,@"shippingStateID",self.txtCity.text,@"shippingCity",@"",@"shippingZip",@"Billing",@"adrsType",@"",@"shippingSaveToList",[self.detailsAry  valueForKey:@"userShippingID"],@"selAddress", nil];

        }
        else
        {
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID",@"update_shipping",@"mode",self.txtName.text,@"shippingFname",self.txtLast.text,@"shippingLname",self.txtAddress.text,@"shippingAddress1",@"",@"shippingAddress2",cID,@"shippingCountry",cID,@"shippingCountryID",sID,@"shippingState",@"",@"shippingProvince",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_EMAIL"],@"shippingEmail",self.txtPhone.text,@"shippingPhone",sID,@"shippingStateID",self.txtCity.text,@"shippingCity",@"",@"shippingZip",@"Shipping",@"adrsType",primary,@"makeAddressAsPrimary",@"",@"address",@"",@"shippingSaveToList",@"",@"selAddress", nil];

        }
    }
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    
    strMsg=@"Network busy! please try again or after sometime.";
    okMsg=@"Ok";
    
    if (appDelObj.isArabic) {
        strMsg=@"يرجى المحاولة بعد مرور بعض الوقت";
        okMsg=@" موافق ";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isKindOfClass: [NSNull class]])
    {
        NSString *strMsg,*okMsg;
        if(appDelObj.isArabic)
        {
            strMsg=@"تمت إضافة العنوان";
            okMsg=@" موافق ";
        }
        else
        {
            strMsg=@"Address added";
            okMsg=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        {
            NSString *strMsg,*okMsg;
            if(appDelObj.isArabic)
            {
                strMsg=@"تم التحديث بنجاح";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Update Suuccessfully";
                okMsg=@"Ok";
            }
            if( [self.shipBill isEqualToString:@"Ship"])
            {
                
            }
             else {
                 appDelObj.CancelBillAddressOnCheckout=@"";
            }
           /* UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {*/
                                            if(appDelObj.isArabic)
                                            {
                                                transition = [CATransition animation];
                                                [transition setDuration:0.3];
                                                transition.type = kCATransitionPush;
                                                transition.subtype = kCATransitionFromRight;
                                                [transition setFillMode:kCAFillModeBoth];
                                                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                                                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }
                                            else
                                            {
                                                [self.navigationController popViewControllerAnimated:YES];
                                            }
                                       /* }]];
            [self presentViewController:alertController animated:YES completion:nil];*/
        }
        else
        {
            NSString *okMsg;
            if(appDelObj.isArabic)
            {
                okMsg=@" موافق ";
            }
            else
            {
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
    }
    [Loading dismiss];
}
- (IBAction)engBackAction:(id)sender
{
   if( [self.shipBill isEqualToString:@"Ship"])
   {
       
   }
    else
    {
        appDelObj.CancelBillAddressOnCheckout=@"Yes";
    }
    if(appDelObj.isArabic)
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)araBackAction:(id)sender
{
    if( [self.shipBill isEqualToString:@"Ship"])
    {
        
    }
    else
    {
        appDelObj.CancelBillAddressOnCheckout=@"Yes";
    }
    if(appDelObj.isArabic)
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)cancelAction:(id)sender
{
    if( [self.shipBill isEqualToString:@"Ship"])
    {
        
    }
    else
    {
        appDelObj.CancelBillAddressOnCheckout=@"Yes";
    }
    if(appDelObj.isArabic) 
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController popViewControllerAnimated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)saveAction:(id)sender
{
    if(self.txtName.text.length==0||self.txtLast.text.length==0||self.txtAddress.text.length==0||self.txtCountry.text.length==0||self.txtState.text.length==0||self.txtPhone.text.length==0||self.txtCity.text.length==0)
    {
        NSString *okMsg,*str;
        if(appDelObj.isArabic)
        {
            okMsg=@" موافق ";
            str=@" جميع الحقول مطلوية  ";
        }
        else
        {
            okMsg=@"Ok";
            str=@"Please fill all mandatory fields";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        NSString *ph=self.txtPhone.text;
        NSString *p=[ph substringWithRange:NSMakeRange(0, 2)];
        if ([p isEqualToString:@"05"])
        {
            if (ph.length==10) {
                [self getDataFromService];
            }
            else
            {
                NSString *okMsg,*str;
                if(appDelObj.isArabic)
                {
                    okMsg=@" موافق ";
                    str=@"يجب ان يكون الرقم 10 خانات ويبدا بـ 05";
                }
                else
                {
                    okMsg=@"Ok";
                    str=@"Phone number must contain 10 digit";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            
            
        }
        else
        {
            NSString *okMsg,*str;
            if(appDelObj.isArabic)
            {
                okMsg=@" موافق ";
                str=@"يجب ان يكون الرقم 10 خانات ويبدا بـ 05";
            }
            else
            {
                okMsg=@"Ok";
                str=@"Phone number begins with 05";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        
    }
}

- (IBAction)primaryAction:(id)sender {
    
    if ([self.btnPrimary.currentBackgroundImage isEqual: [UIImage imageNamed:@"login-select.png"]])
    {
        [self.btnPrimary setBackgroundImage:[UIImage imageNamed:@"login-select-2.png"] forState:UIControlStateNormal];
        primary=@"No";
    }
    else
    {
        [self.btnPrimary setBackgroundImage:[UIImage imageNamed:@"login-select.png"] forState:UIControlStateNormal];
        primary=@"Yes";
        
    }
    
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
