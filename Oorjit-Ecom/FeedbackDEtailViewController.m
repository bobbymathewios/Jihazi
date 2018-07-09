//
//  FeedbackDEtailViewController.m
//  Jihazi
//
//  Created by Apple on 18/04/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "FeedbackDEtailViewController.h"
#import "AppDelegate.h"
@interface FeedbackDEtailViewController ()<passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSMutableArray *listAry,*saveAry;
    UIImage *checkImage;
    UIImage *uncheckImage;
    int selected1,selected2,selected3,selected4;
    NSString *oveall,*shipingTime,*shipinCost,*proQuality,*productRating;
}
@end

@implementation FeedbackDEtailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    listAry=[[NSMutableArray alloc]init];
    saveAry=[[NSMutableArray alloc]init];
    checkImage = [UIImage imageNamed:@"star-2.png"];
    uncheckImage = [UIImage imageNamed:@"star-3.png"];
    [_s1 setImage:uncheckImage forState:UIControlStateNormal];
    [_s2 setImage:uncheckImage forState:UIControlStateNormal];
    [_s3 setImage:uncheckImage forState:UIControlStateNormal];
    [_s4 setImage:uncheckImage forState:UIControlStateNormal];
    [_s5 setImage:uncheckImage forState:UIControlStateNormal];
    [_s11 setImage:uncheckImage forState:UIControlStateNormal];
    [_s12 setImage:uncheckImage forState:UIControlStateNormal];
    [_s13 setImage:uncheckImage forState:UIControlStateNormal];
    [_s14 setImage:uncheckImage forState:UIControlStateNormal];
    [_s15 setImage:uncheckImage forState:UIControlStateNormal];
    [_s21 setImage:uncheckImage forState:UIControlStateNormal];
    [_s22 setImage:uncheckImage forState:UIControlStateNormal];
    [_s23 setImage:uncheckImage forState:UIControlStateNormal];
    [_s24 setImage:uncheckImage forState:UIControlStateNormal];
    [_s25 setImage:uncheckImage forState:UIControlStateNormal];
    [_s31 setImage:uncheckImage forState:UIControlStateNormal];
    [_s32 setImage:uncheckImage forState:UIControlStateNormal];
    [_s33 setImage:uncheckImage forState:UIControlStateNormal];
    [_s34 setImage:uncheckImage forState:UIControlStateNormal];
    [_s35 setImage:uncheckImage forState:UIControlStateNormal];
    [_r1 setImage:uncheckImage forState:UIControlStateNormal];
    [_r2 setImage:uncheckImage forState:UIControlStateNormal];
    [_r3 setImage:uncheckImage forState:UIControlStateNormal];
    [_r4 setImage:uncheckImage forState:UIControlStateNormal];
    [_r5 setImage:uncheckImage forState:UIControlStateNormal];
    
    self.expTxt.layer.borderWidth = 1.0f;
    self.expTxt.layer.borderColor = [[UIColor colorWithRed:0.867 green:0.867 blue:0.867 alpha:1.00] CGColor];
    self.expProTxt.layer.borderWidth = 1.0f;
    self.expProTxt.layer.borderColor = [[UIColor colorWithRed:0.867 green:0.867 blue:0.867 alpha:1.00] CGColor];
    self.imgborder.layer.borderWidth = 1.0f;
    self.imgborder.layer.borderColor = [[UIColor colorWithRed:0.867 green:0.867 blue:0.867 alpha:1.00] CGColor];
    self.reviewTitleTxt.layer.borderWidth = 1.0f;
    self.reviewTitleTxt.layer.borderColor = [[UIColor colorWithRed:0.867 green:0.867 blue:0.867 alpha:1.00] CGColor];
    self.merchantView.layer.borderWidth = 1.0f;
    self.merchantView.layer.borderColor = [[UIColor colorWithRed:0.867 green:0.867 blue:0.867 alpha:1.00] CGColor];
    self.productView.layer.borderWidth = 1.0f;
    self.productView.layer.borderColor = [[UIColor colorWithRed:0.867 green:0.867 blue:0.867 alpha:1.00] CGColor];
    _scrlView.contentSize = CGSizeMake(320,self.submitBtn.frame.origin.y+self.submitBtn.frame.size.height+800);
    
    
    
    if (_imgUrl.length==0)
    {
        _ImageFeedback.image=[UIImage imageNamed:@"placeholder1.png"];
        if(appDelObj.isArabic)
        {
            _ImageFeedback.image=[UIImage imageNamed:@"place_holderar.png"];

        }
    }
    else
    {
        NSString *s=[_imgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",_imgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",_imgPath,_imgUrl];
        }
        [_ImageFeedback sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    
    if(appDelObj.isArabic==YES )
    {
        self.view.transform=CGAffineTransformMakeScale(-1, 1);
        self.prodctqlty.transform=CGAffineTransformMakeScale(-1, 1);
        self.orderDateLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.orderDateLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.shipingrt.transform=CGAffineTransformMakeScale(-1, 1);
        self.shipngcost.transform=CGAffineTransformMakeScale(-1, 1);
        self.merchantFeedbackLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.ratemerchntLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.ovrallrt.transform=CGAffineTransformMakeScale(-1, 1);
        self.merchantFeedbckRestxt.transform=CGAffineTransformMakeScale(-1, 1);
        self.prodctRwrTxt.transform=CGAffineTransformMakeScale(-1, 1);
        self.merchantFeedbckRestxt.transform=CGAffineTransformMakeScale(-1, 1);
        self.ImageFeedback.transform=CGAffineTransformMakeScale(-1, 1);
        self.titleLabel.transform=CGAffineTransformMakeScale(-1, 1);
        self.youPaidLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.youPaidresLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.orderIdLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.headerTitle.transform=CGAffineTransformMakeScale(-1, 1);
          self.orderidresLbl.transform=CGAffineTransformMakeScale(-1, 1);
          self.orderStsLbl.transform=CGAffineTransformMakeScale(-1, 1);
          self.orderstsresLbl.transform=CGAffineTransformMakeScale(-1, 1);
          self.proRatLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.reviewTitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.expProdctLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.expProTxt.transform=CGAffineTransformMakeScale(-1, 1);
        self.orderdateresLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.prodctRwlbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.expLbl.transform=CGAffineTransformMakeScale(-1, 1);
        self.submitBtn.transform=CGAffineTransformMakeScale(-1, 1);
        self.reviewTitleTxt.transform=CGAffineTransformMakeScale(-1, 1);
        self.expTxt.transform=CGAffineTransformMakeScale(-1, 1);
     
        self.expProTxt.textAlignment=NSTextAlignmentRight;
        self.expProdctLbl.textAlignment=NSTextAlignmentRight;
        self.reviewTitleTxt.textAlignment=NSTextAlignmentRight;
        self.reviewTitle.textAlignment=NSTextAlignmentRight;
        self.proRatLbl.textAlignment=NSTextAlignmentRight;
        self.prodctRwrTxt.textAlignment=NSTextAlignmentRight;
        self.prodctRwlbl.textAlignment=NSTextAlignmentRight;
        self.expTxt.textAlignment=NSTextAlignmentRight;
        self.expLbl.textAlignment=NSTextAlignmentRight;
        self.prodctqlty.textAlignment=NSTextAlignmentRight;
        self.shipngcost.textAlignment=NSTextAlignmentRight;
        self.shipingrt.textAlignment=NSTextAlignmentRight;
        self.ovrallrt.textAlignment=NSTextAlignmentRight;
        self.ratemerchntLbl.textAlignment=NSTextAlignmentRight;
        self.merchantFeedbackLbl.textAlignment=NSTextAlignmentRight;
        self.merchantFeedbckRestxt.textAlignment=NSTextAlignmentRight;
        

        self.titleLabel.textAlignment=NSTextAlignmentRight;
        self.youPaidLbl.textAlignment=NSTextAlignmentRight;
        self.youPaidresLbl.textAlignment=NSTextAlignmentRight;
        self.orderStsLbl.textAlignment=NSTextAlignmentRight;
        self.orderstsresLbl.textAlignment=NSTextAlignmentRight;
        self.orderidresLbl.textAlignment=NSTextAlignmentRight;
        self.orderIdLbl.textAlignment=NSTextAlignmentRight;
        self.orderdateresLbl.textAlignment=NSTextAlignmentRight;
        self.orderDateLbl.textAlignment=NSTextAlignmentRight;

        [self.submitBtn setTitle:@"ارسال" forState:UIControlStateNormal];
        self.expProdctLbl.text=@"أخبرنا عن تجربتك مع هذا المنتج";
        self.reviewTitle.text=@"عنوان التقييم";
        self.proRatLbl.text=@"تقييم المنتج ";
        self.prodctRwlbl.text=@"ادخل تقييمك للمنتج";
        self.prodctRwrTxt.text=@" يرجى تقييم المنتج بشكل عام , اخبرنا تجربتك مع هذا المنتج في حقل التقييم ";
        self.expLbl.text=@"شاركنا تجربتك مع هذا البائع";
        self.headerTitle.text=@"أضف تعليقك";
        self.prodctqlty.text=@"جودة المنتج";
        self.shipngcost.text=@"تكلفة الشحن";
        self.shipingrt.text=@"وقت الشحن";
        self.ovrallrt.text=@"المعدل العام";
        self.ratemerchntLbl.text=@"قم بتقييم البائع";
        self.merchantFeedbackLbl.text=@"رأيك في البائع؟";
        self.merchantFeedbckRestxt.text=@"يرجى تقييم تجربتك وكتابة ملاحظاتك حول الطلب من هذا البائع";
        self.youPaidLbl.text=@"المبلغ ";
        self.orderStsLbl.text=@"حالة الطلب";
        self.orderIdLbl.text=@" رقم الطلب ";
        self.orderDateLbl.text=@"تاريخ الطلب";
        
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"معدل التقييم الإجمالي*"];
        [string beginEditing];
        [string addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string.length-1, 1)];
        [string endEditing];
        [self.ovrallrt setAttributedText:string];
        
        NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:@"وقت الشحن*"];
        [string1 beginEditing];
        [string1 addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(string1.length-1, 1)];
        [string1 endEditing];
        [self.shipingrt setAttributedText:string1];
        
        NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"تكلفة الشحن*"];
        [string2 beginEditing];
        [string2 addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(string2.length-1, 1)];
        [string2 endEditing];
        [self.shipngcost setAttributedText:string2];
        
        NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@"جودة المنتج*"];
        [string3 beginEditing];
        [string3 addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(string3.length-1, 1)];
        [string3 endEditing];
        [self.prodctqlty setAttributedText:string3];
        
        NSMutableAttributedString *string4 = [[NSMutableAttributedString alloc] initWithString:@" شاركنا تجربتك مع هذا البائع *"];
        [string4 beginEditing];
        [string4 addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(string4.length-1, 1)];
        [string4 endEditing];
        [self.expLbl setAttributedText:string4];
        
        NSMutableAttributedString *string5 = [[NSMutableAttributedString alloc] initWithString:@"تقييمات المنتج *"];
        [string5 beginEditing];
        [string5 addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(string5.length-1, 1)];
        [string5 endEditing];
        [self.proRatLbl setAttributedText:string5];
        
        NSMutableAttributedString *string6 = [[NSMutableAttributedString alloc] initWithString:@" عنوان التقييم *"];
        [string6 beginEditing];
        [string6 addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(string6.length-1, 1)];
        [string6 endEditing];
        [self.reviewTitle setAttributedText:string6];
        
        NSMutableAttributedString *string7 = [[NSMutableAttributedString alloc] initWithString:@" شاركنا تجربتك مع هذا المنتج*"];
        [string7 beginEditing];
        [string7 addAttribute:NSForegroundColorAttributeName
                        value:[UIColor redColor]  range:NSMakeRange(string7.length-1, 1)];
        [string7 endEditing];
        [self.expProdctLbl setAttributedText:string7];
    }
    else
    {
        self.headerTitle.text=@"Pending Feedback";
        NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Overall Rate*"];
        [string beginEditing];
        [string addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string.length-1, 1)];
        [string endEditing];
        [self.ovrallrt setAttributedText:string];
        
        NSMutableAttributedString *string1 = [[NSMutableAttributedString alloc] initWithString:@"Shipping Time*"];
        [string1 beginEditing];
        [string1 addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string1.length-1, 1)];
        [string1 endEditing];
        [self.shipingrt setAttributedText:string1];
        
        NSMutableAttributedString *string2 = [[NSMutableAttributedString alloc] initWithString:@"Shipping Cost*"];
        [string2 beginEditing];
        [string2 addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string2.length-1, 1)];
        [string2 endEditing];
        [self.shipngcost setAttributedText:string2];
        
        NSMutableAttributedString *string3 = [[NSMutableAttributedString alloc] initWithString:@"Product Quality*"];
        [string3 beginEditing];
        [string3 addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string3.length-1, 1)];
        [string3 endEditing];
        [self.prodctqlty setAttributedText:string3];
        
        NSMutableAttributedString *string4 = [[NSMutableAttributedString alloc] initWithString:@"Tell us your experience with this merchant*"];
        [string4 beginEditing];
        [string4 addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string4.length-1, 1)];
        [string4 endEditing];
        [self.expLbl setAttributedText:string4];
        
        NSMutableAttributedString *string5 = [[NSMutableAttributedString alloc] initWithString:@"Product Rating*"];
        [string5 beginEditing];
        [string5 addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string5.length-1, 1)];
        [string5 endEditing];
        [self.proRatLbl setAttributedText:string5];
        
        NSMutableAttributedString *string6 = [[NSMutableAttributedString alloc] initWithString:@"Review Title*"];
        [string6 beginEditing];
        [string6 addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string6.length-1, 1)];
        [string6 endEditing];
        [self.reviewTitle setAttributedText:string6];
        
        NSMutableAttributedString *string7 = [[NSMutableAttributedString alloc] initWithString:@"Tell us your experience with this product*"];
        [string7 beginEditing];
        [string7 addAttribute:NSForegroundColorAttributeName
                       value:[UIColor redColor]  range:NSMakeRange(string7.length-1, 1)];
        [string7 endEditing];
        [self.expProdctLbl setAttributedText:string7];
    }
    
    
    
    _titleLabel.text=_titleStr;
    _orderidresLbl.text=_orderId;
    _orderdateresLbl.text=_date;
    _orderstsresLbl.text=_status;
    float pay=[_paid floatValue];
    
    _youPaidresLbl.text=[NSString stringWithFormat:@" %.2f %@",pay,appDelObj.currencySymbol];
    
    if ([_haveProRev isEqualToString:@"1"])
    {
        if ([_haveMerRev isEqualToString:@"1"])
        {
            self.merchantView.alpha=0;
            self.productView.alpha=0;
            self.submitBtn.alpha=0;
        }
        else
        {
            self.merchantView.alpha=1;
            self.productView.alpha=0;
           // self.submitBtn.frame=CGRectMake(self.submitBtn.frame.origin.x, self.merchantView.frame.origin.y+self.merchantView.frame.size.height+50, self.submitBtn.frame.size.width, self.submitBtn.frame.size.height);
            _scrlView.contentSize = CGSizeMake(0,self.merchantView.frame.origin.y+self.merchantView.frame.size.height);
        }
    }
    else
    {
        if ([_haveMerRev isEqualToString:@"1"])
        {
            if ([_enableProductReview isEqualToString:@"Yes"]||[_enableProductReview isEqualToString:@"yes"])
            {
                self.merchantView.alpha=0;
                self.productView.alpha=1;
                self.submitBtn.alpha=1;
                self.productView.frame=CGRectMake(self.productView.frame.origin.x, self.merchantView.frame.origin.y+self.merchantView.frame.size.height+50, self.productView.frame.size.width, self.productView.frame.size.height);
                
               // self.submitBtn.frame=CGRectMake(self.submitBtn.frame.origin.x, self.productView.frame.origin.y+self.productView.frame.size.height+50, self.submitBtn.frame.size.width, self.submitBtn.frame.size.height);
                _scrlView.contentSize = CGSizeMake(0,self.productView.frame.origin.y+self.productView.frame.size.height);
            }
            else
            {
                self.merchantView.alpha=0;
                self.productView.alpha=0;
                self.submitBtn.alpha=0;
            }
        }
        else
        {
            if ([_enableProductReview isEqualToString:@"Yes"]||[_enableProductReview isEqualToString:@"yes"])
            {
                self.merchantView.alpha=1;
                self.productView.alpha=1;
                _scrlView.contentSize = CGSizeMake(0,self.productView.frame.origin.y+self.productView.frame.size.height);
            }
            else
            {
                self.merchantView.alpha=1;
                self.productView.alpha=0;
               // self.submitBtn.frame=CGRectMake(self.submitBtn.frame.origin.x, self.merchantView.frame.origin.y+self.merchantView.frame.size.height+50, self.submitBtn.frame.size.width, self.submitBtn.frame.size.height);
                _scrlView.contentSize = CGSizeMake(0,self.merchantView.frame.origin.y+self.merchantView.frame.size.height);
            }
           
        }
    }
