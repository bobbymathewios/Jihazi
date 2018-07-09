//
//  PrescriptionConfirmation.m
//  MedMart
//
//  Created by Remya Das on 04/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "PrescriptionConfirmation.h"
#define ACCEPTABLE_CHARACTERS @" +0123456789"

@interface PrescriptionConfirmation ()<passDataAfterParsing,UITextViewDelegate,UITextFieldDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    int show,tag;
    NSString *fileName,*Specify;
    UIImage *imagePro;
    NSMutableArray *imagePrescriptionAry;
   
}

@end

@implementation PrescriptionConfirmation
@synthesize colArray,URl;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    //self.view.backgroundColor=appDelObj.menubgtable;
    self.topView.backgroundColor=appDelObj.headderColor;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    show=1;
    tag=0;
    imagePrescriptionAry=[[NSMutableArray alloc]init];
    //self.scroll.contentSize=CGSizeMake(0, self.prescriptionGuideView.frame.origin.y+self.prescriptionGuideView.frame.size.height);
    if(appDelObj.isArabic==YES)
    {
        self.imgAra.alpha=1;
        self.btnAra.alpha=1;
        self.imgEng.alpha=0;
        self.btnEng.alpha=0;
        self.imgA1.alpha=0;
        self.imgA2.alpha=0;
        self.imgA3.alpha=0;
    }
    else
    {
        self.imgAra.alpha=0;
        self.btnAra.alpha=0;
        self.imgEng.alpha=1;
        self.btnEng.alpha=1;
        self.imgE1.alpha=0;
        self.imgE2.alpha=0;
        self.imgE3.alpha=0;
    }
    Specify=@"";
    [_comPrescription registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];

    self.imgA2.frame=CGRectMake(self.imgA2.frame.origin.x, self.txtMedicine.frame.origin.y+self.txtMedicine.frame.size.height+20, self.imgA2.frame.size.width, self.imgA2.frame.size.height);
    self.btn2.frame=CGRectMake(self.btn2.frame.origin.x, self.txtMedicine.frame.origin.y+self.txtMedicine.frame.size.height+20, self.btn2.frame.size.width, self.btn2.frame.size.height);
    self.lbl2.frame=CGRectMake(self.lbl2.frame.origin.x, self.txtMedicine.frame.origin.y+self.txtMedicine.frame.size.height+20, self.lbl2.frame.size.width, self.lbl2.frame.size.height);
    self.txtMedicine.alpha=1;self.txtView.alpha=0;self.txtCall.alpha=0;
    self.txtMedicine.frame=CGRectMake(self.txtMedicine.frame.origin.x, self.lbl1.frame.origin.y+self.lbl1.frame.size.height+10, self.txtMedicine.frame.size.width, self.txtMedicine.frame.size.height);
    self.imgA3.frame=CGRectMake(self.imgA3.frame.origin.x, self.lbl2.frame.origin.y+self.lbl2.frame.size.height+20, self.imgA3.frame.size.width, self.imgA3.frame.size.height);
    self.btn3.frame=CGRectMake(self.btn3.frame.origin.x, self.lbl2.frame.origin.y+self.lbl2.frame.size.height+20, self.btn3.frame.size.width, self.btn3.frame.size.height);
    self.lbl3.frame=CGRectMake(self.lbl3.frame.origin.x, self.lbl2.frame.origin.y+self.lbl2.frame.size.height+20, self.lbl3.frame.size.width, self.lbl3.frame.size.height);
    //self.lbl.frame=CGRectMake(0, self.lbl3.frame.origin.y+self.lbl3.frame.size.height+20, self.lbl.frame.size.width, self.lbl.frame.size.height);
    self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.btn.frame.origin.y+self.btn.frame.size.height, self.comPrescription.frame.size.width, 0);

if (colArray.count<=3)
{
    self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 110);
    
}
    else{
        if (colArray.count/3==0)
        {
            self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, (colArray.count/3)*110);
            
        }
        else{
            self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, ((colArray.count/3)*110)+110);
            
        }
        
    }
    self.scroll.contentSize=CGSizeMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height);
                    [self.comPrescription reloadData];
    
    self.txtCall.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_PHONE"];
    
