//
//  ArabicHomeViewController.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "ArabicHomeViewController.h"

@interface ArabicHomeViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,NSURLSessionDelegate,passDataAfterParsing,viewAllDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    NSArray *catNameAry,*catImageAry,*bannerAry,*searchArray,*fullAray;
    WebService *webServiceObj;
    NSMutableArray *widgetAry,*widgetStaticAry,*lanAry,*sliderImgaes;
    NSIndexPath *indexPathSel;
    NSString *catOrBanner,*bannerURl,*listURl,*searchUrl,*lanUrl,*freeproducts,*Product;
}



@end

@implementation ArabicHomeViewController
@synthesize timer;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    CGRect frameRect = self.txtSearch.frame;
    frameRect.size.height = 38;
    self.txtSearch.frame = frameRect;
    self.btnBack.transform = CGAffineTransformMakeScale(-1, 1);
     self.tblBanner.transform=CGAffineTransformMakeScale(-1, 1);
    self.page.transform=CGAffineTransformMakeScale(-1, 1);
    self.tblBanner.rowHeight = self.view.frame.size.width;
    self.tblBanner.transform=CGAffineTransformMakeRotation(-M_PI/2);
    self.tblBanner.showsVerticalScrollIndicator = NO;
    self.tblBanner.frame = CGRectMake(0, 5, self.view.frame.size.width, 200);
    [self.tblBanner setBackgroundColor:[UIColor clearColor]];
    self.tblBanner.pagingEnabled = YES;
    if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad )
    {
        self.lblCOD.font=[UIFont systemFontOfSize:18];
        self.lblKing.font=[UIFont systemFontOfSize:18];
        self.lblvarious.font=[UIFont systemFontOfSize:18];
        self.lblCust.font=[UIFont systemFontOfSize:18];
        self.lblcomp.font=[UIFont systemFontOfSize:18];
        self.lblwarr.font=[UIFont systemFontOfSize:18];
    }
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    appDelObj.dealBundle=@"";
    
    indexPathSel=[[NSIndexPath alloc]init];
    self.navigationController.navigationBarHidden=YES;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    widgetAry=widgetStaticAry=lanAry=[[NSMutableArray alloc]init];
    self.headderViewObj.backgroundColor=appDelObj.headderColor;
    self.topViewObj.backgroundColor=appDelObj.headderColor;
    self.bgImg.backgroundColor=appDelObj.bgViewColor;
    
    [_colSearch registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    
 sliderImgaes=[[NSMutableArray alloc]init];
    if ( [[[NSUserDefaults standardUserDefaults]objectForKey:@"SELECT_LANGUAGE"]isEqualToString:@"YES"])
    {
        self.languageView.alpha=0;
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/banner/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost;
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"2",@"bannerLoc", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else
    {
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        self.languageView.alpha=1;
        [self getLanguage];
    }
}
-(void)viewWillAppear:(BOOL)animated
{
     sliderImgaes=[[NSMutableArray alloc]init];
    catOrBanner=@"Banner";
    appDelObj.dealBundle=@"";
    appDelObj.mainBrand=@"";
    appDelObj.mainPrice=@"";
    appDelObj.mainSearch=@"";
    appDelObj.mainBusiness=@"";
    appDelObj.mainDiscount=@"";
    [[NSUserDefaults standardUserDefaults]setObject:@"Home" forKey:@"Where"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
   
    CGRect frame1 = self.tblCat.tableHeaderView.frame;
    frame1.size.height = 0;
    UIView *headerView1 = [[UIView alloc] initWithFrame:frame1];
    [self.tblCat setTableHeaderView:headerView1];
    catNameAry=[[NSArray alloc]initWithObjects:@"Vegitables",@"Fruits",@"Leafy Vegitables",@"Organic", nil];
    catImageAry=[[NSArray alloc]initWithObjects:@"veg-icon.png",@"fruit-icon.png",@"leaf-icon.png",@"organic-icon.png", nil];
    self.lblCartCount.clipsToBounds=YES;
    self.lblCartCount.layer.cornerRadius=self.lblCartCount.frame.size.height/2;
   
    self.lblCartCount.backgroundColor=appDelObj.cartBg ;
    self.lblCartCount.textColor=appDelObj.headderColor;
    [[self.lblCartCount layer] setBorderWidth:1.0f];
    [[self.lblCartCount layer] setBorderColor:[appDelObj.headderColor CGColor]];
    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    
    if (cartCount.length==0)
    {
        self.lblCartCount.alpha=0;
    }
    else
    {
        self.lblCartCount.alpha=1;
        self.lblCartCount.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    }
    UIImageView *envelopeView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, 20, 20)];
    envelopeView.image = [UIImage imageNamed:@"home-search.png"];
    envelopeView.contentMode = UIViewContentModeScaleAspectFit;
    UIView *test=  [[UIView alloc]initWithFrame:CGRectMake(20, 0, 30, 30)];
    [test addSubview:envelopeView];
    [self.txtSearch.rightView setFrame:envelopeView.frame];
    self.txtSearch.rightView =test;
    self.txtSearch.rightViewMode = UITextFieldViewModeAlways;
    self.txtSearch.layer.borderWidth=1;

    self.txtSearch.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    self.page.frame=CGRectMake(self.page.frame.origin.x, self.tblBanner.frame.origin.y+self.tblBanner.frame.size.height, self.page.frame.size.width, self.page.frame.size.height);
  
    timer=[NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(onTimer)   userInfo:nil repeats:YES];
 
    self.colSearch.frame=CGRectMake(self.colSearch.frame.origin.x, self.colSearch.frame.origin.y, self.colSearch.frame.size.width, 0);
    self.scrollViewObj.backgroundColor=[UIColor whiteColor];
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
    {
        self.catWidth.constant = self.view.frame.size.height+130;
        [self.categoryView needsUpdateConstraints];
        self.catTblw.constant = self.view.frame.size.height+130;
        [self.tblCat needsUpdateConstraints];
        self.bannerw.constant = self.view.frame.size.height+130;
        [self.tblBanner needsUpdateConstraints];
    }
}
-(void) onTimer
{
    if ([ self.tblBanner numberOfRowsInSection:0]>1) {

        UIScrollView *scrollView = (UIScrollView *) self.tblBanner;
        CATransition *animation = [CATransition animation];
        [animation setDuration:1.0];
  
        [animation setType:kCATransitionMoveIn];
   
        [animation setSubtype:kCATransitionFromRight];
        
        [animation setRemovedOnCompletion:YES];
        [animation setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [[ self.tblBanner layer] addAnimation:animation forKey:nil];
        
        if (!scrollView.isDecelerating) {
            if (scrollView.contentOffset.y+self.view.frame.size.width==scrollView.contentSize.height){
                
                
                [scrollView scrollRectToVisible:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.width) animated:NO];
                // self.tblBanner.frame = CGRectMake(0, 4, self.view.frame.size.width, 200);
                
                
                return;
            }
            if (scrollView.contentOffset.y<scrollView.contentSize.height) {
                
                [scrollView scrollRectToVisible:CGRectMake(0, scrollView.contentOffset.y+self.tblBanner.frame.size.width, self.tblBanner.frame.size.width,self.tblBanner.frame.size.width ) animated:NO];

            }
        }
    }
    
    // self.tblBanner.contentOffset=CGPointMake(self.tblBanner.frame.origin.x-320, self.tblBanner.frame.origin.y);
}

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event

