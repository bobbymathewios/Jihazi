//
//  ListViewController.m
//  Favol
//
//  Created by Remya Das on 10/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "ListViewController.h"

@interface ListViewController ()<UITableViewDelegate,UITableViewDataSource,itemQuantityDelegate,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,NSURLSessionDelegate,passDataAfterParsing,UIActionSheetDelegate,itemQuantityDelegate,UITextFieldDelegate,FavHomeDelegate>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    NSArray *listAry,*listImgAry,*filterAry,*filterCatAry,*disAry,*priceAry,*disKeyArray,*brandAry,*tempBrand,*freeproducts;
    NSMutableArray *ListAryData,*brandsIDArray,*BrandAllAry;
    WebService *webServiceObj;
    NSString *filter,*catValue,*BrandValue,*brandSearchStr,*URL,*catName,*brand;;
    int page,filtercatSelect,catSel,brandSel,OfferSel,filerList,catRow,offerRow,loadmore,clear;;
    NSMutableIndexSet *brandSelect;
}

@end

@implementation ListViewController
@synthesize MinValue,maxValue,discount;
- (void)viewDidLoad {
    [super viewDidLoad];
    page=clear=0;
     filter=@"";
    filter=@"";
    loadmore=0;
    self.imm.alpha=0;
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [appDelObj.filterBrandID removeAllObjects];
    //self.view.backgroundColor=appDelObj.priceColor;
    self.topViewObj.backgroundColor=appDelObj.headderColor;
    ListAryData=BrandAllAry=brandsIDArray=[[NSMutableArray alloc]init];
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    [_colListView registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    self.lblCountValue.clipsToBounds=YES;
    self.lblCountValue.layer.cornerRadius=self.lblCountValue.frame.size.height/2;
    self.lblCountValue.backgroundColor=appDelObj.cartBg;
    self.lblCountValue.textColor=appDelObj.headderColor;
    [[self.lblCountValue layer] setBorderWidth:1.0f];
    [[self.lblCountValue layer] setBorderColor:[appDelObj.headderColor CGColor]];
    self.txtSearch.clipsToBounds=YES;
    self.txtSearch.layer.borderWidth=1;
    self.txtSearch.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    //self.imm.backgroundColor=[UIColor colorWithRed:0.914 green:0.914 blue:0.914 alpha:1.00];
    self.lblTitle.text=appDelObj.listTitle;
    filtercatSelect=-1;
    catSel=brandSel=OfferSel=filerList=0;
    catRow=offerRow=-1;
    brandSelect=[[NSMutableIndexSet alloc]init];
    self.lblTitle.textColor=appDelObj.textColor;
    [ListAryData removeAllObjects];
    NSLog(@"Page is    ****%@",[NSString stringWithFormat:@"%d",page]);
   
        if ([appDelObj.dealBundle isEqualToString:@"Yes"])
        {
            if (appDelObj.isArabic) {
                self.lblTitle.text=@"العروض";
            }
            else
            {
                self.lblTitle.text=@"Deals of the day";
            }
        }
    if ([appDelObj.mainBusiness isKindOfClass:[NSNull class]]||appDelObj.mainBusiness.length==0) {
        self.businessID=@"";
    }
    else
    {
        self.businessID=appDelObj.mainBusiness;
    }
    
    if (self.businessID.length==0) {
        self.merchantView.alpha=0;
       // self.colHeight.constant=self.colListView.frame.size.height+66;
        self.colListView.frame=CGRectMake(0, self.colListView.frame.origin.y-self.merh.constant, self.colListView.frame.size.width, self.colListView.frame.size.height+self.merchantView.frame.size.height);
       
    }
    else
    {
        if ([self.isFollowMerchant isEqualToString:@"Yes"]) {
            self.btnaddMerchant.alpha=1;
        } else {
             self.btnaddMerchant.alpha=0;
        }
        self.lblTitle.text=self.businessName;
        if ([self.favOrNotMer isEqualToString:@"1"]) {
            [self.btnaddMerchant setBackgroundImage:[UIImage imageNamed:@"fav-store-active.png"] forState:UIControlStateNormal];
        }
        else
        {
            [self.btnaddMerchant setBackgroundImage:[UIImage imageNamed:@"fav-store.png"] forState:UIControlStateNormal];

        }
         self.merchantView.alpha=1;
        self.lblMerchantName.text=self.businessName;
  // self.colListView.frame=CGRectMake(0, self.lblMerchantName.frame.origin.y+self.lblMerchantName.frame.size.height+5, self.colListView.frame.size.width, self.colListView.frame.size.height);
    }

    [self.merchantView needsUpdateConstraints];
    //[self.colListView needsUpdateConstraints];
    NSString *rate=[NSString stringWithFormat:@"%@",self.Brate];
    NSArray *a=[rate componentsSeparatedByString:@"."];
    NSString *r=[a objectAtIndex:0];
    if ([r  isEqualToString:@"0"])
    {
        self.imgrate1.alpha=0;
        self.imgrate2.alpha=0;
        self.imgrate3.alpha=0;
        self.imgrate4.alpha=0;
        self.imgrate5.alpha=0;
        self.lblBrate.alpha=0;

        self.imgrate1.image=[UIImage imageNamed:@"star-3.png"];
        self.imgrate2.image=[UIImage imageNamed:@"star-3.png"];
        self.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
        self.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
        self.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
        
    }
    else if ([r  isEqualToString:@"1"])
    {
        self.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate2.image=[UIImage imageNamed:@"star-3.png"];
        self.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
        self.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
        self.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
        
    }
    else if ([r  isEqualToString:@"2"])
    {
        self.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
        self.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
        self.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
        
    }
    else if ([r isEqualToString:@"3"])
    {
        self.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
        self.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
    }
    else if ([r isEqualToString:@"4"])
    {
        self.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate4.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
    }
    else if ([r isEqualToString:@"5"])
    {
        self.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate4.image=[UIImage imageNamed:@"star-1.png"];
        self.imgrate5.image=[UIImage imageNamed:@"star-1.png"];
    }
    self.merchantView.clipsToBounds=YES;
    self.merchantView.layer.borderWidth=1;
    self.merchantView.layer.borderColor=[[UIColor colorWithRed:0.886 green:0.886 blue:0.886 alpha:1.00]CGColor];
    if ([appDelObj.mainDiscount isKindOfClass:[NSNull class]]||appDelObj.mainDiscount.length==0) {
        discount=@"";
    }
    else
    {
        discount=appDelObj.mainDiscount;
    }
   
    if ([appDelObj.mainBrand isKindOfClass:[NSNull class]]||appDelObj.mainBrand.length==0) {
        brand=@"";
    }
    else
    {
        brand=appDelObj.mainBrand;
    }
    if ([appDelObj.mainSearch isKindOfClass:[NSNull class]]||appDelObj.mainSearch.length==0) {
        if (self.keyword.length!=0) {
            appDelObj.mainSearch=self.keyword;
        }
        else
        {
        self.keyword=@"";
        }
    }
    else
    {
        self.keyword=appDelObj.mainSearch;
    }
//    if (appDelObj.mainPrice.length==0) {
//        //p=@"";
//    }
//    else
//    {
//        brand=appDelObj.mainBrand;
//    }
    if (appDelObj.CatID.length==0) {
        appDelObj.CatID=@"";
    }
    else
    {
//        brand=appDelObj.mainBrand;
    }
    [self getDataFromService];
}
-(void)viewWillAppear:(BOOL)animated
{
    [[NSUserDefaults standardUserDefaults]setObject:@"List" forKey:@"Where"];
    [[NSUserDefaults standardUserDefaults]synchronize];

    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    if (cartCount.length==0)
    {
        self.lblCountValue.alpha=0;
        
    }
    else
    {
        self.lblCountValue.alpha=1;
        self.lblCountValue.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
        
    }
    if (appDelObj.isArabic==YES)
    {

        self.view.transform = CGAffineTransformMakeScale(-1, 1);
     
        self.lblFilter.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblBrate.transform=CGAffineTransformMakeScale(-1, 1);
       self.filterPriceView.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblFtitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblSort.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblnotApply.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblCatTitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblBrandTitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblDiscountTitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblPrice.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnFilCategory.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnFilBrand.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnFilDisCount.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnFilterprice.transform=CGAffineTransformMakeScale(-1, 1);
        //self.btnFclear.transform=CGAffineTransformMakeScale(-1, 1);
        //self.btnfApply.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblSortBy.transform=CGAffineTransformMakeScale(-1, 1);
        self.lbl1.transform=CGAffineTransformMakeScale(-1, 1);
        self.lbl2.transform=CGAffineTransformMakeScale(-1, 1);
        self.lbl3.transform=CGAffineTransformMakeScale(-1, 1);
        self.lbl4.transform=CGAffineTransformMakeScale(-1, 1);
        self.btnSortCancel.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblTitle.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblnewList.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblPriceFilter.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblCountValue.transform=CGAffineTransformMakeScale(-1, 1);
self.lblMerchantName.transform=CGAffineTransformMakeScale(-1, 1);
        self.lblSort.text=@"ترتيب حسب";
        self.lblFilter.text=self.lblFtitle.text=@"تصفية";
        self.lblnotApply.text=@"غير مطبق";
        self.lblCatTitle.text=@"الفئة";
        self.lblBrandTitle.text=@"علامات تجارية";
        self.lblDiscountTitle.text=@"الخصم";
        self.lblPrice.text=@"السعر";
        self.lblSortBy.text=@"ترتيب حسب";
        self.lbl1.text=@"الأكثر مبيعا ";
        self.lbl2.text=@"السعر - من الأعلى إلى الأقل";
        self.lbl3.text=@"السعر - من الأقل إلى الأعلى";
        self.lbl4.text=@"مصنف حديثآ";
        self.lblnewList.text=@"مصنف حديثآ";
        //self.lblMerchantName.textAlignment=NSTextAlignmentRight;
        self.lblBrate.textAlignment=NSTextAlignmentRight;

        self.lblCatTitle.textAlignment=NSTextAlignmentRight;
        self.lblBrandTitle.textAlignment=NSTextAlignmentRight;
        self.lblDiscountTitle.textAlignment=NSTextAlignmentRight;
        self.lblPrice.textAlignment=NSTextAlignmentRight;
        self.lblSortBy.textAlignment=NSTextAlignmentRight;
        self.lbl1.textAlignment=NSTextAlignmentRight;
        self.lbl2.textAlignment=NSTextAlignmentRight;
        self.lbl3.textAlignment=NSTextAlignmentRight;
        self.lbl4.textAlignment=NSTextAlignmentRight;
        self.lblnotApply.textAlignment=NSTextAlignmentRight;
        self.lblSort.textAlignment=NSTextAlignmentRight;
        self.lblnewList.textAlignment=NSTextAlignmentRight;
        self.lblPriceFilter.textAlignment=NSTextAlignmentRight;
        self.lblFilter.textAlignment=NSTextAlignmentRight;

        [self.btnFilCategory setTitle:@"جميع الفئات" forState:UIControlStateNormal];
        [self.btnFilBrand setTitle:@"علامات تجارية" forState:UIControlStateNormal];
        [self.btnFilDisCount setTitle:@"الخصم" forState:UIControlStateNormal];
        [self.btnFilterprice setTitle:@"السعر" forState:UIControlStateNormal];
        [self.btnFclear setTitle:@"مسح" forState:UIControlStateNormal];
        [self.btnfApply setTitle:@"تحقق" forState:UIControlStateNormal];
        [self.btnSortCancel setTitle:@"الغاء" forState:UIControlStateNormal];
        self.btnFilBrand.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.btnFilDisCount.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        self.btnFilterprice.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);

        //self.txtLast.textAlignment=NSTextAlignmentRight;
       // self.txtname.textAlignment=NSTextAlignmentRight;

    }
    else
    {
    }
    self.lblBrate.text=[NSString stringWithFormat:@"(%@)",self.review];
    self.btnFclear.layer.borderWidth=1;
    self.btnFclear.layer.borderColor=[[UIColor colorWithRed:0.922 green:0.898 blue:0.918 alpha:1.00]CGColor];
    
}
-(void)getDataFromService
{
    filter=@"";
    filerList=0;
   // [ListAryData removeAllObjects];
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
     NSString *pa=[NSString stringWithFormat:@"%d",page];
    if (self.sortType.length==0)
    {
        self.sortType=@"";
    }
    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    
    NSString * useriD;
    if (cartCount.length==0)
    {
        useriD=@"";
    }
    else
    {
        useriD=cartCount;
        
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Deal/productsList/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost;
    NSString *BID;
    if (self.businessID.length==0) {
        BID=@"";
    }
    else
    {
        BID=self.businessID;
    }
    NSString *deal;
    if (appDelObj.dealBundle.length==0) {
        deal=@"";
    }
    else
    {
        deal=appDelObj.dealBundle;
    }
        if (self.keyword.length==0)
        {
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:pa,@"page",appDelObj.CatID,@"categoryID",useriD,@"userID",appDelObj.CatPArID,@"parentCategoryID",@"",@"keyword",self.sortType,@"sortBy",@"",@"priceRangeMin",@"",@"priceRangeMax",discount,@"discountRange",@"",@"attrData",brand,@"brandID",brand,@"brandIDs",BID,@"businessID",deal,@"deals", nil];
        }
        else
        {
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:pa,@"page",appDelObj.CatID,@"categoryID",useriD,@"userID",appDelObj.CatPArID,@"parentCategoryID",self.keyword,@"keyword",self.sortType,@"sortBy",@"",@"priceRangeMin",@"",@"priceRangeMax",discount,@"discountRange",@"",@"attrData",brand,@"brandID",brand,@"brandIDs",BID,@"businessID",deal,@"deals", nil];
        }
    //}
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    if (appDelObj.isArabic) {
        strMsg=@"يرجى المحاولة بعد مرور بعض الوقت";
        okMsg=@" موافق ";
        
    }
    else
    {
    strMsg=@"Network busy! please try again or after sometime.";
    okMsg=@"Ok";
    }
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
                                {
                                    [self menuAction:nil];
                                }]];
    [self presentViewController:alertController animated:YES completion:nil];
    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
       self.navigationController.navigationBarHidden=YES;
    NSString *ok=@"Ok";
    if (appDelObj.isArabic) {
        ok=@" موافق ";
    }
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        if ([filter isEqualToString:@"favMer"])
        {
            if ([self.btnaddMerchant.currentBackgroundImage isEqual: [UIImage imageNamed:@"fav-store.png"]])
            {
                NSLog(@"is the same image");
                     [self.btnaddMerchant setBackgroundImage:[UIImage imageNamed:@"fav-store-active.png"] forState:UIControlStateNormal];
                  self.favOrNotMer=@"1";
            }else{
                NSLog(@"is not the same image");
                [self.btnaddMerchant setBackgroundImage:[UIImage imageNamed:@"fav-store.png"] forState:UIControlStateNormal];
  self.favOrNotMer=@"0";
            }
//            if ([self.favOrNotMer isEqualToString:@"1"]) {
//                  self.favOrNotMer=@"0";
//                [self.btnaddMerchant setBackgroundImage:[UIImage imageNamed:@"fav-store.png"] forState:UIControlStateNormal];
//            }
//            else
//            {
//                 self.favOrNotMer=@"1";
//                [self.btnaddMerchant setBackgroundImage:[UIImage imageNamed:@"fav-store-active.png"] forState:UIControlStateNormal];
//
//            }
            
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else if ([filter isEqualToString:@"filter"])
        {
            BrandAllAry=[[NSMutableArray alloc]init];
            filterCatAry=[[dictionary objectForKey:@"result"] objectForKey:@"Categories"];
            brandAry=[[dictionary objectForKey:@"result"] objectForKey:@"brands"];
            tempBrand=[[dictionary objectForKey:@"result"] objectForKey:@"brands"];

            BrandAllAry=[[dictionary objectForKey:@"result"] objectForKey:@"brands"];

            disAry=[[dictionary objectForKey:@"result"] objectForKey:@"listDiscount"];
            disKeyArray=[[[dictionary objectForKey:@"result"] objectForKey:@"listDiscount"]allKeys];
            priceAry=[[dictionary objectForKey:@"result"] objectForKey:@"priceRanges"];
//            self.labelSlider.minimumValue = [[priceAry valueForKey:@"MINIMUM"]integerValue];
//            self.labelSlider.maximumValue = [[priceAry valueForKey:@"MAXIMUM"]integerValue];
//            self.labelSlider.lowerValue =[[priceAry valueForKey:@"MINIMUM"]integerValue];
//            self.labelSlider.upperValue = [[priceAry valueForKey:@"MAXIMUM"]integerValue];
            if ([[priceAry valueForKey:@"MINIMUM"]integerValue]== [[priceAry valueForKey:@"MAXIMUM"]integerValue])
            {
                self.labelSlider.minimumValue = 0;
                self.labelSlider.maximumValue = [[priceAry valueForKey:@"MAXIMUM"]integerValue];
                self.labelSlider.lowerValue = 0;
                self.labelSlider.upperValue = [[priceAry valueForKey:@"MAXIMUM"]integerValue];
            }
            else
            {
                self.labelSlider.minimumValue = [[priceAry valueForKey:@"MINIMUM"]integerValue];
                self.labelSlider.maximumValue = [[priceAry valueForKey:@"MAXIMUM"]integerValue];
                self.labelSlider.lowerValue =0;
                self.labelSlider.upperValue = [[priceAry valueForKey:@"MAXIMUM"]integerValue];
            }
            
            // [self.labelSlider setContinuous:NO];
//            if (appDelObj.isArabic) {
                self.lblPriceFilter.text = [NSString stringWithFormat:@" %d %@ - %d %@ ", (int)self.labelSlider.minimumValue,appDelObj.currencySymbol,(int)self.labelSlider.maximumValue,appDelObj.currencySymbol];

//            }
//            else
//            {
//                self.lblPriceFilter.text = [NSString stringWithFormat:@" %@ %d-%@ %d",appDelObj.currencySymbol, (int)self.labelSlider.minimumValue,appDelObj.currencySymbol,(int)self.labelSlider.maximumValue];
//
//            }
            self.labelSlider.minimumRange = 1;
            //self.filterTableObj.frame=CGRectMake(self.filterTableObj.frame.origin.x, self.filterTableObj.frame.origin.y, self.filterTableObj.frame.size.width, 35*filterCatAry.count);
            
            if(brandAry.count!=0)
            {
                 self.lblBrandTitle.alpha=1;
                self.lblBrandTitle.frame=CGRectMake(self.lblBrandTitle.frame.origin.x, self.lblBrandTitle.frame.origin.y, self.lblBrandTitle.frame.size.width, self.lblBrandTitle.frame.size.height);
                self.filterTableObjTwo.frame=CGRectMake(self.filterTableObjTwo.frame.origin.x, self.lblBrandTitle.frame.origin.y+self.lblBrandTitle.frame.size.height+5, self.filterTableObjTwo.frame.size.width, (35*brandAry.count)+35);
            }
            else
            {
                self.lblBrandTitle.frame=CGRectMake(self.lblBrandTitle.frame.origin.x, self.lblBrandTitle.frame.origin.y, self.lblBrandTitle.frame.size.width, 0);
                self.lblBrandTitle.alpha=0;
                self.btnFilBrand.alpha=0;
                self.filterTableObjTwo.alpha=0;
                self.filterTableObjTwo.frame=CGRectMake(self.filterTableObjTwo.frame.origin.x, self.lblBrandTitle.frame.origin.y, self.filterTableObjTwo.frame.size.width, 0);

            }
            if(disKeyArray.count!=0)
            {
                self.lblDiscountTitle.alpha=1;
                self.lblDiscountTitle.frame=CGRectMake(self.lblDiscountTitle.frame.origin.x, self.filterTableObjTwo.frame.origin.y+self.filterTableObjTwo.frame.size.height+10, self.lblDiscountTitle.frame.size.width, self.lblDiscountTitle.frame.size.height);
                
                self.tblOffer.frame=CGRectMake(self.tblOffer.frame.origin.x, self.lblDiscountTitle.frame.origin.y+self.lblDiscountTitle.frame.size.height, self.tblOffer.frame.size.width, 35*disAry.count);
            }
            else
            {
                self.lblDiscountTitle.alpha=0;
                self.lblDiscountTitle.frame=CGRectMake(self.lblDiscountTitle.frame.origin.x, self.filterTableObjTwo.frame.origin.y+self.filterTableObjTwo.frame.size.height+10, self.lblDiscountTitle.frame.size.width, 0);
                
                self.tblOffer.frame=CGRectMake(self.tblOffer.frame.origin.x, self.lblDiscountTitle.frame.origin.y+self.lblDiscountTitle.frame.size.height, self.tblOffer.frame.size.width, 35*disAry.count);
                
            }
            
            self.priceViewObj.frame=CGRectMake(self.priceViewObj.frame.origin.x, self.tblOffer.frame.origin.y+self.tblOffer.frame.size.height+10, self.priceViewObj.frame.size.width, self.priceViewObj.frame.size.height);
            [self.filterTableObj reloadData];
            [self.filterTableObjTwo reloadData];
            [self.tblOffer reloadData];
            self.scrollObj.contentSize=CGSizeMake(0, self.priceViewObj.frame.origin.y+ self.priceViewObj.frame.size.height);
            [self updateSliderLabels];
        }
        else if ([filter isEqualToString:@"fav"])
        {
             [ListAryData removeAllObjects];
            page=0;
            [self getDataFromService];
//            [Loading dismiss];
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
//            [self presentViewController:alertController animated:YES completion:^{[self getDataFromService];}];
        }
        else if ([filter isEqualToString:@"Add"])
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
                self.lblCountValue.alpha=0;
            }
            else
            {
                self.lblCountValue.alpha=1;
                self.lblCountValue.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
            }
            if (appDelObj.isArabic) {
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"تم إضافة المنتج إلى عربة التسوق بنجاح" preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            else{
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Item successfully addto cart." preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            }
//            CartViewController *cart=[[CartViewController alloc]init];
//            appDelObj.frommenu=@"no";
//            [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"FROM"];
//            [[NSUserDefaults standardUserDefaults]synchronize];
//            if(appDelObj.isArabic==YES )
//            {
//                transition = [CATransition animation];
//                [transition setDuration:0.3];
//                transition.type = kCATransitionPush;
//                transition.subtype = kCATransitionFromLeft;
//                [transition setFillMode:kCAFillModeBoth];
//                [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//                [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//                [self.navigationController pushViewController:cart animated:NO];
//            }
//            else
//            {
//                [self.navigationController pushViewController:cart animated:NO];
//            }
            [Loading dismiss];
        }
        else
        {
            URL=[[dictionary objectForKey:@"result"]objectForKey:@"prodsImageurl"];
            appDelObj.currencySymbol=[[dictionary objectForKey:@"result"]objectForKey:@"currencySymbol"];
            NSString *favSettings= [[dictionary objectForKey:@"settings"]objectForKey:@"businessFollow"];
            if ([favSettings isEqualToString:@"Yes"]) {
                _btnaddMerchant.alpha=1;
            }
            else{
                _btnaddMerchant.alpha=0;
            }
            NSArray *array=[[dictionary objectForKey:@"result"]objectForKey:@"resProducts"];
            if (array.count==0)
            {
            }
            else
            {
                if (filerList==1)
                {
                    [ListAryData removeAllObjects];
                }
                
                if ([array isKindOfClass: [NSDictionary class]]) {
                    [ListAryData addObject:array];
                }
                else
                {
                    [ListAryData addObjectsFromArray:array];
                    appDelObj.currencySymbol=[[dictionary objectForKey:@"result"]objectForKey:@"currencySymbol"];
                }
            }
            if (ListAryData.count%2==0) {
                self.imm.frame=CGRectMake(self.imm.frame.origin.x, self.imm.frame.origin.y, 1, (ListAryData.count/2*233)+2);

            }
            else{
                self.imm.frame=CGRectMake(self.imm.frame.origin.x, self.imm.frame.origin.y, 1, (ListAryData.count/2*233)+238);

            }
            [self.colListView reloadData];
        }
        [Loading dismiss];
   }
    else
    {
        if (loadmore==1) {
            
        }
        else
        {
            if (filter.length==0)
            {
                self.sortFilterView.alpha=0;
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){ [self menuAction:nil];}]];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else{
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
                
            }
        }
        
         [Loading dismiss];
    }
     [Loading dismiss];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.filterTableObj)
    {
        return 35;
    }
    else if (tableView==self.filterTableObjTwo)
    {
        if (indexPath.row==0) {
            return 44;
        }
        return 35;
    }
    else
    {
        return 35;
    }
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    if (tableView==self.filterTableObj)
    {
        return filterCatAry.count;
    }
    else if (tableView==self.filterTableObjTwo)
    {
        return 1;
    }
    else
    {
        return disKeyArray.count;
    }
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.filterTableObj)
    {
        if (filtercatSelect==section)
        {
            NSArray *a=[[filterCatAry objectAtIndex:section]valueForKey:@"sub_category"];
            if (a.count==0)
            {
                return 1;
            }
            else
            {
                return a.count+1;
            }
        }
    }
    else if (tableView==self.filterTableObjTwo)
    {
        if (brandAry.count==0)
        {
            return 0;
        }
        return brandAry.count+1;
    }
    return 1;
}
//-(NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    if(section==0)
//    {
//    if (tableView==self.filterTableObj)
//    {
//        return @"CATEGORIES";
//    }
//    else if (tableView==self.filterTableObjTwo)
//    {
//        return @"BRAND";
//    }
//    else
//    {
//        return @"DISCOUNT";
//    }
//    }
//    return nil;
//    
//}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuTableViewCell *Cell=[tableView dequeueReusableCellWithIdentifier:@"menuCell"];
    NSArray *menuCellAry;
    if (Cell==nil)
    {
        menuCellAry=[[NSBundle mainBundle]loadNibNamed:@"MenuTableViewCell" owner:self options:nil];
        
    }
     Cell=[menuCellAry objectAtIndex:0];
    if (appDelObj.isArabic==YES)
    {
        Cell.lblNme.transform=CGAffineTransformMakeScale(-1, 1);
        Cell.imgcheck.transform=CGAffineTransformMakeScale(-1, 1);
        Cell.txtSearch.transform=CGAffineTransformMakeScale(-1, 1);

        Cell.lblNme.textAlignment=NSTextAlignmentRight;
        Cell.txtSearch.textAlignment=NSTextAlignmentRight;
        Cell.txtSearch.placeholder=@" البحث عن العلامات التجارية ";
       // Cell=[menuCellAry objectAtIndex:1];
        //Cell.transform=CGAffineTransformMakeScale(-1, 1);
       // Cell.lblNme.transform=CGAffineTransformMakeScale(-1, 1);
       // Cell.imgArrow.transform=CGAffineTransformMakeScale(-1, 1);
       // Cell.lblNme.textAlignment=NSTextAlignmentRight;
    }
    else
    {
       
        Cell.txtSearch.placeholder=@" Search Brand";
    }
    Cell.selectionStyle=UITableViewCellSelectionStyleNone;
    Cell.imgline.frame=CGRectMake(Cell.img.frame.origin.x, Cell.imgline.frame.origin.y, Cell.imgArrow.frame.origin.x+Cell.imgArrow.frame.size.width-Cell.img.frame.origin.x, 0.5);
    

    if (tableView==self.filterTableObj)
    {
        Cell.imgArrow.alpha=0;
        Cell.imgcheck.alpha=0;
        Cell.imgArrow1.alpha=0;

        //Cell.textLabel.text=[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];
        NSArray *a=[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"sub_category"];
        if (a.count==0)
        {
            Cell.imgArrow.alpha=0;
            NSString *s=[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];                NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
            Cell.lblNme.text=str;
            Cell.lblNme.frame=CGRectMake(5, Cell.lblNme.frame.origin.y, Cell.lblNme.frame.size.width, Cell.lblNme.frame.size.height);
            Cell.lblNme.font=[UIFont systemFontOfSize:15];
            
            if (catRow==indexPath.section)
            {
                Cell.contentView.backgroundColor=[UIColor lightGrayColor];
            }
            else
            {
                Cell.contentView.backgroundColor=[UIColor whiteColor];
            
            }//menuCell.imgArrow.frame=CGRectMake(menuCell.imgArrow.frame.origin.x-5, menuCell.imgArrow.frame.origin.y, 16, 11);
            Cell.imgArrow.alpha=0;
            Cell.imgArrow1.alpha=1;
        }
        else
        {
            Cell.imgArrow.alpha=1;
            if (filtercatSelect==indexPath.section)
            {
                if (indexPath.row==0)
                {
                    NSString *s=[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];                NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    Cell.lblNme.text=str;
                    Cell.lblNme.frame=CGRectMake(5, Cell.lblNme.frame.origin.y, Cell.lblNme.frame.size.width, Cell.lblNme.frame.size.height);
                    Cell.lblNme.font=[UIFont systemFontOfSize:15];
                    
                    Cell.contentView.backgroundColor=[UIColor whiteColor];
                    //menuCell.imgArrow.frame=CGRectMake(menuCell.imgArrow.frame.origin.x-5, menuCell.imgArrow.frame.origin.y, 16, 11);
                    Cell.imgArrow.image=[UIImage imageNamed:@"min-.png"];
                    Cell.imgArrow1.alpha=0;
                    Cell.imgArrow.alpha=1;
                }
                else
                {
                    NSString *s=[[[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"sub_category"]objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryName"];
                    //appDelObj.CatPArID=[[[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"sub_category"]objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryParent"];
                    appDelObj.CatPArID=@"";
                    NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    Cell.lblNme.text=str;
                    Cell.lblNme.frame=CGRectMake(25, Cell.lblNme.frame.origin.y, Cell.lblNme.frame.size.width, Cell.lblNme.frame.size.height);
                    Cell.lblNme.font=[UIFont systemFontOfSize:15];
                    if (catRow==indexPath.row-1)
                    {
                        Cell.contentView.backgroundColor=[UIColor lightGrayColor];
                    }
                    else
                    {
                        Cell.contentView.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.973 alpha:1.00];
                        
                    }
                    Cell.imgArrow.alpha=0;
                    Cell.imgArrow1.alpha=1;
                    Cell.imgArrow.alpha=0;
                
                }
                
            }
            else
            {
                NSString *s=[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"];            NSString *str=[s stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                Cell.lblNme.text=str;
                Cell.lblNme.font=[UIFont systemFontOfSize:15];
                Cell.lblNme.frame=CGRectMake(5, Cell.lblNme.frame.origin.y, Cell.lblNme.frame.size.width, Cell.lblNme.frame.size.height);
                Cell.contentView.backgroundColor=[UIColor whiteColor];
                Cell.imgArrow.alpha=0;
                Cell.imgArrow1.alpha=1;
            }
        }
        Cell.txtSearch.alpha=0;
    }
    else if (tableView==self.filterTableObjTwo)
    {
        if ([brandSelect containsIndex:indexPath.row])
        {
            Cell.imgcheck.image=[UIImage imageNamed:@"login-select.png"];
        }
        else
        {
            Cell.imgcheck.image=[UIImage imageNamed:@"login-select-2.png"];
        }
        if(brandAry.count!=0)
        {
            Cell.lblNme.frame=CGRectMake(Cell.imgcheck.frame.origin.x+Cell.imgcheck.frame.size.width+12, Cell.lblNme.frame.origin.y, Cell.lblNme.frame.size.width, Cell.lblNme.frame.size.height);
            if (indexPath.row==0)
            {
                Cell.txtSearch.alpha=1;
                Cell.imgArrow.alpha=0;
                Cell.imgArrow1.alpha=0;
                Cell.imgcheck.alpha=0;
                Cell.lblNme.alpha=0;
                Cell.txtSearch.delegate=self;
                if (brandSearchStr.length==0)
                {
                }
                else
                {
                    Cell.txtSearch.text=brandSearchStr;
                     [Cell.txtSearch becomeFirstResponder];
                }
                Cell.separatorInset = UIEdgeInsetsMake(0.f, self.filterTableObjTwo.frame.size.width, 0.f, 0.f);
            }
            else
            {
                Cell.imgArrow.alpha=0;
                Cell.imgArrow1.alpha=0;
                Cell.imgcheck.alpha=1;
                Cell.lblNme.text=[[brandAry objectAtIndex:indexPath.row-1]valueForKey:@"itemName"];
            }
        }
    }
    else
    {
        if ([[disAry valueForKey:[disKeyArray objectAtIndex:indexPath.section]]isKindOfClass:[NSNull class]])
        {
        }
        else
        {
            Cell.lblNme.frame=CGRectMake(Cell.imgcheck.frame.origin.x+Cell.imgcheck.frame.size.width+12, Cell.lblNme.frame.origin.y, Cell.lblNme.frame.size.width, Cell.lblNme.frame.size.height);
            Cell.lblNme.text=[disAry valueForKey:[disKeyArray objectAtIndex:indexPath.section]];
        }
        Cell.imgArrow.alpha=0;
        Cell.imgcheck.alpha=1;
        if (offerRow==indexPath.section)
        {
            Cell.imgcheck.image=[UIImage imageNamed:@"login-select.png"];
        }
        else
        {
            Cell.imgcheck.image=[UIImage imageNamed:@"login-select-2.png"];
        }
    }
    return Cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.filterTableObj)
    {
        NSArray *a=[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"sub_category"];
        if (a.count==0)
        {
            filtercatSelect=-1;
            catRow=(int)indexPath.section;
            catValue=[NSString stringWithFormat:@"%@",[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryID"]];
            catName=[NSString stringWithFormat:@"%@",[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"productCategoryName"]];
        }
        else if (filtercatSelect==indexPath.section)
        {
            if(indexPath.row==0)
            {
                filtercatSelect=-1;
            self.filterTableObj.frame=CGRectMake(self.filterTableObj.frame.origin.x, self.filterTableObj.frame.origin.y, self.filterTableObj.frame.size.width, 35*filterCatAry.count);
            }
            if (indexPath.row==0)
            {
            }
            else
            {
                catValue=[NSString stringWithFormat:@"%@",[[[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"sub_category"] objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryID"]];
                catName=[NSString stringWithFormat:@"%@",[[[[filterCatAry objectAtIndex:indexPath.section]valueForKey:@"sub_category"] objectAtIndex:indexPath.row-1]valueForKey:@"productCategoryName"]];
                catRow=(int)indexPath.row-1;
            self.filterTableObj.frame=CGRectMake(self.filterTableObj.frame.origin.x, self.filterTableObj.frame.origin.y, self.filterTableObj.frame.size.width, 35*filterCatAry.count+(a.count*35));
            }
            if(brandAry.count!=0)
            {
                self.lblBrandTitle.alpha=1;
        self.lblBrandTitle.frame=CGRectMake(self.lblBrandTitle.frame.origin.x, self.filterTableObj.frame.origin.y+self.filterTableObj.frame.size.height+10, self.lblBrandTitle.frame.size.width, self.lblBrandTitle.frame.size.height);
self.filterTableObjTwo.frame=CGRectMake(self.filterTableObjTwo.frame.origin.x, self.lblBrandTitle.frame.origin.y+self.lblBrandTitle.frame.size.height, self.filterTableObjTwo.frame.size.width, (35*brandAry.count)+35);
            }
            else
            {
            self.lblBrandTitle.frame=CGRectMake(self.lblBrandTitle.frame.origin.x, self.filterTableObj.frame.origin.y+self.filterTableObj.frame.size.height+10, self.lblBrandTitle.frame.size.width, 0);
                self.lblBrandTitle.alpha=0;
self.filterTableObjTwo.frame=CGRectMake(self.filterTableObjTwo.frame.origin.x, self.lblBrandTitle.frame.origin.y+self.lblBrandTitle.frame.size.height, self.filterTableObjTwo.frame.size.width, 0);
            }
            if(disKeyArray.count!=0)
            {
                self.lblDiscountTitle.alpha=1;
    self.lblDiscountTitle.frame=CGRectMake(self.lblDiscountTitle.frame.origin.x, self.filterTableObjTwo.frame.origin.y+self.filterTableObjTwo.frame.size.height+10, self.lblDiscountTitle.frame.size.width, self.lblDiscountTitle.frame.size.height);
                self.tblOffer.frame=CGRectMake(self.tblOffer.frame.origin.x, self.lblDiscountTitle.frame.origin.y+self.lblDiscountTitle.frame.size.height, self.tblOffer.frame.size.width, 35*disAry.count);
            }
            else
            {
                self.lblDiscountTitle.alpha=0;
    self.lblDiscountTitle.frame=CGRectMake(self.lblDiscountTitle.frame.origin.x, self.filterTableObjTwo.frame.origin.y+self.filterTableObjTwo.frame.size.height+10, self.lblDiscountTitle.frame.size.width, 0);
                self.tblOffer.frame=CGRectMake(self.tblOffer.frame.origin.x, self.lblDiscountTitle.frame.origin.y+self.lblDiscountTitle.frame.size.height, self.tblOffer.frame.size.width, 35*disAry.count);
            }
            self.priceViewObj.frame=CGRectMake(self.priceViewObj.frame.origin.x, self.tblOffer.frame.origin.y+self.tblOffer.frame.size.height+10, self.priceViewObj.frame.size.width, 500);
            [self.filterTableObj reloadData];
  self.scrollObj.contentSize=CGSizeMake(0, self.priceViewObj.frame.origin.y+ self.priceViewObj.frame.size.height);
        }
        else
        {
            filtercatSelect=(int)indexPath.section;
            self.filterTableObj.frame=CGRectMake(self.filterTableObj.frame.origin.x, self.filterTableObj.frame.origin.y, self.filterTableObj.frame.size.width, (35*filterCatAry.count)+(a.count*35));
            if(brandAry.count!=0)
            {
                self.lblBrandTitle.alpha=1;
            self.lblBrandTitle.frame=CGRectMake(self.lblBrandTitle.frame.origin.x, self.filterTableObj.frame.origin.y+self.filterTableObj.frame.size.height+10, self.lblBrandTitle.frame.size.width, self.lblBrandTitle.frame.size.height);
self.filterTableObjTwo.frame=CGRectMake(self.filterTableObjTwo.frame.origin.x, self.lblBrandTitle.frame.origin.y+self.lblBrandTitle.frame.size.height, self.filterTableObjTwo.frame.size.width, (35*brandAry.count)+35);
            }
            else
            {
            self.lblBrandTitle.frame=CGRectMake(self.lblBrandTitle.frame.origin.x, self.filterTableObj.frame.origin.y+self.filterTableObj.frame.size.height+10, self.lblBrandTitle.frame.size.width, 0);
                self.lblBrandTitle.alpha=0;
self.filterTableObjTwo.frame=CGRectMake(self.filterTableObjTwo.frame.origin.x, self.lblBrandTitle.frame.origin.y+self.lblBrandTitle.frame.size.height, self.filterTableObjTwo.frame.size.width, 0);
            }
            if(disKeyArray.count!=0)
            {
                self.lblDiscountTitle.alpha=1;
    self.lblDiscountTitle.frame=CGRectMake(self.lblDiscountTitle.frame.origin.x, self.filterTableObjTwo.frame.origin.y+self.filterTableObjTwo.frame.size.height+10, self.lblDiscountTitle.frame.size.width, self.lblDiscountTitle.frame.size.height);
                self.tblOffer.frame=CGRectMake(self.tblOffer.frame.origin.x, self.lblDiscountTitle.frame.origin.y+self.lblDiscountTitle.frame.size.height, self.tblOffer.frame.size.width, 35*disAry.count);
            }
            else
            {
                self.lblDiscountTitle.alpha=0;
    self.lblDiscountTitle.frame=CGRectMake(self.lblDiscountTitle.frame.origin.x, self.filterTableObjTwo.frame.origin.y+self.filterTableObjTwo.frame.size.height+10, self.lblDiscountTitle.frame.size.width, 0);
                self.tblOffer.frame=CGRectMake(self.tblOffer.frame.origin.x, self.lblDiscountTitle.frame.origin.y+self.lblDiscountTitle.frame.size.height, self.tblOffer.frame.size.width, 35*disAry.count);
            }
            self.priceViewObj.frame=CGRectMake(self.priceViewObj.frame.origin.x, self.tblOffer.frame.origin.y+self.tblOffer.frame.size.height+10, self.priceViewObj.frame.size.width, self.priceViewObj.frame.size.height);
            [self.filterTableObj reloadData];
  self.scrollObj.contentSize=CGSizeMake(0, self.priceViewObj.frame.origin.y+ self.priceViewObj.frame.size.height);
        }
         [self.filterTableObj reloadData];
    }
    else if (tableView==self.filterTableObjTwo)
    {
        if (indexPath.row==0)
        {
        }
        else{
            if ([brandSelect containsIndex:indexPath.row])
            {
                [brandSelect removeIndex:indexPath.row];
                if (appDelObj.filterBrandID.count==1||appDelObj.filterBrandID.count==0) {
                    [appDelObj.filterBrandID  removeAllObjects];
                }
                else{
                    [appDelObj.filterBrandID  removeObject:[[brandAry objectAtIndex:indexPath.row-1]valueForKey:@"itemID"]];
                }
            }
            else
            {
                [brandSelect addIndex:indexPath.row];
                BrandValue=[NSString stringWithFormat:@"%@",[[brandAry objectAtIndex:indexPath.row-1]valueForKey:@"itemID"]];
                [appDelObj.filterBrandID addObject:BrandValue];
            }
        }
         [self.filterTableObjTwo reloadData];
    }
    else
    {
        offerRow=(int)indexPath.section;
        discount=[NSString stringWithFormat:@"%@",[disKeyArray objectAtIndex:indexPath.section]];
        appDelObj.mainDiscount=discount;
        [self.tblOffer reloadData];
    }
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.view.frame.size.width/2), 255);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return ListAryData.count;
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    self.imm.alpha=1;
    ItemCollectionViewCell *cell = (ItemCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    cell.layer.borderWidth=.5;
    cell.layer.borderColor=[[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00]CGColor];
    cell.itemName.textColor=appDelObj.titleColor;
    cell.lblOffer.textColor=appDelObj.redColor;
    if(appDelObj.isArabic)
    {
        cell.itemName.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblHot.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffLabel.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblHot.text=@"مميز";
        cell.itemPrice.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffer.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemImg.transform = CGAffineTransformMakeScale(-1, 1);
        cell.btnAdd.transform = CGAffineTransformMakeScale(-1, 1);
        [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        cell.lblOffLabel.text=@"خصم";
        cell.lblHot.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblHot.text=@"مميز";
    }
    cell.btnAdd.alpha=1;
if(indexPath.row<ListAryData.count)
{
    NSString *strImgUrl=[[ListAryData objectAtIndex:indexPath.row ] valueForKey:@"productImage"] ;
    if (strImgUrl.length!=0)
    {
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG;
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",URL,strImgUrl];
        }
        if (appDelObj.isArabic) {
            [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
            [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
    }
    else{
        cell.itemImg.image=[UIImage imageNamed:@"placeholder1.png"];
        if(appDelObj.isArabic)
        {
            cell.itemImg.image=[UIImage imageNamed:@"place_holderar.png"];
        }
    }
    NSString *hotStr=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"featuredStatus"];
    if ([hotStr isEqualToString:@"Yes"]||[hotStr isEqualToString:@"YES"]||[hotStr isEqualToString:@"yes"]) {
        cell.lblHot.alpha=1;
    }
    NSString *offerStr=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"];
    if ([appDelObj.dealBundle isEqualToString:@"Yes"])
    {
        offerStr=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"dealDiscount"];
        if ([offerStr isKindOfClass:[NSNull class]])
        {
            cell.lblOffer.alpha=0;
            cell.offview.alpha=0;
        }
        else
        {
            NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
            if ([[offArr objectAtIndex:0]isEqualToString:@"0"]||[[offArr objectAtIndex:0]isEqualToString:@"00"]||[[offArr objectAtIndex:0]isEqualToString:@"000"]||[[offArr objectAtIndex:0]isEqualToString:@"0000"]) {
                cell.lblOffer.alpha=0;
                cell.offview.alpha=0;
            }
            else{
                if (appDelObj.isArabic) {
                    cell.lblOffLabel.text=@"خصم";
                    cell.lblOffer.text=[NSString stringWithFormat:@"%@%@ ",@"%",[offArr objectAtIndex:0]];
                }
                else
                {
                    cell.lblOffer.text=[NSString stringWithFormat:@"%@%@",[offArr objectAtIndex:0],@"%"];
                }
            }
        }
    }
    else
    {
        if ([offerStr isKindOfClass:[NSNull class]])
        {
            cell.lblOffer.alpha=0;
            cell.offview.alpha=0;
        }
        else
        {
            NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
            if ([[offArr objectAtIndex:0]isEqualToString:@"0"]||[[offArr objectAtIndex:0]isEqualToString:@"00"]||[[offArr objectAtIndex:0]isEqualToString:@"000"]||[[offArr objectAtIndex:0]isEqualToString:@"0000"]) {
                cell.lblOffer.alpha=0;
                cell.offview.alpha=0;
            }
            else{
                if (appDelObj.isArabic) {
                    cell.lblOffLabel.text=@"خصم";
                    cell.lblOffer.text=[NSString stringWithFormat:@"%@%@ ",@"%",[offArr objectAtIndex:0]];
                }
                else
                {
                    cell.lblOffer.text=[NSString stringWithFormat:@"%@%@",[offArr objectAtIndex:0],@"%"];
                }
            }
        }
    }
    NSString *freeStr=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"freeProductsExists"];
    if ([freeStr isEqualToString:@"Yes"]||[freeStr isEqualToString:@"YES"]||[freeStr isEqualToString:@"yes"])
    {
        cell.imgfree.alpha=1;
    }
    else
    {
         cell.imgfree.alpha=0;
    }
    NSString *sname=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"];
    NSString *strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    cell.itemName.text= strname;
    int wishValue=[[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"wishlistProducts"]intValue];
    if(wishValue>0)
    {
        [cell.btnFav setBackgroundImage:[UIImage imageNamed:@"wish2.png"] forState:UIControlStateNormal];
    }
    else
    {
        [cell.btnFav setBackgroundImage:[UIImage imageNamed:@"wish111.png"] forState:UIControlStateNormal];
    }
    if ([appDelObj.dealBundle isEqualToString:@"Yes"])
    {
        float x=[[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"dealPrice"] floatValue];
        float x1=[[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productOptionRegularPrice"] floatValue];
        NSString *sD=[NSString stringWithFormat:@"%.02f",x] ;
        NSString *sD1=[NSString stringWithFormat:@"%.02f",x1 ];
        NSString *s1=[NSString stringWithFormat:@" %@ %@",sD,appDelObj.currencySymbol] ;
        NSString *ss=[NSString stringWithFormat:@"%@ %@",sD1,appDelObj.currencySymbol] ;
NSString *s2=[NSString stringWithFormat:@"%@",ss] ;
        NSAttributedString *strOld=[[NSAttributedString alloc]initWithString:s2];
        NSAttributedString *str=[[NSAttributedString alloc]initWithString:s1];
        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                            initWithAttributedString:str];
        [string addAttribute:NSForegroundColorAttributeName
                       value:appDelObj.priceColor
                       range:NSMakeRange(0, [string length])];
        [string addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightRegular]
                       range:NSMakeRange(0, [string length])];
        NSMutableAttributedString *sss=[[NSMutableAttributedString alloc]initWithAttributedString:strOld];
        NSMutableAttributedString *price= [[NSMutableAttributedString alloc]
                                            initWithAttributedString:sss];
        [price addAttribute:NSForegroundColorAttributeName
                       value:appDelObj.priceOffer
                       range:NSMakeRange(0, [price length])];
        [price addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                       range:NSMakeRange(0, [price length])];
        [price addAttribute:NSStrikethroughStyleAttributeName
                       value:@2
                       range:NSMakeRange(0, [price length])];
        if (appDelObj.isArabic) {
            [price addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [price length])];
        }
        if (appDelObj.isArabic) {
             [string appendAttributedString:price];
            cell.itemPrice.attributedText=string;
        }
        else
        {
             [price appendAttributedString:string];
            cell.itemPrice.attributedText=price;
        }
    }
    else
    {
    float x=[[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productOptionRegularPrice"] floatValue];
    float x1=[[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"offerPrice"] floatValue];
    NSString *s1=[NSString stringWithFormat:@"%.02f",x1] ;
    NSString *s2=[NSString stringWithFormat:@"%.02f",x ];
    if ([s1 isEqualToString:s2])
    {
        NSMutableAttributedString *price;
            price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",s1,appDelObj.currencySymbol]];
        [price addAttribute:NSForegroundColorAttributeName
                       value:appDelObj.priceColor
                       range:NSMakeRange(0, [price length])];
        if (appDelObj.isArabic) {
            [price addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [price length])];
        }
        cell.itemPrice.attributedText=price;
    }
    else{
        if (s1.length!=0&&s2.length!=0)
        {
            NSString *p1=s1;
            NSString *p2=s2;
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p1,appDelObj.currencySymbol]];
            if (appDelObj.isArabic) {
                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p1,appDelObj.currencySymbol]];
            }
            [price addAttribute:NSForegroundColorAttributeName
                          value:appDelObj.priceColor
                          range:NSMakeRange(0, [price length])];
            [price addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [price length])];
            if (appDelObj.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p2,appDelObj.currencySymbol]];
            if (appDelObj.isArabic) {
                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p2,appDelObj.currencySymbol]];
            }
            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                initWithAttributedString:str];
            [string addAttribute:NSForegroundColorAttributeName
                           value:appDelObj.priceOffer
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
            [price appendAttributedString:string];
            cell.itemPrice.attributedText=price;
        }
        else
        {
            cell.itemPrice.text=@"";
        }
    }
    }
     cell.im.alpha=1;
    if (ListAryData.count>6&& indexPath.row==ListAryData.count-1)
    {
        [self loadmoreAction:nil];
    }
    cell.FavDEL=self;
    cell.btnFav.tag=indexPath.row;
     cell.btnAdd.tag=indexPath.row;
    cell.btnf1.tag=indexPath.row;
}
    if ([appDelObj.dealBundle isEqualToString:@"Yes"])
    {
        double minitem;
       
        double  outStock;
        
        if ([[[ListAryData objectAtIndex:indexPath.row ]  valueForKey:@"dealMaxBuyLimit"]isKindOfClass:[NSNull class]]) {
            minitem=1;
        }
        else
        {
            minitem=[[[ListAryData objectAtIndex:indexPath.row ]  valueForKey:@"dealMaxBuyLimit"]doubleValue];
        }
        if ([[[ListAryData objectAtIndex:indexPath.row ]  valueForKey:@"productOptionQuantitySum"]isKindOfClass:[NSNull class]]) {
            outStock=1;
        }
        else
        {
            outStock=[[[ListAryData objectAtIndex:indexPath.row ]  valueForKey:@"productOptionQuantitySum"]doubleValue];
        }
        if (outStock<1) {
            if (appDelObj.isArabic) {
                [cell.btnAdd setTitle:@"غير متوفر" forState:UIControlStateNormal];
            }
            else
            {
                [cell.btnAdd setTitle:@"Out Of Stock" forState:UIControlStateNormal];
            }
        }
        else
        {
            if (appDelObj.isArabic) {
                [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
            }
            else
            {
                [cell.btnAdd setTitle:@"Add To Cart" forState:UIControlStateNormal];
            }
        }
    }
    else
    {
        double minitem;
        minitem=[[[ListAryData objectAtIndex:indexPath.row ]  valueForKey:@"productMinBuyLimit"]doubleValue];
        double  outStock;
        if ([[[ListAryData objectAtIndex:indexPath.row ]  valueForKey:@"productMinBuyLimit"]isKindOfClass:[NSNull class]]) {
            minitem=1;
        }
        else
        {
            minitem=[[[ListAryData objectAtIndex:indexPath.row ]  valueForKey:@"productMinBuyLimit"]doubleValue];
        }
        if ([[[ListAryData objectAtIndex:indexPath.row ]  valueForKey:@"productOptionQuantitySum"]isKindOfClass:[NSNull class]]) {
            outStock=1;
        }
        else
        {
            outStock=[[[ListAryData objectAtIndex:indexPath.row ]  valueForKey:@"productOptionQuantitySum"]doubleValue];
        }
        if (outStock<1) {
            if (appDelObj.isArabic) {
                [cell.btnAdd setTitle:@"غير متوفر" forState:UIControlStateNormal];
            }
            else
            {
                [cell.btnAdd setTitle:@"Out Of Stock" forState:UIControlStateNormal];
            }
        }
        else
        {
            
            if (appDelObj.isArabic) {
                [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
            }
            else
            {
                [cell.btnAdd setTitle:@"Add To Cart" forState:UIControlStateNormal];
            }
        }
    }
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if(appDelObj.isArabic==YES )
    {
        ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
        listDetail.productID=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
        listDetail.productName=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
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
        ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
        listDetail.productID=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
        listDetail.productName=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
        [self.navigationController pushViewController:listDetail animated:YES];
    }
}
-(void)AddToCartvActionDel:(int)tag
{
    NSString *strFree=[ [ListAryData objectAtIndex:tag ]valueForKey:@"freeProductsExists"];
    NSString *strOption=[NSString stringWithFormat:@"%@",[ [ListAryData objectAtIndex:tag ]valueForKey:@"customOptionCount"]];
    int opt;
    if ([strOption isKindOfClass:[NSNull class]]||strOption.length==0) {
        opt=0;
    }
    else
    {
        opt=[strOption intValue];
    }
    if ([strFree isEqualToString:@"Yes"]||[strFree isEqualToString:@"yes"]||opt>0)
    {
            if(appDelObj.isArabic==YES )
            {
                ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
                listDetail.productID=[[ListAryData objectAtIndex:tag ]   valueForKey:@"productID"] ;
                listDetail.productName=[[ListAryData objectAtIndex:tag]   valueForKey:@"productTitle"] ;
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
                ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
                listDetail.productID=[[ListAryData objectAtIndex:tag ]   valueForKey:@"productID"] ;
                listDetail.productName=[[ListAryData objectAtIndex:tag ]   valueForKey:@"productTitle"] ;
                [self.navigationController pushViewController:listDetail animated:YES];
            }
    }
else
{
    filter=@"Add";
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
    NSString *qty;
    if ([appDelObj.dealBundle isEqualToString:@"Yes"])
    {
        qty=[[ListAryData objectAtIndex:tag ]  valueForKey:@"dealMaxBuyLimit"];
    }
    else
    {
        qty=[NSString stringWithFormat:@"%@",[[ListAryData objectAtIndex:tag ]   valueForKey:@"productMinBuyLimit"]];
    }
    if(qty.length==0)
             {
                 qty=@"";
             }
    NSMutableDictionary*   dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",[[ListAryData objectAtIndex:tag ]   valueForKey:@"productID"],@"productID",[[ListAryData objectAtIndex:tag ]   valueForKey:@"productOptionID"],@"productOptionID",qty,@"quantity",[[ListAryData objectAtIndex:tag ]   valueForKey:@"productTitle"],@"productOptionName",[[ListAryData objectAtIndex:tag ]   valueForKey:@"productTitle"],@"productTitle",[[ListAryData objectAtIndex:tag ]   valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",CAID,@"cartID",[[ListAryData objectAtIndex:tag ]   valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",@"",@"strcombinationValues",@"",@"subAttr",@"onetime",@"purchase",@"",@"customOptionValues",@"No",@"freeProduct",@"",@"freeBaseProductID",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
}
-(void)AddToFavActionDel:(int)tag second:(id)sender
{
    LoginViewController *login=[[LoginViewController alloc]init];
    ArabicLoginViewController *loginAra=[[ArabicLoginViewController alloc]init];
    login.fromWhere=@"Favourite";
      loginAra.fromWhere=@"Favourite";
    appDelObj.fromWhere=@"Favourite";
    login.productID=[[ListAryData objectAtIndex:tag]   valueForKey:@"productID"];
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
        NSIndexPath *ip = [NSIndexPath indexPathForRow:tag inSection:0];
        ItemCollectionViewCell *cell = [self.colListView cellForItemAtIndexPath:ip];
        UIImage *imageToCheckFor = [UIImage imageNamed:@"wish2.png"];
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:imageToCheckFor forState:UIControlStateNormal];
        if ([cell.btnFav.currentBackgroundImage isEqual: [UIImage imageNamed:@"wish2.png"]])
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
            filter=@"fav";
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/ajaxWishList/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[ListAryData objectAtIndex:tag]   valueForKey:@"productID"],@"productID", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
    }
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offsetY = scrollView.contentOffset.y;
    CGFloat contentHeight = scrollView.frame.size.height;
    if(contentHeight>=(ListAryData.count/2)*233)
    {
        NSLog(@"offset X %.0f", offsetY);
    }
}
-(void)itemCount:(NSString *)countValueDel
{
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
    if ([appDelObj.frommenu isEqualToString:@"yes"]|| [appDelObj.fromSide isEqualToString:@"yes"])
    {
        if(appDelObj.isArabic==YES )
        {
            [appDelObj arabicMenuAction];
        }
        else
        {
            [appDelObj englishMenuAction];
        }
    }
    else if ([appDelObj.frommenu isEqualToString:@"det"])
    {
        appDelObj.frommenu=@"";
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
    else
    {
        if(appDelObj.isArabic==YES )
        {
            [appDelObj arabicMenuAction];
        }
        else
        {
            [appDelObj englishMenuAction];
        }
    }
}
- (IBAction)searchAction:(id)sender
{
    if (appDelObj.isArabic) {
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
    else
    {
        SearchView *search=[[SearchView alloc]init];
        [self.navigationController pushViewController:search animated:NO];
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];    NSLog(@"%@",newString);
    if (textField==self.txtSearch)
    {

    }
    else
    {
        if (newString.length==0)
        {
            brandSearchStr=@"";
            brandAry=tempBrand;
        }
        else
        {
            brandSearchStr=@"";
            brandSearchStr=newString;
            brandAry=[BrandAllAry filteredArrayUsingPredicate:[NSPredicate predicateWithFormat:@"(itemName  CONTAINS[c] %@)",newString]];
            if (brandAry.count==0)
            {
                brandAry=tempBrand;
            }
        }
        self.filterTableObj.frame=CGRectMake(self.filterTableObj.frame.origin.x, self.filterTableObj.frame.origin.y, self.filterTableObj.frame.size.width, 35*filterCatAry.count);
        if(brandAry.count!=0)
        {
            self.lblBrandTitle.alpha=1;
            self.lblBrandTitle.frame=CGRectMake(self.lblBrandTitle.frame.origin.x, self.filterTableObj.frame.origin.y+self.filterTableObj.frame.size.height+10, self.lblBrandTitle.frame.size.width, self.lblBrandTitle.frame.size.height);
self.filterTableObjTwo.frame=CGRectMake(self.filterTableObjTwo.frame.origin.x, self.lblBrandTitle.frame.origin.y+self.lblBrandTitle.frame.size.height, self.filterTableObjTwo.frame.size.width, (35*brandAry.count)+35);
        }
        else
        {
            self.lblBrandTitle.frame=CGRectMake(self.lblBrandTitle.frame.origin.x, self.filterTableObj.frame.origin.y+self.filterTableObj.frame.size.height+10, self.lblBrandTitle.frame.size.width, 0);
            self.lblBrandTitle.alpha=0;
self.filterTableObjTwo.frame=CGRectMake(self.filterTableObjTwo.frame.origin.x, self.lblBrandTitle.frame.origin.y+self.lblBrandTitle.frame.size.height, self.filterTableObjTwo.frame.size.width, 0);
        }
        if(brandAry.count!=0)
        {
            self.lblBrandTitle.alpha=1;
    self.lblDiscountTitle.frame=CGRectMake(self.lblDiscountTitle.frame.origin.x, self.filterTableObjTwo.frame.origin.y+self.filterTableObjTwo.frame.size.height+10, self.lblDiscountTitle.frame.size.width, self.lblDiscountTitle.frame.size.height);
            self.tblOffer.frame=CGRectMake(self.tblOffer.frame.origin.x, self.lblDiscountTitle.frame.origin.y+self.lblDiscountTitle.frame.size.height, self.tblOffer.frame.size.width, 35*disAry.count);
        }
        else
        {
            self.lblDiscountTitle.alpha=0;
    self.lblDiscountTitle.frame=CGRectMake(self.lblDiscountTitle.frame.origin.x, self.filterTableObjTwo.frame.origin.y+self.filterTableObjTwo.frame.size.height+10, self.lblDiscountTitle.frame.size.width, 0);
            
            self.tblOffer.frame=CGRectMake(self.tblOffer.frame.origin.x, self.lblDiscountTitle.frame.origin.y+self.lblDiscountTitle.frame.size.height, self.tblOffer.frame.size.width, 35*disAry.count);
        }
        self.priceViewObj.frame=CGRectMake(self.priceViewObj.frame.origin.x, self.tblOffer.frame.origin.y+self.tblOffer.frame.size.height+10, self.priceViewObj.frame.size.width, self.priceViewObj.frame.size.height);
        [self.filterTableObj reloadData];
        [self.filterTableObjTwo reloadData];
        [self.tblOffer reloadData];
        [self filterBrandAction:nil];
        self.scrollObj.contentSize=CGSizeMake(0, self.priceViewObj.frame.origin.y+ self.priceViewObj.frame.size.height);
    }
    return YES;
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (textField==self.txtSearch)
    {
        if (textField.text.length==0)
        {
            self.txtSearch.alpha=0;
            self.lblTitle.alpha=1;
        }
    }
    [textField resignFirstResponder];
 return YES;
}
- (IBAction)sortAction:(id)sender
{
    self.sortView.alpha = 1;
    self.sortView.frame = CGRectMake(self.sortView.frame.origin.x, self.sortView.frame.origin.y, self.sortView.frame.size.width, self.sortView.frame.size.height);
    [self.view addSubview:self.sortView];
    self.sortView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.sortView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.sortView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              CGRect rect = self.sortView.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.sortView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
           
                                                               }];
                                          }];
                     }];
}