//    if (appDelObj.isArabic) {
//        [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//    }
//    else
//    {
//        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//    }
//    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/index/languageID/",appDelObj.languageId];
//    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
//    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    /*self.txtView.layer.borderWidth=.5;
    self.txtView.layer.cornerRadius=2;
    self.txtView.layer.borderColor=[[UIColor colorWithRed:0.800 green:0.800 blue:0.800 alpha:1.00]CGColor];
     self.txtView.text = @"Specify medicine";
     self.txtView.textColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.831 alpha:1.00];
     self.txtView.delegate = self;*/
}
/*-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField{
    if (textField==self.txtMedicine)
    {
        [self allMedicineAction:nil];

    }
    else{
        [self callAction:nil];

    }
    return YES;
    
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    [self SpecifyAction:nil];
    self.txtView.text = @"";
    self.txtView.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(self.txtView.text.length == 0){
        self.txtView.textColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.831 alpha:1.00];
        self.txtView.text = @"Specify medicine";
        [self.txtView resignFirstResponder];
    }
}**/


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField==self.txtCall)
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
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please enter a valid phone number" preferredStyle:UIAlertControllerStyleAlert];            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return [string isEqualToString:filtered];

        }
        
    }
    return YES;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.comPrescription.frame.size.width/3)-10, 110);

    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return colArray.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    UIImageView *img=[[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 110, 110)];
    img.image=[UIImage imageNamed:@"box.png"];
    [cell.contentView addSubview:img];
    UIImageView *img1=[[UIImageView alloc]initWithFrame:CGRectMake(2, 2, 104, 104)];
    img1.image=[UIImage imageNamed:@"placeholder1.png"];
    [cell.contentView addSubview:img1];
    NSString *strImgUrl=[NSString stringWithFormat:@"%@",[[colArray objectAtIndex:indexPath.row ]valueForKey:@"imageName"] ];
    if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
    {
        img1.image=[UIImage imageNamed:@"placeholder1.png"];
    }
    else{
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG=[colArray objectAtIndex:indexPath.row ];
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",URl,strImgUrl];
            
        }
        [img1 sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
    }
    
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strImgUrl=[NSString stringWithFormat:@"%@",[[colArray objectAtIndex:indexPath.row ]valueForKey:@"imageName"] ];
    if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
    {
        self.imgLarge.image=[UIImage imageNamed:@"placeholder1.png"];
    }
    else{
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG=[colArray objectAtIndex:indexPath.row ];
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",URl,strImgUrl];
            
        }
        [self.imgLarge sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
    }
    
    self.imgLargeView.alpha = 1;
    self.imgLargeView.frame = CGRectMake(self.imgLargeView.frame.origin.x, self.imgLargeView.frame.origin.y, self.imgLargeView.frame.size.width, self.imgLargeView.frame.size.height);
    [self.view addSubview:self.imgLargeView];
    self.imgLargeView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.imgLargeView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.imgLargeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              CGRect rect = self.imgLargeView.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.imgLargeView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    
    strMsg=@"Network busy! please try again or after sometime.";
    okMsg=@"Ok";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
                                    [self englishBackAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
//        if ([Specify isEqualToString:@"Specify"])
//        {
            [Loading dismiss];
            if(appDelObj.isArabic==YES )
            {
                OrderSummery *listDetail=[[OrderSummery alloc]init];
                
                transition = [CATransition animation];
                [transition setDuration:0.3];
                transition.type = kCATransitionPush;
                transition.subtype = kCATransitionFromLeft;
                [transition setFillMode:kCAFillModeBoth];
                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
                [self.navigationController pushViewController:listDetail animated:NO];
            }
            else
            {
                OrderSummery *listDetail=[[OrderSummery alloc]init];
            
                [self.navigationController pushViewController:listDetail animated:YES];
            }
//        }
//        else{
//            URl=[[dictionary objectForKey:@"prescriptionData"]objectForKey:@"site_url"];
//
//            colArray=[[dictionary objectForKey:@"prescriptionData"]objectForKey:@"selectedPrescription"];
//
//            if (colArray.count<=3)
//            {
//                self.comPrescription.frame=CGRectMake(0, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 110);
//
//            }
//            else{
//                if (colArray.count/3==0)
//                {
//                    self.comPrescription.frame=CGRectMake(0, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, (colArray.count/3)*110);
//
//                }
//                else{
//                    self.comPrescription.frame=CGRectMake(0, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, ((colArray.count/3)*110)+110);
//
//                }
//
//            }
//            self.scroll.contentSize=CGSizeMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height);
//            [self.comPrescription reloadData];
//        }
//
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
 [Loading dismiss];
   
}