//    [self.submitBtn needsUpdateConstraints];
//    [self.productView needsUpdateConstraints];
//    [self.merchantView needsUpdateConstraints];
  //  _scrlView.contentSize = CGSizeMake(0, [UIScreen mainScreen].bounds.size.height*3);

}
- (BOOL)textView:(UITextView* )textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString* )text {
    
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
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

- (IBAction)s2act:(id)sender {
    
    UIImage *currentImage = [_s2.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s2 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s2.imageView.image isEqual:checkImage]) {
        oveall=@"2";
         [_s1 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        
        oveall=@"";
        [_s3 setImage:uncheckImage forState:UIControlStateNormal];
        [_s4 setImage:uncheckImage forState:UIControlStateNormal];
        [_s5 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
    
}

- (IBAction)s1Act:(id)sender {
    UIImage *currentImage = [_s1.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s1 setImage:currentImage forState:UIControlStateNormal];
   
    if ([_s1.imageView.image isEqual:checkImage]) {
  oveall=@"1";
        selected1=1;
    }
    else
    {
      
        oveall=@"";
        selected1=0;
        [_s2 setImage:uncheckImage forState:UIControlStateNormal];
        [_s3 setImage:uncheckImage forState:UIControlStateNormal];
        [_s4 setImage:uncheckImage forState:UIControlStateNormal];
        [_s5 setImage:uncheckImage forState:UIControlStateNormal];
      
        
    }
}
- (IBAction)r3act:(id)sender {
    UIImage *currentImage = [_r3.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_r3 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_r3.imageView.image isEqual:checkImage]) {
        productRating=@"3";
        [_r1 setImage:checkImage forState:UIControlStateNormal];
        [_r2 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
         productRating=@"";
        
        
        [_r4 setImage:uncheckImage forState:UIControlStateNormal];
        [_r5 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}

- (IBAction)r1act:(id)sender {
    UIImage *currentImage = [_r1.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_r1 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_r1.imageView.image isEqual:checkImage]) {
        
       productRating=@"1";
    }
    else
    {
         productRating=@"";
        [_r2 setImage:uncheckImage forState:UIControlStateNormal];
        [_r3 setImage:uncheckImage forState:UIControlStateNormal];
        
        [_r4 setImage:uncheckImage forState:UIControlStateNormal];
        [_r5 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}

- (IBAction)r2act:(id)sender {
    UIImage *currentImage = [_r2.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_r2 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_r2.imageView.image isEqual:checkImage]) {
        
  productRating=@"2";        [_r1 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        
       productRating=@"";
        [_r3 setImage:uncheckImage forState:UIControlStateNormal];

        [_r4 setImage:uncheckImage forState:UIControlStateNormal];
        [_r5 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}

- (IBAction)s3act:(id)sender {
    UIImage *currentImage = [_s3.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s3 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s3.imageView.image isEqual:checkImage]) {
        
oveall=@"3";         [_s1 setImage:checkImage forState:UIControlStateNormal];
         [_s2 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        
        oveall=@"";
     
        [_s4 setImage:uncheckImage forState:UIControlStateNormal];
        [_s5 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)s5act:(id)sender {
    UIImage *currentImage = [_s5.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s5 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s5.imageView.image isEqual:checkImage]) {
        
        oveall=@"5";
         [_s1 setImage:checkImage forState:UIControlStateNormal];
         [_s2 setImage:checkImage forState:UIControlStateNormal];
         [_s3 setImage:checkImage forState:UIControlStateNormal];
        [_s4 setImage:checkImage forState:UIControlStateNormal];

    }
    else
    {
        
        
       oveall=@"";
       
        
        
    }
}

- (IBAction)s4act:(id)sender {
    UIImage *currentImage = [_s4.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s4 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s4.imageView.image isEqual:checkImage]) {
        oveall=@"4";
        [_s1 setImage:checkImage forState:UIControlStateNormal];
        [_s2 setImage:checkImage forState:UIControlStateNormal];
        [_s3 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        
        oveall=@"";
       
        [_s5 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}


- (IBAction)s11act:(id)sender {
    UIImage *currentImage = [_s11.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s11 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s11.imageView.image isEqual:checkImage]) {
        
        shipingTime=@"1";
    }
    else
    {
        
        
        shipingTime=@"";
        [_s12 setImage:uncheckImage forState:UIControlStateNormal];
        [_s13 setImage:uncheckImage forState:UIControlStateNormal];
        [_s14 setImage:uncheckImage forState:UIControlStateNormal];
        [_s15 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)s13act:(id)sender {
    UIImage *currentImage = [_s13.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s13 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s13.imageView.image isEqual:checkImage]) {
        
        shipingTime=@"3";
        [_s11 setImage:checkImage forState:UIControlStateNormal];
        [_s12 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        
       shipingTime=@"";
        
        [_s14 setImage:uncheckImage forState:UIControlStateNormal];
        [_s15 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}

- (IBAction)s12act:(id)sender {
    UIImage *currentImage = [_s12.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s12 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s12.imageView.image isEqual:checkImage]) {
        
        shipingTime=@"2";
        [_s11 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        
       shipingTime=@"";
          [_s13 setImage:uncheckImage forState:UIControlStateNormal];
        [_s14 setImage:uncheckImage forState:UIControlStateNormal];
        [_s15 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)s21act:(id)sender {
    UIImage *currentImage = [_s21.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s21 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s21.imageView.image isEqual:checkImage]) {
        
        shipinCost=@"1";
    }
    else
    {
        
        
        shipinCost=@"";
        [_s22 setImage:uncheckImage forState:UIControlStateNormal];
        [_s23 setImage:uncheckImage forState:UIControlStateNormal];
        [_s24 setImage:uncheckImage forState:UIControlStateNormal];
        [_s25 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}



- (IBAction)s15act:(id)sender {
    UIImage *currentImage = [_s15.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s15 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s15.imageView.image isEqual:checkImage]) {
        
        shipingTime=@"5";
        [_s11 setImage:checkImage forState:UIControlStateNormal];
        [_s12 setImage:checkImage forState:UIControlStateNormal];
        [_s14 setImage:checkImage forState:UIControlStateNormal];
        [_s13 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        
      shipingTime=@"";
        
     
        
        
    }
}

- (IBAction)s14act:(id)sender {
    UIImage *currentImage = [_s14.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s14 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s14.imageView.image isEqual:checkImage]) {
        
        shipingTime=@"4";
        [_s11 setImage:checkImage forState:UIControlStateNormal];
        [_s12 setImage:checkImage forState:UIControlStateNormal];
        [_s13 setImage:checkImage forState:UIControlStateNormal];

    }
    else
    {
        
        
        shipingTime=@"";
        
      
        [_s15 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)s22act:(id)sender {
    UIImage *currentImage = [_s22.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s22 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s22.imageView.image isEqual:checkImage]) {
        
        shipinCost=@"2";
        [_s21 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        shipinCost=@"";
        
                [_s23 setImage:uncheckImage forState:UIControlStateNormal];
        [_s24 setImage:uncheckImage forState:UIControlStateNormal];
        [_s25 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)s23act:(id)sender {
    UIImage *currentImage = [_s23.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s23 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s23.imageView.image isEqual:checkImage]) {
        
         shipinCost=@"3";
        [_s21 setImage:checkImage forState:UIControlStateNormal];
        [_s22 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        
        shipinCost=@"";
        
        [_s24 setImage:uncheckImage forState:UIControlStateNormal];
        [_s25 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)s24act:(id)sender {
    UIImage *currentImage = [_s24.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s24 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s24.imageView.image isEqual:checkImage]) {
        
         shipinCost=@"4";
        [_s21 setImage:checkImage forState:UIControlStateNormal];
        [_s22 setImage:checkImage forState:UIControlStateNormal];
        [_s23 setImage:checkImage forState:UIControlStateNormal];

    }
    else
    {
        
        
        shipinCost=@"";
        
        [_s25 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)s25act:(id)sender {
    UIImage *currentImage = [_s25.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s25 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s25.imageView.image isEqual:checkImage]) {
        
         shipinCost=@"5";
        [_s21 setImage:checkImage forState:UIControlStateNormal];
        [_s22 setImage:checkImage forState:UIControlStateNormal];
        [_s23 setImage:checkImage forState:UIControlStateNormal];
        [_s24 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
         shipinCost=@"";
  
    }
}

- (IBAction)s31act:(id)sender {
    UIImage *currentImage = [_s31.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s31 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s31.imageView.image isEqual:checkImage]) {
        proQuality=@"1";
       
    }
    else
    {
        proQuality=@"";
        
        selected1=2;
        [_s32 setImage:uncheckImage forState:UIControlStateNormal];
        [_s33 setImage:uncheckImage forState:UIControlStateNormal];
        [_s34 setImage:uncheckImage forState:UIControlStateNormal];
        [_s35 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)s32act:(id)sender {
    UIImage *currentImage = [_s32.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s32 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s32.imageView.image isEqual:checkImage]) {
        
        proQuality=@"2";
        [_s31 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        
        proQuality=@"";
        [_s33 setImage:uncheckImage forState:UIControlStateNormal];

        [_s34 setImage:uncheckImage forState:UIControlStateNormal];
        [_s35 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)s35act:(id)sender {
    UIImage *currentImage = [_s35.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s35 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s35.imageView.image isEqual:checkImage]) {
        
        proQuality=@"5";
        [_s31 setImage:checkImage forState:UIControlStateNormal];
        [_s32 setImage:checkImage forState:UIControlStateNormal];
        [_s33 setImage:checkImage forState:UIControlStateNormal];
        [_s34 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        proQuality=@"";
       
    }
}

- (IBAction)s33act:(id)sender {
    UIImage *currentImage = [_s33.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s33 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s33.imageView.image isEqual:checkImage]) {
        
        proQuality=@"3";
        [_s31 setImage:checkImage forState:UIControlStateNormal];
        [_s32 setImage:checkImage forState:UIControlStateNormal];

    }
    else
    {
        
        proQuality=@"";
        selected1=2;
        
        [_s34 setImage:uncheckImage forState:UIControlStateNormal];
        [_s35 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}

- (IBAction)s34act:(id)sender {
    UIImage *currentImage = [_s34.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_s34 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_s34.imageView.image isEqual:checkImage]) {
        
        proQuality=@"4";
        [_s31 setImage:checkImage forState:UIControlStateNormal];
        [_s32 setImage:checkImage forState:UIControlStateNormal];
        [_s33 setImage:checkImage forState:UIControlStateNormal];

    }
    else
    {
        
        
        proQuality=@"";
        
        [_s35 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)r4act:(id)sender {
    UIImage *currentImage = [_r4.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_r4 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_r4.imageView.image isEqual:checkImage]) {
        
  productRating=@"4";
        [_r1 setImage:checkImage forState:UIControlStateNormal];
        [_r2 setImage:checkImage forState:UIControlStateNormal];
          [_r3 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        
        
        productRating=@"";
        
        [_r5 setImage:uncheckImage forState:UIControlStateNormal];
        
        
    }
}
- (IBAction)r5act:(id)sender {
    UIImage *currentImage = [_r5.imageView.image isEqual:checkImage] ? uncheckImage:checkImage;
    [_r5 setImage:currentImage forState:UIControlStateNormal];
    
    if ([_r5.imageView.image isEqual:checkImage]) {
        
        productRating=@"5";
        [_r1 setImage:checkImage forState:UIControlStateNormal];
        [_r2 setImage:checkImage forState:UIControlStateNormal];
        [_r3 setImage:checkImage forState:UIControlStateNormal];
        [_r4 setImage:checkImage forState:UIControlStateNormal];
    }
    else
    {
        productRating=@"";
        
       
        
        
    }
}
- (IBAction)submitAct:(id)sender
{
    if (_merchantView.alpha==1&&_productView.alpha==1)
    {
        NSLog(@"both********");
        if (oveall.length==0||shipinCost.length==0||shipingTime.length==0||proQuality.length==0||productRating.length==0||_expTxt.text.length==0||_expProTxt.text.length==0||_reviewTitleTxt.text.length==0)
        {
            NSString *msg=@"Please give all mandatory values";
            NSString *ok=@"Ok";
            if (appDelObj.isArabic) {
                msg=@"يرجى إعطاء جميع القيم الإلزامية";
                ok=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
        }
        else
        {
            [self submitReview];
        }
    }
    else
    {
        if (_merchantView.alpha==1)
        {
            NSLog(@"Merchant********");
            if (oveall.length==0||shipinCost.length==0||shipingTime.length==0||proQuality.length==0||_expTxt.text.length==0)
            {
                NSString *msg=@"Please give all mandatory values";
                NSString *ok=@"Ok";
                if (appDelObj.isArabic) {
                    msg=@"يرجى إعطاء جميع القيم الإلزامية";
                    ok=@" موافق ";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                [self submitReview];
            }
        }
        else
        {
            NSLog(@"product********");
            if (productRating.length==0||_expProTxt.text.length==0||_reviewTitleTxt.text.length==0)
            {
                NSString *msg=@"Please give all mandatory values";
                NSString *ok=@"Ok";
                if (appDelObj.isArabic) {
                    msg=@"يرجى إعطاء جميع القيم الإلزامية";
                    ok=@" موافق ";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                [self submitReview];
            }
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
                                    [self back:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)submitReview
{
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    if (oveall.length==0) {
        oveall=@"";
    }
    if (shipingTime.length==0) {
        shipingTime=@"";
    }
    if (shipinCost.length==0) {
        shipinCost=@"";
    }
    if (proQuality.length==0) {
        proQuality=@"";
    }
    if (productRating.length==0) {
        productRating=@"";
    }
    if (_expTxt.text.length==0) {
        _expTxt.text=@"";
    }
    if (_expProTxt.text.length==0) {
        _expProTxt.text=@"";
    }
    if (_reviewTitleTxt.text.length==0) {
        _reviewTitleTxt.text=@"";
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/review/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",_orderId,@"orderItemID",_pid,@"pid",_bid,@"bid",oveall,@"currentRating",shipinCost,@"shippingCostRating",shipingTime,@"shippingTimeRating",proQuality,@"productQuantityRatings",productRating,@"productRatings",_expTxt.text,@"businessReviewComment",_expProTxt.text,@"productReviewComment",_reviewTitleTxt.text,@"productReviewTitle",_masterOderid,@"id",@"Yes",@"submit", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    NSString *ok=@"Ok";
    
    if (appDelObj.isArabic) {
       
        ok=@" موافق ";
    }
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        
        NSLog(@"sucessssss");
       NSString* msg=@"Your comments submitted successfully!!! Product review will be posted after the admin approval";
       
        if (appDelObj.isArabic) {
            msg=@"تم ارسال تقييم طلبك بنجاح، سيتم نشره بعد مراجعته من قبل الادارة";
            ok=@" موافق ";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *acion){[self back:nil];}]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
}

- (IBAction)back:(id)sender {
    if(appDelObj.isArabic==YES )
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
@end
