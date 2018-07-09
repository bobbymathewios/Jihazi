//
//  WiriteReviewViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 22/06/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "WiriteReviewViewController.h"

@interface WiriteReviewViewController ()<passDataAfterParsing,UITextFieldDelegate,UITextViewDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSString *rateing;
    int selected;
     UIImage *checkImage,*uncheckImage;
}

@end

@implementation WiriteReviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)viewWillAppear:(BOOL)animated
{
    
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.lblReiview.textColor=appDelObj.textColor;

   // self.view.backgroundColor=appDelObj.menubgtable;
    self.topView.backgroundColor=appDelObj.headderColor;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    if (appDelObj.isArabic==YES)
    {
//        self.btnAra.alpha=1;
//        self.btnEng.alpha=0;
         self.view.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblReiview.transform = CGAffineTransformMakeScale(-1, 1);
        self.txtComments.transform = CGAffineTransformMakeScale(-1, 1);
        self.txtHeadline.transform = CGAffineTransformMakeScale(-1, 1);
        self.btn1.transform = CGAffineTransformMakeScale(-1, 1);
        self.btn2.transform = CGAffineTransformMakeScale(-1, 1);
        self.btn3.transform = CGAffineTransformMakeScale(-1, 1);
        self.btn4.transform = CGAffineTransformMakeScale(-1, 1);
        self.btn5.transform = CGAffineTransformMakeScale(-1, 1);
         self.lblrate.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnSubmit.transform = CGAffineTransformMakeScale(-1, 1);
        self.txtHeadline.placeholder=@" عنوان التقييم ";
        self.txtHeadline.textAlignment=NSTextAlignmentRight;
        self.txtComments.textAlignment=NSTextAlignmentRight;
         self.lblrate.textAlignment=NSTextAlignmentRight;
        self.lblrate.text=@"معدل التقييم الإجمالي ";
        self.lblReiview.text=@" اكتب تعليق ";
        self.txtComments.text = @"اكتب تعليقك";
        [self.btnSubmit setTitle:@"ارسال" forState:UIControlStateNormal];
    }
    else
    {
        self.txtComments.text = @"Write your comment";
//        self.btnAra.alpha=0;
//        self.btnEng.alpha=1;
    }
    checkImage = [UIImage imageNamed:@"star-1.png"];
    uncheckImage = [UIImage imageNamed:@"reviewstar.png"];
    selected=0;
    
    [_btn1 setImage:uncheckImage forState:UIControlStateNormal];
    [_btn2 setImage:uncheckImage forState:UIControlStateNormal];
    [_btn3 setImage:uncheckImage forState:UIControlStateNormal];
    
    [_btn4 setImage:uncheckImage forState:UIControlStateNormal];
    
    [_btn5 setImage:uncheckImage forState:UIControlStateNormal];
    self.txtComments.layer.borderWidth=.5;
    //self.txtComments.layer.cornerRadius=2;
    self.txtComments.layer.borderColor=[[UIColor blackColor]CGColor];
    
    
    self.txtComments.textColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.831 alpha:1.00];
    self.txtComments.delegate = self;
    self.scrollObj.contentSize=CGSizeMake(0, self.btnSubmit.frame.origin.y+self.btnSubmit.frame.size.height);
}
- (BOOL) textViewShouldBeginEditing:(UITextView *)textView
{
    self.txtComments.text = @"";
    self.txtComments.textColor = [UIColor blackColor];
    return YES;
}