- (IBAction)backAraAction:(id)sender {
    
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)englishBackAction:(id)sender {
    
        
        [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)proceedAction:(id)sender {
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/specify/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost;
    if (show==1)
    {
        if (self.txtMedicine.text.length==0)
        {
            NSString *msg;
            msg=@"Please enter course duration!";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else
        {
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"All",@"specify_medicine",self.txtMedicine.text,@"cource_duration",@"",@"medicine_details",@"",@"enquiryPhone", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        
    }
    else if (show==2)
    {
        if (self.txtView.text.length==0)
        {
            NSString* msg=@"Please enter medicines!";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
       else
       {
           dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"Specified",@"specify_medicine",self.txtView.text,@"medicine_details",@"",@"cource_duration",@"",@"enquiryPhone", nil];
           [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
       }
    }
    else if (show==3)
    {
        if (_txtCall.text.length==0)
        {
            NSString* msg=@"Pleaase enter a valid phone number!";
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"Call For Details",@"specify_medicine",self.txtCall.text,@"enquiryPhone",@"",@"medicine_details",@"",@"cource_duration", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
       
    }
    else
    {
        NSString* msg=@"Pleaase specify one option!";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
}


- (IBAction)allMedicineAction:(id)sender {
    show=1;
    //self.txtMedicine.text=@"";
    //self.txtView.text = @"";
    //self.txtCall.text=@"";
    self.imgE1.image=self.imgA1.image=[UIImage imageNamed:@"lan-button-active.png"];
    self.imgE2.image=self.imgA2.image=[UIImage imageNamed:@"lan-button.png"];
    self.imgE3.image=self.imgA3.image=[UIImage imageNamed:@"lan-button.png"];
    [UIView animateWithDuration:.5 animations:^{
        self.imgA2.frame=CGRectMake(self.imgA2.frame.origin.x, self.txtMedicine.frame.origin.y+self.txtMedicine.frame.size.height+20, self.imgA2.frame.size.width, self.imgA2.frame.size.height);
        self.btn2.frame=CGRectMake(self.btn2.frame.origin.x, self.txtMedicine.frame.origin.y+self.txtMedicine.frame.size.height+20, self.btn2.frame.size.width, self.btn2.frame.size.height);
        self.lbl2.frame=CGRectMake(self.lbl2.frame.origin.x, self.txtMedicine.frame.origin.y+self.txtMedicine.frame.size.height+20, self.lbl2.frame.size.width, self.lbl2.frame.size.height);
        self.txtMedicine.alpha=1;self.txtView.alpha=0;self.txtCall.alpha=0;
        self.txtMedicine.frame=CGRectMake(self.txtMedicine.frame.origin.x, self.lbl1.frame.origin.y+self.lbl1.frame.size.height+10, self.txtMedicine.frame.size.width, self.txtMedicine.frame.size.height);
self.imgA3.frame=CGRectMake(self.imgA3.frame.origin.x, self.lbl2.frame.origin.y+self.lbl2.frame.size.height+20, self.imgA3.frame.size.width, self.imgA3.frame.size.height);
        self.btn3.frame=CGRectMake(self.btn3.frame.origin.x, self.lbl2.frame.origin.y+self.lbl2.frame.size.height+20, self.btn3.frame.size.width, self.btn3.frame.size.height);
        self.lbl3.frame=CGRectMake(self.lbl3.frame.origin.x, self.lbl2.frame.origin.y+self.lbl2.frame.size.height+20, self.lbl3.frame.size.width, self.lbl3.frame.size.height);
        //self.lbl.frame=CGRectMake(0, self.lbl3.frame.origin.y+self.lbl3.frame.size.height+20, self.lbl.frame.size.width, self.lbl.frame.size.height);
        self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.btn.frame.origin.y+self.btn.frame.size.height, self.comPrescription.frame.size.width, 0);
        if (colArray.count<=3)
        {
            self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 110);

        }
        else{
            if (colArray.count/3==0)
            {
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, (colArray.count/3)*110);

            }
            else{
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, ((colArray.count/3)*110)+110);

            }

        }    }];
   self.scroll.contentSize=CGSizeMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height);

}

- (IBAction)SpecifyAction:(id)sender {
    show=2;
    //self.txtMedicine.text=@"";
    //self.txtView.text = @"";
    //self.txtCall.text=@"";
    self.imgE2.image=self.imgA2.image=[UIImage imageNamed:@"lan-button-active.png"];
    self.imgE1.image=self.imgA1.image=[UIImage imageNamed:@"lan-button.png"];
    self.imgE3.image=self.imgA3.image=[UIImage imageNamed:@"lan-button.png"];
    [UIView animateWithDuration:.5 animations:^{
        self.imgA1.frame=CGRectMake(self.imgA1.frame.origin.x, self.imgA1.frame.origin.y, self.imgA1.frame.size.width, self.imgA1.frame.size.height);
        self.btn1.frame=CGRectMake(self.btn1.frame.origin.x, self.btn1.frame.origin.y, self.btn1.frame.size.width, self.btn1.frame.size.height);
        self.lbl1.frame=CGRectMake(self.lbl1.frame.origin.x, self.lbl1.frame.origin.y, self.lbl1.frame.size.width, self.lbl1.frame.size.height);

        self.txtMedicine.alpha=0;
        self.txtCall.alpha=0;


        self.imgA2.frame=CGRectMake(self.imgA2.frame.origin.x, self.lbl1.frame.origin.y+self.lbl1.frame.size.height+20, self.imgA2.frame.size.width, self.imgA2.frame.size.height);
        self.btn2.frame=CGRectMake(self.btn2.frame.origin.x, self.lbl1.frame.origin.y+self.lbl1.frame.size.height+20, self.btn2.frame.size.width, self.btn2.frame.size.height);
        self.lbl2.frame=CGRectMake(self.lbl2.frame.origin.x, self.lbl1.frame.origin.y+self.lbl1.frame.size.height+20, self.lbl2.frame.size.width, self.lbl2.frame.size.height);
        self.txtView.frame=CGRectMake(self.txtView.frame.origin.x, self.lbl2.frame.origin.y+self.lbl2.frame.size.height+10, self.txtView.frame.size.width, self.txtView.frame.size.height);

        
        self.txtView.alpha=1;

        self.imgA3.frame=CGRectMake(self.imgA3.frame.origin.x, self.txtView.frame.origin.y+self.txtView.frame.size.height+20, self.imgA3.frame.size.width, self.imgA3.frame.size.height);
        self.btn3.frame=CGRectMake(self.btn3.frame.origin.x, self.txtView.frame.origin.y+self.txtView.frame.size.height+20, self.btn3.frame.size.width, self.btn3.frame.size.height);
        self.lbl3.frame=CGRectMake(self.lbl3.frame.origin.x, self.txtView.frame.origin.y+self.txtView.frame.size.height+20, self.lbl3.frame.size.width, self.lbl3.frame.size.height);

        ///self.lbl.frame=CGRectMake(0, self.lbl3.frame.origin.y+self.lbl3.frame.size.height+10, self.lbl.frame.size.width, self.lbl.frame.size.height);
        self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.btn.frame.origin.y+self.btn.frame.size.height, self.comPrescription.frame.size.width, 0);

        if (colArray.count<=3)
        {
            self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 110);

        }
        else{
            if (colArray.count/3==0)
            {
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, (colArray.count/3)*110);

            }
            else{
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, ((colArray.count/3)*110)+110);

            }

        }
    }];
}