{
    if (searchArray.count==0)
    {
        self.colSearch.frame=CGRectMake(self.colSearch.frame.origin.x, self.colSearch.frame.origin.y, self.colSearch.frame.size.width, 0);
    }
    else if (searchArray.count>3)
    {
        self.colSearch.frame=CGRectMake(self.colSearch.frame.origin.x, self.colSearch.frame.origin.y, self.colSearch.frame.size.width, self.view.frame.size.height-self.headderViewObj.frame.size.height+50);
    }
    else
    {
        self.colSearch.frame=CGRectMake(self.colSearch.frame.origin.x, self.colSearch.frame.origin.y, self.colSearch.frame.size.width, (self.view.frame.size.width/2)*searchArray.count);
    }
    [self.txtSearch resignFirstResponder];
}
//-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
//{
//
//    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
//    NSLog(@"%@",newString);
//    if (newString.length==0)
//    {
//        self.txtSearch.text=@"";
//        [self.txtSearch resignFirstResponder];
//
//        self.colSearch.alpha=0;
//        self.colSearch.frame=CGRectMake(self.colSearch.frame.origin.x, self.colSearch.frame.origin.y, self.colSearch.frame.size.width, 0);
//    }
//    else
//    {
//        self.colSearch.alpha=1;
//
//        NSString *postUrl = [NSString stringWithFormat:@"%@mobileapp/Deal/productsList/languageID/%@",appDelObj.baseURL,appDelObj.languageId];
//        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
//
//        [request setHTTPMethod:@"POST"];
//
//        NSMutableData *body = [NSMutableData data];
//
//        NSString *boundary = @"---------------------------14737809831466499882746641449";
//        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
//        [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
//
//        [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"keyword"] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithString:newString] dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
//        [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
//        // set request body
//        [request setHTTPBody:body];
//        NSURLResponse  *res;
//        NSError *err;
//        NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
//        //[connection start];
//
//        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
//        NSLog(@"Response  %@",dic);
//        searchUrl=[[dic objectForKey:@"result"]objectForKey:@"prodsImageurl"];
//        if ([[dic objectForKey:@"response"] isEqualToString:@"Success"])
//        {
//            searchArray =[[dic objectForKey:@"result"]objectForKey:@"resProducts"];
//            appDelObj.currencySymbol=[[dic objectForKey:@"result"]objectForKey:@"currencySymbol"];
//        }
//        if (searchArray.count>3)
//        {
//            self.colSearch.frame=CGRectMake(self.colSearch.frame.origin.x, self.colSearch.frame.origin.y, self.colSearch.frame.size.width, 300);
//
//        }
//        else
//        {
//            self.colSearch.frame=CGRectMake(self.colSearch.frame.origin.x, self.colSearch.frame.origin.y, self.colSearch.frame.size.width, (self.view.frame.size.width/2)*searchArray.count);
//
//        }        [self.colSearch reloadData];
//
//    }
//    return YES;
//}

-(void)textFieldDidBeginEditing:(UITextField *)textField
{
    [self.txtSearch resignFirstResponder];
  
    SearchView *search=[[SearchView alloc]init];
    transition = [CATransition animation];
    [transition setDuration:0.3];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:search animated:NO];
    
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    if (textField.text.length==0)
    {
    }
    else
    {
        ListViewController *listObj=[[ListViewController alloc]init];
        appDelObj.listTitle=textField.text;
        listObj.keyword=textField.text;
        appDelObj.CatID=@"";
        appDelObj.CatPArID=@"";
        appDelObj.frommenu=@"";
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:listObj animated:YES];
    }
    return YES;
}
-(void)getData
{
    self.languageView.alpha=0;
    catOrBanner=@"Banner";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/banner/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost;
    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"2",@"bannerLoc", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)getLanguage
{
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/getAllLanguages/languageID/",appDelObj.languageId];
    self.languageView.alpha=1;
    NSURL *url = [NSURL URLWithString:urlStr];
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    NSURLResponse * response;
    NSError * error;
    NSData * data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
    NSDictionary *dic=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    if ([[dic objectForKey:@"response"]isEqualToString:@"Success"])
    {
        
        lanAry=[dic objectForKey:@"result"];
        [[NSUserDefaults standardUserDefaults]setObject:[dic objectForKey:@"contactEmail"] forKey:@"CustomerEmail"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if(lanAry.count==1)
        {
            appDelObj.languageId=[[lanAry objectAtIndex:0]valueForKey:@"languageID"];
            if([[[lanAry objectAtIndex:0]valueForKey:@"languageName"]isEqualToString:@"Arabic"]||[[[lanAry objectAtIndex:0]valueForKey:@"languageName"]isEqualToString:@"العربية"])
            {
                [[NSUserDefaults standardUserDefaults]setObject:@"Arabic" forKey:@"LANGUAGE"];
                [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:0]valueForKey:@"languageID"] forKey:@"LANGUAGEID"];
                appDelObj.isArabic=YES;
                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SELECT_LANGUAGE"];
                [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:0]valueForKey:@"languageName"] forKey:@"SELECT_LANGUAGE_Name"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                [appDelObj arabicMenuAction];
                
            }
            else
            {
                [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:0]valueForKey:@"languageID"] forKey:@"LANGUAGEID"];
                [[NSUserDefaults standardUserDefaults]setObject:@"English" forKey:@"LANGUAGE"];
                appDelObj.isArabic=NO;
                [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SELECT_LANGUAGE"];
                [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:0]valueForKey:@"languageName"] forKey:@"SELECT_LANGUAGE_Name"];
                [[NSUserDefaults standardUserDefaults]synchronize];
                // [appDelObj englishMenuAction];
                [self getData];
            }
            
            self.languageView.alpha=0;
            [Loading dismiss];
            
        }
        else
        {
        
            [Loading dismiss];
        }
    }
    else
    {
        [Loading dismiss];
    }
}