-(void) textViewDidChange:(UITextView *)textView
{
    
    if(self.txtComments.text.length == 0){
        self.txtComments.textColor = [UIColor colorWithRed:0.812 green:0.812 blue:0.831 alpha:1.00];
        if (appDelObj.isArabic) {
            self.txtComments.text = @"اكتب تعليقك";
        } else {
            self.txtComments.text = @"Write your comment";
        }
        
        [self.txtComments resignFirstResponder];
    }
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
- (IBAction)rateOneAction:(id)sender
{
    rateing=@"1";
    if (selected==0||[_btn1.imageView.image isEqual:checkImage])
    {
        UIImage *currentImage = [_btn1.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
        [_btn1 setImage:currentImage forState:UIControlStateNormal];
        
        if ([_btn1.imageView.image isEqual:checkImage])
        {
            
            selected=1;
        }
        
        else
        {
            selected=0;
            [_btn2 setImage:uncheckImage forState:UIControlStateNormal];
            [_btn3 setImage:uncheckImage forState:UIControlStateNormal];
            [_btn4 setImage:uncheckImage forState:UIControlStateNormal];
            [_btn5 setImage:uncheckImage forState:UIControlStateNormal];
            
        }
    }
}

- (IBAction)rateTWoAction:(id)sender
{
    rateing=@"2";
    if (selected==1||[_btn1.imageView.image isEqual:checkImage])
    {
        UIImage *currentImage = [_btn2.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
        [_btn2 setImage:currentImage forState:UIControlStateNormal];
        if ([_btn2.imageView.image isEqual:checkImage])
        {
            
            
            selected=2;
        }
        
        else
        {
            selected=1;
            [_btn3 setImage:uncheckImage forState:UIControlStateNormal];
            [_btn4 setImage:uncheckImage forState:UIControlStateNormal];
            [_btn5 setImage:uncheckImage forState:UIControlStateNormal];
            
        }
    }
    
}

- (IBAction)rateThreeAction:(id)sender
{
    rateing=@"3";
    if (selected==2||[_btn2.imageView.image isEqual:checkImage])
    {
        UIImage *currentImage = [_btn3.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
        [_btn3 setImage:currentImage forState:UIControlStateNormal];
        if ([_btn3.imageView.image isEqual:checkImage])
        {
            selected=3;
        }
        else
        {
            selected=2;
            [_btn4 setImage:uncheckImage forState:UIControlStateNormal];
            [_btn5 setImage:uncheckImage forState:UIControlStateNormal];
            
        }
    }
}

- (IBAction)rateFourAction:(id)sender
{
    rateing=@"4";
    if (selected==3||[_btn3.imageView.image isEqual:checkImage])
    {
        UIImage *currentImage = [_btn4.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
        [_btn4 setImage:currentImage forState:UIControlStateNormal];
        if ([_btn4.imageView.image isEqual:checkImage])
        {
            selected=4;
        }
        
        else
        {
            selected=3;
            [_btn5 setImage:uncheckImage forState:UIControlStateNormal];
            
        }
    }
}

- (IBAction)rateFiveAction:(id)sender
{
    rateing=@"5";
    if (selected==4||[_btn4.imageView.image isEqual:checkImage])
    {
        UIImage *currentImage = [_btn5.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
        [_btn5 setImage:currentImage forState:UIControlStateNormal];
        if ([_btn4.imageView.image isEqual:checkImage])
        {
            
            
            selected=5;
            
        }
        else
        {
            selected=4;
        }
    }
}
- (IBAction)submitAction:(id)sender
{
    if (self.txtHeadline.text.length==0||self.txtComments.text.length==0||rateing.length==0) {
        NSString *strMsg,*okMsg;
        if (appDelObj.isArabic)
        {
            strMsg=@"يرجى ملء جميع البيانات اللازمة!";
            okMsg=@" موافق ";
        }
        else
        {
            strMsg=@"Please fill all neccessary data!";
            okMsg=@"Ok";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        
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
        }
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/review/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.productID,@"productID",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.txtHeadline.text,@"reviewTitle",self.txtComments.text,@"reviewText",rateing,@"productRating", nil];
    
    
    
    
    
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
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
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
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
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self englishBackAction:nil];}]];
        
        [self presentViewController:alertController animated:YES completion:nil];
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
- (IBAction)arabicbackAction:(id)sender
{
    if ([self.fromLogin isEqualToString:@"yes"])
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromRight;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        NSArray *array = [self.navigationController viewControllers];
        
        [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
        
    }
    else
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
    
    
}

- (IBAction)englishBackAction:(id)sender
{
    if (appDelObj.isArabic) {
        if ([self.fromLogin isEqualToString:@"yes"])
        {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromRight;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            NSArray *array = [self.navigationController viewControllers];
            
            [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
            
        }
        else
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
    }
    else
    {
    if ([self.fromLogin isEqualToString:@"yes"])
    {
        NSArray *array = [self.navigationController viewControllers];
        
        [self.navigationController popToViewController:[array objectAtIndex:0] animated:YES];
    }
    else
    {
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    }
    
}
@end