- (IBAction)filterAction:(id)sender
{
    filter=@"filter";
    brandSearchStr=@"";
    brandsIDArray=[[NSMutableArray alloc]init];
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Deal/listFilter/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost;
    if (appDelObj.mainSearch.length==0) {
        appDelObj.mainSearch=@"";
    }
    if (appDelObj.mainBrand.length==0) {
        appDelObj.mainBrand=@"";
    }
    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"0",@"page",appDelObj.CatID,@"categoryID",appDelObj.mainSearch,@"keyword",appDelObj.mainBrand,@"brandID",self.businessID,@"businessID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    self.filterViewObj.alpha = 1;
    self.filterViewObj.frame = CGRectMake(self.filterViewObj.frame.origin.x, self.filterViewObj.frame.origin.y, self.filterViewObj.frame.size.width, self.filterViewObj.frame.size.height);
    [self.view addSubview:self.filterViewObj];
    self.filterViewObj.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.filterViewObj.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.filterViewObj.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              CGRect rect = self.filterViewObj.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.filterViewObj.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
   
                                                               }];
                                          }];
                     }];
}
- (IBAction)cancelSortAction:(id)sender
{
    CGRect rect = self.sortView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.filterViewObj.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.sortView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.sortView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.sortView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.sortView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [self.sortView removeFromSuperview];
                                                                   
                                                               }];
                                          }];
                     }];
}
- (IBAction)cartAction:(id)sender
{
    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    if (cartCount.length==0)
    {
        CartViewController *cart=[[CartViewController alloc]init];
        appDelObj.frommenu=@"";
        cart.emptyCart=@"Yes";
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        [self.navigationController pushViewController:cart animated:YES];
    }
    else
    {
    CartViewController *cart=[[CartViewController alloc]init];
    appDelObj.frommenu=@"no";
        [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        if(appDelObj.isArabic==YES )
        {
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
            [self.navigationController pushViewController:cart animated:YES];
        }
    }    
}
- (IBAction)closeAction:(id)sender
{
    if (clear==1)
    {
        [self getDataFromService];
    }
    clear=0;
    CGRect rect = self.filterViewObj.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.filterViewObj.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.filterViewObj.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.filterViewObj.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.filterViewObj removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.filterViewObj.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.filterViewObj removeFromSuperview];
                                                                   
                                                               }];
                                          }];
                     }];
}
- (IBAction)resetAction:(id)sender
{
    clear=1;
    catValue=appDelObj.CatID;
    appDelObj.CatID=catValue;
    MinValue=@"";
    maxValue=@"";
    BrandValue=@"";
    if (appDelObj.isArabic) {
        self.lblnotApply.text=@"غير مطبق";
    }
    else
    {
        self.lblnotApply.text=@"Not Applied";
    }
    appDelObj.mainBrand=@"";
    appDelObj.mainPrice=@"";
    appDelObj.mainSearch=@"";
    appDelObj.mainBusiness=@"";
    appDelObj.mainDiscount=@"";
    discount=@"";
    offerRow=-1;
    [brandSelect removeAllIndexes];
    filtercatSelect=-1;
    [appDelObj.filterBrandID removeAllObjects];
    [self.filterTableObjTwo reloadData];
    [self.filterTableObj reloadData];
    [self.tblOffer reloadData];
}

