//
//  CancelOrderViewController.m
//  Favot
//
//  Created by Remya Das on 03/08/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "CancelOrderViewController.h"

@interface CancelOrderViewController ()<passDataAfterParsing,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,UITextViewDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableArray *listAry;
    int textfield;
    NSString *reason,*refund,*reasonID,*refundID,*productIds,*orderQTY,*action,*actionID;
    NSArray *picAry,*picAry2,*orderIemsAry,*picAry3;
    UIPickerView *picker,*pickerOne;
    NSDictionary *dic;
}
@end

@implementation CancelOrderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    textfield=0;
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.topObj.backgroundColor=appDelObj.headderColor;
    //self.view.backgroundColor=appDelObj.priceColor;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    self.txtYourComment.layer.borderWidth = 1.0f;
    self.txtYourComment.layer.borderColor = [[UIColor lightGrayColor] CGColor];
    if (appDelObj.isArabic==YES)
    {
        self.view.transform=CGAffineTransformMakeScale(-1, 1);

        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
          self.txtText.transform=CGAffineTransformMakeScale(-1, 1);
        
        self.lblOrderID.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblReasonForCancel.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblReason.transform=CGAffineTransformMakeScale(-1, 1);  self.txtReason.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtAction.transform=CGAffineTransformMakeScale(-1, 1);
        self.txtYourComment.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnSubmit.transform=CGAffineTransformMakeScale(-1, 1);

        
       // self.lblTitle.textAlignment=NSTextAlignmentRight;
         self.txtText.textAlignment=NSTextAlignmentRight;
        self.lblOrderID.textAlignment=NSTextAlignmentRight;
        self.lblReasonForCancel.textAlignment=NSTextAlignmentRight;
        self.lblReason.textAlignment=NSTextAlignmentRight;
        self.txtReason.textAlignment=NSTextAlignmentRight;
        
        self.txtAction.textAlignment=NSTextAlignmentRight;
        self.txtYourComment.textAlignment=NSTextAlignmentRight;
        
        self.lblTitle.text=@"طلب استبدال/استرجاع";
        self.txtAction.placeholder=@"-اختر فعلا-";
        self.txtReason.placeholder=@"يرجى تحديد السبب";
        
        self.lblOrderID.text=[NSString stringWithFormat:@" رقم الطلب :%@",self.OrderID];
        self.txtText.text=@"يرجى ادخال سبب الالغاء/الاسترجاع";
        self.lblReasonForCancel.text=@"السبب";
        self.lblReason.text=@"السبب";
        self.lblCmtText.text=@"تعليقك";
        [self.btnSubmit setTitle:@"ارسال" forState:UIControlStateNormal];
        
    }
    
    
    else
    {
          self.lblTitle.text=@"Return/Replace order";
        self.lblOrderID.text=[NSString stringWithFormat:@"OrderID: %@",self.OrderID];
    }
   picker = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
    picker.delegate=self;
    picker.dataSource=self;
    [self.txtReason setInputView:picker];
    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    [toolBar setTintColor:appDelObj.redColor];
    UIBarButtonItem *doneBtn;
    if (appDelObj.isArabic) {
       // toolBar.transform = CGAffineTransformMakeScale(-1, 1);
      //  picker.transform = CGAffineTransformMakeScale(-1, 1);
        doneBtn=[[UIBarButtonItem alloc]initWithTitle:@" تم " style:UIBarButtonItemStyleDone target:self action:@selector(chooseData)];
    }
    else
    {
        doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(chooseData)];
    }
    UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
    [self.txtReason setInputAccessoryView:toolBar];
    
  
  
  
        self.btnSubmit.alpha=1;
        self.txtYourComment.userInteractionEnabled=YES;
        self.txtReason.userInteractionEnabled=YES;
        orderIemsAry=self.array;
    if ([self.fromDetail isEqualToString:@"yes"]) {
        orderIemsAry=self.array;
    }
    else{
    orderIemsAry=[self.array valueForKey:@"items"];
    }
    self.tblOrder.frame=CGRectMake(self.tblOrder.frame.origin.x, self.tblOrder.frame.origin.y, self.tblOrder.frame.size.width, 61*orderIemsAry.count);
    self.actionView.frame=CGRectMake(self.actionView.frame.origin.x, 61*orderIemsAry.count+5, self.actionView.frame.size.width, self.actionView.frame.size.height);
    self.scrollObj.contentSize=CGSizeMake(0, self.actionView.frame.origin.y+self.actionView.frame.size.height+20);
        if(orderIemsAry.count==1)
        {
            productIds=[[orderIemsAry objectAtIndex:0]valueForKey:@"orderItemID"];
            orderQTY=[[orderIemsAry objectAtIndex:0]valueForKey:@"orderItemQuantity"];
        }
        else
        {
            productIds=[[orderIemsAry objectAtIndex:0]valueForKey:@"orderItemID"];
            orderQTY=[[orderIemsAry objectAtIndex:0]valueForKey:@"orderItemQuantity"];
            for (int i=1; i<orderIemsAry.count; i++)
            {
                productIds=[NSString stringWithFormat:@"%@,%@",productIds,[[orderIemsAry objectAtIndex:i]valueForKey:@"orderItemID"]];
                orderQTY=[NSString stringWithFormat:@"%@,%@",orderQTY,[[orderIemsAry objectAtIndex:i]valueForKey:@"orderItemQuantity"]];
            }
        }
    self.lblTitle.textColor=appDelObj.textColor;

    
    self.txtYourComment.layer.borderWidth=.5;
    //self.txtComments.layer.cornerRadius=2;
    self.txtYourComment.layer.borderColor=[[UIColor blackColor]CGColor];
    if (appDelObj.isArabic) {
        self.txtYourComment.text = @"تعليقك";
    }
    else
    {
        self.txtYourComment.text = @"Write your comment";
    }
    
    self.txtYourComment.textColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.831 alpha:1.00];
    self.txtYourComment.delegate = self;
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
   
    NSString *restMessage = [NSString stringWithFormat:@"%@mobileapp/user/rma/languageID/%@",appDelObj.baseURL,appDelObj.languageId];
    NSURL *url = [NSURL URLWithString:restMessage];
    NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
    NSURLResponse  *res;
    NSError *err;
    NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&res error:&err];
    NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
   

    reason=[[picAry objectAtIndex:0]valueForKey:@"actionReason"];
    refund=[[picAry2 objectAtIndex:0]valueForKey:@"actionReason"];
    reasonID=[[picAry objectAtIndex:0]valueForKey:@"actionReasonID"];
    refundID=[[picAry2 objectAtIndex:0]valueForKey:@"actionReasonID"];
    [Loading dismiss];
    if ([self.type isEqualToString:@"Cancel Order"])
    {
        if (appDelObj.isArabic) {
             self.lblTitle.text=@"طلب الغاء";
        }
        else
        {
            self.lblTitle.text=@"Cancel Order";
        }
        
        self.lblReason.alpha=0;
        self.txtAction.alpha=0;
        self.lblReasonForCancel.alpha=0;
        self.txtReason.alpha=0;
        self.txtYourComment.frame=CGRectMake(self.txtYourComment.frame.origin.x, self.lblReasonForCancel.frame.origin.y+10, self.lblReasonForCancel.frame.size.width, self.txtYourComment.frame.size.height);
        picAry =[[dic objectForKey:@"result"]objectForKey:@"listresReasonCancel"];
    
    }
    else{
        self.lblReason.alpha=1;
        self.txtAction.alpha=1;
        //picAry2 =[[dic objectForKey:@"result"]objectForKey:@"listresReasonCancel"];
        picAry =[[dic objectForKey:@"result"]objectForKey:@"listresReasonReturn"];
    }
    
    
    self.tblOrder.frame=CGRectMake(self.tblOrder.frame.origin.x, self.tblOrder.frame.origin.y, self.tblOrder.frame.size.width, 61*orderIemsAry.count);
    self.actionView.frame=CGRectMake(self.actionView.frame.origin.x, 61*orderIemsAry.count+self.tblOrder.frame.origin.y, self.actionView.frame.size.width, self.actionView.frame.size.height);
    [self.tblOrder reloadData];
}
-(BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.txtYourComment.text = @"";
    self.txtYourComment.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(self.txtYourComment.text.length == 0){
        self.txtYourComment.textColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.831 alpha:1.00];
        self.txtYourComment.text = @"Write your comment";
        if (appDelObj.isArabic) {
             self.txtYourComment.text = @"تعليقك";
        }
        [self.txtYourComment resignFirstResponder];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return orderIemsAry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CancelCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
    NSArray *listCellAry;
    if (listCell==nil)
    {
        listCellAry=[[NSBundle mainBundle]loadNibNamed:@"CancelCell" owner:self options:nil];
    }
//    if(appDelObj.isArabic)
//    {
//        listCell=[listCellAry objectAtIndex:1];
//    }
//    else
//    {
        listCell=[listCellAry objectAtIndex:0];
//    }
    if(appDelObj.isArabic==YES )
    {
        listCell.lblPrice.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblQty.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.lblname.transform=CGAffineTransformMakeScale(-1, 1);
        listCell.img.transform=CGAffineTransformMakeScale(-1, 1);

        listCell.lblPrice.textAlignment=NSTextAlignmentLeft;
        listCell.lblQty.textAlignment=NSTextAlignmentRight;

        listCell.lblname.textAlignment=NSTextAlignmentRight;

    }
    listCell.selectionStyle=UITableViewCellSelectionStyleNone;
    float x2=[[[orderIemsAry objectAtIndex:indexPath.section]valueForKey:@"orderItemSubtotal"]floatValue];
    int qtyItem=[[[orderIemsAry objectAtIndex:indexPath.section]valueForKey:@"orderItemQuantity"]intValue];
    float sum=x2*qtyItem;
    NSString *s2;
//    if (appDelObj.isArabic) {
//        s2=[NSString stringWithFormat:@"%@ %.02f ",appDelObj.currencySymbol,sum];
//    }
//    else
//    {
        s2=[NSString stringWithFormat:@"%.02f  %@ ",sum,appDelObj.currencySymbol];
//    }
    listCell.lblPrice.text=s2;
    listCell.lblname.text=[[orderIemsAry objectAtIndex:indexPath.section]valueForKey:@"productOptionName"];
    float x3=[[[orderIemsAry objectAtIndex:indexPath.section]valueForKey:@"orderItemPrice"]floatValue];
    NSString *s3;
//    if (appDelObj.isArabic) {
//s3=[NSString stringWithFormat:@"%@  %.02f  ",appDelObj.currencySymbol,x3];    }
//    else
//    {
s3=[NSString stringWithFormat:@"%.02f  %@ ",x3,appDelObj.currencySymbol];
    
    listCell.lblQty.text=[NSString stringWithFormat:@"%@ * %@",[[orderIemsAry objectAtIndex:indexPath.section]valueForKey:@"orderItemQuantity"],s3];
    NSString *strImgUrl=[[orderIemsAry objectAtIndex:indexPath.section]valueForKey:@"imagePath"];
    if ([self.fromDetail isEqualToString:@"yes"]) {
        strImgUrl=[[orderIemsAry objectAtIndex:indexPath.section]valueForKey:@"productImage"];
    }
    if (strImgUrl.length==0)
    {
        listCell.img.image=[UIImage imageNamed:@"placeholder1.png"];
        if (appDelObj.isArabic) {
            listCell.img.image=[UIImage imageNamed:@"place_holderar.png"];

        }
    }
    else
    {
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",self.url,strImgUrl];
        }
        if (appDelObj.isArabic) {
             [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        }
        else
        { [listCell.img sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
            
        }
       
    }
    
    return listCell;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    
 textfield=1;
    
    
}
-(void)chooseData
{
  
        if (reason.length==0) {
            
                reason=[[picAry objectAtIndex:0]valueForKey:@"actionReason"];
                reasonID=[[picAry objectAtIndex:0]valueForKey:@"actionReasonID"];
           
            
            
        }
        self.txtReason.text=reason;
    
    [self.txtReason resignFirstResponder];
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
   
        if ([[[picAry objectAtIndex:row]valueForKey:@"actionReason"] isKindOfClass:[NSNull class]])
        {
            str=@"nil";
        }
        else
        {
            str=[[picAry objectAtIndex:row]valueForKey:@"actionReason"];
        }
   
    [Loading dismiss];
    return str;
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    
        reason=[[picAry objectAtIndex:row]valueForKey:@"actionReason"];
        reasonID=[[picAry objectAtIndex:row]valueForKey:@"actionReasonID"];
   
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)backAction:(id)sender
{
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

- (IBAction)submitAction:(id)sender
{
    if ([self.type isEqualToString:@"Cancel Order"])
    {
        self.cancel=@"no";
        if (appDelObj.isArabic) {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/returnrequest/languageID/",appDelObj.languageId];
        NSString *com=self.txtYourComment.text;
        if (com.length==0) {
            com=@"";
        }
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.OrderID,@"orderID",productIds,@"productIDs",com,@"rmacomment",orderQTY,@"quantity",@"Yes",@"entireOrder", nil];
        NSLog(@"canceling details   %@",dicPost);
        
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
       
    }
    else
    {
        if (reason.length==0) {
            NSString *str=@"Please select reason";
            NSString *ok=@"Ok";
            if (appDelObj.isArabic) {
                str=@"يرجى تحديد السبب";
                ok=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else{
            if (appDelObj.isArabic) {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
             self.cancel=@"no";
            NSString *com=self.txtYourComment.text;
            if (com.length==0||[com isEqualToString:@"Write your comment"]||[com isEqualToString:@"تعليقك"]) {
                com=@"";
            }
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/returnrequest/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.OrderID,@"orderID",productIds,@"productIDs",com,@"rmacomment",orderQTY,@"quantity",reasonID,@"reasonID",@"Yes",@"entireOrder", nil];
        NSLog(@"canceling details   %@",dicPost);
        
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
    }
    
    
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
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
                                    [self backAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([self.cancel isEqualToString:@"no"])
        {
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@ "تم ارسال طلبك بنجاح";
                okMsg=@" موافق ";
            }
            else
            {
                strMsg=@"Your order has been canceled successfully";
                okMsg=@"Ok";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action)
                                        {
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
                                        }]];
            
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            orderIemsAry=[[dictionary objectForKey:@"result"]objectForKey:@"resApprovedProduct"];
            self.txtReason.text=[[[dictionary objectForKey:@"result"] objectForKey:@"resReturnDetails"]objectForKey:@"returnStatus"];
            self.txtYourComment.text=[[[dictionary objectForKey:@"result"] objectForKey:@"resReturnDetails"]objectForKey:@"comments"];
            self.txtText.text=@"Order Cancel";
            self.txtText.textColor=[UIColor redColor];
            self.tblOrder.frame=CGRectMake(self.tblOrder.frame.origin.x, self.tblOrder.frame.origin.y, self.tblOrder.frame.size.width, 61*orderIemsAry.count);
            self.actionView.frame=CGRectMake(self.actionView.frame.origin.x, self.tblOrder.frame.origin.y+self.tblOrder.frame.size.height+5, self.actionView.frame.size.width, self.actionView.frame.size.height);
            self.scrollObj.contentSize=CGSizeMake(0, self.actionView.frame.origin.y+self.actionView.frame.size.height+20);
            [self.tblOrder reloadData];
        }
    }
    else
    {
        NSString *okMsg;
        if (appDelObj.isArabic)
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
    [Loading dismiss];
}
@end