-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    
    //self.colSearch.frame=CGRectMake(0, self.colSearch.frame.origin.y, self.colSearch.frame.size.width, 1);
    NSString *fb=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"settings"]objectForKey:@"facebook_enable_login"]];
    if ([fb isKindOfClass:[NSNull class]]||fb.length==0||[fb isEqualToString:@"(null)"]||[fb isEqualToString:@"<null>"])
    {
        fb=@"Yes";
    }
    else
    {
        fb=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"settings"]objectForKey:@"facebook_enable_login"]];
    }
    [[NSUserDefaults standardUserDefaults]setObject:fb forKey:@"FB_Login"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    int height=0;
    if([dictionary isKindOfClass:[NSNull class]])
    {
        NSString *strMsg,*okMsg;
        
        strMsg=@"يرجى المحاولة بعد مرور بعض الوقت";
        okMsg=@" موافق ";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"No data available" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
        
    {
        if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
        {
            if ([catOrBanner isEqualToString:@"Banner"])
            {
                bannerAry=[[dictionary objectForKey:@"result"]objectForKey:@"banner"];
                bannerURl=[[dictionary objectForKey:@"result"]objectForKey:@"bannerPath"];
                self.page.numberOfPages=bannerAry.count;
                if (!timer) {
                    timer=[NSTimer scheduledTimerWithTimeInterval:10.0 target:self selector:@selector(onTimer)   userInfo:nil repeats:YES];
                }
                catOrBanner=@"Category";
                if (bannerAry.count==0)
                {
                    _tblBanner.alpha=0;
                    _page.alpha=0;
                    self.categoryView.frame=CGRectMake(0, 0, self.categoryView.frame.size.width, self.categoryView.frame.size.height);
                    if(height==0)
                    {
                        self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.size.height+self.categoryView.frame.origin.y, self.tblCat.frame.size.width, height+100);
                        
                    }
                    else
                    {
                        self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.size.height+self.categoryView.frame.origin.y, self.tblCat.frame.size.width, height+100);
                        
                    }
                    self.carh.constant = self.tblCat.frame.size.height;
                    [self.tblCat needsUpdateConstraints];
                    
                    self.scrollViewObj.contentSize=CGSizeMake(0, self.tblCat.frame.origin.y+self.tblCat.frame.size.height+130);
                }
      [self.tblBanner reloadData];
                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/listWidgets/languageID/",appDelObj.languageId];
                NSMutableDictionary *dicPost;
                
                dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"home",@"widgetDisplayedOn", nil];
                
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
            else if([catOrBanner isEqualToString:@"Fav"])
            {
                NSString *ok=@"Ok";
                if (appDelObj.isArabic) {
                    
                    ok=@" موافق ";
                    
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else if ([catOrBanner isEqualToString:@"Add"])
            {
                [[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"] forKey:@"cartID" ];
                [[NSUserDefaults standardUserDefaults]synchronize];
                NSArray* cartAry=[[dictionary objectForKey:@"result"]objectForKey:@"items"];
                NSString *cCount=[NSString stringWithFormat:@"%lu",(unsigned long)cartAry.count];
                if ([cCount isEqualToString:@"0"]) {
                    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                else
                {
                    [[NSUserDefaults standardUserDefaults]setObject:cCount forKey:@"CART_COUNT"];
                    [[NSUserDefaults standardUserDefaults]synchronize];
                }
                if ([cCount isEqualToString:@"0"])
                {
                    self.lblCartCount.alpha=0;
                }
                else
                {
                    self.lblCartCount.alpha=1;
                    self.lblCartCount.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
                }
                if ([freeproducts isEqualToString:@"Yes"])
                {
                    if(appDelObj.isArabic==YES )
                    {
                        SubstituteViewController *listDetail=[[SubstituteViewController alloc]init];
                        listDetail.from=@"Detail";
                 
                        listDetail.imgUrl=appDelObj.homeImgURL;
                        listDetail.PRODUCTID=Product;
                        listDetail.from=@"Cart";
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
                        SubstituteViewController *listDetail=[[SubstituteViewController alloc]init];
                        listDetail.from=@"Cart";
                        listDetail.imgUrl=appDelObj.homeImgURL;
              
                          listDetail.PRODUCTID=Product;
                        [self.navigationController pushViewController:listDetail animated:YES];
                    }
                    
                }
                else
                {
                    NSString *ok=@"Ok";
                    if (appDelObj.isArabic) {
                        ok=@" موافق ";
                    }
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"  تم الاضافة الى عربة التسوق " preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
//                    CartViewController *cart=[[CartViewController alloc]init];
//                    appDelObj.frommenu=@"no";
//                    cart.fromlogin=@"yes";
//
//                    [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"FROM"];
//                    [[NSUserDefaults standardUserDefaults]synchronize];
//                    if(appDelObj.isArabic==YES )
//                    {
//                        transition = [CATransition animation];
//                        [transition setDuration:0.3];
//                        transition.type = kCATransitionPush;
//                        transition.subtype = kCATransitionFromLeft;
//                        [transition setFillMode:kCAFillModeBoth];
//                        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//                        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//                        [self.navigationController pushViewController:cart animated:NO];
//                    }
//                    else
//                    {
//                        [self.navigationController pushViewController:cart animated:NO];
//                    }
                }
                
                
                [Loading dismiss];
            }
            else
            {
                widgetAry=[[dictionary objectForKey:@"result"]objectForKey:@"widget"];
                appDelObj.homeImgURL=  listURl=[[dictionary objectForKey:@"result"]objectForKey:@"viewImageUrl"];
                
                appDelObj.currencySymbol=[[dictionary objectForKey:@"result"]objectForKey:@"currencySymbol"];
                appDelObj.widgetImgURL=[[dictionary objectForKey:@"result"]objectForKey:@"viewImageUrl"];
                
                for (int i=0; i<widgetAry.count; i++)
                {
                    if ([[[widgetAry objectAtIndex:i]valueForKey:@"widget_type"] isEqualToString:@"product"])
                    {
                        height=height+308;
                    }
                    else{
                        height=height+0;
                    }
                }
                for (int j=0;j< widgetAry.count; j++)
                {
                    if ([[[widgetAry
                           objectAtIndex:j]valueForKey:@"widget_type"]isEqualToString:@"banner"])
                    {
                        height=height+183;
                    }
                    else
                    {
                        height=height+0;
                    }
                }
                if (bannerAry.count==0)
                {
                    _tblBanner.alpha=0;
                    _page.alpha=0;
                    self.categoryView.frame=CGRectMake(0, 0, self.categoryView.frame.size.width, self.categoryView.frame.size.height);
                    if(height==0)
                    {
                        self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.size.height+self.categoryView.frame.origin.y, self.tblCat.frame.size.width, height+100);
                        
                    }
                    else
                    {
                        self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.size.height+self.categoryView.frame.origin.y, self.tblCat.frame.size.width, height+100);
                        
                    }
                    self.carh.constant = self.tblCat.frame.size.height;
                    [self.tblCat needsUpdateConstraints];
                    
                    self.scrollViewObj.contentSize=CGSizeMake(0, self.tblCat.frame.origin.y+self.tblCat.frame.size.height+130);
                }
                else
                {
                    _tblBanner.alpha=1;
                    _page.alpha=1;
 
                    self.categoryView.frame=CGRectMake(0, self.tblBanner.frame.origin.y+self.tblBanner.frame.size.height+_page.frame.size.height+5, self.categoryView.frame.size.width, self.categoryView.frame.size.height);
                    
                    if(height==0)
                    {
                        self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.size.height+self.categoryView.frame.origin.y, self.tblCat.frame.size.width, height+100);
                        
                    }
                    else
                    {self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.size.height+self.categoryView.frame.origin.y, self.tblCat.frame.size.width, height+100);
                    }
                    self.carh.constant = self.tblCat.frame.size.height;
                    [self.tblCat needsUpdateConstraints];
     
                    self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.origin.y+self.categoryView.frame.size.height+self.page.frame.size.height-10, self.tblCat.frame.size.width, height+100);

                    self.scrollViewObj.contentSize=CGSizeMake(0, self.tblCat.frame.origin.y+self.tblCat.frame.size.height+self.tblBanner.frame.origin.y);
                }
                
                
               // [self.tblBanner reloadData];
                [self.tblCat reloadData];
            }
        }
        else
        {
            if ([catOrBanner isEqualToString:@"Banner"])
            {
                if (bannerAry.count==0)
                {
                    _tblBanner.alpha=0;
                    _page.alpha=0;
                    self.categoryView.frame=CGRectMake(0, 0, self.categoryView.frame.size.width, self.categoryView.frame.size.height);
                    if(height==0)
                    {
                        self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.size.height+self.categoryView.frame.origin.y, self.tblCat.frame.size.width, height+100);
                        
                    }
                    else
                    {
                        self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.size.height+self.categoryView.frame.origin.y, self.tblCat.frame.size.width, height+100);
                        
                    }
                    self.carh.constant = self.tblCat.frame.size.height;
                    [self.tblCat needsUpdateConstraints];
                    
                    self.scrollViewObj.contentSize=CGSizeMake(0, self.tblCat.frame.origin.y+self.tblCat.frame.size.height+130);
                }
                catOrBanner=@"Category";
                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/index/listWidgets/languageID/",appDelObj.languageId];
                NSMutableDictionary *dicPost;
                
                dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"home",@"widgetDisplayedOn", nil];
                
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                
            }
            else if ([catOrBanner isEqualToString:@"Add"])
            {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:@" موافق " style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else
            {
                if (bannerAry.count!=0)
                {
                    _tblBanner.alpha=1;
                    _page.alpha=1;
                    //self.tblBanner.frame = CGRectMake(self.scrollViewObj.frame.origin.x, 0, self.view.frame.size.width, 200);
                    /*_page.frame=CGRectMake(_page.frame.origin.x, self.tblBanner.frame.origin.y+self.tblBanner.frame.size.height+5, _page.frame.size.width, _page.frame.size.height);*/
                    self.categoryView.frame=CGRectMake(0, self.tblBanner.frame.origin.y+self.tblBanner.frame.size.height+_page.frame.size.height+5, self.categoryView.frame.size.width, self.categoryView.frame.size.height);
                    
                    if(height==0)
                    {
                        self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.size.height+self.categoryView.frame.origin.y, self.tblCat.frame.size.width, height+100);
                        
                    }
                    else
                    {self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.size.height+self.categoryView.frame.origin.y, self.tblCat.frame.size.width, height+100);
                    }
                    self.carh.constant = self.tblCat.frame.size.height;
                    [self.tblCat needsUpdateConstraints];
         
                    
          
                    
                   // [self.tblBanner needsUpdateConstraints];
                    //[self.page needsUpdateConstraints];
                    self.tblCat.frame=CGRectMake(self.tblCat.frame.origin.x, self.categoryView.frame.origin.y+self.categoryView.frame.size.height+self.page.frame.size.height-10, self.tblCat.frame.size.width, height+100);
                    self.scrollViewObj.contentSize=CGSizeMake(0, self.tblCat.frame.origin.y+self.tblCat.frame.size.height+self.tblBanner.frame.origin.y);
                    [self.tblBanner reloadData];
                }
                else{
                    
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"لا تتوافر بيانات" preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@" موافق " style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                
            }
        }
    }
    [Loading dismiss];
}
-(CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (tableView==self.tblCat)
    {
        if (section==widgetAry.count-1) {
            return 100;
        }
        return 0;
    }
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (tableView==self.tblCat)
    {
        if (section==widgetAry.count-1)
        {
            UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                         CGRectMake(0, 0, tableView.frame.size.width, 100)];
            sectionHeaderView.backgroundColor = [UIColor whiteColor];
            UIImageView *imglog=[[UIImageView alloc]initWithFrame:CGRectMake((tableView.frame.size.width/2)-30, 0, 60, 50)];
            imglog.image=[UIImage imageNamed:@"place_holderar.png"];
            UIImageView *imgpy=[[UIImageView alloc]initWithFrame:CGRectMake(0, 50, self.scrollViewObj.frame.size.width, 50)];
            imgpy.image=[UIImage imageNamed:@"paymentar.png"];
            [sectionHeaderView addSubview:imglog];
            [sectionHeaderView addSubview:imgpy];
            return sectionHeaderView;
        }
        else
        {
            UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                         CGRectMake(0, 0, 0, 0)];
            return sectionHeaderView;
        }
    }
    else
    {
        UIView *sectionHeaderView = [[UIView alloc] initWithFrame:
                                     CGRectMake(0, 0, 0, 0)];
        return sectionHeaderView;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
     if ( tableView==self.tblBanner)
    {
        return 1;
    }
    return widgetAry.count;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tblCat)
    {
        if ([[[widgetAry objectAtIndex:section]valueForKey:@"widget_type"]isEqualToString:@"banner"])
        {
            return 1;
            //            NSArray *smallArr,*largeArray;
            //            NSArray *arr=[[widgetAry objectAtIndex:section]valueForKey:@"listBannerWidget"];
            //            if (arr.count!=0)
            //            {
            //                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.bannerSize contains[cd] %@",@"Small"];
            //                smallArr = [arr filteredArrayUsingPredicate:bPredicate];
            //                NSLog(@"HERE SMALL %@",smallArr);
            //                NSPredicate *bPredicate1 = [NSPredicate predicateWithFormat:@"SELF.bannerSize contains[cd] %@",@"Large"];
            //                largeArray = [arr filteredArrayUsingPredicate:bPredicate1];
            //                NSLog(@"HERE LARGE %@",largeArray);
            //                return smallArr.count/2+largeArray.count;
            //            }
            //            else
            //            {
            //                return 0;
            //            }
        }
        else  if([[[widgetAry objectAtIndex:section]valueForKey:@"widget_type"]isEqualToString:@"product"])
        {
            return 1;
        }
        else
        {return 0;}
    }
    else  if (tableView==self.tblBanner)
    {
        return bannerAry.count;
    }
    else
    {
        return lanAry.count;
    }
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblCat)
    {
        if (widgetAry.count==0)
        {
            return 0;
        }
        else if ([[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"widget_type"]isEqualToString:@"banner"])        {
            return 185;
        }
        else  if([[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"widget_type"]isEqualToString:@"product"])
        {
            return 308;
        }
        else
        {
            return 0;
        }
    }
    else  if (tableView==self.tblBanner)
    {
        return self.tblBanner.frame.size.width;
    }
    else
    {
        return 44;
    }
}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.tblBanner)
    {
        self.page.currentPage=indexPath.row;
    }
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblCat)
    {
        if (widgetAry.count!=0&&[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"widget_type"]isEqualToString:@"banner"])
        {
            WStaticTableViewCell *catCell=[tableView dequeueReusableCellWithIdentifier:@"catCell"];
            NSArray *catCellAry;
            if (catCell==nil)
            {
                catCellAry=[[NSBundle mainBundle]loadNibNamed:@"WStaticTableViewCell" owner:self options:nil];
            }
            catCell=[catCellAry objectAtIndex:0];
            catCell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            NSArray *smallArr,*largeArray;
            NSArray *arr=[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"listBannerWidget"];
            if (arr.count!=0)
            {
                NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.bannerSize contains[cd] %@",@"Small"];
                smallArr = [arr filteredArrayUsingPredicate:bPredicate];
                NSLog(@"HERE SMALL %@",smallArr);
                NSPredicate *bPredicate1 = [NSPredicate predicateWithFormat:@"SELF.bannerSize contains[cd] %@",@"Large"];
                largeArray = [arr filteredArrayUsingPredicate:bPredicate1];
                NSLog(@"HERE LARGE %@",largeArray);
                if ([[[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"listBannerWidget"]objectAtIndex:0]valueForKey:@"bannerSize"]isEqualToString:@"Large"])
                    //if (largeArray.count!=0&&indexPath.row==1)//[[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"listBannerWidget"]objectAtIndex:indexPath.row]valueForKey:@"SELF.bannerSize"]isEqualToString:@"Large"])
                {
                    catCell.imgStatic.alpha=1;
                    catCell.btnB1.alpha=0;
                    catCell.btnB2.alpha=0;
                    
                    NSString *strImgUrl=[[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"listBannerWidget"]objectAtIndex:0]valueForKey:@"bannerImage"] ;
                    NSString *urlIMG;
                    NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
                    if([s isEqualToString:@"http"])
                    {
                        urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
                    }
                    else
                    {
                        urlIMG=[NSString stringWithFormat:@"%@%@",listURl,strImgUrl];
                    }
                    [catCell.imgStatic sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                    
                    
                }
                else
                {
                    //  CGRect sizeRect = [UIScreen mainScreen].bounds;
                    NSInteger separatorHeight = 10;
                    UIView * additionalSeparator = [[UIView alloc] initWithFrame:CGRectMake(0,catCell.frame.size.height-separatorHeight+2,self.tblCat.frame.size.width,separatorHeight)];
                    additionalSeparator.backgroundColor =[UIColor whiteColor];
                    [catCell addSubview:additionalSeparator];
                    int x=0;
                    catCell.btn.tag=indexPath.section;
                    catCell.imgStatic.alpha=0;
                    
                    
                    if (x<smallArr.count)
                    {
                        //                    if (x<smallArr.count)
                        //                    {
                        catCell.btnB1.alpha=1;
                        catCell.btnB1.tag=x;
                        
                        NSString *strImgUrl=[[smallArr objectAtIndex:x]valueForKey:@"bannerImage"] ;
                        NSString *urlIMG;
                        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
                        if([s isEqualToString:@"http"])
                        {
                            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
                        }
                        else
                        {
                            urlIMG=[NSString stringWithFormat:@"%@%@",listURl,strImgUrl];
                        }
                        [catCell performSelectorInBackground:@selector(loadFirstImg:) withObject:urlIMG ];
                        //[catCell.btnB1 sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                        //[catCell.btnB1 sd_setBackgroundImageWithURL:[NSURL URLWithString:urlIMG] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                        //[catCell.btnB1 sd_setBackgroundImageWithURL:[NSURL URLWithString:urlIMG] forState:UIControlStateNormal];
                        //[catCell.btnB1 setBackgroundImage:[UIImage imageNamed:@"wish111.png"] forState:UIControlStateNormal];
                        x=x+1;
                    }
                    //                    }
                    if (x<smallArr.count)
                    {
                        catCell.btnB2.alpha=1;
                        catCell.btnB2.tag=x;
                        NSString *strImgUrl1=[[smallArr objectAtIndex:x]valueForKey:@"bannerImage"] ;
                        NSString *urlIMG1;
                        NSString *s1=[strImgUrl1 substringWithRange:NSMakeRange(0, 4)];
                        if([s1 isEqualToString:@"http"])
                        {
                            urlIMG1=[NSString stringWithFormat:@"%@",strImgUrl1];
                        }
                        else
                        {
                            urlIMG1=[NSString stringWithFormat:@"%@%@",listURl,strImgUrl1];
                            
                        }
                        [catCell.btnB2 sd_setBackgroundImageWithURL:[NSURL URLWithString:urlIMG1] forState:UIControlStateNormal placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                        
                    }
                }
            }
            else
            {
            }
            catCell.ItemDelegate=self;
            return catCell;
        }
        else if(widgetAry.count!=0&&[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"widget_type"]isEqualToString:@"product"])
        {
            WidgetTableViewCell *catCell=[tableView dequeueReusableCellWithIdentifier:@"catCell"];
            NSArray *catCellAry;
            if (catCell==nil)
            {
                catCellAry=[[NSBundle mainBundle]loadNibNamed:@"WidgetTableViewCell" owner:self options:nil];
            }
            if (appDelObj.isArabic==YES)
            {
                catCell=[catCellAry objectAtIndex:1];
            }
            else
            {
                catCell=[catCellAry objectAtIndex:0];
            }
            catCell.selectionStyle=UITableViewCellSelectionStyleNone;
            
            catCell.lblName.text=[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"widgetTitle"];
            [catCell setCollectionData:[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"listWidgetTabItems"]];
            NSString *viewMore=[[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"widgetTabs"]objectAtIndex:0]valueForKey:@"enableViewMore"];
            if ([viewMore isEqualToString:@"Yes"]||[viewMore isEqualToString:@"yes"]||[viewMore isEqualToString:@"YES"])
            {
                NSString *custom=[[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"widgetTabs"]objectAtIndex:0]valueForKey:@"viewMoreLabelType"];
                if ([custom isEqualToString:@"custom"])
                {
                    NSString *label=[[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"widgetTabs"]objectAtIndex:0]valueForKey:@"viewMoreLabel"];
                    if ([label isKindOfClass:[NSNull class]]||label.length==0)
                    {
                        catCell.btnViewAll.alpha=0;
                    }
                    else
                    {
                        [catCell.btnViewAll setTitle:[[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"widgetTabs"]objectAtIndex:0]valueForKey:@"viewMoreLabel"] forState:UIControlStateNormal];
                    }
                }
            }
            else
            {
                catCell.btnViewAll.alpha=0;
            }
            
            catCell.btnViewAll.tag=indexPath.section;
            catCell.colItem.tag=indexPath.section;
            catCell.ViewDEL=self;
            return catCell;
        }
        else
        {
            WidgetTableViewCell *catCell=[tableView dequeueReusableCellWithIdentifier:@"catCell"];
            NSArray *catCellAry;
            if (catCell==nil)
            {
                catCellAry=[[NSBundle mainBundle]loadNibNamed:@"WidgetTableViewCell" owner:self options:nil];
            }
            if (appDelObj.isArabic==YES)
            {
                catCell=[catCellAry objectAtIndex:1];
            }
            else
            {
                catCell=[catCellAry objectAtIndex:0];
            }
            catCell.selectionStyle=UITableViewCellSelectionStyleNone;
            catCell.lblName.alpha=0;
            catCell.btnViewAll.alpha=0;
            catCell.colItem.alpha=0;
            return catCell;
        }
    }
    else  if (tableView==self.tblBanner)
    {
        UITableViewCell *bannerCell=[tableView dequeueReusableCellWithIdentifier:@"bannerCell"];
        if (bannerCell==nil)
        {
            bannerCell=[[UITableViewCell alloc]init];
        }
        bannerCell.backgroundColor = [UIColor clearColor];
        /*set imageview*/

        UIImageView *bannerImage = [[UIImageView alloc] init];
        [bannerImage setBackgroundColor:[UIColor clearColor]];
        bannerImage.tag = 111222333;


        NSString *strImgUrl=[[bannerAry objectAtIndex:indexPath.row]valueForKey:@"bannerImage"] ;

        NSString *urlIMG;
        NSString *img=strImgUrl;
        if ([img isKindOfClass:[NSNull class]]||[img isEqualToString:@""]|| img.length==0||img.length<4) {
            bannerImage.image=[UIImage imageNamed:@"place_holderar.png"];
        }
        else
        {
            NSString *s=[img substringWithRange:NSMakeRange(0, 4)];

            if([s isEqualToString:@"http"])
            {



                urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
            }
            else
            {
                urlIMG=[NSString stringWithFormat:@"%@%@",bannerURl,img];
            }
           urlIMG=[urlIMG stringByReplacingOccurrencesOfString:@" " withString:@"%20"];
           // bannerImage.image = [UIImage imageWithContentsOfURL:theURL];
           [bannerImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];


        }

        // bannerImage.backgroundColor=[UIColor redColor];

        // [bannerImage setImage:[UIImage imageNamed:@"index-banner.png"]];
        bannerImage.clipsToBounds=YES;
        bannerImage.contentMode = UIViewContentModeScaleToFill;
        bannerImage.transform=CGAffineTransformMakeRotation(M_PI / 2);
        bannerImage.frame= CGRectMake(0,0,self.tblBanner.frame.size.height , self.view.frame.size.width);

        [bannerCell.contentView addSubview:bannerImage];
        /*set uilabel*/
        bannerImage.layer.cornerRadius = 7;
        bannerImage.clipsToBounds = YES;
        bannerCell.selectionStyle=UITableViewCellSelectionStyleNone;
       // bannerCell.backgroundColor=[UIColor redColor];
        return bannerCell;
//             UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"bannerCell"];
//             if (cell==nil)
//                {
//                    cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"bannerCell"];
//               }
//        //UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ReuseID" forIndexPath:indexPath];
//        cell.textLabel.text = [NSString stringWithFormat:@"Cell %li", (long)indexPath.row];
//        return cell;
    }
    else
    {
        LanguageTableViewCell *catCell=[tableView dequeueReusableCellWithIdentifier:@"catCell"];
        NSArray *catCellAry;
        if (catCell==nil)
        {
            catCellAry=[[NSBundle mainBundle]loadNibNamed:@"LanguageTableViewCell" owner:self options:nil];
        }
        if (appDelObj.isArabic==YES)
        {
            catCell=[catCellAry objectAtIndex:1];
        }
        else
        {
            catCell=[catCellAry objectAtIndex:0];
        }
        catCell.selectionStyle=UITableViewCellSelectionStyleNone;
        catCell.lblLan.text=[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"];
        if ([appDelObj.languageId isEqualToString:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageID"]])
        {
            catCell.imgSelLan.image=[UIImage imageNamed:@"lan-button-active.png"];
            
        }
        else
        {
            catCell.imgSelLan.image=[UIImage imageNamed:@"lan-button.png"];
            
        }
        NSString *strImgUrl=[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageImage"] ;
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@/%@",lanUrl,strImgUrl];
        }
        [catCell.imgLan sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        ;
        return catCell;
    }
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblBanner)
    {
        ListViewController *listObj=[[ListViewController alloc]init];
        //NSArray *linkArr;
        //NSArray *strBannerLink=[[bannerAry objectAtIndex:indexPath.row]valueForKey:@"bannerLink"];
        if (![[[bannerAry objectAtIndex:indexPath.row]valueForKey:@"bannerLink"] isKindOfClass:[NSNull class]])
        {
            NSArray *idzStr=[[bannerAry objectAtIndex:indexPath.row]valueForKey:@"bannerLink"];
            appDelObj.listTitle=[[bannerAry objectAtIndex:indexPath.row]valueForKey:@"bannerTitle"];
            
            appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
            
            listObj.keyword=[idzStr valueForKey:@"search"];
            listObj.sortType=[idzStr valueForKey:@"productPref"];
            appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
            appDelObj.mainBrand=[idzStr valueForKey:@"brand"];
            appDelObj.mainPrice=[idzStr valueForKey:@"price"];
            appDelObj.mainSearch=[idzStr valueForKey:@"search"];
            appDelObj.mainBusiness=[idzStr valueForKey:@"businessID"];
            appDelObj.mainDiscount=[idzStr valueForKey:@"discount"];
            NSString *min=[idzStr valueForKey:@"price"];
            NSArray *minValue=[min componentsSeparatedByString:@"-"];
            if (minValue.count==0)
            {
                
            }
            else
            {
                if (minValue.count==1)
                {
                    listObj.MinValue=[minValue objectAtIndex:0];
                    
                }
                else
                {
                    listObj.MinValue=[minValue objectAtIndex:0];
                    listObj.maxValue=[minValue objectAtIndex:1];
                    
                }
                
            }
            
            listObj.dis=[idzStr valueForKey:@"discount"];
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            appDelObj.frommenu=@"";
            appDelObj.CatPArID=@"";
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:listObj animated:YES];
        }
        
    }
    else if (tableView==self.tblCat)
    {
        if ([[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"widget_type"]isEqualToString:@"banner"])
        {
            
            
            appDelObj.listTitle=[[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"listBannerWidget"]objectAtIndex:0]valueForKey:@"bannerTitle"];
            
            ListViewController *listObj=[[ListViewController alloc]init];
            //NSArray *linkArr;
            //NSArray *strBannerLink=[[bannerAry objectAtIndex:indexPath.row]valueForKey:@"bannerLink"];
            
            NSArray *idzStr=[[[[widgetAry objectAtIndex:indexPath.section]valueForKey:@"listBannerWidget"]objectAtIndex:0]valueForKey:@"bannerLink"];
            
            appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
            
            listObj.keyword=[idzStr valueForKey:@"search"];
            listObj.sortType=[idzStr valueForKey:@"productPref"];
            appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
            appDelObj.mainBrand=[idzStr valueForKey:@"brand"];
            appDelObj.mainPrice=[idzStr valueForKey:@"price"];
            appDelObj.mainSearch=[idzStr valueForKey:@"search"];
            appDelObj.mainBusiness=[idzStr valueForKey:@"businessID"];
            appDelObj.mainDiscount=[idzStr valueForKey:@"discount"];
            NSString *min=[idzStr valueForKey:@"price"];
            NSArray *minValue=[min componentsSeparatedByString:@"-"];
            if (minValue.count==0)
            {
                
            }
            else
            {
                if (minValue.count==1)
                {
                    listObj.MinValue=[minValue objectAtIndex:0];
                    
                }
                else
                {
                    listObj.MinValue=[minValue objectAtIndex:0];
                    listObj.maxValue=[minValue objectAtIndex:1];
                    
                }
                
            }
            
            listObj.dis=[idzStr valueForKey:@"discount"];
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            appDelObj.frommenu=@"";
            appDelObj.CatPArID=@"";
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
            [[NSUserDefaults standardUserDefaults]synchronize];
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:listObj animated:YES];
        }
        
    }
    else
    {
        appDelObj.languageId=[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageID"];
        
        if([[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"]isEqualToString:@"Arabic"]||[[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"]isEqualToString:@"العربية"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"Arabic" forKey:@"LANGUAGE"];
            
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageID"] forKey:@"LANGUAGEID"];
            appDelObj.isArabic=YES;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SELECT_LANGUAGE"];
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"] forKey:@"SELECT_LANGUAGE_Name"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            [appDelObj arabicMenuAction];
            
        }
        else
        {
            
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageID"] forKey:@"LANGUAGEID"];
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"] forKey:@"LANGUAGE"];
            
            appDelObj.isArabic=NO;
            [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SELECT_LANGUAGE"];
            [[NSUserDefaults standardUserDefaults]setObject:[[lanAry objectAtIndex:indexPath.row]valueForKey:@"languageName"] forKey:@"SELECT_LANGUAGE_Name"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            [appDelObj englishMenuAction];
            
        }
        [self getData];
        CGRect rect = _languageView.frame;
        [UIView animateWithDuration:0.0
                         animations:^{
                             _languageView.frame = rect;
                         }
                         completion:^(BOOL finished) {
                             CGRect rect = _languageView.frame;
                             rect.origin.y = self.view.frame.size.height;
                             [UIView animateWithDuration:0.4
                                              animations:^{
                                                  _languageView.frame = rect;
                                              }
                                              completion:^(BOOL finished) {
                                                  [_languageView removeFromSuperview];
                                                  [UIView animateWithDuration:0.2
                                                                   animations:^{
                                                                       _languageView.alpha = 0;
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       
                                                                       [_languageView removeFromSuperview];
                                                                   }];
                                              }];
                         }];
    }
}
-(void)viewlistDelMethod:(NSString *)tagBtn second:(NSString *)tagBtnmain
{
    int x=[tagBtn intValue];
    int x1=[tagBtnmain intValue];
    
    NSArray *smallArr;
    NSArray *arr=[[widgetAry objectAtIndex:x1]valueForKey:@"listBannerWidget"];
    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.bannerSize contains[cd] %@",@"Small"];
    smallArr = [arr filteredArrayUsingPredicate:bPredicate];
    NSLog(@"HERE SMALL %@",smallArr);
    NSArray *idzStr=[[smallArr objectAtIndex:x]valueForKey:@"bannerLink"];
    
    ListViewController *listObj=[[ListViewController alloc]init];
    appDelObj.listTitle=[[smallArr objectAtIndex:x]valueForKey:@"bannerTitle"];
    
    appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
    
    listObj.keyword=[idzStr valueForKey:@"search"];
    listObj.sortType=[idzStr valueForKey:@"productPref"];
    appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
    appDelObj.mainBrand=[idzStr valueForKey:@"brand"];
    appDelObj.mainPrice=[idzStr valueForKey:@"price"];
    appDelObj.mainSearch=[idzStr valueForKey:@"search"];
    appDelObj.mainBusiness=[idzStr valueForKey:@"businessID"];
    appDelObj.mainDiscount=[idzStr valueForKey:@"discount"];
    NSString *min=[idzStr valueForKey:@"price"];
    NSArray *minValue=[min componentsSeparatedByString:@"-"];
    if (minValue.count==0)
    {
        
    }
    else
    {
        if (minValue.count==1)
        {
            listObj.MinValue=[minValue objectAtIndex:0];
            
        }
        else
        {
            listObj.MinValue=[minValue objectAtIndex:0];
            listObj.maxValue=[minValue objectAtIndex:1];
            
        }
        
    }
    
    listObj.dis=[idzStr valueForKey:@"discount"];
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    appDelObj.frommenu=@"";
    appDelObj.CatPArID=@"";
    transition = [CATransition animation];
    [transition setDuration:0.3];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:listObj animated:YES];
}
-(void)viewAllActionDel:(int)tag
{
    ListViewController *listObj=[[ListViewController alloc]init];
    //appDelObj.CatID=[[widgetAry objectAtIndex:tag]valueForKey:@"categoryID"];
    appDelObj.frommenu=@"";
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
   // listObj.catIDFromHome=[[widgetAry objectAtIndex:tag]valueForKey:@"categoryID"];
    listObj.titleString=[[widgetAry objectAtIndex:tag]valueForKey:@"widgetTitle"];
    appDelObj.listTitle=[[widgetAry objectAtIndex:tag]valueForKey:@"widgetTitle"];
    if (![[[[[widgetAry objectAtIndex:tag]valueForKey:@"widgetTabs"]objectAtIndex:0]valueForKey:@"viewMoreLink"] isKindOfClass:[NSNull class]])
    {
        NSArray *idzStr=[[[[widgetAry objectAtIndex:tag]valueForKey:@"widgetTabs"]objectAtIndex:0]valueForKey:@"viewMoreLink"];
        //appDelObj.listTitle=[[widgetAry objectAtIndex:tag]valueForKey:@"bannerTitle"];
        
        appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
        
        listObj.keyword=[idzStr valueForKey:@"search"];
        listObj.sortType=[idzStr valueForKey:@"productPref"];
        appDelObj.CatID=[idzStr valueForKey:@"dealCatID"];
        appDelObj.mainBrand=[idzStr valueForKey:@"brand"];
        appDelObj.mainPrice=[idzStr valueForKey:@"price"];
        appDelObj.mainSearch=[idzStr valueForKey:@"search"];
        appDelObj.mainBusiness=[idzStr valueForKey:@"businessID"];
        appDelObj.mainDiscount=[idzStr valueForKey:@"discount"];
        NSString *min=[idzStr valueForKey:@"price"];
        NSArray *minValue=[min componentsSeparatedByString:@"-"];
        if (minValue.count==0)
        {
            
        }
        else
        {
            if (minValue.count==1)
            {
                listObj.MinValue=[minValue objectAtIndex:0];
                
            }
            else
            {
                listObj.MinValue=[minValue objectAtIndex:0];
                listObj.maxValue=[minValue objectAtIndex:1];
                
            }
            
        }
        
        listObj.dis=[idzStr valueForKey:@"discount"];
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        appDelObj.frommenu=@"";
        appDelObj.CatPArID=@"";
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:listObj animated:YES];
    }
    
}
-(void)productDetailDel:(NSString *)pid
{
    ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
    listDetail.productID=pid ;
    transition = [CATransition animation];
    [transition setDuration:0.3];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:listDetail animated:YES];
}
-(void)productDetailBundleDelegate:(NSString *)pid
{
    bundleDetailViewController *listDetail=[[bundleDetailViewController alloc]init];
    listDetail.bundleKey=pid ;
    [self.navigationController pushViewController:listDetail animated:YES];
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

- (IBAction)menuAction:(id)sender
{
    appDelObj.menuTag=1;
    ArabicMenuViewController *ar=[[ArabicMenuViewController alloc]init];
    [ar.view setNeedsDisplay];
    [self performSelector:@selector(presentRightMenuViewController:) withObject:nil];
    
}
- (IBAction)backAction:(id)sender
{
    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    if (cartCount.length==0)
    {
        CartViewController *cart=[[CartViewController alloc]init];
        cart.fromlogin=@"yes";
        appDelObj.frommenu=@"";
        cart.emptyCart=@"Yes";
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:cart animated:NO];
    }
    else
    {
        
        CartViewController *cart=[[CartViewController alloc]init];
        appDelObj.frommenu=@"";
        cart.fromlogin=@"yes";

        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:cart animated:NO];
    }
}
-(void)FavouriteAddAction:(NSString *)pid second:(NSString*)sender
{
    LoginViewController *login=[[LoginViewController alloc]init];
    ArabicLoginViewController *loginAra=[[ArabicLoginViewController alloc]init];
    loginAra.fromWhere=@"Favourite";
    login.productID=pid;
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        if(appDelObj.isArabic==YES )
        {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:loginAra animated:NO];
        }
        else
        {
            [self.navigationController pushViewController:login animated:YES];
        }
    }
    else
    {
        UIButton *btn=(UIButton *)sender;
        
        UIImage *imageToCheckFor = [UIImage imageNamed:@"wish2.png"];
        
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:imageToCheckFor forState:UIControlStateNormal];
        if ([sender isEqualToString:@"Remove"])
        {
            if(appDelObj.isArabic==YES )
            {
                WishLlstViewController *listDetail=[[WishLlstViewController alloc]init];
                listDetail.fromMenu=@"yes";
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
                
                WishLlstViewController *listDetail=[[WishLlstViewController alloc]init];
                listDetail.fromMenu=@"yes";
                [self.navigationController pushViewController:listDetail animated:YES];
            }
        }
        else
        {
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            catOrBanner=@"Fav";
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/ajaxWishList/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",pid,@"productID", nil];
            
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        
        // }
        
        
        
    }
}
- (IBAction)uploadPrescriptionAction:(id)sender {
    appDelObj.fromListPrescription=@"";
    appDelObj.frommenu=@"";
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    LoginViewController *login=[[LoginViewController alloc]init];
    ArabicLoginViewController *loginAra=[[ArabicLoginViewController alloc]init];
    loginAra.fromWhere=@"Prescription";
    loginAra.fromWhere=@"Prescription";
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        if(appDelObj.isArabic==YES )
            
        {
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:loginAra animated:NO];
            
        }
        else
        {
            //            [self.navigationController pushViewController:login animated:YES];
            //
            CATransition *transition = [CATransition animation];
            transition.duration = 0.3;
            transition.type = kCATransitionFade;
            //transition.subtype = kCATransitionFromTop;
            
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:login animated:NO];
            
        }
        
    }
    
    
    else
    {
        UploadPrescription *listObj=[[UploadPrescription alloc]init];
        appDelObj.frommenu=@"";
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:listObj animated:YES];
    }
    
}