- (IBAction)callAction:(id)sender {
    show=3;
    //self.txtMedicine.text=@"";
    //self.txtView.text = @"";
    //self.txtCall.text=@"";
    self.imgE3.image=self.imgA3.image=[UIImage imageNamed:@"lan-button-active.png"];
    self.imgE2.image=self.imgA2.image=[UIImage imageNamed:@"lan-button.png"];
    self.imgE1.image=self.imgA1.image=[UIImage imageNamed:@"lan-button.png"];
    [UIView animateWithDuration:.5 animations:^{
        
        self.imgA1.frame=CGRectMake(self.imgA1.frame.origin.x, self.imgA1.frame.origin.y, self.imgA1.frame.size.width, self.imgA1.frame.size.height);
        self.btn1.frame=CGRectMake(self.btn1.frame.origin.x, self.btn1.frame.origin.y, self.btn1.frame.size.width, self.btn1.frame.size.height);
        self.txtMedicine.alpha=0;
        self.txtCall.alpha=1;self.txtView.alpha=0;
        
        
        self.imgA2.frame=CGRectMake(self.imgA2.frame.origin.x, self.lbl1.frame.origin.y+self.lbl1.frame.size.height+20, self.imgA2.frame.size.width, self.imgA2.frame.size.height);
        self.btn2.frame=CGRectMake(self.btn2.frame.origin.x, self.lbl1.frame.origin.y+self.lbl1.frame.size.height+20, self.btn2.frame.size.width, self.btn2.frame.size.height);
        self.lbl2.frame=CGRectMake(self.lbl2.frame.origin.x, self.lbl1.frame.origin.y+self.lbl1.frame.size.height+20, self.lbl2.frame.size.width, self.lbl2.frame.size.height);

        self.imgA3.frame=CGRectMake(self.imgA3.frame.origin.x, self.lbl2.frame.origin.y+self.lbl2.frame.size.height+20, self.imgA3.frame.size.width, self.imgA3.frame.size.height);
        self.btn3.frame=CGRectMake(self.btn3.frame.origin.x, self.lbl2.frame.origin.y+self.lbl2.frame.size.height+20, self.btn3.frame.size.width, self.btn3.frame.size.height);
        self.lbl3.frame=CGRectMake(self.lbl3.frame.origin.x, self.lbl2.frame.origin.y+self.lbl2.frame.size.height+20, self.lbl3.frame.size.width, self.lbl3.frame.size.height);
        self.txtCall.frame=CGRectMake(self.txtCall.frame.origin.x, self.lbl3.frame.origin.y+self.lbl3.frame.size.height+10, self.txtView.frame.size.width, self.txtCall.frame.size.height);

//        self.lbl.frame=CGRectMake(0, self.txtCall.frame.origin.y+self.txtCall.frame.size.height+20, self.lbl.frame.size.width, self.lbl.frame.size.height);
        self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.btn.frame.origin.y+self.btn.frame.size.height, self.comPrescription.frame.size.width, 0);

        if (colArray.count<=3)
        {
            self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, 110);
            
        }
        else{
            if (colArray.count/3==0)
            {
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, (colArray.count/3)*110);
            }
            else{
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.comPrescription.frame.origin.y, self.comPrescription.frame.size.width, ((colArray.count/3)*110)+110);
            }
        }
    }];
}

- (IBAction)attachedAction:(id)sender {
    if (tag==0) {
        self.comPrescription.alpha=1;
        tag=1;
    }
    else{
        tag=0;
        self.comPrescription.alpha=0;
    }
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (BOOL)textView:(UITextView* )textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString* )text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    return YES;
}
- (IBAction)closeAction:(id)sender {
    CGRect rect = self.imgLargeView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.imgLargeView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         //closeBtn.alpha = 0;
                         CGRect rect = self.imgLargeView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.imgLargeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.imgLargeView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.imgLargeView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.imgLargeView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}
@end