- (IBAction)viewDealAction:(id)sender
{
    ListAryData=[[NSMutableArray alloc]init];
    [self.colListView reloadData];
    self.imm.alpha=0;
    page=0;
    if (appDelObj.isArabic) {
        self.lblnotApply.text=@"مستعمل";
    }
    else
    {
        self.lblnotApply.text=@"Applied";
    }
    clear=0;
    filerList=1;
    filter=@"";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *pa=[NSString stringWithFormat:@"%d",page];
    NSString *bIDs=@"";
    if (catValue.length==0)
    {
        catValue=appDelObj.CatID;
        catValue=@"0";
        self.lblTitle.text=appDelObj.listTitle;
    }
    else
    {
        self.lblTitle.text=catName;
    }
    if (appDelObj.CatPArID.length==0)
    {
        appDelObj.CatPArID=@"";
    }
    if (appDelObj.filterBrandID.count==0)
    {
        bIDs=@"";
        BrandValue=@"";
    }
    else
    {
        if(appDelObj.filterBrandID.count==1)
        {
        }
        else
        {
        }
        BrandValue=[appDelObj.filterBrandID objectAtIndex:0];
        bIDs=[appDelObj.filterBrandID objectAtIndex:0];
        for (int i=1; i<appDelObj.filterBrandID.count; i++)
        {
            bIDs=[NSString stringWithFormat:@"%@,%@",bIDs,[appDelObj.filterBrandID objectAtIndex:i]];
        }
    }
    appDelObj.mainBrand=bIDs;
    if (self.keyword.length==0)
    {
        self.keyword=@"";
    }
    if (self.sortType.length==0)
    {
        self.sortType=@"";
    }
    if (MinValue.length==0)
    {
       MinValue=@"";
    }
    if (maxValue.length==0)
    {
        maxValue=@"";
    }
    if (discount.length==0)
    {
        discount=@"";
    }
    NSString *BID;
    if (self.businessID.length==0) {
        BID=@"";
    }
    else
    {
        BID=self.businessID;
    }
    if (bIDs.length==0) {
        bIDs=@"";
    }
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Deal/productsList/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost;
    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:pa,@"page",appDelObj.CatID,@"categoryID",appDelObj.CatPArID,@"parentCategoryID",self.keyword,@"keyword",self.sortType,@"sortBy",MinValue,@"priceRangeMin",maxValue,@"priceRangeMax",discount,@"discountRange",@"",@"attrData",BrandValue,@"brandID",bIDs,@"brandIDs",BID,@"businessID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    [self closeAction:nil];
}