- (IBAction)viewMoreCatAction:(id)sender
{
    AllCategoryView *all=[[AllCategoryView alloc]init];
    
    [self.navigationController pushViewController:all animated:YES];
}

- (IBAction)catAction:(id)sender {
    //    appDelObj.frommenu=@"";
    //    UIButton *btn=(UIButton*)sender;
    //    if (btn.tag==1)
    //    {
    //        appDelObj.listTitle=@"Prescription";
    //        appDelObj.CatID=@"4";
    //
    //        self.i1.alpha=1;
    //        self.i2.alpha=0;
    //        self.i3.alpha=0;
    //        self.i4.alpha=0;
    //        self.i5.alpha=0;
    //        self.i6.alpha=0;
    //    }
    //    else if (btn.tag==2)
    //    {
    //        appDelObj.listTitle=@"OTC";
    //        appDelObj.CatID=@"5";
    //
    //        self.i1.alpha=0;
    //        self.i2.alpha=1;
    //        self.i3.alpha=0;
    //        self.i4.alpha=0;
    //        self.i5.alpha=0;
    //        self.i6.alpha=0;
    //    }
    //    else if (btn.tag==3)
    //    {
    //        appDelObj.listTitle=@"Baby & Mother";
    //        appDelObj.CatID=@"6";
    //
    //        self.i1.alpha=0;
    //        self.i2.alpha=0;
    //        self.i3.alpha=1;
    //        self.i4.alpha=0;
    //        self.i5.alpha=0;
    //        self.i6.alpha=0;
    //    }
    //    else if (btn.tag==4)
    //    {
    //        appDelObj.listTitle=@"Diabetes";
    //        appDelObj.CatID=@"3";
    //
    //        self.i1.alpha=0;
    //        self.i2.alpha=0;
    //        self.i3.alpha=0;
    //        self.i4.alpha=1;
    //        self.i5.alpha=0;
    //        self.i6.alpha=0;
    //    }
    //    else if (btn.tag==5)
    //    {
    //        appDelObj.listTitle=@"Personal Care";
    //        appDelObj.CatID=@"7";
    //
    //        self.i1.alpha=0;
    //        self.i2.alpha=0;
    //        self.i3.alpha=0;
    //        self.i4.alpha=0;
    //        self.i5.alpha=1;
    //        self.i6.alpha=0;
    //    }
    //    else if (btn.tag==6)
    //    {
    //        appDelObj.listTitle=@"Health Aid";
    //        appDelObj.CatID=@"1";
    //
    //        self.i1.alpha=0;
    //        self.i2.alpha=0;
    //        self.i3.alpha=0;
    //        self.i4.alpha=0;
    //        self.i5.alpha=0;
    //        self.i6.alpha=1;
    //    }
    //    ListViewController *listObj=[[ListViewController alloc]init];
    //
    //   // [self.navigationController pushViewController:listObj animated:YES];
}