- (IBAction)loadmoreAction:(id)sender
{
    page++;
    loadmore=1;
     filerList=0;
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    NSString *pa=[NSString stringWithFormat:@"%d",page];
    if (self.sortType.length==0)
    {
        self.sortType=@"";
    }
    NSString *BID;
    if (self.businessID.length==0) {
        BID=@"";
    }
    else
    {
        BID=self.businessID;
    }
    [self getDataFromService];
}
- (void) viewDidAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateSliderLabels];
}
- (void) updateSliderLabels
{
    CGPoint lowerCenter;
    lowerCenter.x = (self.labelSlider.lowerCenter.x + self.labelSlider.frame.origin.x);
    lowerCenter.y = (self.labelSlider.center.y - 30.0f);
    self.lowerLabel.center = lowerCenter;
    self.lowerLabel.text = [NSString stringWithFormat:@"%d", (int)self.labelSlider.lowerValue];
    CGPoint upperCenter;
    upperCenter.x = (self.labelSlider.upperCenter.x + self.labelSlider.frame.origin.x);
    upperCenter.y = (self.labelSlider.center.y - 30.0f);
    self.upperLabel.center = upperCenter;
        self.lblPriceFilter.text = [NSString stringWithFormat:@"%d %@-%d%@ ", (int)self.labelSlider.lowerValue,appDelObj.currencySymbol,(int)self.labelSlider.upperValue,appDelObj.currencySymbol];
    MinValue=[NSString stringWithFormat:@"%f",self.labelSlider.lowerValue];
    maxValue=[NSString stringWithFormat:@"%f",self.labelSlider.upperValue ];
}
- (IBAction)labelSliderChanged:(NMRangeSlider*)sender
{
    [self updateSliderLabels];
}
- (void) configureLabelSlider
{
    self.labelSlider.minimumValue = [[priceAry valueForKey:@"MINIMUM"]integerValue];
    self.labelSlider.maximumValue = [[priceAry valueForKey:@"MAXIMUM"]integerValue];
    self.labelSlider.lowerValue =[[priceAry valueForKey:@"MINIMUM"]integerValue];
    self.labelSlider.upperValue = [[priceAry valueForKey:@"MAXIMUM"]integerValue];
    self.labelSlider.minimumRange = 1;
}
- (IBAction)lowAction:(id)sender
{
    ListAryData =[[NSMutableArray alloc]init];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"lan-button-active.png"] forState:UIControlStateNormal];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self cancelSortAction:nil];
    self.sortType=@"price_asc";
    if (appDelObj.isArabic) {
        self.lblnewList.text=@"السعر - من الأقل إلى الأعلى";
    }
    else
    {
          self.lblnewList.text=@"Price Low-to-High";
    }
    NSString *BID;
    if (self.businessID.length==0) {
        BID=@"";
    }
    else
    {
        BID=self.businessID;
    }
    filter=@"";
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    [self getDataFromService];
}
- (IBAction)poularAction:(id)sender
{
    ListAryData =[[NSMutableArray alloc]init];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"lan-button-active.png"] forState:UIControlStateNormal];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self cancelSortAction:nil];
    self.sortType=@"popularity";
    filter=@"";
    if (appDelObj.isArabic) {
        self.lblnewList.text=@"الأكثر مبيعا ";
    }
    else
    {
         self.lblnewList.text=@"Popularity";
    }
    NSString *BID;
    if (self.businessID.length==0) {
        BID=@"";
    }
    else
    {
        BID=self.businessID;
    }
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
      [self getDataFromService];
}
- (IBAction)highAction:(id)sender
{
    ListAryData =[[NSMutableArray alloc]init];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"lan-button-active.png"] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self cancelSortAction:nil];
    self.sortType=@"price_desc";
    filter=@"";
    if (appDelObj.isArabic) {
        self.lblnewList.text=@"السعر - من الأعلى إلى الأقل";
    }
    else
    {
        self.lblnewList.text=@"Price High-to-Low";
    }
    NSString *BID;
    if (self.businessID.length==0) {
        BID=@"";
    }
    else
    {
        BID=self.businessID;
    }
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
      [self getDataFromService];
}
- (IBAction)addNewAction:(id)sender
{
    ListAryData =[[NSMutableArray alloc]init];
    [self.btn4 setBackgroundImage:[UIImage imageNamed:@"lan-button-active.png"] forState:UIControlStateNormal];
    [self.btn2 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self.btn3 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self.btn1 setBackgroundImage:[UIImage imageNamed:@"lan-button.png"] forState:UIControlStateNormal];
    [self cancelSortAction:nil];
    self.sortType=@"new_products";
    filter=@"";
    if (appDelObj.isArabic) {
        self.lblnewList.text=@"مصنف حديثآ";
    }
    else
    {
         self.lblnewList.text=@"Newst First";
    }
    NSString *BID;
    if (self.businessID.length==0) {
        BID=@"";
    }
    else
    {
        BID=self.businessID;
    }
   if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    [self getDataFromService];
}
- (IBAction)FilterCategoryAction:(id)sender {
    [UIView animateWithDuration:.5 animations:^{self.scrollObj.contentOffset=CGPointMake(0, 0); }];
    self.btnFilCategory.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00];
    self.btnFilBrand.backgroundColor=[UIColor clearColor];
    self.btnFilDisCount.backgroundColor=[UIColor clearColor];