- (IBAction)wishlistAction:(id)sender {
    //    WishLlstViewController *order=[[WishLlstViewController alloc]init];
    //    order.fromMenu=@"yes";
    //
    //        [self.navigationController pushViewController:order animated:YES];
    appDelObj.frommenu=@"";
    ArabicLoginViewController *loginAra=[[ArabicLoginViewController alloc]init];
    loginAra.fromWhere=@"Wish";
    appDelObj.fromWhere=@"Wish";
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
       
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:loginAra animated:NO];
        
    }
    else
    {
       
            WishLlstViewController *listDetail=[[WishLlstViewController alloc]init];
            listDetail.fromMenu=@"";
            transition = [CATransition animation];
            [transition setDuration:0.3];
            transition.type = kCATransitionPush;
            transition.subtype = kCATransitionFromLeft;
            [transition setFillMode:kCAFillModeBoth];
            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
            [self.navigationController pushViewController:listDetail animated:NO];
      
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width/2)-10, 233);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return searchArray.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell *cell = (ItemCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSString *strImgUrl=[[searchArray objectAtIndex:indexPath.row ] valueForKey:@"productImage"] ;
    if(strImgUrl.length!=0)
    {
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",searchUrl,strImgUrl];
        }
        [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        
    }
    else{
        cell.itemImg.image=[UIImage imageNamed:@"place_holderar.png"];
    }
    if(appDelObj.isArabic)
    {
        /*cell.itemName.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemPrice.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffer.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemImg.transform = CGAffineTransformMakeScale(-1, 1);
        cell.btnAdd.transform = CGAffineTransformMakeScale(-1, 1);*/
        [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        //cell.itemName.textAlignment=NSTextAlignmentRight;
        //cell.lblHot.transform = CGAffineTransformMakeScale(-1, 1);
       // cell.lblOffLabel.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblHot.text=@"مميز";
    }
    NSString *hotStr=[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"featuredStatus"];
    if ([hotStr isEqualToString:@"Yes"]||[hotStr isEqualToString:@"YES"]||[hotStr isEqualToString:@"yes"]) {
        cell.lblHot.alpha=1;
    }
    cell.btnAdd.alpha=0;
    cell.btnAdd.tag=indexPath.row;
    NSString *sname=[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"];
    NSString *strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    cell.itemName.text= strname;
    float x=0;
    float x1=0;
    if ([[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"productOptionRegularPrice"] isKindOfClass:[NSNull class]]||[[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"productOptionRegularPrice"] isEqualToString:@"<null>"]) {
        x=0;
        
    }
    else
    {
        x=[[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"productOptionRegularPrice"] floatValue];

    }
    if ([[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"offerPrice"] isKindOfClass:[NSNull class]]||[[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"offerPrice"] isEqualToString:@"<null>"]) {
        x1=0;
        
    }
    else
    {
        x1=[[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"offerPrice"] floatValue];

    }
    NSString *s1=[NSString stringWithFormat:@"%.02f",x] ;
    NSString *s2=[NSString stringWithFormat:@"%.02f",x1 ];
    NSString *offerStr=[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"];
    NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
    if ([[offArr objectAtIndex:0]isEqualToString:@"0"]) {
        cell.lblOffer.alpha=0;
        cell.offview.alpha=0;
    }
    else{
        cell.lblOffer.text=[NSString stringWithFormat:@"%@%@ Off",[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"],@"%"];
    }
    NSString *freeStr=[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"freeProductsExists"];
    if ([freeStr isEqualToString:@"Yes"]||[freeStr isEqualToString:@"YES"]||[freeStr isEqualToString:@"yes"])
    {
        cell.imgfree.alpha=1;
    }
    else
    {
        cell.imgfree.alpha=0;
    }
    if (s1.length!=0&&s2.length!=0)
    {
        NSString *p1=s1;
        NSString *p2=s2;
        NSMutableAttributedString *str;
        //        if (appDelObj.isArabic) {
        str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",p1,appDelObj.currencySymbol]];
        
        if ([s1 isEqualToString:s2])
        {
            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                initWithAttributedString:str];
            [string addAttribute:NSForegroundColorAttributeName
                           value:appDelObj.priceColor
                           range:NSMakeRange(0, [string length])];
            
            [string addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                           range:NSMakeRange(0, [string length])];
            if (appDelObj.isArabic) {
                [string addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                               range:NSMakeRange(0, [string length])];
            }
            cell.itemPrice.attributedText=string;
        }
        else
        {
        NSString *p1=s1;
        NSString *p2=s2;
        NSMutableAttributedString *str;
//        if (appDelObj.isArabic) {
            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@",p1,appDelObj.currencySymbol]];
            
        
        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                            initWithAttributedString:str];
        [string addAttribute:NSForegroundColorAttributeName
                       value:appDelObj.priceColor
                       range:NSMakeRange(0, [string length])];
        
        [string addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                       range:NSMakeRange(0, [string length])];
        if (appDelObj.isArabic) {
            [string addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [string length])];
        }
        [string addAttribute:NSStrikethroughStyleAttributeName
                       value:@2
                       range:NSMakeRange(0, [string length])];
        NSMutableAttributedString *price;
        
price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@%@  ",p2,appDelObj.currencySymbol]];
        
        [price addAttribute:NSForegroundColorAttributeName
                      value:[UIColor blackColor]
                      range:NSMakeRange(0, [price length])];
        [price addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                      range:NSMakeRange(0, [price length])];
        if (appDelObj.isArabic) {
            [price addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [price length])];
        }
        //NSMutableAttributedString *priceold=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",string]];
        [price appendAttributedString:string];
        cell.itemPrice.attributedText=price;
        }
    }
    else
    {
        cell.itemPrice.text=@"";
    }
    if (appDelObj.isArabic) {
        [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnAdd setTitle:@"Add To Cart" forState:UIControlStateNormal];
    }
    return cell;
}
-(void)productaddCart:(NSArray *)array second:(NSString *)colID
{
    freeproducts=[array valueForKey:@"freeProductsExists"];
    Product=[array valueForKey:@"itemID"];

    fullAray=array;
    catOrBanner=@"Add";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (User.length==0)
    {
        User=@"";
    }
    NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
    if (CAID.length==0||[CAID isEqualToString:@""])
    {
        CAID=@"";
    }
    NSString* urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
    NSMutableDictionary*   dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",[array valueForKey:@"itemID"],@"productID",[array valueForKey:@"productOptionID"],@"productOptionID",[array valueForKey:@"productMinBuyLimit"],@"quantity",[array valueForKey:@"itemName"],@"productOptionName",[array valueForKey:@"itemName"],@"productTitle",[array valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",CAID,@"cartID",[array valueForKey:@"itemIcon"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",@"",@"strcombinationValues",@"",@"subAttr",@"onetime",@"purchase",@"",@"customOptionValues",@"No",@"freeProduct",@"",@"freeBaseProductID",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
    listDetail.productID=[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
    listDetail.productName=[[searchArray objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
    transition = [CATransition animation];
    [transition setDuration:0.3];
    transition.type = kCATransitionPush;
    transition.subtype = kCATransitionFromLeft;
    [transition setFillMode:kCAFillModeBoth];
    [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
    [self.navigationController pushViewController:listDetail animated:YES];
}

-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    
    strMsg=@"يرجى المحاولة بعد مرور بعض الوقت";
    okMsg=@" موافق ";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
@end