self.btnFilterprice.backgroundColor=[UIColor clearColor];
}
- (IBAction)filterBrandAction:(id)sender {
    [UIView animateWithDuration:.5 animations:^{self.scrollObj.contentOffset=CGPointMake(0, self.filterTableObj.frame.origin.y+self.filterTableObj.frame.size.height); }];
    self.btnFilBrand.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00];
    self.btnFilCategory.backgroundColor=[UIColor clearColor];
    self.btnFilDisCount.backgroundColor=[UIColor clearColor];
    self.btnFilterprice.backgroundColor=[UIColor clearColor];

}
- (IBAction)filterDiscountAction:(id)sender {
    [UIView animateWithDuration:.5 animations:^{self.scrollObj.contentOffset=CGPointMake(0, self.filterTableObjTwo.frame.origin.y+self.filterTableObjTwo.frame.size.height);  }];
    self.btnFilDisCount.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00];
    self.btnFilBrand.backgroundColor=[UIColor clearColor];
    self.btnFilCategory.backgroundColor=[UIColor clearColor];
    self.btnFilterprice.backgroundColor=[UIColor clearColor];
}
- (IBAction)filterpriceAction:(id)sender {
    [UIView animateWithDuration:.5 animations:^{self.scrollObj.contentOffset=CGPointMake(0, self.tblOffer.frame.origin.y+self.tblOffer.frame.size.height); }];
    self.btnFilterprice.backgroundColor=[UIColor colorWithRed:0.965 green:0.965 blue:0.965 alpha:1.00];
    self.btnFilBrand.backgroundColor=[UIColor clearColor];
    self.btnFilDisCount.backgroundColor=[UIColor clearColor];
    self.btnFilCategory.backgroundColor=[UIColor clearColor];
}
- (IBAction)addFavMerchantAction:(id)sender {
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        LoginViewController *login=[[LoginViewController alloc]init];
        ArabicLoginViewController *loginAra=[[ArabicLoginViewController alloc]init];
        login.fromWhere=@"MerchantWish";
        loginAra.fromWhere=@"MerchantWish";

        appDelObj.fromWhere=@"MerchantWish";
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
        if ([self.btnaddMerchant.currentBackgroundImage isEqual: [UIImage imageNamed:@"fav-store.png"]])
        {
            filter=@"favMer";
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            NSString *urlStr;
            NSMutableDictionary *dicPost;
            urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/following/languageID/",appDelObj.languageId];
            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",@"unfollow",@"action",self.businessID,@"businessID", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        else
        {
            NSString *strMsg,*okMsg,*no;
            strMsg=@"Do you want to unfollow this Merchant ?";
            okMsg=@"Yes";
            no=@"No";
            if (appDelObj.isArabic) {
                strMsg=@"هل تريد إلغاء متابعة هذا التاجر؟";
                okMsg=@" موافق";
                no=@"لا";
            }
            UIAlertController * alert=[UIAlertController
                                       alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
            UIAlertAction* yesButton = [UIAlertAction
                                        actionWithTitle:okMsg
                                        style:UIAlertActionStyleDefault
                                        handler:^(UIAlertAction * action)
                                        {
                                            filter=@"favMer";
                                            if (appDelObj.isArabic)
                                            {
                                                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                                            }
                                            else
                                            {
                                                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                                            }
                                            NSString *urlStr;
                                            NSMutableDictionary *dicPost;
                                            urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/user/following/languageID/",appDelObj.languageId];
                                            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",@"unfollow",@"action",self.businessID,@"businessID", nil];
                                            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                                        }];
            UIAlertAction* noButton = [UIAlertAction
                                       actionWithTitle:no
                                       style:UIAlertActionStyleDefault
                                       handler:^(UIAlertAction * action)
                                       {
                                           [self dismissViewControllerAnimated:YES completion:nil];
                                       }];
            [alert addAction:yesButton];
            [alert addAction:noButton];
            [self presentViewController:alert animated:YES completion:nil];
        }
    }
}
- (IBAction)merchantMailAction:(id)sender {
}
@end
