//
//  ListDetailViewController.m
//  Favol
//
//  Created by Remya Das on 10/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "ListDetailViewController.h"
#define ACCEPTABLE_CHARACTERS @" +0123456789"

@interface ListDetailViewController ()<passDataAfterParsing,UITableViewDelegate,UITableViewDataSource,ReviewDelegate,combinationDelegate,InformationDelegates,BEMAnalogClockDelegate,UIGestureRecognizerDelegate,UIDocumentPickerDelegate,viewSililarAllDelegate,DetailDelegate,OptionsDelegate,UIPickerViewDelegate,UIPickerViewDataSource,UITextFieldDelegate,SubDetailDelegate,FavHomeDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate,BuyBoxDelegate>
{
    AppDelegate *appDelObj;
     CATransition * transition;
    double outStock; NSString*fileName,*presNeed,*subName,*subID,*selSubOptionName,*selSubOptID,*subscribeStr,*deliveriesvalue,*selSubscriptionname,*subscribe,*subscribeORnot,*enableReview,*redirection,*freeProductAvl,*freeProductID,*addFreeProductorNot,*fName,*freeImage,*freeOptID,*freeOptName,*CombPrice,*combPriceDiff,*comSKU,*startTime,*endTime;
    UIImage *imagePro;
    UIImageView *imgSel;
    int rmvWish,rowSub,optionSelectForimage,tierSelInd,freecount;;
    NSMutableArray *DetailListAryData,*relatedItem,*allAttributeArray,*customOption,*optionsArray,*availableShipMethods,*DescriptionArray,*reviewArray,*sellerArray,*mutipleImagesArray,*colArray,*combinationSelectArray,*includeCombinationArray,*multiSelVarientAry,*excludeComAry,*freeProductsAry;
    NSArray *attributesGroupWise,*resDealReviewDetails,*keyArray,*combinationsArray,*encodedCombinations,*varientsArray,*tierArray,*subscriptions,*subscriptionDetail,*substituteMedArray,*stateArray,*multipleImage,*freeProducts,*freeProductOption,*freeProductCombination,*specificationArray;
    WebService *webServiceObj;
    NSString *loginorNot,*fav,*productOptionID,*chooseOption,*combinationHash,*imgUrl,*businessurl,*addtoCart,*filecustoptID,*customOptionFile,*customOptionVariantID,*CID,*SID,*sName,*cName;
    NSMutableIndexSet *optionSelect,*desSelRow,*varientSelect,*tierSel,*subSelIndex,*selectMultiSelectvariant;
    int index,textfield,minQty,maxQty;
    CusOptCell *cell;
    NSIndexPath *indexPathCusOpt;
    UIPickerView *picker,*picker1,*picker2;
    UIToolbar *toolBar;
    int rowSelectedPic,alreadyReview;
    float heghtDes,price,optprice;
    NSMutableArray * cellsArray;
    NSMutableData *responseData;
}
@end

@implementation ListDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     self.weee.scrollView.scrollEnabled=NO;
    optionSelectForimage=0;
    outStock=1;
    cellsArray = [NSMutableArray new];
    responseData=[[NSMutableData alloc]init];
    redirection=@"";
    fav=@"";
    rowSub=-1;
    textfield=1;
    addtoCart=@"";rmvWish=0;
    selSubscriptionname=@"onetime";
    subscribeORnot=@"";
    enableReview=@"";
    customOptionFile=customOptionVariantID=@"";
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    self.sellerTop.backgroundColor=appDelObj.headderColor;
    //self.view.backgroundColor=[UIColor colorWithRed:0.953 green:0.945 blue:0.949 alpha:1.00];
    imgSel=[[UIImageView alloc]init];
    allAttributeArray=[[NSMutableArray alloc]init];
    availableShipMethods=[[NSMutableArray alloc]init];
    reviewArray=[[NSMutableArray alloc]init];
    DescriptionArray=[[NSMutableArray alloc]init];
    customOption=[[NSMutableArray alloc]init];
    optionsArray=[[NSMutableArray alloc]init];
    colArray=[[NSMutableArray alloc]init];
    mutipleImagesArray=[[NSMutableArray alloc]init];
    sellerArray=[[NSMutableArray alloc]init];
    self.btnBuyNow.backgroundColor=appDelObj.BlueColor;
    self.btnAddtoCart.clipsToBounds=YES;
    self.btnAddtoCart.layer.borderWidth=0.5;
    self.btnAddtoCart.layer.borderColor=[[UIColor colorWithRed:0.906 green:0.906 blue:0.906 alpha:1.00]CGColor];
    DetailListAryData=relatedItem=[[NSMutableArray alloc]init];
    multiSelVarientAry=[[NSMutableArray alloc]init];
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    self.consultView.clipsToBounds=YES;
    self.consultView.layer.cornerRadius=2;
    // NSString *sname=self.productName;
    //self.lblTitle.textColor=appDelObj.textColor;
   // [[self.btnSuscribeData layer] setBorderColor:[appDelObj.BlueColor CGColor]];
    self.tblSubscription.clipsToBounds=YES;
    self.tblSubscription.layer.borderWidth=1;
    self.tblSubscription.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    
    self.subscribeView.clipsToBounds=YES;
    self.subscribeView.layer.borderWidth=1;
    self.subscribeView.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];

    self.tblDescription.clipsToBounds=YES;
    self.tblDescription.layer.borderWidth=1;
    self.tblDescription.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    
    self.txtCheckdelivery.clipsToBounds=YES;
    self.txtCheckdelivery.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    self.txtCheckdelivery.layer.borderWidth=1;
    optionSelect=[[NSMutableIndexSet alloc]init];
    self.shippingView.clipsToBounds=YES;
    self.shippingView.layer.borderWidth=1;
    self.shippingView.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    self.dealView.clipsToBounds=YES;
    self.dealView.layer.borderWidth=1;
    self.dealView.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    self.priceView.clipsToBounds=YES;
    self.priceView.layer.borderWidth=1;
    self.priceView.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
   
    desSelRow=[[NSMutableIndexSet alloc]init];
    subSelIndex=[[NSMutableIndexSet alloc]init];
    tierSel=[[NSMutableIndexSet alloc]init];
    varientSelect=[[NSMutableIndexSet alloc]init];
    selectMultiSelectvariant=[[NSMutableIndexSet alloc]init];
    self.btnFavMer.clipsToBounds=YES;
    self.btnFavMer.layer.borderWidth=1;
    self.btnFavMer.layer.borderColor=[[UIColor redColor]CGColor];
    self.viewStore.clipsToBounds=YES;
    self.viewStore.layer.borderWidth=1;
    self.viewStore.layer.borderColor=[[UIColor colorWithRed:0.886 green:0.886 blue:0.886 alpha:1.00]CGColor];
    self.AllSellerView.clipsToBounds=YES;
    self.AllSellerView.layer.borderWidth=1;
    self.AllSellerView.layer.borderColor=[[UIColor colorWithRed:0.886 green:0.886 blue:0.886 alpha:1.00]CGColor];
    if (appDelObj.isArabic==YES)
    {

         self.view.transform = CGAffineTransformMakeScale(-1, 1);

        self.lblName.transform = CGAffineTransformMakeScale(-1, 1);

         self.lblCOD.transform = CGAffineTransformMakeScale(-1, 1);
         self.lblCashOnDeli.transform = CGAffineTransformMakeScale(-1, 1);
         self.lblReturnPolicy.transform = CGAffineTransformMakeScale(-1, 1);
         self.lblShipping.transform = CGAffineTransformMakeScale(-1, 1);
         self.lblJihazhiDeli.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblhot.transform = CGAffineTransformMakeScale(-1, 1);
         self.lblShortDes.transform = CGAffineTransformMakeScale(-1, 1);
        self.weee.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblhot.text=@"مميز";
          self.lblQtySelected.transform = CGAffineTransformMakeScale(-1, 1);
          self.lblAvalGiftsLabel.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblCartCount.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblBusinessName1.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblRateper.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblCodAvlNot.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblchoose.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblNameFree.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblBusinessFree.transform = CGAffineTransformMakeScale(-1, 1);
        self.selfreeCount.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblAllSellers.transform = CGAffineTransformMakeScale(-1, 1);

        self.lblprice.transform =self.lblBottomPrice.transform= CGAffineTransformMakeScale(-1, 1);
        self.lblofferbottom.transform=self.lblOffer.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblqtyLabel.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblDailyDeal.transform = CGAffineTransformMakeScale(-1, 1);

        self.dealTime.transform = CGAffineTransformMakeScale(-1, 1);

        self.lblcheck.transform = CGAffineTransformMakeScale(-1, 1);
        self.txtCheckdelivery.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnCheck.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnAddtoCart.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnallstore.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblOut.transform = CGAffineTransformMakeScale(-1, 1);

        self.btnFavMer.transform = CGAffineTransformMakeScale(-1, 1);
        self.btnAskMerchant.transform = CGAffineTransformMakeScale(-1, 1);
        [self.btnAskMerchant setTitle:@" اسأل البائع ؟ " forState:UIControlStateNormal];

        [self.btnFavMer setTitle:@"فاف التاجر" forState:UIControlStateNormal];
        self.lblSoldBy.transform = CGAffineTransformMakeScale(-1, 1);
        [self.btnallstore setTitle:@"عرض جميع المنتجات" forState:UIControlStateNormal];
        self.lblDailyDeal.text=@"العروض ";
        self.lblOut.text=@"غير متوفر";
        self.lblSoldBy.text=@"البائع :";
        [self.btnAddtoCart setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        self.lblqtyLabel.text=@"الكمية";
        self.lblAvalGiftsLabel.text=@"الهدايا المتاحة";
        self.lblAllSellers.text=@"الباعة";
        self.lblcheck.text=@"تحقق من خيار التسليم";
        //self.lblprice.transform = CGAffineTransformMakeScale(-1, 1);
        [self.btnCheck setTitle:@"التحقق من" forState:UIControlStateNormal];
        self.txtCheckdelivery.placeholder=@"أدخل الكود الشخصي التعريفي";
        self.lblreturnTitlelbl.text=@"مستردة";
        self.lblRewards.text=@"المكافآت";
        self.lblEarn.text=@"كسب";
        self.lblDailyDeal.textAlignment=NSTextAlignmentRight;
        self.dealTime.textAlignment=NSTextAlignmentRight;
        self.lblSoldBy.textAlignment=NSTextAlignmentRight;
        self.lblBusinessName1.textAlignment=NSTextAlignmentRight;
        self.lblAvalGiftsLabel.textAlignment=NSTextAlignmentRight;
        self.lblRateper.textAlignment=NSTextAlignmentRight;
        self.lblCodAvlNot.textAlignment=NSTextAlignmentRight;
        self.lblchoose.textAlignment=NSTextAlignmentRight;
        self.lblBusinessFree.textAlignment=NSTextAlignmentRight;
        self.lblNameFree.textAlignment=NSTextAlignmentRight;
        self.lblCodAvlNot.textAlignment=NSTextAlignmentRight;
        self.selfreeCount.textAlignment=NSTextAlignmentRight;
       // self.lblofferbottom.textAlignment=NSTextAlignmentRight;
        //self.lblBottomPrice.textAlignment=NSTextAlignmentRight;
        self.lblcheck.textAlignment=NSTextAlignmentRight;
        self.txtCheckdelivery.textAlignment=NSTextAlignmentRight;
        self.lblCOD.textAlignment=NSTextAlignmentRight;
        self.lblCashOnDeli.textAlignment=NSTextAlignmentRight;
        self.lblReturnPolicy.textAlignment=NSTextAlignmentRight;
        self.lblShipping.textAlignment=NSTextAlignmentRight;
        self.lblJihazhiDeli.textAlignment=NSTextAlignmentRight;
        self.lblAllSellers.textAlignment=NSTextAlignmentRight;
self.lblShortDes.textAlignment=NSTextAlignmentRight;
        
        self.lblchoose.text=@"اختيار المنتج الخاص بك هدية مجانية";
//        self.tblOptions.transform = CGAffineTransformMakeScale(-1, 1);
//        self.tblCustomoptions.transform = CGAffineTransformMakeScale(-1, 1);
//        self.tblDescription.transform = CGAffineTransformMakeScale(-1, 1);
//        self.tblReview.transform = CGAffineTransformMakeScale(-1, 1);
//        self.tblRelated.transform = CGAffineTransformMakeScale(-1, 1);
//        self.tblVarients.transform = CGAffineTransformMakeScale(-1, 1);
        self.lblCOD.text=@"خدمة الدفع عند الإستلام متوفرة";
        self.lblCashOnDeli.text=@"الدفع عند الاستلام";
        self.lblReturnPolicy.text=@"10 أيام للاستفادة من سياسة الارجاع ";
        self.lblShipping.text=@"الشحن";
        self.lblJihazhiDeli.text=@"قيمة التوصيل من جهازي كوم (جميع المدن عدا الرياض) 25 ريال  ";
        self.lblSellerTitle.text=@"جميع البائعين";
    }
    else
    {
        
    }
    self.tblOptionsView.frame=CGRectMake(self.tblOptionsView.frame.origin.x, self.tblOptionsView.frame.origin.y, self.tblOptionsView.frame.size.width, self.tblOptionsView.frame.size.height);
    loginorNot=@"";
    self.imgItem.center = self.imgItem.center;
    self.lblCartCount.clipsToBounds=YES;
    self.lblCartCount.layer.cornerRadius=self.lblCartCount.frame.size.height/2;
    self.lblCartCount.backgroundColor=appDelObj.cartBg;
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
    
    
    
    self.tblImages.rowHeight = 300;
    self.tblImages.transform=CGAffineTransformMakeRotation(-M_PI/2);
    self.tblImages.showsVerticalScrollIndicator = NO;
    self.tblImages.frame = CGRectMake(0, 5, self.view.frame.size.width, self.tblImages.frame.size.height);
    [self.tblImages setBackgroundColor:[UIColor clearColor]];
    self.tblImages.pagingEnabled = YES;
    CGRect frame = self.tblImages.tableHeaderView.frame;
    frame.size.height = 1;
    UIView *headerView = [[UIView alloc] initWithFrame:frame];
    [self.tblImages setTableHeaderView:headerView];
    
    self.txtSelSubscription.clipsToBounds=YES;
    self.txtSelSubscription.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    self.txtSelSubscription.layer.borderWidth=1;
    self.txtCheckdelivery.clipsToBounds=YES;
    self.txtCheckdelivery.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
    self.txtCheckdelivery.layer.borderWidth=0.5;
////    UIImageView *envelopeView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 5, 20, 20)];
////    envelopeView.image = [UIImage imageNamed:@"down_arrowpromocode.png"];
////    envelopeView.contentMode = UIViewContentModeScaleAspectFit;
////    UIView *test=  [[UIView alloc]initWithFrame:CGRectMake(20, 0, 30, 30)];
////    [test addSubview:envelopeView];
////    [self.txtSelSubscription.rightView setFrame:envelopeView.frame];
////    self.txtSelSubscription.rightView =test;
////    self.txtSelSubscription.rightViewMode = UITextFieldViewModeAlways;
//    picker1 = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
//    picker1.delegate=self;
//    picker1.dataSource=self;
//    [self.txtSelSubscription setInputView:picker1];
//    UIToolbar *toolBar=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//    [toolBar setTintColor:appDelObj.redColor];
//    UIBarButtonItem *doneBtn;
//    if (appDelObj.isArabic) {
//        toolBar.transform = CGAffineTransformMakeScale(-1, 1);
//        picker1.transform = CGAffineTransformMakeScale(-1, 1);
//        doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"فعله" style:UIBarButtonItemStyleDone target:self action:@selector(chooseDataFromPic)];
//    }
//    else
//    {
//        doneBtn=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(chooseDataFromPic)];
//    }UIBarButtonItem *space=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    [toolBar setItems:[NSArray arrayWithObjects:space,doneBtn, nil]];
//    [self.txtSelSubscription setInputAccessoryView:toolBar];
//
//    picker2 = [[UIPickerView alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 220)];
//    picker2.delegate=self;
//    picker2.dataSource=self;
//    [self.txtCountryCoun setInputView:picker2];
//    [self.txtregionCon setInputView:picker2];
//    UIToolbar *toolBar1=[[UIToolbar alloc]initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
//    [toolBar1 setTintColor:appDelObj.redColor];
//    UIBarButtonItem *doneBtn1;
//    if (appDelObj.isArabic) {
//        toolBar1.transform = CGAffineTransformMakeScale(-1, 1);
//        picker2.transform = CGAffineTransformMakeScale(-1, 1);
//        doneBtn1=[[UIBarButtonItem alloc]initWithTitle:@"فعله" style:UIBarButtonItemStyleDone target:self action:@selector(chooseData1)];
//    }
//    else
//    {
//        doneBtn1=[[UIBarButtonItem alloc]initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(chooseData1)];
//    }
//    UIBarButtonItem *space1=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
//    [toolBar1 setItems:[NSArray arrayWithObjects:space1,doneBtn1, nil]];
//    [self.txtCountryCoun setInputAccessoryView:toolBar1];
//    [self.txtregionCon setInputAccessoryView:toolBar1];
//
//
//    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@"Full Name*"];
//
//    [string beginEditing];
//    [string addAttribute:NSForegroundColorAttributeName
//                   value:[UIColor redColor]  range:NSMakeRange(string.length-1, 1)];
//
//    [string endEditing];
//
//    [self.txtNameCoun setAttributedPlaceholder:string floatingTitle:@"Full Name"];
//    NSMutableAttributedString *stringL = [[NSMutableAttributedString alloc] initWithString:@"Full Address*"];
//
//    [stringL beginEditing];
//    [stringL addAttribute:NSForegroundColorAttributeName
//                    value:[UIColor redColor]  range:NSMakeRange(stringL.length-1, 1)];
//
//    [stringL endEditing];
//
//    [self.txtFullAddrCoun setAttributedPlaceholder:stringL floatingTitle:@"Full Address"];
//
//    NSMutableAttributedString *stringA = [[NSMutableAttributedString alloc] initWithString:@"Country*"];
//
//    [stringA beginEditing];
//    [stringA addAttribute:NSForegroundColorAttributeName
//                    value:[UIColor redColor]  range:NSMakeRange(stringA.length-1, 1)];
//
//    [stringA endEditing];
//
//    [self.txtCountryCoun setAttributedPlaceholder:stringA floatingTitle:@"Country"];
//
//    NSMutableAttributedString *stringS = [[NSMutableAttributedString alloc] initWithString:@"State*"];
//
//    [stringS beginEditing];
//    [stringS addAttribute:NSForegroundColorAttributeName
//                    value:[UIColor redColor]  range:NSMakeRange(stringS.length-1, 1)];
//
//    [stringS endEditing];
//
//    [self.txtregionCon setAttributedPlaceholder:stringS floatingTitle:@"State"];
//    NSMutableAttributedString *stringP = [[NSMutableAttributedString alloc] initWithString:@"EmailID*"];
//
//    [stringP beginEditing];
//    [stringP addAttribute:NSForegroundColorAttributeName
//                    value:[UIColor redColor]  range:NSMakeRange(stringP.length-1, 1)];
//
//    [stringP endEditing];
//
//    [self.txtPinCoun setAttributedPlaceholder:stringP floatingTitle:@"EmailID"];
//    NSMutableAttributedString *stringPH = [[NSMutableAttributedString alloc] initWithString:@"Phone Number*"];
//
//    [stringPH beginEditing];
//    [stringPH addAttribute:NSForegroundColorAttributeName
//                     value:[UIColor redColor]  range:NSMakeRange(stringPH.length-1, 1)];
//
//    [stringPH endEditing];
//
//    [self.txtPhoneCoun setAttributedPlaceholder:stringPH floatingTitle:@"Phone Number"];
//
//    self.txtNameCoun.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_NAME"];
//    excludeComAry=[[NSMutableArray alloc]init];
//
     [_colFree registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    [_colFreeLarge registerNib:[UINib nibWithNibName:@"ItemCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
    self.freeView1.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.freeView1.layer.borderWidth = 1.0f;
    self.freeView2.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.freeView2.layer.borderWidth = 1.0f;
    if ([appDelObj.dealBundle isEqualToString:@"Yes"]) {
        self.dealView.alpha=1;
        self.priceView.frame=CGRectMake(self.priceView.frame.origin.x, self.dealView.frame.origin.y+self.dealView.frame.size.height+5, self.priceView.frame.size.width, self.priceView.frame.size.height);
    }
    else
    {
        self.dealView.alpha=0;
        self.priceView.frame=CGRectMake(self.priceView.frame.origin.x, self.dealView.frame.origin.y, self.priceView.frame.size.width, self.priceView.frame.size.height);
    }
     [self getDataFromService];
}
-(BOOL)textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    return YES;
}
-(void)chooseDataFromPic
{
    [self.txtSelSubscription resignFirstResponder];
    if (subName.length==0)
    {
        self.txtSelSubscription.text=[NSString stringWithFormat:@" %@",[[subscriptions objectAtIndex:0]valueForKey:@"subscriptionName"]];

    }
    if (rowSub>subscriptions.count-1)
    {
        rowSub=0;
        self.txtSelSubscription.text=[NSString stringWithFormat:@" %@",[[subscriptions objectAtIndex:rowSub]valueForKey:@"subscriptionName"]];
        subID=[[subscriptions objectAtIndex:rowSub]valueForKey:@"subcriptionTypeId"];

    }
    subscriptionDetail=[[subscriptions objectAtIndex:rowSub]valueForKey:@"durations"];
    [self.tblSubscription reloadData];
    self.tblSubscription.alpha=1;

    self.tblSubscription.frame=CGRectMake(self.tblSubscription.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height, self.tblSubscription.frame.size.width, 40*subscriptionDetail.count);
//    self.btnSuscribeData.frame=CGRectMake(self.btnSuscribeData.frame.origin.x, self.tblSubscription.frame.origin.y+self.tblSubscription.frame.size.height+1, self.btnSuscribeData.frame.size.width, self.btnSuscribeData.frame.size.height);
// self.btnSuscribeData.alpha=1;
    
    self.checkDeliveryView.frame=CGRectMake(self.checkDeliveryView.frame.origin.x, self.tblSubscription.frame.origin.y+self.tblSubscription.frame.size.height+1, self.checkDeliveryView.frame.size.width, self.checkDeliveryView.frame.size.height);
    if (substituteMedArray.count==0)
    {
        self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height-1, self.tblSubstituteMedicine.frame.size.width, 0);
        self.tblSubstituteMedicine.alpha=0;
    }
    else{
        self.tblSubstituteMedicine.alpha=1;
        self.tblSubstituteMedicine.alpha=1;
        if (substituteMedArray.count<=3)
        {
            self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*substituteMedArray.count)+32);
        }
        else
        {
            self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*3)+92);
            
        }    }
    
    self.tblDescription.frame=CGRectMake(self.tblDescription.frame.origin.x, self.tblSubstituteMedicine.frame.origin.y+self.tblSubstituteMedicine.frame.size.height+10, self.tblDescription.frame.size.width, heghtDes);    self.AllSellerView.alpha=0; self.AllSellerView.frame=CGRectMake(self.AllSellerView.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height, self.AllSellerView.frame.size.width, 0);
    if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"]){
        self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+5, self.tblReview.frame.size.width, 50);
        
    }
    else if ( [reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0){
        self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width, 0);
        
    }
    else{
        
    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width, 280+(142*reviewArray.count));
    }
    self.tblRelated.frame=CGRectMake(self.tblRelated.frame.origin.x, self.tblReview.frame.origin.y+self.tblReview.frame.size.height+10, self.tblRelated.frame.size.width, 308*relatedItem.count);
    self.scrollViewObj.contentSize=CGSizeMake(0, self.tblRelated.frame.origin.y+self.tblRelated.frame.size.height);
     deliveriesvalue=@"";
    
}
-(void)viewWillAppear:(BOOL)animated
{
     self.navigationController.navigationBarHidden=YES;
    freeProductID=@"";
    freeProductAvl=@"No";
    freecount=0;
    freeProductsAry=[[NSMutableArray alloc]init];
    [[NSUserDefaults standardUserDefaults]setObject:@"Home" forKey:@"Where"];
    [[NSUserDefaults standardUserDefaults]synchronize];
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
    if (rmvWish==1)
    {
         rmvWish=0;
        [self getDataFromService];
    }

}
-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
    
}
-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (pickerView==picker1) {
        return subscriptions.count;
    }
    else if (pickerView==picker2) {
        return stateArray.count;
    }
    return maxQty-minQty+1;
    
}
-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    if (pickerView==picker1) {
        return [[subscriptions objectAtIndex:row]valueForKey:@"subscriptionName"];
    }
    else if (pickerView==picker2)
    {
        NSString *str;
        if (textfield==1)
        {
            if ([[[stateArray objectAtIndex:row]valueForKey:@"countryName"] isKindOfClass:[NSNull class]])
            {
                str=@"nil";
            }
            else
            {
                str=[[stateArray objectAtIndex:row]valueForKey:@"countryName"];
            }
        }
        else
        {
            if ([[[stateArray objectAtIndex:row]valueForKey:@"stateName"] isKindOfClass:[NSNull class]])
            {
                str=@"nil";
            }
            else
            {
                str=[[stateArray objectAtIndex:row]valueForKey:@"stateName"];
            }
        }
       return str;
    }
    NSString *str;
//    if (row==0) {
//        return str= [NSString stringWithFormat:@"%d",minQty];
//    }
//    else
//    {
        return str= [NSString stringWithFormat:@"%d",minQty+row];
    //}
   
    return str;
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    if (pickerView==picker1) {
        NSString *str=[[subscriptions objectAtIndex:row]valueForKey:@"subscriptionName"];
        if (str.length!=0)
        {
            subName=[[subscriptions objectAtIndex:row]valueForKey:@"subscriptionName"];
            subID=[[subscriptions objectAtIndex:row]valueForKey:@"subcriptionTypeId"];
            
            rowSub=(int)row;
        }
        
    }
    else if (pickerView==picker2)
    {
        if (textfield==1)
        {
            CID=[[stateArray objectAtIndex:row]valueForKey:@"countryID"];
            cName  =[[stateArray objectAtIndex:row]valueForKey:@"countryName"];
        }
        else
        {
            SID=[[stateArray objectAtIndex:row]valueForKey:@"stateID"];
            sName  =[[stateArray objectAtIndex:row]valueForKey:@"stateName"];
        }
    }
    else
    {
        rowSelectedPic=minQty+(int)row;
    }
}
-(void)chooseData
{
    if (rowSelectedPic<=0)
    {
        rowSelectedPic=minQty;
    }
    int productQty=[[DetailListAryData valueForKey:@"productOptionQuantity"]intValue];
    int productOptQty=[[DetailListAryData valueForKey:@"productQuantityUnlimited"]intValue];
    int stock=productQty+productOptQty;
    if (stock<1) {
        NSString *str=@"Stock not available";
        NSString *ok=@"Ok";
        if (appDelObj.isArabic) {
            str=@"المخزون غير متوفر";
            ok=@" موافق ";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
    self.lblQtySelected.text=[NSString stringWithFormat:@"%d",rowSelectedPic];
    int xp=rowSelectedPic;
    
    float x=[[DetailListAryData  valueForKey:@"offerPrice"] floatValue];
    float p=x*xp;
    price=p;
    self.hidePrice.text=[NSString stringWithFormat:@"%.2f",p];
    NSString *s3=[NSString stringWithFormat:@"%.02f",p] ;
    float x1=[[DetailListAryData  valueForKey:@"productOptionRegularPrice"] floatValue];
    optprice=x1;
    NSString *s1=[NSString stringWithFormat:@"%.02f",x1] ;
 NSString *p1=s1;
    NSString *p2=s3;
    if ([p1 isEqualToString:p2])
    {
        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",p1],appDelObj.currencySymbol]];
        if (appDelObj.isArabic) {
            price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",p1],appDelObj.currencySymbol]];
        }
        if (appDelObj.isArabic) {
            [price addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [price length])];
        }
        [price addAttribute:NSForegroundColorAttributeName value:appDelObj.priceColor                               range:NSMakeRange(0, [price length])];
        self.lblprice.attributedText=price;
        
        self.lblBottomPrice.attributedText=price;
        self.lblBottomPrice.textColor=[UIColor redColor];
    }
    else{
    NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
        if (appDelObj.isArabic) {
            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
        }
        
        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]                                                    initWithAttributedString:str];
      
        [string addAttribute:NSForegroundColorAttributeName value:appDelObj.priceOffer                               range:NSMakeRange(0, [string length])];
     

        [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]                               range:NSMakeRange(0, [string length])];
        if (appDelObj.isArabic) {
            [string addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [string length])];
        }
        [string addAttribute:NSStrikethroughStyleAttributeName value:@2                               range:NSMakeRange(0, [string length])];
        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
        if (appDelObj.isArabic) {
            price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
        }
        [price addAttribute:NSForegroundColorAttributeName   value:appDelObj.priceColor                              range:NSMakeRange(0, [price length])];
        [price addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]                              range:NSMakeRange(0, [price length])];
        if (appDelObj.isArabic) {
            [price addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [price length])];
        }
        [price appendAttributedString:string];
        self.lblprice.attributedText=price;
        self.lblprice.textAlignment=NSTextAlignmentCenter;
        NSMutableAttributedString *stringBottom=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
        [stringBottom addAttribute:NSForegroundColorAttributeName   value:[UIColor redColor]                              range:NSMakeRange(0, [stringBottom length])];
[stringBottom appendAttributedString:string];
        self.lblBottomPrice.attributedText=price;
        //self.lblBottomPrice.textAlignment=NSTextAlignmentCenter;
        
    self.lblBottomPrice.attributedText=stringBottom;
self.lblprice.attributedText=price;
    
    }
    [UIView animateWithDuration:.5 animations:^{picker.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 220);
        toolBar.frame=CGRectMake(0, self.view.frame.size.height, self.view.frame.size.width, 44);}];
    }
    
}
-(void)getDataFromService
{
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    [optionSelect removeAllIndexes];
    [desSelRow removeAllIndexes];
    allAttributeArray=customOption=[[NSMutableArray alloc]init];
productOptionID=@"";
    chooseOption=@"";
    fav=@"";
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/productDetails/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.productID,@"productID",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];

    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
-(void)timeDelay
{
    
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
    NSLog(@"%@",dictionary);
      self.navigationController.navigationBarHidden=YES;
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        NSString *msg;
        NSString *sss=[dictionary objectForKey:@"errorMsg"];
        if ([[dictionary objectForKey:@"errorMsg"]isKindOfClass: [NSNull class]]||sss.length==0) {
            msg=@"nothing";
        }
        else
        {
            msg=[dictionary objectForKey:@"errorMsg"];
        }
        if ([msg isEqualToString:@"Item Exists"])
            
        {
                               loginorNot=@"login";
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
                    urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/updateQuantity/languageID/",appDelObj.languageId];
            NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
            if (userID.length==0) {
                userID=@"";
            }
                    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",[DetailListAryData valueForKey:@"productID"],@"productID",[DetailListAryData valueForKey:@"productOptionID"],@"productOptionID",self.lblQtySelected.text,@"quantity",@"",@"dealDefaultCurrency",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
                        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        else
        {
            if ([loginorNot isEqualToString:@"login"])
            {
                NSLog(@"%@",dictionary);
                if ([addtoCart isEqualToString:@"AddCart"])
                {
                    NSString *sname=[DetailListAryData  valueForKey:@"productTitle"];
                    NSString *strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    NSString *cart,*ok,*str;
                    if (appDelObj.isArabic) {
                        cart=@"عرض العربة";
                        ok=@" موافق ";
                        str=[NSString stringWithFormat:@"تم إضافة المنتج إلى عربة التسوق"];
                        
                    }
                    else
                    {
                        cart=@"View Cart";
                        ok=@"Ok";
                        str=[NSString stringWithFormat:@"Successsfully added to cart"];
                    }
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"] forKey:@"cartID" ];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        NSArray* cartAry=[[dictionary objectForKey:@"result"]objectForKey:@"items"];
                        if (cartAry.count!=0)
                        {
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
                        }
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
                        
                        if ([freeProducts isKindOfClass:[NSNull class]]||freeProducts.count==0)
                        {
                            if ([redirection isEqualToString:@"Yes"]||[redirection isEqualToString:@"yes"])
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
                                    [self.navigationController pushViewController:cart animated:NO];
                                }
                            }
                            else{
                              //  [self backAction:nil];
                            }
                        }
                        else
                        {
                            if(appDelObj.isArabic==YES )
                            {
                                SubstituteViewController *listDetail=[[SubstituteViewController alloc]init];
                                listDetail.from=@"Detail";
                                listDetail.pid=[DetailListAryData   valueForKey:@"productID"] ;
                                listDetail.PRODUCTID=[DetailListAryData   valueForKey:@"productID"] ;

                                listDetail.pname=[DetailListAryData    valueForKey:@"productTitle"] ;
                                listDetail.pimg=[DetailListAryData    valueForKey:@"productImage"] ;
                                listDetail.pseller=[DetailListAryData    valueForKey:@"businessName"] ;
                                listDetail.freecount=[NSString stringWithFormat:@"%@",[DetailListAryData    valueForKey:@"freeProductsCount"] ];
                                listDetail.dedCount=[NSString stringWithFormat:@"%@",[DetailListAryData    valueForKey:@"totAddedFreeGifts"] ];
                                listDetail.optID=productOptionID;
                                listDetail.imgUrl=imgUrl;
                                listDetail.arrayFree=freeProducts;
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
                                listDetail.pid=[DetailListAryData   valueForKey:@"productID"] ;
                                listDetail.pname=[DetailListAryData    valueForKey:@"productTitle"] ;
                                listDetail.pimg=[DetailListAryData    valueForKey:@"productImage"] ;
                                listDetail.pseller=[DetailListAryData    valueForKey:@"businessName"] ;
                                listDetail.freecount=[NSString stringWithFormat:@"%@",[DetailListAryData    valueForKey:@"freeProductsCount"] ];
                                listDetail.dedCount=[NSString stringWithFormat:@"%@",[DetailListAryData    valueForKey:@"totAddedFreeGifts"] ];
                                listDetail.PRODUCTID=[DetailListAryData   valueForKey:@"productID"] ;

                                listDetail.optID=productOptionID;
                                listDetail.from=@"Detail";

                                listDetail.imgUrl=imgUrl;
                                listDetail.arrayFree=freeProducts;
                                [self.navigationController pushViewController:listDetail animated:YES];
                            }
                        }
                       
                        
                        
                        [Loading dismiss];}]];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                else if ([addtoCart isEqualToString:@"AddCartFreeProduct"])
                {
                    NSString *sname=fName;
                    NSString *strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    NSString *cart,*ok,*str;
                    if (appDelObj.isArabic) {
                        cart=@"عرض العربة";
                        ok=@" موافق ";
                        str=[NSString stringWithFormat:@"تم إضافة المنتج إلى عربة التسوق"];
                        
                    }
                    else
                    {
                        cart=@"View Cart";
                        ok=@"Ok";
                        str=[NSString stringWithFormat:@"Successsfully added to cart"];
                    }
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:cart style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"] forKey:@"cartID" ];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        NSArray* cartAry=[[dictionary objectForKey:@"result"]objectForKey:@"items"];
                        if (cartAry.count!=0)
                        {
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
                        }
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
                        
                        [self closeFree:nil];
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
                                [self.navigationController pushViewController:cart animated:NO];
                            }
                        
                        
                        
                        [Loading dismiss];}]];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Continue Shopping" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"] forKey:@"cartID" ];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        NSArray* cartAry=[[dictionary objectForKey:@"result"]objectForKey:@"items"];
                        if (cartAry.count!=0)
                        {
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
                        }
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
                        
                        if (freecount==freeProductsAry.count) {
                            [self backAction:nil];
                        }
                        else
                        {
                            
                        }
                        
                        
                        
                        [Loading dismiss];}]];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                else if ([fav isEqualToString:@"Consult"])
                {
                    NSString *ok=@"Ok";
                    if (appDelObj.isArabic) {
                       
                        ok=@" موافق ";
                       
                        
                    }
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    NSString *sname=[DetailListAryData  valueForKey:@"productTitle"];
                    NSString *strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    NSString *ok=@"Ok";
                    if (appDelObj.isArabic) {
                       
                        ok=@" موافق ";
                       
                    }
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@ successfully subscribed.",strname] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[[NSUserDefaults standardUserDefaults]setObject:[[dictionary objectForKey:@"result"]objectForKey:@"cartID"] forKey:@"cartID" ];
                        [[NSUserDefaults standardUserDefaults]synchronize];
                        if ([redirection isEqualToString:@"Yes"]||[redirection isEqualToString:@"yes"])
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
                                [self.navigationController pushViewController:cart animated:NO];
                            }
                        }
                        else{
                           // [self backAction:nil];
                        }
                        
                       
                        [Loading dismiss];}]];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
            }
            else
            {
                NSString *ok=@"Ok";
                if (appDelObj.isArabic) {
                    ok=@" موافق ";
                }
                if ([fav isEqualToString:@"fav"])
                {
                   
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else if ([fav isEqualToString:@"Merchant"])
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else if ([fav isEqualToString:@"UploadFile"])
                {
                    NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:indexPathCusOpt.section];
                    CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                    cell.txtDay.text=[[dictionary objectForKey:@"result"]objectForKey:@"customOptionFile"];
                    [Loading dismiss];
                }
                else if ([fav isEqualToString:@"Delivery"])
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else if ([fav isEqualToString:@"Consult"])
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else if ([fav isEqualToString:@"ApplyCombination"])
                {
                    NSString *strImgUrl=[[[dictionary  objectForKey:@"productCustomImages"]objectAtIndex:0] valueForKey:@"productImage"] ;
                    if(strImgUrl.length==0)
                    {
                    }
                    else
                    {
                        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
                        NSString *urlIMG;
                        if([s isEqualToString:@"http"])
                        {
                            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
                        }
                        else
                        {
                            urlIMG=[NSString stringWithFormat:@"%@%@",appDelObj.ImgURL,strImgUrl];
                        }
                
                       
                        if (appDelObj.isArabic) {
                            [self.imgItem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                            [self.imgFree sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                        } else {
                            [self.imgItem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                            [self.imgFree sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                        }

                    }
                }
                else
                {
                    float height=0;
                    redirection=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"redirect_to_cart_page_on_add_to_cart_click"]];
                    alreadyReview=[[[dictionary objectForKey:@"result"]objectForKey:@"revCnt"]intValue];
                    DetailListAryData=[dictionary objectForKey:@"result"];
                    if ([appDelObj.dealBundle isEqualToString:@"Yes"])
                    {
                        
                        
                        startTime=[DetailListAryData valueForKey:@"daysLeft"];
                        endTime=[DetailListAryData valueForKey:@"hoursLeft"];
                         NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@",startTime]];
                        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                            initWithAttributedString:str];
                        [string addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor blackColor]
                                       range:NSMakeRange(0, [string length])];
                        
                        [string addAttribute:NSFontAttributeName
                                       value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                       range:NSMakeRange(0, [string length])];
                        NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",@"Days"]];
                        if (appDelObj.isArabic) {
                            str1=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",@"أيام "]];
                        }
                        NSMutableAttributedString *string1= [[NSMutableAttributedString alloc]
                                                            initWithAttributedString:str1];
                        [string1 addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor grayColor]
                                       range:NSMakeRange(0, [string1 length])];
                        
                        [string1 addAttribute:NSFontAttributeName
                                       value:[UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular]
                                       range:NSMakeRange(0, [string1 length])];
                        [string appendAttributedString:string1];
                        /*************/
                        NSMutableAttributedString *str2=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",endTime]];
                        NSMutableAttributedString *string2= [[NSMutableAttributedString alloc]
                                                            initWithAttributedString:str2];
                        [string2 addAttribute:NSForegroundColorAttributeName
                                       value:[UIColor blackColor]
                                       range:NSMakeRange(0, [string2 length])];
                        
                        [string2 addAttribute:NSFontAttributeName
                                       value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                       range:NSMakeRange(0, [string2 length])];
                        if (appDelObj.isArabic) {
                            [string2 addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:16.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [string2 length])];
                        }
                        NSMutableAttributedString *str3=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",@"Hrs"]];
                        if (appDelObj.isArabic) {
                            str3=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",@"ساعة "]];
                        }
                        NSMutableAttributedString *string3= [[NSMutableAttributedString alloc]
                                                             initWithAttributedString:str3];
                        [string3 addAttribute:NSForegroundColorAttributeName
                                        value:[UIColor grayColor]
                                        range:NSMakeRange(0, [string3 length])];
                        
                        [string3 addAttribute:NSFontAttributeName
                                        value:[UIFont systemFontOfSize:13.0 weight:UIFontWeightRegular]
                                        range:NSMakeRange(0, [string3 length])];
                        if (appDelObj.isArabic) {
                            [string3 addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [string3 length])];
                        }
                        [string2 appendAttributedString:string3];
                        [string appendAttributedString:string2];
                        self.dealTime.attributedText=string;
                    }
                    
                    multipleImage=[DetailListAryData valueForKey:@"images"];
                    if ([[[dictionary objectForKey:@"result"]objectForKey:@"settingsDealReview"]isKindOfClass:[NSNull class]]) {
                        enableReview=@"No";
                    }
                    else
                    {
                    enableReview=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"settingsDealReview"]];
                        if (enableReview.length==0) {
                            enableReview=@"No";
                        }
                    }
                    
                    relatedItem=[[NSMutableArray alloc]init];
                    [reviewArray removeAllObjects];
                    NSString *hotStr=[[dictionary objectForKey:@"result"]objectForKey:@"featuredStatus"];
                    if ([hotStr isEqualToString:@"Yes"]||[hotStr isEqualToString:@"YES"]||[hotStr isEqualToString:@"yes"]) {
                        self.lblhot.alpha=1;
                    }
                    minQty=[[[dictionary objectForKey:@"result"]objectForKey:@"productMinBuyLimit"]intValue];
                    if (minQty<=0)
                    {
                        minQty=1;
                        self.lblQtySelected.text=@"1";
                    }
                    else{
                    self.lblQtySelected.text=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"productMinBuyLimit"]];
                    }
                   if ([appDelObj.dealBundle isEqualToString:@"Yes"])
                   {
                         maxQty=[[[dictionary objectForKey:@"result"]objectForKey:@"dealMaxBuyLimit"]intValue];
                    }
                    else
                    {
                        if ( [[[dictionary objectForKey:@"result"]objectForKey:@"productMaxBuyLimit"]isKindOfClass:[NSNull class]])
                        {
                            maxQty=25;
                        }
                        else
                        {
                            maxQty=[[[dictionary objectForKey:@"result"]objectForKey:@"productMaxBuyLimit"]intValue];
                            if (maxQty==0)
                            {
                                maxQty=25;
                            }
                        }
                    }
         
                    [includeCombinationArray removeAllObjects];
                    includeCombinationArray =[[NSMutableArray alloc]init];
                    encodedCombinations=[[dictionary objectForKey:@"result"]objectForKey:@"encodedCombinations"];
                    NSMutableArray *rev=[[NSMutableArray alloc]init];
                    
                    if([[[dictionary objectForKey:@"result"]objectForKey:@"wishlistProducts"]isEqualToString:@"Yes"])
                    {
                        [self.btnFav setBackgroundImage:[UIImage imageNamed:@"wish2.png"] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [self.btnFav setBackgroundImage:[UIImage imageNamed:@"wish111.png"] forState:UIControlStateNormal];
                    }
                    NSArray *revArrrel=[[dictionary objectForKey:@"result"]objectForKey:@"relatedProducts"];
                    
                    
                    if ([revArrrel isKindOfClass:[NSDictionary class]])                    {
                        [rev addObject:revArrrel];
                    }
                    else
                    {
                        [rev addObjectsFromArray:revArrrel];
                    }
                    NSArray *relArray=[[rev objectAtIndex:0] valueForKey:@"related"];
                    if (relArray.count!=0)
                    {
                        NSString *Name=@"Related Products";
                        if (appDelObj.isArabic) {
                            Name=@"منتجات ذات صله";
                        }
                        NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:Name,@"name",[rev valueForKey:@"related"],@"Data", nil];
                      
                        [relatedItem addObject:dic];
                    }
                    NSArray *upArray=[[rev objectAtIndex:0] valueForKey:@"upsell"];
                    if (upArray.count!=0)
                    {
                        NSString *Name=@"Frequently bought together";
                        if (appDelObj.isArabic) {
                            Name=@"اشترى في كثير من الأحيان جنبا إلى جنب";
                        }
                        NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:Name,@"name",[rev valueForKey:@"upsell"],@"Data", nil];
                        [relatedItem addObject:dic];
                    }
                    NSArray *crossArray=[[rev objectAtIndex:0] valueForKey:@"crossel"];
                    if (crossArray.count!=0)
                    {
                        NSString *Name=@"You may also like";
                        if (appDelObj.isArabic) {
                            Name=@"ربما يعجبك أيضا";
                        }
                        NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:Name,@"name",[rev valueForKey:@"crossel"],@"Data", nil];
                        [relatedItem addObject:dic];
                    }
                    
                    subscriptions=[[dictionary objectForKey:@"result"]objectForKey:@"subscriptionoptions"];
                    substituteMedArray=[[dictionary objectForKey:@"result"]objectForKey:@"substituteProduct"];
                    [colArray removeAllObjects];
                    self.lblSubscribeSave.text=[NSString stringWithFormat:@"I subscribe recurring deliveries & save up to %@%@",[[dictionary objectForKey:@"result"]objectForKey:@"subscriptionDiscount"],@"%"];
                    [optionsArray removeAllObjects];
                    [customOption removeAllObjects];
                    [DescriptionArray removeAllObjects];
                    imgUrl=[[dictionary objectForKey:@"result"]objectForKey:@"imagePath"];
                    businessurl=[[dictionary objectForKey:@"result"]objectForKey:@"businessUrl"];
                    self.lblBusinessName1.text=[[dictionary objectForKey:@"result"]objectForKey:@"businessName"];
                    self.lblBusinessFree.text=[[dictionary objectForKey:@"result"]objectForKey:@"businessName"];

                    NSLog(@"IMAGE ARRAY:%@=%@",multipleImage,imgUrl);

                    appDelObj.currencySymbol=[[dictionary objectForKey:@"result"]objectForKey:@"currencySymbol"];
                    if ([[[dictionary objectForKey:@"result"]objectForKey:@"cod_available"]isEqualToString:@"Yes"]&&[[[dictionary objectForKey:@"result"]objectForKey:@"productReturnable"]isEqualToString:@"Yes"]) {
//                        if (appDelObj.isArabic) {
//                            self.lblCodAvlNot.text=@"نقدا عند التسليم المتاحة";
//                        }
//                        else
//                        {
//                           self.lblCodAvlNot.text=@"Cash on delivery available";
//                        }
//
//                        self.codImg.image=[UIImage imageNamed:@"1-5.png"];
//                    }
//                    else{
//                        if (appDelObj.isArabic) {
//                          self.lblCodAvlNot.text=@"الدفع عند التسليم غير متوفر";
//                        }
//                        else
//                        {
//                            self.lblCodAvlNot.text=@"Cash on delivery not available";
//                        }
//
//                        self.codImg.image=[UIImage imageNamed:@"2-1.png"];
                    }
                    else if ([[[dictionary objectForKey:@"result"]objectForKey:@"cod_available"]isEqualToString:@"Yes"])
                    {
                        self.imgReturn.alpha=0;
                        self.lblReturnPolicy.alpha=0;
                        self.imgCOD.frame=CGRectMake(self.imgCOD.frame.origin.x, self.imgCOD.frame.origin.y+20, self.imgCOD.frame.size.width, self.imgCOD.frame.size.height);
                        self.lblCashOnDeli.frame=CGRectMake(self.lblCashOnDeli.frame.origin.x, self.lblCashOnDeli.frame.origin.y+20, self.lblCashOnDeli.frame.size.width, self.lblCashOnDeli.frame.size.height);
                        self.lblCOD.frame=CGRectMake(self.lblCOD.frame.origin.x, self.lblCOD.frame.origin.y+20, self.lblCOD.frame.size.width, self.lblCOD.frame.size.height);
                        self.imgShipping.frame=CGRectMake(self.imgShipping.frame.origin.x, self.imgShipping.frame.origin.y-10, self.imgShipping.frame.size.width, self.imgShipping.frame.size.height);
                        self.lblShipping.frame=CGRectMake(self.lblShipping.frame.origin.x, self.lblShipping.frame.origin.y-10, self.lblShipping.frame.size.width, self.lblShipping.frame.size.height);
//                        NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"100%",@"label1",@"Returnable",@"label2",@"cas.png",@"image", nil];
//                        [colArray addObject:dic];
//                        NSDictionary *dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"100%",@"label1",@"Earn Reward point",@"label2",@"p-details-1.png",@"image", nil];
//                        [colArray addObject:dic1];
//                        NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"100%",@"label1",@"COD Available",@"label2",@"p-details-3.png",@"image", nil];
//                        [colArray addObject:dic2];
                    }
                    else if ([[[dictionary objectForKey:@"result"]objectForKey:@"productReturnable"]isEqualToString:@"Yes"])

                    {
                        self.imgCOD.alpha=0;
                        self.lblCashOnDeli.alpha=0;
                        self.lblCOD.alpha=0;

                        self.lblReturnPolicy.frame=CGRectMake(self.lblReturnPolicy.frame.origin.x, self.lblReturnPolicy.frame.origin.y-25, self.lblReturnPolicy.frame.size.width, self.lblReturnPolicy.frame.size.height);
                        self.imgReturn.frame=CGRectMake(self.imgReturn.frame.origin.x, self.imgReturn.frame.origin.y+25, self.imgReturn.frame.size.width, self.imgReturn.frame.size.height);
                        self.imgShipping.frame=CGRectMake(self.imgShipping.frame.origin.x, self.imgShipping.frame.origin.y-10, self.imgShipping.frame.size.width, self.imgShipping.frame.size.height);
                        self.lblShipping.frame=CGRectMake(self.lblShipping.frame.origin.x, self.lblShipping.frame.origin.y-10, self.lblShipping.frame.size.width, self.lblShipping.frame.size.height);
                        self.lblJihazhiDeli.frame=CGRectMake(self.lblJihazhiDeli.frame.origin.x, self.lblJihazhiDeli.frame.origin.y-10, self.lblJihazhiDeli.frame.size.width, self.lblJihazhiDeli.frame.size.height);

//                        if ([[[dictionary objectForKey:@"result"]objectForKey:@"productReturnable"]isEqualToString:@"Yes"])
//                        {
//
//                        NSDictionary *dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"100%",@"label1",@"Returnable",@"label2",@"cas.png",@"image", nil];
//                        [colArray addObject:dic];
//                        }
//                        if ([[[dictionary objectForKey:@"result"]objectForKey:@"enable_reward_points"]isEqualToString:@"Yes"])
//                        {
//
//                            NSDictionary *dic1=[[NSDictionary alloc]initWithObjectsAndKeys:@"100%",@"label1",@"Earn Reward point",@"label2",@"p-details-1.png",@"image", nil];
//                            [colArray addObject:dic1];
//                        }
//                        if ([[[dictionary objectForKey:@"result"]objectForKey:@"cod_available"]isEqualToString:@"Yes"])
//                        {
//
//                            NSDictionary *dic2=[[NSDictionary alloc]initWithObjectsAndKeys:@"100%",@"label1",@"COD Available",@"label2",@"p-details-3.png",@"image", nil];
//                            [colArray addObject:dic2];
//                        }
//
                    }
                             else
                             {
                                 self.imgCOD.alpha=0;
                                 self.lblCashOnDeli.alpha=0;
                                 self.lblCOD.alpha=0;
                                 self.imgReturn.alpha=0;
                                 self.lblReturnPolicy.alpha=0;
                                 self.imgShipping.frame=CGRectMake(self.imgShipping.frame.origin.x, self.imgReturn.frame.origin.y, self.imgShipping.frame.size.width, self.imgShipping.frame.size.height);
                                 self.lblShipping.frame=CGRectMake(self.imgShipping.frame.origin.x, self.lblReturnPolicy.frame.origin.y, self.imgShipping.frame.size.width, self.imgShipping.frame.size.height);
                                 self.lblJihazhiDeli.frame=CGRectMake(self.lblJihazhiDeli.frame.origin.x, self.lblJihazhiDeli.frame.origin.y-15, self.lblJihazhiDeli.frame.size.width, self.lblJihazhiDeli.frame.size.height);

                             }
                    
                    
                    NSLog(@"collection array is====%@",colArray);
                    
                    [mutipleImagesArray removeAllObjects];
                    NSArray *imageArray=[[dictionary objectForKey:@"result"]objectForKey:@"images"];
                    NSString *strImgUrl=[DetailListAryData  valueForKey:@"productImage"] ;
                    if (strImgUrl.length!=0)
                    {
                        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
                        NSString *urlIMG;
                        if([s isEqualToString:@"http"])
                        {
                            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
                        }
                        else
                        {
                            urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
                        }
                        NSLog(@"%@",urlIMG);
                       
                        if (appDelObj.isArabic) {
                             [self.imgFree sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                        } else {
                             [self.imgFree sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                        }
                        
                    }
                    else{
                        self.imgItem.image=[UIImage imageNamed:@"placeholder1.png"];
                        if (appDelObj.isArabic) {
                             self.imgItem.image=[UIImage imageNamed:@"place_holderar.png"];
                        }
                    }
                    
                    if ([imageArray isKindOfClass:[NSNull class]]||imageArray.count==0)
                    {
                        self.imgItem.alpha=1;
                        self.tblImages.alpha=0;
                        self.pager.numberOfPages=1;

                        NSString *strImgUrl=[DetailListAryData  valueForKey:@"productImage"] ;
                        if (strImgUrl.length!=0)
                        {
                            NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
                            NSString *urlIMG;
                            if([s isEqualToString:@"http"])
                            {
                                urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
                            }
                            else
                            {
                                urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
                            }
                            NSLog(@"%@",urlIMG);
                           
                            if (appDelObj.isArabic) {
                                [self.imgItem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                                [self.imgFree sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                            } else {
                                [self.imgItem sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                                [self.imgFree sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                            }

                        }
                        else{
                            self.imgItem.image=[UIImage imageNamed:@"placeholder1.png"];
                            if (appDelObj.isArabic) {
                                self.imgItem.image=[UIImage imageNamed:@"place_holderar.png"];
                            }
                        }
                        
                    }
                    else
                    {
                        if ([imageArray isKindOfClass:[NSDictionary class]])
                        {
                            [mutipleImagesArray addObject:imageArray];
                        }
                        else
                        {
                            [mutipleImagesArray addObjectsFromArray:imageArray];
                        }
                        self.imgItem.alpha=0;
                        self.tblImages.alpha=1;
                        self.pager.numberOfPages=imageArray.count+1;
                        [self.tblImages reloadData];
                    }
                    
                    if([[[dictionary objectForKey:@"result"]objectForKey:@"wishlistProducts"]isEqualToString:@"yes"]||[[[dictionary objectForKey:@"result"]objectForKey:@"wishlistProducts"]isEqualToString:@"Yes"]||[[[dictionary objectForKey:@"result"]objectForKey:@"wishlistProducts"]isEqualToString:@"YES"])
                    {
                        [_btnFav setBackgroundImage:[UIImage imageNamed:@"wish2.png"] forState:UIControlStateNormal];
                    }
                    else
                    {
                        [_btnFav setBackgroundImage:[UIImage imageNamed:@"wish111.png"] forState:UIControlStateNormal];
                    }
                    
                    NSArray *sellerArr=[[dictionary objectForKey:@"result"]objectForKey:@"buyBoxProd"];                                        if ([sellerArr isKindOfClass:[NSDictionary class]])
                    {
                        [sellerArray addObject:sellerArr];
                    }
                    else
                    {
                        if (!sellerArr||sellerArr.count==0) {
                            
                        }
                        else
                        {
                        [sellerArray addObjectsFromArray:sellerArr];
                        }
                    }
                    NSLog(@"SELLERSSS:  %@",sellerArray);
                    NSString *sname=[DetailListAryData  valueForKey:@"productTitle"];
                    productOptionID=[DetailListAryData  valueForKey:@"productOptionID"];
                    NSString *strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    self.lblName.text=strname ;
                    self.lblNameFree.text=strname ;
                    float x=[[DetailListAryData  valueForKey:@"offerPrice"] floatValue];
                    price=x;
                    self.hidePrice.text=[NSString stringWithFormat:@"%.02f",x];

                    float x1=[[DetailListAryData  valueForKey:@"productOptionRegularPrice"] floatValue];
                    if ([appDelObj.dealBundle isEqualToString:@"Yes"])
                    {
                        x=[[DetailListAryData  valueForKey:@"dealPrice"] floatValue];
                    }
                    optprice=x1;
                    NSString *s1=[NSString stringWithFormat:@"%.02f",x1] ;
                    NSString *s2=[NSString stringWithFormat:@"%.02f",x ];
                    
                    
                    if ([s1 isEqualToString:s2]&&s1.length!=0&&s2.length!=0)
                    {
                        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",s2],appDelObj.currencySymbol]];
                        if (appDelObj.isArabic) {
                            price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",s2],appDelObj.currencySymbol]];
                        }
                        if (appDelObj.isArabic) {
                            [price addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [price length])];
                        }
                        [price addAttribute:NSForegroundColorAttributeName value:appDelObj.priceColor                               range:NSMakeRange(0, [price length])];

                        self.lblprice.attributedText=price;
                        self.lblBottomPrice.attributedText=price;
                          self.lblBottomPrice.textColor=[UIColor redColor];
                    }
                    else{
                    if (s1.length!=0&&s2.length!=0)
                    {
                        //NSArray *a=[s1 componentsSeparatedByString:@"."];
                        //NSArray *a1=[s2 componentsSeparatedByString:@"."];
                        NSString *p1=s1;
                        NSString *p2=s2;
                        NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
                        if (appDelObj.isArabic) {
                            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
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
                                          value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [string length])];
                        }
                        [string addAttribute:NSStrikethroughStyleAttributeName
                                       value:@2
                                       range:NSMakeRange(0, [string length])];
                        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
                        if (appDelObj.isArabic) {
                            price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
                        }
                        [price addAttribute:NSForegroundColorAttributeName
                              value:appDelObj.priceOffer
                              range:NSMakeRange(0, [price length])];
                        [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
                        if (appDelObj.isArabic) {
                            [price addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [price length])];
                        }
                        [price appendAttributedString:string];
                        self.lblprice.attributedText=price;
                        self.lblprice.textAlignment=NSTextAlignmentCenter;
                        NSMutableAttributedString *stringBottom=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
                        [stringBottom addAttribute:NSForegroundColorAttributeName   value:[UIColor redColor]                              range:NSMakeRange(0, [stringBottom length])];
                        [stringBottom appendAttributedString:string];
                        self.lblBottomPrice.attributedText=stringBottom;
                        //self.lblBottomPrice.textAlignment=NSTextAlignmentCenter;
                        
                        self.lblBottomPrice.attributedText=stringBottom;
                       // self.lblBottomPrice.attributedText=price;
                        self.lblBottomPrice.textAlignment=NSTextAlignmentCenter;

                    }
                    }
                //self.lblOffer.frame=CGRectMake(self.lblprice.frame.origin.x+self.lblprice.frame.size.width+20, self.lblOffer.frame.origin.y, self.lblOffer.frame.size.width, self.lblOffer.frame.size.height);
                    double optmin=[[[[DetailListAryData  valueForKey:@"options"]objectAtIndex:0]valueForKey:@"productMinBuyLimit"]doubleValue];

                    double optSum=[[[[DetailListAryData  valueForKey:@"options"]objectAtIndex:0]valueForKey:@"productOptionQuantity"]doubleValue];
                    double optQSum=[[[[DetailListAryData  valueForKey:@"options"]objectAtIndex:0]valueForKey:@"productQuantityUnlimited"]doubleValue];
                    outStock=optSum+optQSum;
                    if (outStock<1) {
                        self.btnAddtoCart.alpha=0;
                        self.lblOut.alpha=1;
                    }
                    else  if (optQSum<1&&optSum<minQty)
                    {
                        self.btnAddtoCart.alpha=0;
                        self.lblOut.alpha=1;
                    }
                    else
                    {
                        if([[DetailListAryData  valueForKey:@"stockAvailable"]isEqualToString:@"No"])
                        {
                            self.btnAddtoCart.alpha=0;
                            self.lblOut.alpha=1;
                        }
                        else
                        {
                            self.btnAddtoCart.alpha=1;
                            self.lblOut.alpha=0;
                        }
                    }
                    NSString *offerStr=[DetailListAryData  valueForKey:@"productOptionOfferDiscount"];
                    if ([appDelObj.dealBundle isEqualToString:@"Yes"])
                    {
                        offerStr=[DetailListAryData  valueForKey:@"dealDiscount"];
                    }
                    if ([offerStr isKindOfClass:[NSNull class]]||offerStr.length==0) {
                        offerStr=@"";
                        self.lblOffer.alpha=0;
                        self.lblofferbottom.alpha=0;
                    }
                    else
                    {
                        NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
                        if (offArr.count!=0)
                        {
                            if ([[offArr objectAtIndex:0]isEqualToString:@"0"])
                            {
                                self.lblOffer.alpha=0;
                                self.lblofferbottom.alpha=0;
                            }
                            else
                            {
                                int off=[[offArr objectAtIndex:0]intValue];
                                self.lblOffer.text=[NSString stringWithFormat:@"%d%@ Off",off,@"%"];
                                self.lblofferbottom.text=[NSString stringWithFormat:@"%d%@ Off",off,@"%"];
                                if (appDelObj.isArabic) {
                                    self.lblOffer.text=[NSString stringWithFormat:@"%d%@ %@",off,@"%",@"خصم"];
                                    self.lblofferbottom.text=[NSString stringWithFormat:@"%d%@ %@ ",off,@"%",@"خصم"];
                                }
                            }
                  
                           
                        }
                        else
                        {
                            self.lblOffer.alpha=0;
                            self.lblofferbottom.alpha=0;
                        }
                    }
                    
      
                  
                   // self.lblOffer.text=[NSString stringWithFormat:@"%@ %@off",[DetailListAryData  valueForKey:@"productOptionOfferDiscount"],@"%"];
                   
                    if([[DetailListAryData  valueForKey:@"ratingTotal"] isKindOfClass:[NSNull class]])
                    {
                        self.lblNoProductReviewAvailable.alpha=1;
                        self.lblAvgRate.alpha=0;
                        self.lblRateper.alpha=0;
                        self.imgrate1.alpha=0;
                        self.imgrate2.alpha=0;
                        self.imgrate3.alpha=0;
                        self.imgrate4.alpha=0;
                        self.imgrate5.alpha=0;
                        self.btnViewReviewList.alpha=0;
                    }
                    else
                    {
                        self.lblNoProductReviewAvailable.alpha=0;
                        self.lblAvgRate.text=[DetailListAryData  valueForKey:@"ratingTotal"];
                    
                        self.lblRateper.text=[NSString stringWithFormat:@"(%@ Reviews)",[DetailListAryData  valueForKey:@"productReviewsCount"]];
                        if (appDelObj.isArabic)
                        {
                            self.lblRateper.text=[NSString stringWithFormat:@"(التعليقات %@)",[DetailListAryData  valueForKey:@"productReviewsCount"]];
                        }
                        if ([[DetailListAryData  valueForKey:@"ratingTotal"] isEqualToString:@"0"])
                        {
                            self.imgrate1.image=[UIImage imageNamed:@"star-3.png"];
                            self.imgrate2.image=[UIImage imageNamed:@"star-3.png"];
                            self.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
                            self.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                            self.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                        
                        }
                        else if ([[DetailListAryData  valueForKey:@"ratingTotal"] isEqualToString:@"1"])
                        {
                            self.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate2.image=[UIImage imageNamed:@"star-3.png"];
                            self.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
                            self.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                            self.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                        
                        }
                        else if ([[DetailListAryData  valueForKey:@"ratingTotal"] isEqualToString:@"2"])
                        {
                            self.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
                            self.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                            self.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                        
                        }
                        else if ([[DetailListAryData  valueForKey:@"ratingTotal"] isEqualToString:@"3"])
                        {
                            self.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                            self.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                        }
                        else if ([[DetailListAryData  valueForKey:@"ratingTotal"] isEqualToString:@"4"])
                        {
                            self.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate4.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                        }
                        else if ([[DetailListAryData  valueForKey:@"ratingTotal"] isEqualToString:@"5"])
                        {
                            self.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate4.image=[UIImage imageNamed:@"star-1.png"];
                            self.imgrate5.image=[UIImage imageNamed:@"star-1.png"];
                        }
                    }
                    optionsArray=[[NSMutableArray alloc]init];
                    NSArray *optArr=[[dictionary objectForKey:@"result"]objectForKey:@"options"];          
                    if ([optArr isKindOfClass:[NSDictionary class]])
                    {
                        [optionsArray addObject:optArr];
                    }
                    else
                    {
                        [optionsArray addObjectsFromArray:optArr];
                    }
                     customOption=[[NSMutableArray alloc]init];
                    combinationSelectArray=[[NSMutableArray alloc]init];
                    includeCombinationArray=[[NSMutableArray alloc]init];

                    NSArray *custArr=[[dictionary objectForKey:@"result"]objectForKey:@"customOption"];                                        if ([custArr isKindOfClass:[NSDictionary class]])                    {
                        if (custArr.count!=0) {
                              [customOption addObject:custArr];
                        }
                      
                    }
                    else
                    {
                        if (custArr.count!=0) {
                            
                        [customOption addObjectsFromArray:custArr];
                        }
                    }
                    if ([customOption isKindOfClass:[NSNull class]]|| customOption.count==0||customOption.count==1)
                    {
                        
                    }
                    else
                    {
                    //NSArray *combArray=[customOption filterUsingPredicate:[NSPredicate predicateWithFormat:@"include_in_combination like %@",@"Yes"]];
                    
                    }
                    for(int i=0;i<customOption.count;i++)
                    {
                        if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"file"]||[[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"datetime"]||[[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"time"]||[[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"date"]||[[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"textbox"]||[[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"select"])                        {
                            height=height+65;
                        }
                        else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"textarea"])                        {
                            height=height+147;
                        }
                        else if([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
                        {
                            NSArray *a=[[customOption objectAtIndex:i]valueForKey:@"variants"];
                            height=height+(a.count*65);
                            
                        }
                    }
                    reviewArray=[[NSMutableArray alloc]init];
                    NSArray *revArr=[[dictionary objectForKey:@"result"]objectForKey:@"resDealReviewDetails"];                                  
                    if ([revArr isKindOfClass:[NSDictionary class]])                    {
                        if (revArr.count!=0) {
                            [reviewArray addObject:revArr];
                        }
                        
                    }
                    else
                    {
                        if (revArr.count!=0) {
                            [reviewArray addObjectsFromArray:revArr];
                        }
                        
                    }
                    int free= [[DetailListAryData  valueForKey:@"freeProductsCount"]
                               intValue];
                    if (free<=0) {
                        self.imgFreeimg.alpha=0;
                    }
                    else{
                        self.imgFreeimg.alpha=1;
                    }
                    heghtDes=0;
                    specificationArray=[DetailListAryData  valueForKey:@"attributesGroupWise"];
                    NSString *shortDes=[DetailListAryData  valueForKey:@"productShortDescription"];
                    NSString *specificationStr=@"";
                    if ([specificationArray isKindOfClass:[NSNull class]]||specificationArray.count==0)
                    {
                    }
                    else
                    {
                    if (specificationArray.count!=0)
                    {
                        for (int sh=0; sh<3; sh++)
                        {
                             if (sh<specificationArray.count)
                             {
                                 specificationStr=[NSString stringWithFormat:@"%@        %@ : %@",specificationStr,[[specificationArray objectAtIndex:sh]valueForKey:@"attrName"],[[specificationArray objectAtIndex:sh]valueForKey:@"attrValue"]];
                             }
                        }
                    }
                    }
                    if ([shortDes isKindOfClass:[NSNull class]]||shortDes.length==0) {
                        
                    }
                    else
                    {
                        if ([specificationArray isKindOfClass:[NSNull class]]||specificationArray.count==0)
                        {
                            NSAttributedString *str=[[NSAttributedString alloc]initWithString:shortDes];
                            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                                initWithAttributedString:str];
                            [string addAttribute:NSForegroundColorAttributeName
                                           value:[UIColor blackColor]
                                           range:NSMakeRange(0, [string length])];
                            
                            //self.lblShortDes.attributedText=string;
                           // [self.weee loadHTMLString:[DetailListAryData  valueForKey:@"productDescription"] baseURL:nil];
                            if (appDelObj.isArabic) {
                                [self.weee loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@<div>",shortDes ]baseURL:nil];
                                //[self.web loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@<div>",[[dictionary objectForKey:@"results" ] objectForKey:@"contentDescription"]] baseURL:nil];
                            }
                            else
                            {
                                [self.weee loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@<div>",shortDes ]baseURL:nil];
                            }
                        }
                        else
                        {
                            NSAttributedString *str=[[NSAttributedString alloc]initWithString:shortDes];
                            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                                initWithAttributedString:str];
                            [string addAttribute:NSForegroundColorAttributeName
                                           value:[UIColor blackColor]
                                           range:NSMakeRange(0, [string length])];
                            NSAttributedString *str1=[[NSAttributedString alloc]initWithString:specificationStr];
                            NSMutableAttributedString *string1= [[NSMutableAttributedString alloc]
                                                                 initWithAttributedString:str1];
                            [string1 addAttribute:NSForegroundColorAttributeName
                                            value:[UIColor grayColor]
                                            range:NSMakeRange(0, [string1 length])];
                            [string appendAttributedString:string1];
                            //self.lblShortDes.attributedText=string;
                            if (appDelObj.isArabic) {
                                [self.weee loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@ %@<div>",shortDes,specificationStr ]baseURL:nil];
                                //[self.web loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@<div>",[[dictionary objectForKey:@"results" ] objectForKey:@"contentDescription"]] baseURL:nil];
                            }
                            else
                            {
                                [self.weee loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@ %@<div>",shortDes,specificationStr ]baseURL:nil];
                            }
                        }
                    
                    }
                    
                    DescriptionArray=[[NSMutableArray alloc]init];
                    NSString *des=[DetailListAryData  valueForKey:@"productDescription"];
                    if ([des isKindOfClass:[NSNull class]]||des.length==0)
                    {
                        
                    }
                    else
                    {
                        NSDictionary *dic;
                        if (appDelObj.isArabic) {
                            dic=[[NSDictionary alloc]initWithObjectsAndKeys:[DetailListAryData  valueForKey:@"productDescription"],@"Des",@"وصف المنتج",@"DesName",@"no",@"table", nil];

                        }
                        else
                        {
                            dic=[[NSDictionary alloc]initWithObjectsAndKeys:[DetailListAryData  valueForKey:@"productDescription"],@"Des",@"Description",@"DesName",@"no",@"table", nil];

                        }
                        [DescriptionArray addObject:dic];
                        heghtDes=heghtDes+60;
                    }
                    
                    
                   // DescriptionArray=[[NSMutableArray alloc]init];
                    NSString *des1=[DetailListAryData  valueForKey:@"productSpecification"];
                    if ([specificationArray isKindOfClass:[NSNull class]]||specificationArray.count==0)
                    {
                        
                    }
                    else
                    {
                        NSDictionary *dic;
                        if (appDelObj.isArabic) {
                            dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"",@"Des",@"المواصفات",@"DesName",@"yes",@"table", nil];
                            
                        }
                        else
                        {
                            dic=[[NSDictionary alloc]initWithObjectsAndKeys:@"",@"Des",@"Specification",@"DesName",@"yes",@"table", nil];
                            
                        }
                        [DescriptionArray addObject:dic];
                        heghtDes=heghtDes+60;
                    }
                    NSString *fine=[DetailListAryData  valueForKey:@"productFinePrint"];
                    if ([fine isKindOfClass:[NSNull class]]||fine.length==0)
                    {
                        
                    }
                    else
                    {
                        NSDictionary *dic;
                        if (appDelObj.isArabic) {
                            dic=[[NSDictionary alloc]initWithObjectsAndKeys:[DetailListAryData  valueForKey:@"productFinePrint"],@"Des",@"المطبوعات الجميلة",@"DesName",@"no",@"table", nil];
                        }
                        else
                        {
                            dic=[[NSDictionary alloc]initWithObjectsAndKeys:[DetailListAryData  valueForKey:@"productFinePrint"],@"Des",@"Fineprints",@"DesName",@"no",@"table", nil];
                        }
                        [DescriptionArray addObject:dic];
                        heghtDes=heghtDes+60;
                    }
                    NSString *high=[DetailListAryData  valueForKey:@"productHighlights"];
                    if ([high isKindOfClass:[NSNull class]]||high.length==0)
                    {
                        
                    }
                    else
                    {
                        NSDictionary *dic;
                        if (appDelObj.isArabic) {
                            dic=[[NSDictionary alloc]initWithObjectsAndKeys:[DetailListAryData  valueForKey:@"productHighlights"],@"Des",@"يسلط الضوء",@"DesName",@"no",@"table", nil];
                        }
                        else
                        {
                            dic=[[NSDictionary alloc]initWithObjectsAndKeys:[DetailListAryData  valueForKey:@"productHighlights"],@"Des",@"Highlights",@"DesName",@"no",@"table", nil];
                        }
                        [DescriptionArray addObject:dic];
                        heghtDes=heghtDes+60;
                    }
     /*************BUSINESSSSSS***/////////////////////
                    NSString *strbuinesslogo=[DetailListAryData  valueForKey:@"businessImage"] ;
                    if (strbuinesslogo.length!=0)
                    {
                        NSString *strbuinesslogo1=[strbuinesslogo substringWithRange:NSMakeRange(0, 4)];
                        NSString *urlIMG1;
                        if([strbuinesslogo1 isEqualToString:@"http"])
                        {
                            urlIMG1=[NSString stringWithFormat:@"%@",strbuinesslogo];
                        }
                        else
                        {
                            urlIMG1=[NSString stringWithFormat:@"%@%@",imgUrl,strbuinesslogo];
                            
                        }
                       
                        if (appDelObj.isArabic) {
                             [self.imgSellerLogo sd_setImageWithURL:[NSURL URLWithString:urlIMG1] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                        }
                        else
                        {
                             [self.imgSellerLogo sd_setImageWithURL:[NSURL URLWithString:urlIMG1] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                        }
                    }
                    else
                    {
                        self.imgSellerLogo.image=[UIImage imageNamed:@"placeholder1.png"];
                        if (appDelObj.isArabic) {
                             self.imgSellerLogo.image=[UIImage imageNamed:@"place_holderar.png"];
                        }
                    }
                    
                    NSString *bname=[DetailListAryData  valueForKey:@"businessName"];
                    NSString *strnameb=[bname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
                    self.lblSellerName.text=strnameb;
                    self.lblSellerAvg.text=[NSString stringWithFormat:@"%@",[DetailListAryData  valueForKey:@"busAvgRating"]];
                    if ([[NSString stringWithFormat:@"%@",[DetailListAryData  valueForKey:@"busAvgRating"]] isEqualToString:@"0"])
                    {
                        self.star1.image=[UIImage imageNamed:@"star-3.png"];
                        self.star2.image=[UIImage imageNamed:@"star-3.png"];
                        self.star3.image=[UIImage imageNamed:@"star-3.png"];
                        self.star4.image=[UIImage imageNamed:@"star-3.png"];
                        self.star5.image=[UIImage imageNamed:@"star-3.png"];
                    }
                    else if ([[NSString stringWithFormat:@"%@",[DetailListAryData  valueForKey:@"busAvgRating"]] isEqualToString:@"1"])
                    {
                        self.star1.image=[UIImage imageNamed:@"star-1.png"];
                        self.star2.image=[UIImage imageNamed:@"star-3.png"];
                        self.star3.image=[UIImage imageNamed:@"star-3.png"];
                        self.star4.image=[UIImage imageNamed:@"star-3.png"];
                        self.star5.image=[UIImage imageNamed:@"star-3.png"];
                    }
                    else if ([[NSString stringWithFormat:@"%@",[DetailListAryData  valueForKey:@"busAvgRating"]] isEqualToString:@"2"])
                    {
                        self.star1.image=[UIImage imageNamed:@"star-1.png"];
                        self.star2.image=[UIImage imageNamed:@"star-1.png"];
                        self.star3.image=[UIImage imageNamed:@"star-3.png"];
                        self.star4.image=[UIImage imageNamed:@"star-3.png"];
                        self.star5.image=[UIImage imageNamed:@"star-3.png"];
                    }
                    else if ([[NSString stringWithFormat:@"%@",[DetailListAryData  valueForKey:@"busAvgRating"]] isEqualToString:@"3"])
                    {
                        self.star1.image=[UIImage imageNamed:@"star-1.png"];
                        self.star2.image=[UIImage imageNamed:@"star-1.png"];
                        self.star3.image=[UIImage imageNamed:@"star-1.png"];
                        self.star4.image=[UIImage imageNamed:@"star-3.png"];
                        self.star5.image=[UIImage imageNamed:@"star-3.png"];
                    }
                    else if ([[NSString stringWithFormat:@"%@",[DetailListAryData  valueForKey:@"busAvgRating"]] isEqualToString:@"4"])
                    {
                        self.star1.image=[UIImage imageNamed:@"star-1.png"];
                        self.star2.image=[UIImage imageNamed:@"star-1.png"];
                        self.star3.image=[UIImage imageNamed:@"star-1.png"];
                        self.star4.image=[UIImage imageNamed:@"star-1.png"];
                        self.star5.image=[UIImage imageNamed:@"star-3.png"];
                    }
                    else if ([[NSString stringWithFormat:@"%@",[DetailListAryData  valueForKey:@"busAvgRating"]] isEqualToString:@"5"])
                    {
                        self.star1.image=[UIImage imageNamed:@"star-1.png"];
                        self.star2.image=[UIImage imageNamed:@"star-1.png"];
                        self.star3.image=[UIImage imageNamed:@"star-1.png"];
                        self.star4.image=[UIImage imageNamed:@"star-1.png"];
                        self.star5.image=[UIImage imageNamed:@"star-1.png"];
                    }
                    
                    
                    self.btnSuscribeData.alpha=0;
                    
                    
                    /*//////////////////*/
                    
                    freeProducts=[[dictionary objectForKey:@"result"]objectForKey:@"freeProducts"];
                    NSLog(@"Freeeeeee%@",freeProducts);
                    self.lblfreecount.text=[NSString stringWithFormat:@"Select your any %@ gift product",[[dictionary objectForKey:@"result"]objectForKey:@"freeProductsCount"]];
                    freecount=[[[dictionary objectForKey:@"result"]objectForKey:@"freeProductsCount"] intValue];
                     freeProductID=@"";
                    if (freeProducts.count<=0)
                    {
                        freeProductAvl=@"No";
                         freeProductID=@"";
                    }
                    else
                    {
                        freeProductAvl=@"";
                    }
                    if([customOption isKindOfClass:[NSNull class]]||customOption.count==0)
                    {
                        self.tblCustomoptions.frame=CGRectMake(self.tblCustomoptions.frame.origin.x, self.priceView.frame.origin.y+self.priceView.frame.size.height+1, self.tblCustomoptions.frame.size.width, 0);
                        self.tblCustomoptions.alpha=0;
                        if([optionsArray isKindOfClass:[NSNull class]]||optionsArray.count==0||optionsArray.count==1)
                        {
                            self.tblOptions.frame=CGRectMake(self.tblOptions.frame.origin.x, self.tblCustomoptions.frame.origin.y, self.tblOptions.frame.size.width, 0);
                            self.tblOptions.alpha=0;

                            if ([freeProductAvl isEqualToString:@"No"])
                            {
                                
                                self.subscribeView.frame=CGRectMake(0, self.tblCustomoptions.frame.origin.y+self.tblCustomoptions.frame.size.height, self.subscribeView.frame.size.width, 0);
                                self.subscribeView.alpha=0;
                            }
                            else
                            {
                                self.subscribeView.frame=CGRectMake(0, self.tblCustomoptions.frame.origin.y+self.tblCustomoptions.frame.size.height+50, self.subscribeView.frame.size.width, self.subscribeView.frame.size.height);
                                self.subscribeView.alpha=1;
                                
                            }
                            //self.tblSubscription.frame=CGRectMake(self.tblSubscription.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height, self.tblSubscription.frame.size.width, 0);
                            //self.checkDeliveryView.frame=CGRectMake(self.checkDeliveryView.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height+1, self.checkDeliveryView.frame.size.width, self.checkDeliveryView.frame.size.height);
                           
                           /* if (substituteMedArray.count==0)
                            {
                                self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height-1, self.tblSubstituteMedicine.frame.size.width, 0);
                                self.tblSubstituteMedicine.alpha=0;
                            }
                            else{
                                 self.tblSubstituteMedicine.alpha=1;
                                self.tblSubstituteMedicine.alpha=1;
                                if (substituteMedArray.count<=3)
                                {
                                    self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*substituteMedArray.count)+32);
                                }
                                else
                                {
                                    self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*3)+92);
                                    
                                }                            }*/
                            
                            self.tblDescription.frame=CGRectMake(self.tblDescription.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height+1, self.tblDescription.frame.size.width, heghtDes);
                            [self.tblDescription reloadData];
                            
                        }
                        else
                        {
                             self.tblOptions.alpha=1;
                            self.tblOptions.frame=CGRectMake(self.tblOptions.frame.origin.x, self.tblCustomoptions.frame.origin.y, self.tblOptions.frame.size.width, 93*optionsArray.count);
                            [self.tblOptions reloadData];
                            if (freeProducts.count>0)
                            {
                                self.subscribeView.frame=CGRectMake(0, self.tblOptions.frame.origin.y+self.tblOptions.frame.size.height+50, self.subscribeView.frame.size.width, self.subscribeView.frame.size.height);
                                self.subscribeView.alpha=1;
                                
                            }
                            else
                            {
                                self.subscribeView.frame=CGRectMake(0, self.tblOptions.frame.origin.y+self.tblOptions.frame.size.height-1, self.subscribeView.frame.size.width, 0);
                                self.subscribeView.alpha=0;
                            }
                            //self.tblSubscription.frame=CGRectMake(self.tblSubscription.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height, self.tblSubscription.frame.size.width, 0);

                            //self.checkDeliveryView.frame=CGRectMake(self.checkDeliveryView.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height+1, self.checkDeliveryView.frame.size.width, self.checkDeliveryView.frame.size.height);
                          /*  if (substituteMedArray.count==0)
                            {
                                self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height-1, self.tblSubstituteMedicine.frame.size.width, 0);
                                self.tblSubstituteMedicine.alpha=0;
                            }
                            else{
                                self.tblSubstituteMedicine.alpha=1;
                                self.tblSubstituteMedicine.alpha=1;
                                if (substituteMedArray.count<=3)
                                {
                                    self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*substituteMedArray.count)+32);
                                }
                                else
                                {
                                    self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*3)+92);
                                    
                                }                            }*/
                            
                            self.tblDescription.frame=CGRectMake(self.tblDescription.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height+1, self.tblDescription.frame.size.width, heghtDes);
                            [self.tblDescription reloadData];
                        }
                    }
                    else
                    {
                        self.tblCustomoptions.frame=CGRectMake(self.tblCustomoptions.frame.origin.x,self.priceView.frame.origin.y+self.priceView.frame.size.height+1, self.tblCustomoptions.frame.size.width, height);
                        [self.tblCustomoptions reloadData];
                        if([optionsArray isKindOfClass:[NSNull class]]||optionsArray.count==0||optionsArray.count==1)
                        {
                            self.tblOptions.frame=CGRectMake(self.tblOptions.frame.origin.x, self.tblCustomoptions.frame.origin.y+self.tblCustomoptions.frame.size.height+1, self.tblOptions.frame.size.width, 0);
                            self.tblOptions.alpha=0;
                            if ([freeProductAvl isEqualToString:@"No"])
                            {
                               
                                self.subscribeView.frame=CGRectMake(0, self.tblCustomoptions.frame.origin.y+self.tblCustomoptions.frame.size.height, self.subscribeView.frame.size.width, 0);
                                self.subscribeView.alpha=0;
                            }
                            else
                            {
                                self.subscribeView.frame=CGRectMake(0, self.tblCustomoptions.frame.origin.y+self.tblCustomoptions.frame.size.height+50, self.subscribeView.frame.size.width, self.subscribeView.frame.size.height);
                                self.subscribeView.alpha=1;
                                
                            }
                            //self.tblSubscription.frame=CGRectMake(self.tblSubscription.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height, self.tblSubscription.frame.size.width, 0);

//self.checkDeliveryView.frame=CGRectMake(self.checkDeliveryView.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height+1, self.checkDeliveryView.frame.size.width, self.checkDeliveryView.frame.size.height);
                           /* if (substituteMedArray.count==0)
                            {
                                self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height-1, self.tblSubstituteMedicine.frame.size.width, 0);
                                self.tblSubstituteMedicine.alpha=0;
                            }
                            else{
                                self.tblSubstituteMedicine.alpha=1;
                                self.tblSubstituteMedicine.alpha=1;
                                if (substituteMedArray.count<=3)
                                {
                                    self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*substituteMedArray.count)+32);
                                }
                                else
                                {
                                    self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*3)+92);
                                    
                                }
                                
                            }*/
                            
                            self.tblDescription.frame=CGRectMake(self.tblDescription.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height+1, self.tblDescription.frame.size.width, heghtDes);
                            [self.tblDescription reloadData];
                        }
                        else
                        {
                             self.tblOptions.alpha=1;
                            self.tblOptions.frame=CGRectMake(self.tblOptions.frame.origin.x, self.tblCustomoptions.frame.origin.y+self.tblCustomoptions.frame.size.height+1, self.tblOptions.frame.size.width, 90*optionsArray.count);
                            [self.tblOptions reloadData];
                            if (freeProducts>0)
                            {
                                self.subscribeView.frame=CGRectMake(0, self.tblOptions.frame.origin.y+self.tblOptions.frame.size.height+50, self.subscribeView.frame.size.width, self.subscribeView.frame.size.height);
                                self.subscribeView.alpha=1;
                                self.btnSuscribeData.alpha=0;
                                
                            }
                            else
                            {
                                self.subscribeView.frame=CGRectMake(0, self.tblOptions.frame.origin.y+self.tblOptions.frame.size.height-1, self.subscribeView.frame.size.width, 0);
                                self.subscribeView.alpha=0;
                                 self.btnSuscribeData.alpha=0;
                            }
                            //self.tblSubscription.frame=CGRectMake(self.tblSubscription.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height, self.tblSubscription.frame.size.width, 0);

                            //self.checkDeliveryView.frame=CGRectMake(self.checkDeliveryView.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height+1, self.checkDeliveryView.frame.size.width, self.checkDeliveryView.frame.size.height);
                           /* if (substituteMedArray.count==0)
                            {
                                self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height-1, self.tblSubstituteMedicine.frame.size.width, 0);
                                self.tblSubstituteMedicine.alpha=0;
                            }
                            else{
                                self.tblSubstituteMedicine.alpha=1;
                                self.tblSubstituteMedicine.alpha=1;
                                if (substituteMedArray.count<=3)
                                {
                                    self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*substituteMedArray.count)+32);
                                }
                                else
                                {
                                    self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*3)+92);
                                    
                                }                            }*/
                            
                            self.tblDescription.frame=CGRectMake(self.tblDescription.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height+1, self.tblDescription.frame.size.width, heghtDes);
                            [self.tblDescription reloadData];
                        }
                    }
                    if ([sellerArray isKindOfClass:[NSNull class]]||sellerArray.count==0)
                    {
                          self.AllSellerView.alpha=0; self.AllSellerView.frame=CGRectMake(self.AllSellerView.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height, self.AllSellerView.frame.size.width, 0);
                    }
                    else{
                       self.AllSellerView.alpha=1;
                        self.AllSellerView.frame=CGRectMake(self.AllSellerView.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height+1, self.AllSellerView.frame.size.width, self.AllSellerView.frame.size.height);
//                        self.AllSellerView.alpha=0;
//                        self.AllSellerView.frame=CGRectMake(self.AllSellerView.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height+1, self.AllSellerView.frame.size.width, 0);
                    }
                    if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"]){
                        self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+5, self.tblReview.frame.size.width, 50);
                        
                    }
                    else if ([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)
                    {
                      self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+5, self.tblReview.frame.size.width,0);
                    }
                    else{
                        self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width, 280+(142*reviewArray.count));
                        
                    }

                    self.viewStore.frame=CGRectMake(self.viewStore.frame.origin.x, self.tblReview.frame.origin.y+self.tblReview.frame.size.height+10, self.viewStore.frame.size.width, self.viewStore.frame.size.height);

                    
                    self.tblRelated.frame=CGRectMake(self.tblRelated.frame.origin.x, self.viewStore.frame.origin.y+self.viewStore.frame.size.height+10, self.tblRelated.frame.size.width, 308*relatedItem.count);
                    self.tblRelated.dataSource=self;
                    self.tblRelated.delegate=self;
                    [self.tblRelated reloadData];
                   // [self.tblSubstituteMedicine reloadData];
                     [self.tblSeller reloadData];
                    [self.tblReview reloadData];
                       [self.col reloadData];
                    [self.colFree reloadData];

//                    self.tblOptionH.constant = self.tblOptions.frame.size.height;
//                    [self.tblOptions needsUpdateConstraints];
//                    self.tblImageH.constant = self.tblImages.frame.size.height;
//                    [self.tblImages needsUpdateConstraints];
//                    self.tblCustomOptionH.constant = self.tblCustomoptions.frame.size.height;
//                    [self.tblCustomoptions needsUpdateConstraints];
//                    self.tblSubscriptionH.constant = self.tblSubscription.frame.size.height;
//                    [self.tblSubscription needsUpdateConstraints];
//                    self.tblsubstituteMedH.constant = self.tblSubstituteMedicine.frame.size.height;
//                    [self.tblSubstituteMedicine needsUpdateConstraints];
//                    self.tblDescriptionH.constant = self.tblDescription.frame.size.height;
//                    [self.tblDescription needsUpdateConstraints];
//                    self.tblReviewH.constant = self.tblReview.frame.size.height;
//                    [self.tblReview needsUpdateConstraints];
//                    self.tblRelatedH.constant = self.tblRelated.frame.size.height;
//                    [self.tblRelated needsUpdateConstraints];
                    
                    
                    self.scrollViewObj.contentSize=CGSizeMake(0, self.tblRelated.frame.origin.y+self.tblRelated.frame.size.height+30);
                }
            }
        }
        [Loading dismiss];
    }
    else if ([[dictionary objectForKey:@"response"]isEqualToString:@"Exists"])
    {
        CartViewController *cart=[[CartViewController alloc]init];
        cart.fromDetail=@"yes";
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
    else
    {
        NSString *str=@"Ok";
        if (appDelObj.isArabic) {
            str=@" موافق ";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:nil]];
        
        [self presentViewController:alertController animated:YES completion:nil];
    }
    [Loading dismiss];
    

     [Loading dismiss];
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    CGRect frame = webView.frame;
    frame.size.height = 5.0f;
    webView.frame = frame;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
    
  

}
-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView==self.tblImages)
    {
        self.pager.currentPage=indexPath.row;
    }
}
-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (tableView==self.tblSubstituteMedicine)
    {
        return 30;
    }
    else
    {
         return 0;
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *view;
    if (tableView==self.tblSubstituteMedicine)
    {
        view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, self.tblSubstituteMedicine.frame.size.width, 30)];
          view.backgroundColor=[UIColor whiteColor];
       UILabel *lbl=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.tblSubstituteMedicine.frame.size.width, 30)];
        lbl.text=[NSString stringWithFormat:@"Substitute for %@",[DetailListAryData valueForKey:@"productTitle"]];
        lbl.font=[UIFont systemFontOfSize:15 weight:UIFontWeightBold];
        [view addSubview:lbl];
        return view;
       // return [NSString stringWithFormat:@"Substitute for %@",[DetailListAryData valueForKey:@"productTitle"]];
    }
    else{
    //UIView *view;
    view=[[UIView alloc]initWithFrame:CGRectMake(0, 0, 0, 5)];
    view.backgroundColor=[UIColor clearColor];

        return view;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblCustomoptions)
    {
        if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"file"]||[[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"datetime"]||[[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"time"]||[[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"date"]||[[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"textbox"]||[[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"select"]||[[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
        {
            return 65;
        }
        else
        {
            return 147;
        }
    }
    
    else  if (tableView==self.tblDescription)
    {
        if ([desSelRow containsIndex:indexPath.section])
        {
            if ([[[DescriptionArray objectAtIndex:indexPath.section]valueForKey:@"table"] isEqualToString:@"yes"])
            {
                return 40;
            }
            return 202;
        }
        return 40;
    }
    else  if (tableView==self.tblSubscription)
    {
        return 40;
    }
    else  if (tableView==self.tblReview)
    {
        if([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)
        {
            return 50;
        }
        else
        {
            if (indexPath.section==0)
            {
                return 180;
            }
            else
            {
                if (indexPath.row==0)
                {
                    return 50;
                }
            return 142;
            }
        }
        
    }
    else if (tableView==self.tblVarients||tableView==self.tblOptionsView)
    {
        return 44;
    }
    else if (tableView==self.tblRelated)
    {
        return 308;
    }
    else if (tableView==self.tblSeller)
    {
        if (indexPath.row==0) {
            NSString *logo=[NSString stringWithFormat:@"%@",[[sellerArray objectAtIndex:indexPath.section]  valueForKey:@"businessLogo"]];
   NSString *rate=[NSString stringWithFormat:@"%@",[[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"busRating"]  valueForKey:@"ratingCount"]];
            
            if (logo.length==0&&rate.length==0) {
                return 58;
            }
            return 101;
        }
        else{
            return 63;
        }
    }
    else if (tableView==self.tblImages)
    {
        return self.view.frame.size.width;
    }
    else  if (tableView==self.tblSubstituteMedicine)
    {
        return 62;
    }
    else
    {
        return 88;
    }
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    if (tableView==self.tblCustomoptions)
    {
        
        return customOption.count;
    }
    else  if (tableView==self.tblDescription)
    {
        return DescriptionArray.count;
    }
    else  if (tableView==self.tblReview)
    {
        if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"]){
            return 1;
        }
        else if(reviewArray.count==0)
        {
            return 0;
        }
        else
        {
        return 2;
        }
    }
    else if (tableView==self.tblRelated)
    {
        return relatedItem.count;
    }
    else if (tableView==self.tblSeller)
    {
        return sellerArray.count;
    }
    else if(tableView==self.tblOptionsView)
    {
        return 1;
        
    }
    else if (tableView==self.tblImages)    {
        return 1;
    }
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView==self.tblCustomoptions)
    {
        if ([[[customOption objectAtIndex:section]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
        {
            NSArray *a=[[customOption objectAtIndex:section]valueForKey:@"variants"];
            return a.count;
        }
        return  1;
    }
    else if (tableView==self.tblVarients)
    {
        return varientsArray.count;
    }
    else  if (tableView==self.tblDescription)
    {
        if ([[[DescriptionArray objectAtIndex:section]valueForKey:@"table"] isEqualToString:@"yes"]) {
            if([desSelRow containsIndex:section])
            {
                return specificationArray.count;
            }
                
            return 1;
        }
        return 1;
    }
    else  if (tableView==self.tblOptions)
    {
        return optionsArray.count;
    }
    else  if (tableView==self.tblReview)
    {
        if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"]){
            return 1;
            
        }
        else if([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)
        {
            return 1;
        }
        else{
            if (section==0)
            {
                return 1;
            }
            else
            {
                return reviewArray.count+1;
            }
        }
       
    }
    else  if (tableView==self.tblRelated)
    {
        return 1;
    }
    else if(tableView==self.tblSeller)
    {
        NSString *cod=[NSString stringWithFormat:@"%@",[[sellerArray objectAtIndex:section]valueForKey:@"cod_available"]];
        NSString *returnPolicy=[NSString stringWithFormat:@"%@",[[sellerArray objectAtIndex:section]valueForKey:@"productReturnable"] ];
        if ([cod isEqualToString:@"Yes"]&&[returnPolicy isEqualToString:@"Yes"])
        {
            return 4;
        }
        else
       {
           if (![cod isEqualToString:@"Yes"]&&![returnPolicy isEqualToString:@"Yes"])
           {
               return 2;
           }
           else
           {
               return 3;
           }
       }
        return 4;
    }
    else if(tableView==self.tblOptionsView)
    {
        return tierArray.count;
    }
    else if (tableView==self.tblImages)
    {
       // NSArray *imageArray=[DetailListAryData valueForKey:@"images"];
        if ([multipleImage isKindOfClass:[NSNull class]]||multipleImage.count==0)
        {
            
            return 0;
        }
        else
        {
            if (optionSelectForimage==0) {
                return multipleImage.count+1;
            }
            else
            {
                return multipleImage.count;
            }
        }
        //return multipleImage.count+1;
    }
    else  if (tableView==self.tblSubscription)
    {
        return subscriptionDetail.count;
    }
    else  if (tableView==self.tblSubstituteMedicine)
    {
        if ([substituteMedArray isKindOfClass:[NSNull class]]||substituteMedArray.count==0)
        {
            return 0;
        }
        else if (substituteMedArray.count<=3)
        {
            return substituteMedArray.count;
        }
        else
        {
            return 4;
        }
        //return substituteMedArray.count;
    }
        return 0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView==self.tblCustomoptions)
    {
            CusOptCell *cCell=[tableView dequeueReusableCellWithIdentifier:@"CusOptCell"];
            NSArray *cCellAry;
            if (cCell==nil)
            {
                cCellAry=[[NSBundle mainBundle]loadNibNamed:@"CusOptCell" owner:self options:nil];
            }
        if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"file"])
        {
            cCell=[cCellAry objectAtIndex:5];
        }
        else if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"datetime"])
        {
            cCell=[cCellAry objectAtIndex:0];
                

        }
        else if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"time"])
        {
            cCell=[cCellAry objectAtIndex:1];
           
        }
        else if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"date"])
        {
            cCell=[cCellAry objectAtIndex:2];
           
        }
        else if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"textbox"])
        {
            cCell=[cCellAry objectAtIndex:4];
        }
        else if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"textarea"])
        {
            cCell=[cCellAry objectAtIndex:6];
        }
        else if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
        {
            cCell=[cCellAry objectAtIndex:7];
        }
        else 
        {
            cCell=[cCellAry objectAtIndex:3];
        }
        if (appDelObj.isArabic)
        {
            cCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
            cCell.txtDay.transform = CGAffineTransformMakeScale(-1, 1);
            cCell.txtHour.transform = CGAffineTransformMakeScale(-1, 1);
            cCell.text.transform = CGAffineTransformMakeScale(-1, 1);
            cCell.img1.transform = CGAffineTransformMakeScale(-1, 1);
            cCell.lblName.textAlignment=NSTextAlignmentRight;
            cCell.txtDay.textAlignment=NSTextAlignmentRight;
            cCell.txtHour.textAlignment=NSTextAlignmentRight;
            cCell.text.textAlignment=NSTextAlignmentRight;
            cCell.txtHour.placeholder=cell.txtDay.placeholder=@"تحديد";
        }
        cCell.selectionStyle=UITableViewCellSelectionStyleNone;
        if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
        {
            if (indexPath.row==0)
            {
                
                cCell.infoIm.alpha=1;
                NSString *st=[[customOption objectAtIndex:indexPath.section]valueForKey:@"validateRule"] ;
                NSArray *a=[st componentsSeparatedByString:@"~"];
                
                if ([[a objectAtIndex:0]isEqualToString:@"required"]||[[a objectAtIndex:0]isEqualToString:@"Required"])
                {
                    NSMutableAttributedString *stringS = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ *", [[customOption objectAtIndex:indexPath.section]valueForKey:@"customOptionName"]]];

                    [stringS beginEditing];
                    [stringS addAttribute:NSForegroundColorAttributeName
                                    value:[UIColor redColor]  range:NSMakeRange(stringS.length-1, 1)];
                    
                    [stringS endEditing];
                    
                    [cCell.lblName setAttributedText:stringS];
                }
                else
                {
                    cCell.lblName.text=[[customOption objectAtIndex:indexPath.section]valueForKey:@"customOptionName"];
                }
                cCell.INFODelegate=self;
                cCell.btnInfo.tag=indexPath.section;
            }
            else
            {
                 cCell.infoIm.alpha=0;
                cCell.btnInfo.alpha=0;

                cCell.lblName.alpha=0;
            }
            NSArray *a=[[customOption objectAtIndex:indexPath.section]valueForKey:@"variants"];
            if (indexPath.row==a.count) {
                cCell.linr.alpha=1;
            }
            else
            {
                cCell.linr.alpha=0;
            }
            cCell.txtDay.text=[[[[customOption objectAtIndex:indexPath.section]valueForKey:@"variants"]objectAtIndex:indexPath.row]valueForKey:@"value"];
            cCell.txtDay.userInteractionEnabled=NO;
            if ([selectMultiSelectvariant containsIndex:indexPath.row])
            {
                cCell.img1.image=[UIImage imageNamed:@"login-select.png"];
            }
            else
            {
                cCell.img1.image=[UIImage imageNamed:@"login-select-2.png"];
                
            }
        }
        else
        {
            NSString *st=[[customOption objectAtIndex:indexPath.section]valueForKey:@"validateRule"] ;
            NSArray *a=[st componentsSeparatedByString:@"~"];
            
            if ([[a objectAtIndex:0]isEqualToString:@"required"]||[[a objectAtIndex:0]isEqualToString:@"Required"])
            {
                NSMutableAttributedString *stringS = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@ *", [[customOption objectAtIndex:indexPath.section]valueForKey:@"customOptionName"]]];
                
                [stringS beginEditing];
                [stringS addAttribute:NSForegroundColorAttributeName
                                value:[UIColor redColor]  range:NSMakeRange(stringS.length-1, 1)];
                
                [stringS endEditing];
                
                [cCell.lblName setAttributedText:stringS];
            }
            else
            {
                cCell.lblName.text=[[customOption objectAtIndex:indexPath.section]valueForKey:@"customOptionName"];
            }
            cCell.INFODelegate=self;
            cCell.btnInfo.tag=indexPath.section;
            cCell.btnClock.tag=indexPath.section;
            cCell.btnSelect.tag=indexPath.section;
        }
       

        return cCell;
    }
    else  if (tableView==self.tblSubscription)
    {
        subscriptionCell *subscription=[tableView dequeueReusableCellWithIdentifier:@"subscriptionCell"];
        NSArray *cCellAry;
        if (subscription==nil)
        {
            cCellAry=[[NSBundle mainBundle]loadNibNamed:@"subscriptionCell" owner:self options:nil];
        }
        subscription=[cCellAry objectAtIndex:0];
         subscription.selectionStyle=UITableViewCellSelectionStyleNone;
        subscription.lblName.text=[NSString stringWithFormat:@"%@(%@ Deliveries)",[[subscriptionDetail objectAtIndex:indexPath.row]valueForKey:@"subscriptionDurationName"],[[subscriptionDetail objectAtIndex:indexPath.row]valueForKey:@"deliveries"]];
        if ([subSelIndex containsIndex:indexPath.row])
        {
            subscription.imgSel.image=[UIImage imageNamed:@"lan-button-active.png"];

        }
        else{
            subscription.imgSel.image=[UIImage imageNamed:@"lan-button.png"];

        }
//        float price=[[DetailListAryData valueForKey:@"productOptionProductPrice"]floatValue];
//        int deliveries=[[[subscriptionDetail objectAtIndex:indexPath.row]valueForKey:@"deliveries"]intValue];
//        float save=[[DetailListAryData valueForKey:@"subscriptionDiscount"]floatValue];
//        float priceValue=(price*deliveries)-((price*deliveries*save)/100);
        subscription.lblPrice.text=[NSString stringWithFormat:@"%@ %@",[[subscriptionDetail objectAtIndex:indexPath.row]valueForKey:@"price"],appDelObj.currencySymbol];;
        if (appDelObj.isArabic) {
            subscription.lblPrice.text=[NSString stringWithFormat:@"%@ %@",[[subscriptionDetail objectAtIndex:indexPath.row]valueForKey:@"price"],appDelObj.currencySymbol];;

        }
        return subscription;
    }
    else  if (tableView==self.tblSubstituteMedicine)
    {
        MedicineCell *substitution=[tableView dequeueReusableCellWithIdentifier:@"MedicineCell"];
        NSArray *cCellAry;
        if (substitution==nil)
        {
            cCellAry=[[NSBundle mainBundle]loadNibNamed:@"MedicineCell" owner:self options:nil];
        }
        substitution=[cCellAry objectAtIndex:0];
         substitution.selectionStyle=UITableViewCellSelectionStyleNone;
        substitution.DEL=self;
        if (substituteMedArray.count==0)
        {
        }
        else if (substituteMedArray.count<=3)
        {
//            if (indexPath.row==substituteMedArray.count)
//            {
//                substitution.lblName.alpha=0;
//                substitution.lblSave.alpha=0;
//                substitution.lblPrice.alpha=0;
//                substitution.lblSeller.alpha=0;
//                substitution.btnview.alpha=1;
//            }
//            else{
                substitution.lblName.alpha=1;
                substitution.lblSave.alpha=1;
                substitution.lblPrice.alpha=1;
                substitution.lblSeller.alpha=1;
                substitution.btnview.alpha=0;
                substitution.lblName.text=[[substituteMedArray objectAtIndex:indexPath.row]valueForKey:@"productTitle"];
                float theFloat1 = [[[substituteMedArray objectAtIndex:indexPath.row]valueForKey:@"offerPrice"]floatValue];
                
                NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",theFloat1,appDelObj.currencySymbol]];
            if (appDelObj.isArabic) {
                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",theFloat1,appDelObj.currencySymbol]];
            }
                substitution.lblPrice.attributedText=str;
                
                substitution.lblSeller.text=[[substituteMedArray objectAtIndex:indexPath.row]valueForKey:@"businessName"];
                float theFloat = [[[substituteMedArray objectAtIndex:indexPath.row]valueForKey:@"productOptionOfferDiscount"]floatValue];
                CGFloat val = theFloat;
                
                // CGFloat rounded_down = floorf(val * 100) / 100;   /* Result: 37.77 */
                //CGFloat nearest = floorf(val * 100 + 0.5) / 100;  /* Result: 37.78 */
                //CGFloat rounded_up = ceilf(val * 100) / 100;
                
                NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f%@",theFloat,@"%"]];
                
                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                    initWithAttributedString:str1];
                [string addAttribute:NSForegroundColorAttributeName
                               value:appDelObj.redColor
                               range:NSMakeRange(0, [string length])];
              
                [string addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                               range:NSMakeRange(0, [string length])];
           
                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  ",[NSString stringWithFormat:@"%@",[[substituteMedArray objectAtIndex:indexPath.row]valueForKey:@"SaveorPay"]]]];
                [price addAttribute:NSForegroundColorAttributeName
                              value:appDelObj.priceColor
                              range:NSMakeRange(0, [price length])];
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
                [price appendAttributedString:string];
                substitution.lblSave.attributedText=price;
//            }
            
        }
        else
        {
            if (indexPath.row==3)
            {
                substitution.lblName.alpha=0;
                substitution.lblSave.alpha=0;
                substitution.lblPrice.alpha=0;
                substitution.lblSeller.alpha=0;
                substitution.btnview.alpha=1;
            }
            else
            {
                substitution.lblName.alpha=1;
                substitution.lblSave.alpha=1;
                substitution.lblPrice.alpha=1;
                substitution.lblSeller.alpha=1;
                substitution.btnview.alpha=0;
                substitution.lblName.text=[[substituteMedArray objectAtIndex:indexPath.row]valueForKey:@"productTitle"];
                float theFloat1 = [[[substituteMedArray objectAtIndex:indexPath.row]valueForKey:@"offerPrice"]floatValue];
                
                NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %.2f %@",theFloat1,appDelObj.currencySymbol]];
                if (appDelObj.isArabic) {
                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f %@",theFloat1,appDelObj.currencySymbol]];
                }
                substitution.lblPrice.attributedText=str;
                
                substitution.lblSeller.text=[[substituteMedArray objectAtIndex:indexPath.row]valueForKey:@"businessName"];
                float theFloat = [[[substituteMedArray objectAtIndex:indexPath.row]valueForKey:@"productOptionOfferDiscount"]floatValue];
                CGFloat val = theFloat;
                
                // CGFloat rounded_down = floorf(val * 100) / 100;   /* Result: 37.77 */
                //CGFloat nearest = floorf(val * 100 + 0.5) / 100;  /* Result: 37.78 */
                //CGFloat rounded_up = ceilf(val * 100) / 100;
                
                NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f%@",theFloat,@"%"]];
                
                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                                    initWithAttributedString:str1];
                [string addAttribute:NSForegroundColorAttributeName
                               value:appDelObj.redColor
                               range:NSMakeRange(0, [string length])];
             
                [string addAttribute:NSFontAttributeName
                               value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                               range:NSMakeRange(0, [string length])];
                [string addAttribute:NSStrikethroughStyleAttributeName
                               value:@2
                               range:NSMakeRange(0, [string length])];
                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  ",[NSString stringWithFormat:@"%@",[[substituteMedArray objectAtIndex:indexPath.row]valueForKey:@"SaveorPay"]]]];
                [price addAttribute:NSForegroundColorAttributeName
                              value:appDelObj.priceColor
                              range:NSMakeRange(0, [price length])];
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
                [price appendAttributedString:string];
                substitution.lblSave.attributedText=price;
            }
        }
        
        
      
        return substitution;
    }
    else if (tableView==self.tblVarients)
    {
        SelectVarCell *cCell=[tableView dequeueReusableCellWithIdentifier:@"SelectVarCell"];
        NSArray *cCellAry;
        if (cCell==nil)
        {
            cCellAry=[[NSBundle mainBundle]loadNibNamed:@"SelectVarCell" owner:self options:nil];
            
        }
        cCell=[cCellAry objectAtIndex:0];
         cCell.selectionStyle=UITableViewCellSelectionStyleNone;
        if ([varientSelect containsIndex:indexPath.row])
        {
            cCell.imgSelect.image=[UIImage imageNamed:@"login-select.png"];
        }
        else
        {
            cCell.imgSelect.image=[UIImage imageNamed:@"login-select-2.png"];
        }
        if (appDelObj.isArabic)
        {
            cCell.imgSelect.transform = CGAffineTransformMakeScale(-1, 1);
            cCell.lblSelVarients.transform = CGAffineTransformMakeScale(-1, 1);

            cCell.lblSelVarients.textAlignment=NSTextAlignmentRight;
        }
        cCell.lblSelVarients.text=[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"value"];
        cCell.selectionStyle=UITableViewCellSelectionStyleNone;
        return cCell;
    }
    else  if (tableView==self.tblDescription)
    {
        if ([[[DescriptionArray objectAtIndex:indexPath.section]valueForKey:@"table"] isEqualToString:@"yes"]&&[desSelRow containsIndex:indexPath.section]&&indexPath.row!=0)
        {
            SpecificationCell *desCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *desCellAry;
            if (desCell==nil)
            {
                desCellAry=[[NSBundle mainBundle]loadNibNamed:@"SpecificationCell" owner:self options:nil];
            }
            desCell=[desCellAry objectAtIndex:0];
            desCell.selectionStyle=UITableViewCellSelectionStyleNone;
            desCell.clipsToBounds=YES;
            desCell.layer.borderWidth=1;
            desCell.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
            if (appDelObj.isArabic)
            {
                desCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
                desCell.lblValue.transform = CGAffineTransformMakeScale(-1, 1);
                desCell.lblName.textAlignment=NSTextAlignmentRight;
                desCell.lblValue.textAlignment=NSTextAlignmentRight;
            }
      
            desCell.lblName.text=[[specificationArray objectAtIndex:indexPath.row-1]valueForKey:@"attrName"];
            desCell.lblValue.text=[[specificationArray objectAtIndex:indexPath.row-1]valueForKey:@"attrValue"];
           
            return desCell;
            
        }
        else
        {
            DescriptionCell *desCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *desCellAry;
            if (desCell==nil)
            {
                desCellAry=[[NSBundle mainBundle]loadNibNamed:@"DescriptionCell" owner:self options:nil];
            }
            desCell=[desCellAry objectAtIndex:0];
            desCell.clipsToBounds=YES;
            desCell.layer.borderWidth=1;
            desCell.layer.borderColor=[[UIColor colorWithRed:0.902 green:0.902 blue:0.902 alpha:1.00]CGColor];
            desCell.selectionStyle=UITableViewCellSelectionStyleNone;
            desCell.btnViewMore.tag=indexPath.section;
            //desCell.DEL=self;
            desCell.btnViewMore.alpha=1;
            if (appDelObj.isArabic)
            {
                desCell.btnViewMore.transform = CGAffineTransformMakeScale(-1, 1);
                desCell.lblTitle.transform = CGAffineTransformMakeScale(-1, 1);
                desCell.detail.transform = CGAffineTransformMakeScale(-1, 1);
                desCell.lblTitle.textAlignment=NSTextAlignmentRight;
                [desCell.btnViewMore setTitle:@"عرض المزيد" forState:UIControlStateNormal];
                //desCell.detail.textAlignment=NSTextAlignmentRight;
            }
            if (indexPath.row==0) {
                desCell.act.alpha=0;
                desCell.detail.alpha=0;
                desCell.btnViewMore.alpha=0;
            }
            if ([[[DescriptionArray objectAtIndex:indexPath.section]valueForKey:@"table"] isEqualToString:@"yes"]) {
                desCell.act.alpha=0;
                desCell.detail.alpha=0;
                desCell.btnViewMore.alpha=0;
            }
            if ([desSelRow containsIndex:indexPath.section])
            {
                desCell.act.alpha=1;
                desCell.detail.alpha=1;
                desCell.btnViewMore.alpha=1;
                desCell.lblTitle.text=[[DescriptionArray objectAtIndex:indexPath.section ]  valueForKey:@"DesName"];
                if ([[[DescriptionArray objectAtIndex:indexPath.section]valueForKey:@"table"] isEqualToString:@"yes"]) {
                    desCell.act.alpha=0;
                    desCell.detail.alpha=0;
                    desCell.btnViewMore.alpha=0;
                }
                else
                {
                     desCell.act.alpha=1;
                    if (appDelObj.isArabic) {
                        [desCell.detail loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@<div>",[[DescriptionArray objectAtIndex:indexPath.section ]  valueForKey:@"Des"] ]baseURL:nil];
                        //[self.web loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@<div>",[[dictionary objectForKey:@"results" ] objectForKey:@"contentDescription"]] baseURL:nil];
                    }
                    else
                    {
                        [desCell.detail loadHTMLString:[NSString stringWithFormat:@"<div dir='rtl'>%@<div>",[[DescriptionArray objectAtIndex:indexPath.section ]  valueForKey:@"Des"] ]baseURL:nil];
                    }
                    desCell.btnViewMore.alpha=1;
                }
                desCell.imgPlus.image=[UIImage imageNamed:@"min-.png"];
            }
            else
            {
                 desCell.act.alpha=0;
                desCell.detail.alpha=0;
                desCell.btnViewMore.alpha=0;
                //[desCell.btnPlus setTitle:@"+" forState:UIControlStateNormal];
                
                desCell.imgPlus.image=[UIImage imageNamed:@"plu+.png"];
                desCell.lblTitle.text=[[DescriptionArray objectAtIndex:indexPath.section ]  valueForKey:@"DesName"];
                
                
            }
            desCell.DEL=self;
            return desCell;
        }
       
    }
    else  if (tableView==self.tblReview)
    {
        if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"])
        {
            RiviewListCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"RiviewListCell" owner:self options:nil];
                
            }
            listCell=[listCellAry objectAtIndex:1];
            if (appDelObj.isArabic)
            {
                 listCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
                 listCell.lblDate.transform = CGAffineTransformMakeScale(-1, 1);
                 listCell.lbltitle.transform = CGAffineTransformMakeScale(-1, 1);
                 listCell.lblLetter.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.btnR.transform = CGAffineTransformMakeScale(-1, 1);
                [listCell.btnR setBackgroundImage:[UIImage imageNamed:@"write-a-review-ar.png"] forState:UIControlStateNormal];
                 listCell.txtDes.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblName.textAlignment=NSTextAlignmentRight;
                listCell.lblDate.textAlignment=NSTextAlignmentRight;
                listCell.lbltitle.textAlignment=NSTextAlignmentRight;
                listCell.txtDes.textAlignment=NSTextAlignmentRight;

                listCell.already.text=@"لقد قمت بتقيم هذا المنتج";
            }
            else
            {
                listCell.already.text=@"You are already review this product";
            }
            listCell.reviewDEL=self;
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (alreadyReview>0) {
                listCell.already.alpha=1;
                 listCell.btnR.alpha=0;
            }
            else
            {
                listCell.already.alpha=0;
                listCell.btnR.alpha=1;
            }
            return listCell;
        }
        else
        {
        if (indexPath.section==0)
        {
            ReviewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"ReviewCell" owner:self options:nil];
                
            }
            listCell=[listCellAry objectAtIndex:0];
             listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (appDelObj.isArabic)
            {
                listCell.lblTitle.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblrate.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblCount.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lbl1.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lbl2.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lbl3.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lbl4.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lbl5.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.imm.transform = CGAffineTransformMakeScale(-1, 1);
               

                listCell.lblTitle.textAlignment=NSTextAlignmentRight;
                listCell.lblrate.textAlignment=NSTextAlignmentRight;
                listCell.lblCount.textAlignment=NSTextAlignmentRight;
                listCell.lbl5.textAlignment=NSTextAlignmentRight;
                listCell.lbl4.textAlignment=NSTextAlignmentRight;
                listCell.lbl3.textAlignment=NSTextAlignmentRight;
                listCell.lbl2.textAlignment=NSTextAlignmentRight;
                listCell.lbl1.textAlignment=NSTextAlignmentRight;
                listCell.lblTitle.text=@"إعادة النظر";
            }
            if(DetailListAryData.count!=0)
            {
            //NSArray *arrRate=[[[DetailListAryData valueForKey:@"result"]valueForKey:@"resTotProductReviewDetails"]valueForKey:@"resProductReview"];
                listCell.lblrate.text=listCell.lblCount.text=[NSString stringWithFormat:@"%@",[[DetailListAryData valueForKey:@"resTotProductReviewDetails"]valueForKey:@"avgratings"]];
                listCell.lblrate.text=[NSString stringWithFormat:@"%@ rating and %lu reviews",[[DetailListAryData valueForKey:@"resTotProductReviewDetails"]valueForKey:@"avgratings"],(unsigned long)reviewArray.count];
                if (appDelObj.isArabic) 
                {
                    listCell.lblrate.text=[NSString stringWithFormat:@" تصنيف و %lu استعراض %@",(unsigned long)reviewArray.count,[[DetailListAryData valueForKey:@"resTotProductReviewDetails"]valueForKey:@"avgratings"]];
                    listCell.imm.image=[UIImage imageNamed:@"rating-ar.png"];
                }
                listCell.lbl5.text=[NSString stringWithFormat:@"%@",[[[[DetailListAryData valueForKey:@"resTotProductReviewDetails"]valueForKey:@"resProductReview"]objectAtIndex:0]valueForKey:@"rateCnt"]];
                listCell.lbl4.text=[NSString stringWithFormat:@"%@",[[[[DetailListAryData valueForKey:@"resTotProductReviewDetails"]valueForKey:@"resProductReview"]objectAtIndex:1]valueForKey:@"rateCnt"]];
                listCell.lbl3.text=[NSString stringWithFormat:@"%@",[[[[DetailListAryData valueForKey:@"resTotProductReviewDetails"]valueForKey:@"resProductReview"]objectAtIndex:2]valueForKey:@"rateCnt"]];
                listCell.lbl2.text=[NSString stringWithFormat:@"%@",[[[[DetailListAryData valueForKey:@"resTotProductReviewDetails"]valueForKey:@"resProductReview"]objectAtIndex:3]valueForKey:@"rateCnt"]];
                listCell.lbl1.text=[NSString stringWithFormat:@"%@",[[[[DetailListAryData valueForKey:@"resTotProductReviewDetails"]valueForKey:@"resProductReview"]objectAtIndex:4]valueForKey:@"rateCnt"]];
            }

           
            return listCell;
            
        
        }
        else
        {
            RiviewListCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"RiviewListCell" owner:self options:nil];
                
            }
            
             listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            if (indexPath.row==0)
            {
                listCell=[listCellAry objectAtIndex:1];
                if (appDelObj.isArabic) {
                    listCell.btnR.transform = CGAffineTransformMakeScale(-1, 1);
                    self.lblName.transform = CGAffineTransformMakeScale(-1, 1);
                    [listCell.btnR setBackgroundImage:[UIImage imageNamed:@"write-a-review-ar.png"] forState:UIControlStateNormal];
                    listCell.already.text=@"لقد قمت بتقيم هذا المنتج";
                }
                else
                {
                    listCell.already.text=@"You are already review this product";
                }
                listCell.reviewDEL=self;
                if (alreadyReview>0) {
                    listCell.already.alpha=1;
                    
                    listCell.btnR.alpha=0;
                }
                else
                {
                    listCell.already.alpha=0;
                    listCell.btnR.alpha=1;
                }
            }
            else{
                listCell=[listCellAry objectAtIndex:0];
            if(reviewArray.count!=0)
            {
                listCell.lblName.text=[NSString stringWithFormat:@"%@ %@",[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"userFirstName"],[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"userLastName"]];
                NSString *sName=[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"userFirstName"];
                listCell.lblLetter.text=[sName substringToIndex:1];
                NSString *str=[[reviewArray objectAtIndex:indexPath.row-1]valueForKey:@"reviwedDate"];
                NSArray *a=[str componentsSeparatedByString:@" "];
                listCell.lblDate.text=[a objectAtIndex:0];
                listCell.lbltitle.text=[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"reviewTitle"];
                listCell.txtDes.text=[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"reviewText"];
                
                int t=[ [[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"isCertifiedUser"]intValue];
                if (t==1) {
                    listCell.already.text=[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"lblcertifiedbuyer"];
                }
                else
                {
                    listCell.already.text=@"";
                }
                
                if ([[NSString stringWithFormat:@"%@",[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"productRating"]] isEqualToString:@"0"])
                {
                    listCell.imgrate1.image=[UIImage imageNamed:@"star-3.png"];
                    listCell.imgrate2.image=[UIImage imageNamed:@"star-3.png"];
                    listCell.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
                    listCell.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                    listCell.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                    
                }
                else if ([[NSString stringWithFormat:@"%@",[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"productRating"]] isEqualToString:@"1"])
                {
                    listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate2.image=[UIImage imageNamed:@"star-3.png"];
                    listCell.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
                    listCell.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                    listCell.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                    
                }
                else if ([[NSString stringWithFormat:@"%@",[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"productRating"]] isEqualToString:@"2"])
                {
                    listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
                    listCell.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                    listCell.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                    
                }
                else if ([[NSString stringWithFormat:@"%@",[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"productRating"]] isEqualToString:@"3"])
                {
                    listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                    listCell.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                    
                }
                else if ([[NSString stringWithFormat:@"%@",[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"productRating"]] isEqualToString:@"4"])
                {
                    listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate4.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                    
                }
                else if ([[NSString stringWithFormat:@"%@",[[reviewArray objectAtIndex:indexPath.row-1] valueForKey:@"productRating"]] isEqualToString:@"5"])
                {
                    listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate4.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate5.image=[UIImage imageNamed:@"star-1.png"];
                    
                }
            }
            }if (appDelObj.isArabic)
            {
                listCell.lblName.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblDate.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lbltitle.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblLetter.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.txtDes.transform = CGAffineTransformMakeScale(-1, 1);
                //listCell.lblLetter.textAlignment=NSTextAlignmentRight;
                listCell.lblName.textAlignment=NSTextAlignmentRight;
                listCell.lblDate.textAlignment=NSTextAlignmentLeft;
                listCell.lbltitle.textAlignment=NSTextAlignmentRight;
                listCell.txtDes.textAlignment=NSTextAlignmentRight;
                 listCell.already.textAlignment=NSTextAlignmentLeft;
                  listCell.already.transform = CGAffineTransformMakeScale(-1, 1);
            }
            return listCell;
        }
        }
    }
    else  if (tableView==self.tblRelated)
    {
        
        SimilarTableViewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SimilarTableViewCell" owner:self options:nil];
            
        }
        listCell=[listCellAry objectAtIndex:0];
        if (appDelObj.isArabic)
        {
            listCell.lblItem.transform = CGAffineTransformMakeScale(-1, 1);
            
            listCell.lblItem.textAlignment=NSTextAlignmentRight;
            
        }
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        listCell.colItem.tag=indexPath.section;
        listCell.ViewDEL=self;
        appDelObj.DetailImgURL=imgUrl;
        [listCell setCollectionData:[[relatedItem objectAtIndex:indexPath.section]valueForKey:@"Data"]];
        listCell.lblItem.text=[[relatedItem objectAtIndex:indexPath.section]valueForKey:@"name"];
//        if (indexPath.section==0)
//        {
//            [listCell setCollectionData:[relatedItem valueForKey:@"related"]];
//            listCell.lblItem.text=@"Related Products";
//        }
//        else if (indexPath.section==1)
//        {
//            [listCell setCollectionData:[relatedItem valueForKey:@"upsell"]];
//            listCell.lblItem.text=@"Frequently bought together";
//        }
//        else
//        {
//            [listCell setCollectionData:[relatedItem valueForKey:@"crossel"]];
//            listCell.lblItem.text=@"You may also like";
//        }
        return listCell;
        
    }
    else if(tableView==self.tblOptions)
    {
       OptionCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"OptionCell" owner:self options:nil];
        }
        listCell=[listCellAry objectAtIndex:0];
         listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        if (appDelObj.isArabic==YES)
        {
             listCell.lblOptionName.transform = CGAffineTransformMakeScale(-1, 1);
             listCell.lblOptionPrice.transform = CGAffineTransformMakeScale(-1, 1);
            listCell.btnView.transform = CGAffineTransformMakeScale(-1, 1);
            [listCell.btnView setTitle:@" عرض" forState:UIControlStateNormal];
            listCell.lblOptionName.textAlignment=NSTextAlignmentRight;
            listCell.lblOptionPrice.textAlignment=NSTextAlignmentRight;
            
        }
        else
        {
            listCell.lblOptionName.textAlignment=NSTextAlignmentLeft;
            listCell.lblOptionPrice.textAlignment=NSTextAlignmentLeft;
            
        }
        
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        listCell.lblOptionName.text=[NSString stringWithFormat:@"%@",[[optionsArray objectAtIndex:indexPath.row]valueForKey:@"productOptionName"]];
        
        NSString *s1=[NSString stringWithFormat:@"%@",[[optionsArray objectAtIndex:indexPath.row ]   valueForKey:@"offerPrice"]];
        NSString *s2=[NSString stringWithFormat:@"%@",[[optionsArray objectAtIndex:indexPath.row ]   valueForKey:@"productOptionRegularPrice"]];
        if (s1.length!=0&&s2.length!=0)
        {
            float x=[s1 floatValue];
            float x1=[s2 floatValue];
       
            NSString *p1=[NSString stringWithFormat:@"%.2f",x1];
            NSString *p2=[NSString stringWithFormat:@"%.2f",x];
            if ([s1 isEqualToString:s2])
            {
                NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
                
                
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
                listCell.lblOptionPrice.attributedText=string;
            }
            else
            {
              
                
                
                NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
                
                
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
                                   value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                                   range:NSMakeRange(0, [string length])];
                }
                [string addAttribute:NSStrikethroughStyleAttributeName
                               value:@2
                               range:NSMakeRange(0, [string length])];
                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
                if (appDelObj.isArabic) {
                    price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
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
                [price appendAttributedString:string];
                listCell.lblOptionPrice.attributedText=price;
            }
           
        }
        
        else
            
        {
            listCell.lblOptionPrice.text=@"";
        }
        
        
        if ([optionSelect containsIndex:indexPath.row])
        {
            listCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
        }
        else
        {
            if([optionSelect isKindOfClass:[NSNull class]]||optionSelect.count==0)
            {
                if (indexPath.row==0)
                {
                 listCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
                }
                else{
                    listCell.imgSelect.image=[UIImage imageNamed:@"lan-button.png"];
                }
            }
            else
            {
                listCell.imgSelect.image=[UIImage imageNamed:@"lan-button.png"];
            }
//            if (indexPath.row==0)
//            {
//                listCell.imgSelect.image=[UIImage imageNamed:@"lan-button-active.png"];
//
//            }
//            else
//            {
            
                
            //}
        }
        listCell.btnView.tag=indexPath.row;
        listCell.DEL=self;
        NSArray *optArr=[[optionsArray objectAtIndex:indexPath.row]   valueForKey:@"tierPrices"];
        if ([optArr isKindOfClass:[NSNull class]]||optArr.count==0)
        {
            listCell.btnView.alpha=0;
        }
        return listCell;
    }
    else if(tableView==self.tblOptionsView)
    {
        OptionViewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
        NSArray *listCellAry;
        if (listCell==nil)
        {
            listCellAry=[[NSBundle mainBundle]loadNibNamed:@"OptionViewCell" owner:self options:nil];
            
        }
        listCell=[listCellAry objectAtIndex:0];
        if (appDelObj.isArabic==YES)
        {
            listCell.lblOptViewList.transform = CGAffineTransformMakeScale(-1, 1);
            listCell.lblOptViewList.textAlignment=NSTextAlignmentRight;
            
        }
        listCell.selectionStyle=UITableViewCellSelectionStyleNone;
        //listCell.lblOptViewList.text=[NSString stringWithFormat:@"%@",[[tierArray objectAtIndex:indexPath.row]valueForKey:@"productOptionName"]];
    
       // float x=[[[tierArray objectAtIndex:indexPath.row]   valueForKey:@"quantity"] intValue];
        float x1=[[[tierArray objectAtIndex:indexPath.row]   valueForKey:@"tierPrice"] floatValue];
        NSString *s1=[NSString stringWithFormat:@"%@",[[tierArray objectAtIndex:indexPath.row]   valueForKey:@"quantity"]] ;
        NSString *s2=[NSString stringWithFormat:@"%.02f",x1 ];
        NSString *p1=s1;
        NSString *p2=s2;
        
        NSMutableAttributedString *priceBuy=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@  ",@"Buy"]];
        [priceBuy addAttribute:NSForegroundColorAttributeName
                      value:[UIColor blackColor]
         
                      range:NSMakeRange(0, [priceBuy length])];
        [priceBuy addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                      range:NSMakeRange(0, [priceBuy length])];
        
        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ ",p1]];
        [price addAttribute:NSForegroundColorAttributeName
                      value:[UIColor colorWithRed:0.953 green:0.506 blue:0.204 alpha:1.00]
         
                      range:NSMakeRange(0, [price length])];
        [price addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                      range:NSMakeRange(0, [price length])];
        NSMutableAttributedString *priceFor=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ ",@"for"]];
        [priceBuy appendAttributedString:price];
        [priceFor addAttribute:NSForegroundColorAttributeName
                      value:[UIColor blackColor]
         
                      range:NSMakeRange(0, [priceFor length])];
        [priceFor addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                      range:NSMakeRange(0, [priceFor length])];
        
        
        NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@ ",p2,appDelObj.currencySymbol]];
        if (appDelObj.isArabic) {
            str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@ ",p2,appDelObj.currencySymbol]];
        }
        [priceBuy appendAttributedString:priceFor];
        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]
                                            initWithAttributedString:str];
        [string addAttribute:NSForegroundColorAttributeName
                       value:[UIColor colorWithRed:0.953 green:0.506 blue:0.204 alpha:1.00]
                       range:NSMakeRange(0, [string length])];
        
        [string addAttribute:NSFontAttributeName
                       value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                       range:NSMakeRange(0, [string length])];
        //[string replaceCharactersInRange:NSMakeRange(0, 2) withString:appDelObj.currencySymbol];
       
        [priceBuy appendAttributedString:string];
        
        NSMutableAttributedString *priceo=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ ",@"each and save"]];
        [priceo addAttribute:NSForegroundColorAttributeName
                         value:[UIColor blackColor]
         
                         range:NSMakeRange(0, [priceo length])];
        [priceo addAttribute:NSFontAttributeName
                         value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                         range:NSMakeRange(0, [priceo length])];
        
        [priceBuy appendAttributedString:priceo];
        
         int qty=[[[tierArray objectAtIndex:indexPath.row]   valueForKey:@"quantity"] intValue];
        float priceitem=[[[tierArray objectAtIndex:indexPath.row]   valueForKey:@"tierPrice"] floatValue];
        float productPrice=[[[optionsArray objectAtIndex:tierSelInd]   valueForKey:@"productOptionRegularPrice"] floatValue];

        float tierOpt=priceitem*qty;
        float final =((productPrice-tierOpt)/productPrice)*100;
        NSString *sFinal=[NSString stringWithFormat:@"%.02f",final ];
        
        
        NSMutableAttributedString *priceOff=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@ ",sFinal,appDelObj.currencySymbol]];
        if (appDelObj.isArabic) {
            priceOff=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@ ",sFinal,appDelObj.currencySymbol]];
        }
        [priceOff addAttribute:NSForegroundColorAttributeName
                      value:[UIColor colorWithRed:0.953 green:0.506 blue:0.204 alpha:1.00]
         
                      range:NSMakeRange(0, [priceOff length])];
        [priceOff addAttribute:NSFontAttributeName
                      value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                      range:NSMakeRange(0, [priceOff length])];
         [priceBuy appendAttributedString:priceOff];
        if (appDelObj.isArabic) {
            [priceBuy addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                          range:NSMakeRange(0, [priceBuy length])];
        }
        //saleprice-offerprice/saleprice *100

        listCell.lblOptViewList.text=[[tierArray objectAtIndex:indexPath.row]valueForKey:@"tierLabel"];
        //[price appendAttributedString:string];
        
        
        if ([tierSel containsIndex:indexPath.row])
        {
            listCell.imgSel.image=[UIImage imageNamed:@"lan-button-active.png"];
            
        }
        else
        {
            if (indexPath.row==0)
            {
                listCell.imgSel.image=[UIImage imageNamed:@"lan-button-active.png"];
                
            }
            else
            {
                    listCell.imgSel.image=[UIImage imageNamed:@"lan-button.png"];
                    
            }
            
        }
        
        return listCell;
        
    }
    
    else if (tableView==self.tblSeller)
    {
        if (indexPath.row==0)
        {
            SellerCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SellerCell" owner:self options:nil];
            }
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            listCell=[listCellAry objectAtIndex:0];
            if (appDelObj.isArabic==YES)
            {
                listCell.lblAvg.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.imgrate1.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.imgrate2.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.imgrate3.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.imgrate4.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.imgrate5.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblTitle.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblAvgCount.transform = CGAffineTransformMakeScale(-1, 1);
           
                listCell.imgSellerLogo.transform = CGAffineTransformMakeScale(-1, 1);
                
                listCell.lblAvg.textAlignment=NSTextAlignmentRight;
                listCell.lblTitle.textAlignment=NSTextAlignmentRight;
                listCell.lblAvgCount.textAlignment=NSTextAlignmentRight;
         
                // listCell.lblship1.textAlignment=NSTextAlignmentRight;
                // listCell.lblship2.textAlignment=NSTextAlignmentRight;
                //.lblreturn.textAlignment=NSTextAlignmentRight;
        
            }
            
            
            NSString *strbuinesslogo=[[sellerArray objectAtIndex:indexPath.section]  valueForKey:@"businessLogo"] ;
            if(strbuinesslogo.length!=0){
                NSString *strbuinesslogo1=[strbuinesslogo substringWithRange:NSMakeRange(0, 4)];
                NSString *urlIMG1;
                if(strbuinesslogo1.length!=0&&[strbuinesslogo1 isEqualToString:@"http"])
                {
                    urlIMG1=[NSString stringWithFormat:@"%@",strbuinesslogo];
                    
                }
                else
                {
                    urlIMG1=[NSString stringWithFormat:@"%@%@",businessurl,strbuinesslogo];
                    
                }
              
                if (appDelObj.isArabic) {
                      [listCell.imgSellerLogo sd_setImageWithURL:[NSURL URLWithString:urlIMG1] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                } else {
                      [listCell.imgSellerLogo sd_setImageWithURL:[NSURL URLWithString:urlIMG1] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                }
            }
            else{
                listCell.imgSellerLogo.image=[UIImage imageNamed:@"placeholder1.png"];
                if (appDelObj.isArabic) {
                    listCell.imgSellerLogo.image=[UIImage imageNamed:@"place_holderar.png"];
                }
            }
            
            NSString *bname=[[sellerArray objectAtIndex:indexPath.section]  valueForKey:@"businessName"];
            NSString *strnameb=[bname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];                    listCell.lblTitle.text=strnameb;
            NSString *logo=[NSString stringWithFormat:@"%@",[[sellerArray objectAtIndex:indexPath.section]  valueForKey:@"businessLogo"]];
            if (logo.length==0) {
                listCell.imgSellerLogo.alpha=0;
                listCell.rateView.frame=CGRectMake(listCell.imgSellerLogo.frame.origin.x, listCell.rateView.frame.origin.y, listCell.rateView.frame.size.width, listCell.rateView.frame.size.height);
            }
            NSString *rate=[NSString stringWithFormat:@"%@",[[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"busRating"]  valueForKey:@"ratingCount"]];
            if (rate.length==0||[rate isEqualToString:@"0"]) {
                listCell.rateView.alpha=0;
            }
            listCell.lblAvg.text=[NSString stringWithFormat:@"%@",[[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"busRating"]  valueForKey:@"ratingTotal"]];
            if ([[[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"busRating"]  valueForKey:@"ratingCount"]isKindOfClass:[NSNull class]]||[[NSString stringWithFormat:@"%@",[[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"busRating"]  valueForKey:@"ratingCount"]] isEqualToString:@"0"])
            {
                listCell.imgrate1.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate2.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate1.alpha=0;
                listCell.imgrate2.alpha=0;
                listCell.imgrate3.alpha=0;
                listCell.imgrate4.alpha=0;
                listCell.imgrate5.alpha=0;
                listCell.lblAvgCount.alpha=0;
                listCell.lblAvg.alpha=0;
            }
            else if ([[NSString stringWithFormat:@"%@",[[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"busRating"]  valueForKey:@"ratingCount"]] isEqualToString:@"1"])
            {
                listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate2.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                
            }
            else if ([[NSString stringWithFormat:@"%@",[[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"busRating"]  valueForKey:@"ratingCount"]] isEqualToString:@"2"])
            {
                listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate3.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                
            }
            else if ([[NSString stringWithFormat:@"%@",[[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"busRating"]  valueForKey:@"ratingCount"]] isEqualToString:@"3"])
            {
                listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate4.image=[UIImage imageNamed:@"star-3.png"];
                listCell.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                
            }
            else if ([[NSString stringWithFormat:@"%@",[[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"busRating"]  valueForKey:@"ratingCount"]] isEqualToString:@"4"])
            {
                listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate4.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate5.image=[UIImage imageNamed:@"star-3.png"];
                
            }
            else if ([[NSString stringWithFormat:@"%@",[[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"busRating"]  valueForKey:@"ratingCount"]] isEqualToString:@"5"])
            {
                listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate4.image=[UIImage imageNamed:@"star-1.png"];
                listCell.imgrate5.image=[UIImage imageNamed:@"star-1.png"];
                
            }
            else{
               
                    listCell.imgrate1.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate2.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate3.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate4.image=[UIImage imageNamed:@"star-1.png"];
                    listCell.imgrate5.image=[UIImage imageNamed:@"star-1.png"];
                    
            
            }
            return listCell;
        }
        else if (indexPath.row==3)
        {
            SellerListCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SellerListCell" owner:self options:nil];
            }
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            listCell=[listCellAry objectAtIndex:0];
            if (appDelObj.isArabic) {
                listCell.btnBuy.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblNew.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblold.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lbloffer.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblNew.textAlignment=NSTextAlignmentRight;
                listCell.lbloffer.textAlignment=NSTextAlignmentRight;
                listCell.lblold.textAlignment=NSTextAlignmentRight;
                [listCell.btnBuy setTitle:@"يشترى" forState:UIControlStateNormal];
                
            }
            NSString *oldStr=[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"productOptionRegularPrice"];
            NSString *newStr=[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"offerPrice"];
            float x=[oldStr floatValue];
            float x1=[newStr floatValue];
            //listCell.lblold.text=[NSString stringWithFormat:@"%.2f %@",x,appDelObj.currencySymbol];
            NSAttributedString *s=[[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"%.2f %@",x,appDelObj.currencySymbol]];
            NSMutableAttributedString *price= [[NSMutableAttributedString alloc]
                                               initWithAttributedString:s];
            [price addAttribute:NSForegroundColorAttributeName
                          value:appDelObj.priceOffer
                          range:NSMakeRange(0, [price length])];
            
            [price addAttribute:NSFontAttributeName
                          value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                          range:NSMakeRange(0, [price length])];
            //[string replaceCharactersInRange:NSMakeRange(0, 2) withString:appDelObj.currencySymbol];
//           // [price addAttribute:NSStrikethroughStyleAttributeName
//                          value:@2
//                          range:NSMakeRange(0, [price length])];
            if (appDelObj.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
            listCell.lblold.attributedText=price;
            
            listCell.lblNew.text=[NSString stringWithFormat:@"%.2f %@",x1,appDelObj.currencySymbol];
            NSString *offStr=[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"productOptionOfferDiscount"];
            float off=[offStr floatValue];
            if (off<=0)
            {
                listCell.lbloffer.alpha=0;
            }
            else
            {
                listCell.lbloffer.text=[NSString stringWithFormat:@" %.2f  %@ Off",off,@"%"];
                if (appDelObj.isArabic) {
                    listCell.lbloffer.text=[NSString stringWithFormat:@" %.2f  %@ خصم ",off,@"%"];

                }

            }
            listCell.btnBuy.tag=indexPath.section;
            listCell.BuyDEL=self;
            return listCell;
        }
        else
        {
            SellMethodCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];
            NSArray *listCellAry;
            if (listCell==nil)
            {
                listCellAry=[[NSBundle mainBundle]loadNibNamed:@"SellMethodCell" owner:self options:nil];
            }
            listCell.selectionStyle=UITableViewCellSelectionStyleNone;
            listCell=[listCellAry objectAtIndex:0];
            if (appDelObj.isArabic)
            {
                listCell.imgLogo.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblTitle.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblSubTitle.transform = CGAffineTransformMakeScale(-1, 1);
                listCell.lblTitle.textAlignment=NSTextAlignmentRight;
                listCell.lblSubTitle.textAlignment=NSTextAlignmentRight;
            }
            NSString *cod=[NSString stringWithFormat:@"%@",[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"cod_available"]];
            NSString *returnPolicy=[NSString stringWithFormat:@"%@",[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"productReturnable"] ];
            if ([cod isEqualToString:@"Yes"]&&[returnPolicy isEqualToString:@"Yes"])
            {
                if (indexPath.row==1)
                {
                    listCell.imgLogo.image=[UIImage imageNamed:@"p-details-3.png"];
                    listCell.lblTitle.text=@"Cash on Delivery";
                    listCell.lblSubTitle.text=@"COD Available";
                    if (appDelObj.isArabic) {
                        listCell.lblTitle.text=@"الدفع عن الاستلام";
                        listCell.lblSubTitle.text=@"COD متاح";
                    }
                }
                else
                {
                    listCell.imgLogo.image=[UIImage imageNamed:@"cas.png"];
                    listCell.lblTitle.text=[NSString stringWithFormat:@"%@ Days Return Policy",[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"productReturnPeriod"]];
                    if (appDelObj.isArabic) {
                        listCell.lblTitle.text=[NSString stringWithFormat:@"أيام عودة السياسة %@ ",[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"productReturnPeriod"]];

                    }
                    listCell.lblSubTitle.alpha=0;
                }
            }
            else
            {
                if ([cod isEqualToString:@"Yes"])
                {
                    listCell.imgLogo.image=[UIImage imageNamed:@"p-details-3.png"];
                    listCell.lblTitle.text=@"Cash on Delivery";
                    listCell.lblSubTitle.text=@"COD Available";
                    if (appDelObj.isArabic) {
                        listCell.lblTitle.text=@"الدفع عن الاستلام";
                        listCell.lblSubTitle.text=@"COD متاح";
                    }
                }
                else
                {
                    listCell.imgLogo.image=[UIImage imageNamed:@"cas.png"];
                    listCell.lblTitle.text=[NSString stringWithFormat:@"%@ Days Return Policy",[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"productReturnPeriod"]];
                    if (appDelObj.isArabic) {
                        listCell.lblTitle.text=[NSString stringWithFormat:@"أيام عودة السياسة %@ ",[[sellerArray objectAtIndex:indexPath.section]valueForKey:@"productReturnPeriod"]];
                        
                    }
                    listCell.lblSubTitle.alpha=0;
                }
            }
            return listCell;
        }
        
    }
    else if (tableView==self.tblImages)
    {
        UITableViewCell *bannerCell=[tableView dequeueReusableCellWithIdentifier:@"bannerCell"];
        if (bannerCell==nil)
        {
            bannerCell=[[UITableViewCell alloc]init];
            
        }
        bannerCell.backgroundColor = [UIColor clearColor];
         bannerCell.selectionStyle=UITableViewCellSelectionStyleNone;
        /*set imageview*/
        UIImageView *bannerImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, self.imgItem.frame.origin.y, self.view.frame.size.width, self.imgItem.frame.size.height)];
        [bannerImage setBackgroundColor:[UIColor clearColor]];
        bannerImage.tag = 111222333;
        if (optionSelectForimage==0)
        {
            if (indexPath.row==0)
            {
                NSString *strImgUrl=[DetailListAryData  valueForKey:@"productImage"];
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
                        urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
                        
                    }
                   
                    if (appDelObj.isArabic) {
                         [bannerImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                    } else {
                         [bannerImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                    }
                    
                }
                else{
                    bannerImage.image=[UIImage imageNamed:@"placeholder1.png"];
                    if (appDelObj.isArabic) {
                         bannerImage.image=[UIImage imageNamed:@"place_holderar.png"];
                    }
                }
                
            }
            else
            {
                NSString *strImgUrl=[[multipleImage objectAtIndex:indexPath.row-1]   valueForKey:@"productImage"] ;
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
                        urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
                        
                    }
                   
                    if (appDelObj.isArabic) {
                         [bannerImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                    }
                    else{
                         [bannerImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                    }
                }
                else{
                    bannerImage.image=[UIImage imageNamed:@"placeholder1.png"];
                      if (appDelObj.isArabic) {
                          bannerImage.image=[UIImage imageNamed:@"place_holderar.png"];
                      }
                }
                
            }
        }
        else
        {
            NSString *strImgUrl=[[multipleImage objectAtIndex:indexPath.row]   valueForKey:@"productImage"] ;
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
                    urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
                    
                }
               
                if (appDelObj.isArabic) {
                     [bannerImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                } else {
                     [bannerImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                }
            }
            else{
                bannerImage.image=[UIImage imageNamed:@"placeholder1.png"];
                if (appDelObj.isArabic) {
                    bannerImage.image=[UIImage imageNamed:@"placeholder1.png"];
                }
            }
        }
        
        bannerImage.clipsToBounds=YES;
        bannerImage.contentMode = UIViewContentModeScaleAspectFit;
        bannerCell.transform=CGAffineTransformMakeRotation(M_PI / 2);
        [bannerCell.contentView addSubview:bannerImage];
        /*set uilabel*/
        bannerImage.layer.cornerRadius = 7;
        bannerImage.clipsToBounds = YES;
        bannerCell.selectionStyle=UITableViewCellSelectionStyleNone;
        
     return bannerCell;
    }
    
    else
    {
        UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cc"];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cc"];
        }
        return cell;
    }
}
-(void)buyBoxAction:(int)tag
{
    addtoCart=@"AddCart";
    loginorNot=@"login";

    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    if (userID.length==0)
    {
        userID=@"0";
    }
    NSString *urlStr;
    NSMutableDictionary *dicPost;
    NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
    if (CAID.length==0||[CAID isEqualToString:@""])
    {
        CAID=@"";
    }
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",[DetailListAryData valueForKey:@"productID"],@"basepar",[[sellerArray objectAtIndex:tag]valueForKey:@"productID"],@"productID",[[sellerArray objectAtIndex:tag]valueForKey:@"productOptionID"],@"productOptionID",@"1",@"quantity",[DetailListAryData valueForKey:@"productTitle"],@"productOptionName",[DetailListAryData valueForKey:@"productTitle"],@"productTitle",[[sellerArray objectAtIndex:tag] valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",@"",@"cartID",[[sellerArray objectAtIndex:tag] valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",@"",@"strcombinationValues",@"",@"subAttr",@"",@"purchase",@"",@"customOptionValues",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
        
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    [self sellerBackAction:nil];
}
-(void)ViewMoreSubAction:(int)tag
{
//    SubstituteViewController *sub=[[SubstituteViewController alloc]init];
//    sub.pid=[DetailListAryData valueForKey:@"productID"];
//    sub.pname=[DetailListAryData valueForKey:@"productTitle"];
//
//    sub.pprice=[DetailListAryData valueForKey:@"offerPrice"];
//    sub.ppriceoffer=[DetailListAryData valueForKey:@"productOptionRegularPrice"];
//    sub.pseller=[DetailListAryData valueForKey:@"businessName"];
//    sub.pprescribe=[DetailListAryData valueForKey:@"requirePrescription"];
//    sub.poffer=[DetailListAryData valueForKey:@"productOptionOfferDiscount"];
//
//    [self.navigationController pushViewController:sub animated:YES];
}
-(void)detailPageAction:(int)tag

{
    AboutViewController *about=[[AboutViewController alloc]init];
    about.cms=@"10";
    about.fromMenu=@"no";
    //if(tag==0)
    //{
    about.desc=[[DescriptionArray objectAtIndex:tag ]  valueForKey:@"Des"];
    about.titleText=[[DescriptionArray objectAtIndex:tag ]  valueForKey:@"DesName"];
    
      if(appDelObj.isArabic)
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:about animated:NO];
    }
    else
    {
        
        
        [self.navigationController pushViewController:about animated:YES];
    }
    
    
}
-(void)varientsSelection:(int)tag
{
    index=tag;
    [varientSelect removeAllIndexes];
    varientsArray=[[customOption objectAtIndex:tag]valueForKey:@"variants"];
    [self.tblVarients reloadData];
    self.varientsView.alpha = 1;
    
    self.varientsView.frame = CGRectMake(self.varientsView.frame.origin.x, self.varientsView.frame.origin.y, self.varientsView.frame.size.width, self.varientsView.frame.size.height);
    [self.view addSubview:self.varientsView];
    
    self.varientsView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.varientsView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         
                         //[_popupView addSubview:categoryViewObj.view];
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         // categoryViewObj.view.frame = rect;
                         
                         rect.origin.y = -10;
                         
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.varientsView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              CGRect rect = self.varientsView.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.varientsView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   //                                                                   if (isFilterSelected == NO) {
                                                                   //                                                                       [CategoryViewObj setViewData];
                                                                   //                                                                   }
                                                                   //closeBtn.alpha =1;
                                                               }];
                                          }];
                     }];
}
-(void)optionsPageAction:(int)tag
{
    NSArray *optArr=[[optionsArray objectAtIndex:tag]   valueForKey:@"tierPrices"];
    tierArray=optArr;
    tierSelInd=tag;
    if (tierArray.count>2) {
        self.tblOptionsView.frame=CGRectMake(self.tblOptionsView.frame.origin.x, self.view.frame.size.height-(tierArray.count*50), self.tblOptionsView.frame.size.width, (tierArray.count*60));
    }
    else{
        self.tblOptionsView.frame=CGRectMake(self.tblOptionsView.frame.origin.x, self.tblOptionsView.frame.origin.y, self.tblOptionsView.frame.size.width, self.tblOptionsView.frame.size.height);
    }
    if (optArr.count!=0)
    {
        //self.tblOptionsView.frame=CGRectMake(self.tblOptionsView.frame.origin.x, self.view.frame.size.height-(tierArray.count*50), self.tblOptionsView.frame.size.width, (tierArray.count*60));
        self.optionsView.alpha = 1;
        
        self.optionsView.frame = CGRectMake(self.optionsView.frame.origin.x, self.optionsView.frame.origin.y, self.optionsView.frame.size.width, self.optionsView.frame.size.height);
        [self.view addSubview:self.optionsView];
        
        self.timeView.tintColor = [UIColor blackColor];
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.optionsView.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             
                             //[_popupView addSubview:categoryViewObj.view];
                             CGRect rect = self.view.frame;
                             rect.origin.y = self.view.frame.size.height;
                             // categoryViewObj.view.frame = rect;
                             
                             rect.origin.y = -10;
                             
                             [UIView animateWithDuration:0.3
                                              animations:^{
                                                  self.optionsView.frame = rect;
                                              }
                                              completion:^(BOOL finished) {
                                                  
                                                  CGRect rect = self.optionsView.frame;
                                                  rect.origin.y = 0;
                                                  
                                                  [UIView animateWithDuration:0.5
                                                                   animations:^{
                                                                       self.optionsView.frame = rect;
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       
                                                                       //                                                                   if (isFilterSelected == NO) {
                                                                       //                                                                       [CategoryViewObj setViewData];
                                                                       //                                                                   }
                                                                       //closeBtn.alpha =1;
                                                                   }];
                                              }];
                         }];
        
    }
    [self.tblOptionsView reloadData];
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
   if (tableView==self.tblOptions)
        
    {
        if ([optionSelect containsIndex:indexPath.row]) {
            [optionSelect removeAllIndexes];
        }
        else
        {
            [optionSelect removeAllIndexes];
            [optionSelect addIndex:indexPath.row];
        }
        [self.tblOptions reloadData];
        chooseOption=@"yes";
        self.lblDefaultOption.text=[[optionsArray objectAtIndex:indexPath.row]valueForKey:@"productOptionName"];
        optionSelectForimage=1;
        multipleImage=[[optionsArray objectAtIndex:indexPath.row]valueForKey:@"images"];
        self.pager.numberOfPages=multipleImage.count;
        [_tblImages reloadData];
        
        double optSum=[[[optionsArray objectAtIndex:indexPath.row]valueForKey:@"productOptionQuantity"]doubleValue];
        double optQSum=[[[optionsArray objectAtIndex:indexPath.row]valueForKey:@"productQuantityUnlimited"]doubleValue];
        
        outStock=optSum+optQSum;
        if (outStock<1) {
            self.btnAddtoCart.alpha=0;
            self.lblOut.alpha=1;
        }
        else
        {
            self.btnAddtoCart.alpha=1;
            self.lblOut.alpha=0;
        }
        
        productOptionID=[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"productOptionID"];
        float x=[[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"offerPrice"] floatValue];
        float x1=[[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"productOptionRegularPrice"] floatValue];
        self.hidePrice.text=[NSString stringWithFormat:@"%.2f",x];

        price=x;
         optprice=x1;
        NSString *s1=[NSString stringWithFormat:@"%.2f",x1] ;
        NSString *s2=[NSString stringWithFormat:@"%.2f",x ];
        if ([s1 isEqualToString:s2])
        {
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",s1],appDelObj.currencySymbol]];
            if (appDelObj.isArabic) {
                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",s1],appDelObj.currencySymbol]];
            }
            if (appDelObj.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
            [price addAttribute:NSForegroundColorAttributeName value:appDelObj.priceColor                               range:NSMakeRange(0, [price length])];

            self.lblprice.attributedText=price;
            self.lblBottomPrice.attributedText=price;
              self.lblBottomPrice.textColor=[UIColor redColor];
        }
        else{
        if (s1.length!=0&&s2.length!=0)
        {
            //NSArray *a=[s1 componentsSeparatedByString:@"."];
            //NSArray *a1=[s2 componentsSeparatedByString:@"."];
            NSString *p1=s1;
            NSString *p2=s2;
            
            
            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
            if (appDelObj.isArabic) {
                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
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
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [string length])];
            }
            [string addAttribute:NSStrikethroughStyleAttributeName
                           value:@2
                           range:NSMakeRange(0, [string length])];
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
            if (appDelObj.isArabic) {
                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
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
            //NSMutableAttributedString *priceold=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",string]];
            [price appendAttributedString:string];
            self.lblprice.attributedText=price;
            
            
            NSMutableAttributedString *stringBottom=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
            [stringBottom addAttribute:NSForegroundColorAttributeName   value:[UIColor redColor]                              range:NSMakeRange(0, [stringBottom length])];
            [stringBottom appendAttributedString:string];
            self.lblBottomPrice.attributedText=price;
            //self.lblBottomPrice.textAlignment=NSTextAlignmentCenter;
            
            self.lblBottomPrice.attributedText=stringBottom;
        }
           
            
        }
        NSString *offerStr=[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"productOptionOfferDiscount"];
        NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
        if ([[offArr objectAtIndex:0]isEqualToString:@"0"]) {
            self.lblOffer.alpha=0;
            self.lblofferbottom.alpha=0;
        }
        else{
            self.lblOffer.text=[NSString stringWithFormat:@"%@%@ Off",[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"productOptionOfferDiscount"],@"%"];
            self.lblofferbottom.text=[NSString stringWithFormat:@"%@%@ Off",[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"productOptionOfferDiscount"],@"%"];
            if (appDelObj.isArabic) {
                self.lblOffer.text=[NSString stringWithFormat:@"خصم %@%@",[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"productOptionOfferDiscount"],@"%"];
                self.lblofferbottom.text=[NSString stringWithFormat:@"خصم %@%@",@"%",[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"productOptionOfferDiscount"]];
            }
            
        }
        
        

    }
   else  if (tableView==self.tblSubscription)
   {
       
       if ([subSelIndex containsIndex:indexPath.row])
       {
           [subSelIndex removeAllIndexes];
           selSubOptID=@"";
           selSubOptionName=@"";
           deliveriesvalue=@"";
           subscribeORnot=@"";
           //[self.btnAddtoCart setTitle:@"ADD TO CART" forState:UIControlStateNormal];

       }
       else
       {
           subscribeORnot=@"Yes";
           [subSelIndex removeAllIndexes];
           [subSelIndex addIndex:indexPath.row];
           selSubOptID=[[subscriptionDetail objectAtIndex:indexPath.row]valueForKey:@"subcriptionDurationId"];
           selSubOptionName=[[subscriptionDetail objectAtIndex:indexPath.row]valueForKey:@"subscriptionDurationName"];
           deliveriesvalue=[[subscriptionDetail objectAtIndex:indexPath.row]valueForKey:@"deliveries" ];
           [self.btnAddtoCart setTitle:@"SUBSCRIBE" forState:UIControlStateNormal];

       }
       [self.tblSubscription reloadData];

   }
    else if(tableView==self.tblSubstituteMedicine)
    {
        if (indexPath.row==3)
        {
            
        }
        else
        {
        if(appDelObj.isArabic==YES )
        {
            ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
            listDetail.productID=[[substituteMedArray objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
            listDetail.productName=[[substituteMedArray objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
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
            listDetail.productID=[[substituteMedArray objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
            listDetail.productName=[[substituteMedArray objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
            [self.navigationController pushViewController:listDetail animated:YES];
        }
        }
    }
    else if (tableView==self.tblOptionsView)
    {
        if ([tierSel containsIndex:indexPath.row])
        {
            [tierSel removeAllIndexes];
            
        }
        else
        {
            [tierSel addIndex:indexPath.row];
            
        }
        [self.tblOptionsView reloadData];
 }
    else if (tableView==self.tblCustomoptions)
    {
        /*if ([[[customOption objectAtIndex:indexPath.row]valueForKey:@"inputType"]isEqualToString:@"file"])
        {
            
            UIDocumentPickerViewController *documentPicker = [[UIDocumentPickerViewController alloc] initWithDocumentTypes:@[@"public.image"]
                                                                                                                inMode:UIDocumentPickerModeImport];
            documentPicker.delegate = self;
            documentPicker.modalPresentationStyle = UIModalPresentationFormSheet;
            [self presentViewController:documentPicker animated:YES completion:nil];
        }*/
        if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"file"])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Select from" preferredStyle:UIAlertControllerStyleAlert];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Camera" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self imagepickerfromCamera];}]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Gallery" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){[self imagepickerfromGallery];}]];
            [alertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:nil]];

            [self presentViewController:alertController animated:YES completion:nil];

//            UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil
//                                                                     delegate: self
//                                                            cancelButtonTitle: @"Cancel"
//                                                       destructiveButtonTitle: nil
//                                                            otherButtonTitles: @"Take a new photo",
//                                          @"Choose from gallery", nil];
//            [actionSheet showInView:self.view];
            indexPathCusOpt=indexPath;
        }
        else if ([[[customOption objectAtIndex:indexPath.section]valueForKey:@"inputType"]isEqualToString:@"multiselect"] )
        {
//            if ([selectMultiSelectvariant containsIndex:indexPath.row])
//            {
//                [selectMultiSelectvariant removeIndex:indexPath.row];
//
//            }
//            else
//            {
//                [selectMultiSelectvariant addIndex:indexPath.row];
//            }
            if ([selectMultiSelectvariant containsIndex:indexPath.row])
            {
                [selectMultiSelectvariant removeIndex:indexPath.row];
                NSIndexPath *ip = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                cell.img1.image=[UIImage imageNamed:@"login-select-2.png"];
                cell.img1.tag=indexPath.row;
//                if(multiSelVarientAry.count==0)
//                {
                NSString *multiID=[[[[customOption objectAtIndex:indexPath.section]valueForKey:@"variants"]objectAtIndex:indexPath.row]valueForKey:@"customOptionVariantID"];
                for (int i=0; i<multiSelVarientAry.count; i++)
                {
                    if ([multiID isEqualToString:[[multiSelVarientAry objectAtIndex:i]valueForKey:@"customOptionVariantID"]])
                    {
                        [multiSelVarientAry removeObjectAtIndex:i];
                    }
                }
                    ///[multiSelVarientAry addObject:[[[customOption objectAtIndex:indexPath.section]valueForKey:@"variants"]objectAtIndex:indexPath.row]];
//                }
//                else
//                {
                
//                }
            }
            else
            {
                [selectMultiSelectvariant addIndex:indexPath.row];
                NSIndexPath *ip = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                
                  cell.img1.image=[UIImage imageNamed:@"login-select.png"];
                NSString *multiID=[[[[customOption objectAtIndex:indexPath.section]valueForKey:@"variants"]objectAtIndex:indexPath.row]valueForKey:@"customOptionVariantID"];
               
                [multiSelVarientAry addObject:[[[customOption objectAtIndex:indexPath.section]valueForKey:@"variants"]objectAtIndex:indexPath.row]];
            }
           // [self.tblCustomoptions reloadData];
        }
        else
            
        {
            filecustoptID=[[customOption objectAtIndex:indexPath.section]valueForKey:@"customOptionID"];

        }
    }
    else if (tableView==self.tblVarients)
    {
        if ([varientSelect containsIndex:indexPath.row])
        {
            [varientSelect removeAllIndexes];
            
        }
        else
        {
            [varientSelect removeAllIndexes];
            [varientSelect addIndex:indexPath.row];
        }
        [self.tblVarients reloadData];
        
        if([[[customOption objectAtIndex:index]valueForKey:@"include_in_combination"] isEqualToString:@"Yes"])
        {
            int flag=0;
            int indexToRemove=-1;
            NSString *str=[NSString stringWithFormat:@"%@",[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"customOptionVariantID"]];
            if (includeCombinationArray.count==0)
            {
                float price=[[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"priceDiff"]floatValue];
                if (price>0)
                {
                    float pprice=[self.hidePrice.text floatValue];
                    float t=price+pprice;
                    self.lblprice.text=[NSString stringWithFormat:@"%.2f",t];
                    self.lblBottomPrice.text=[NSString stringWithFormat:@"%.2f",t];

                }
                 [includeCombinationArray addObject:[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"customOptionVariantID"]];
            }
            else
            {
                for (int i=0; i<includeCombinationArray.count; i++)
                {
                    NSString *V1=[NSString stringWithFormat:@"%@",[includeCombinationArray objectAtIndex:i]];
                    for (int k=0; k<varientsArray.count; k++)
                    {
                        NSString *V2=[NSString stringWithFormat:@"%@",[[varientsArray objectAtIndex:k]valueForKey:@"customOptionVariantID"]];
                        if ([V1 isEqualToString:V2])
                        {
                             [includeCombinationArray removeObjectAtIndex:i];
                        }

                    }
                }
                
                for (int i=0; i<includeCombinationArray.count; i++)
                {
                    NSString *s=[NSString stringWithFormat:@"%@",[includeCombinationArray objectAtIndex:i]];
                    if ([str isEqualToString:s])
                    {
                        flag=1;
                        float price=[[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"priceDiff"]floatValue];
                        if (price>0)
                        {
                            float pprice=[self.hidePrice.text floatValue];
                            float t=price-pprice;
                            self.lblprice.text=[NSString stringWithFormat:@"%.2f",t];
                            self.lblBottomPrice.text=[NSString stringWithFormat:@"%.2f",t];
                            
                        }
                        [includeCombinationArray removeObjectAtIndex:i];
                    }
                   
                }
                if (flag==1)
                {
                   
                }
                else
                {
                    [includeCombinationArray addObject:[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"customOptionVariantID"]];
                    float price=[[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"priceDiff"]floatValue];
                    if (price>0)
                    {
                        float pprice=[self.hidePrice.text floatValue];
                        float t=price+pprice;
                        self.lblprice.text=[NSString stringWithFormat:@"%.2f",t];
                        self.lblBottomPrice.text=[NSString stringWithFormat:@"%.2f",t];
                        
                    }
                }
            }
            
        }
        else
        {
            int flag=0;
            int indexToRemove=-1;
            NSString *str=[NSString stringWithFormat:@"%@",[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"customOptionVariantID"]];
            if (excludeComAry.count==0)
            {
                float price=[[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"priceDiff"]floatValue];
                if (price>0)
                {
                    float pprice=[self.hidePrice.text floatValue];
                    float t=price+pprice;
                    self.lblprice.text=[NSString stringWithFormat:@"%.2f",t];
                    self.lblBottomPrice.text=[NSString stringWithFormat:@"%.2f",t];
                    
                }
                [excludeComAry addObject:[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"customOptionVariantID"]];
            }
            else
            {
                for (int i=0; i<excludeComAry.count; i++)
                {
                    NSString *s=[NSString stringWithFormat:@"%@",[excludeComAry objectAtIndex:i]];
                    if ([str isEqualToString:s])
                    {
                        flag=1;
                        indexToRemove=i;
                    }
                    
                }
                if (flag==1)
                {
                    [excludeComAry removeObjectAtIndex:indexToRemove];
                    float price=[[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"priceDiff"]floatValue];
                    if (price>0)
                    {
                        float pprice=[self.hidePrice.text floatValue];
                        float t=price-pprice;
                        self.lblprice.text=[NSString stringWithFormat:@"%.2f",t];
                        self.lblBottomPrice.text=[NSString stringWithFormat:@"%.2f",t];
                        
                    }
                }
                else
                {
                    [excludeComAry addObject:[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"customOptionVariantID"]];
                    /************************************///////////
                    float price=[[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"priceDiff"]floatValue];
                    if (price>0)
                    {
                        float pprice=[self.hidePrice.text floatValue];
                        float t=price+pprice;
                        self.lblprice.text=[NSString stringWithFormat:@"%.2f",t];
                        self.lblBottomPrice.text=[NSString stringWithFormat:@"%.2f",t];
                        
                    }
                    /******************************/////////////
                }
            }
        }
        
        
        float x=price;
        
        float x1=optprice;
        
        float xx=[[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"priceDiff"]floatValue];
        x=x+xx;
        
        NSString *s1=[NSString stringWithFormat:@"%.2f",x1] ;
        NSString *s2=[NSString stringWithFormat:@"%.2f",x ];
        if ([s1 isEqualToString:s2])
        {
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",s1],appDelObj.currencySymbol]];
            if (appDelObj.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
            self.lblprice.attributedText=price;
            self.lblBottomPrice.attributedText=price;
              self.lblBottomPrice.textColor=[UIColor redColor];
        }
        else{
            if (s1.length!=0&&s2.length!=0)
            {
                //NSArray *a=[s1 componentsSeparatedByString:@"."];
                //NSArray *a1=[s2 componentsSeparatedByString:@"."];
                NSString *p1=s1;
                NSString *p2=s2;
                
                
                NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
                
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
                                  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                                  range:NSMakeRange(0, [string length])];
                }
                [string addAttribute:NSStrikethroughStyleAttributeName
                               value:@2
                               range:NSMakeRange(0, [string length])];
                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
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
                //NSMutableAttributedString *priceold=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@" %@",string]];
                [price appendAttributedString:string];
                self.lblprice.attributedText=price;
                NSMutableAttributedString *stringBottom=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
                [stringBottom addAttribute:NSForegroundColorAttributeName   value:[UIColor redColor]                              range:NSMakeRange(0, [stringBottom length])];
                [stringBottom appendAttributedString:string];
                self.lblBottomPrice.attributedText=price;
                //self.lblBottomPrice.textAlignment=NSTextAlignmentCenter;
                
                self.lblBottomPrice.attributedText=stringBottom;
            }
        }
//            NSString *offerStr=[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"productOptionOfferDiscount"];
//            NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
//            if ([[offArr objectAtIndex:0]isEqualToString:@"0"]) {
//                self.lblOffer.alpha=0;
//                self.lblofferbottom.alpha=0;
//            }
//            else{
//                self.lblOffer.text=[NSString stringWithFormat:@"%@%@ Off",[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"productOptionOfferDiscount"],@"%"];
//                self.lblofferbottom.text=[NSString stringWithFormat:@"%@%@ Off",[[optionsArray objectAtIndex:indexPath.row]  valueForKey:@"productOptionOfferDiscount"],@"%"];
//
//            }
//
        
        
        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:index];
        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
        cell.txtDay.text=[[varientsArray objectAtIndex:indexPath.row]valueForKey:@"value"];
        CGRect rect = self.varientsView.frame;
        //rect.origin.y = 0;
        
        [UIView animateWithDuration:0.0
                         animations:^{
                             self.varientsView.frame = rect;
                         }
                         completion:^(BOOL finished) {
                             //closeBtn.alpha = 0;
                             CGRect rect = self.varientsView.frame;
                             rect.origin.y = self.view.frame.size.height;
                             
                             [UIView animateWithDuration:0.4
                                              animations:^{
                                                  self.varientsView.frame = rect;
                                              }
                                              completion:^(BOOL finished) {
                                                  
                                                  [self.varientsView removeFromSuperview];
                                                  [UIView animateWithDuration:0.2
                                                                   animations:^{
                                                                       //                                                                   topToolBar.hidden = NO;
                                                                       self.varientsView.alpha = 0;
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       
                                                                       [self.varientsView removeFromSuperview];
                                                                       
                                                                       //[CategoryViewObj clearTable];
                                                                   }];
                                              }];
                         }];
        
    }
    if (tableView==self.tblDescription)
    {
        if ([desSelRow containsIndex:indexPath.section])
        {
            [desSelRow removeAllIndexes];
            
            self.tblDescription.frame=CGRectMake(self.tblDescription.frame.origin.x, self.tblDescription.frame.origin.y, self.tblDescription.frame.size.width, DescriptionArray.count*60);

            if ([sellerArray isKindOfClass:[NSNull class]]||sellerArray.count==0)
            {
                self.AllSellerView.alpha=0; self.AllSellerView.frame=CGRectMake(self.AllSellerView.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height-1, self.AllSellerView.frame.size.width, 0);
                if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"])
                {
                    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+5, self.tblReview.frame.size.width, 50);
                    
                }
                else if ([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0){
                    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height+10, self.tblReview.frame.size.width, 0);
                    
                }
                else{
                    
                self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height+10, self.tblReview.frame.size.width, 280+(142*reviewArray.count));
                }

            }
            else
            {
                self.AllSellerView.alpha=1; self.AllSellerView.frame=CGRectMake(self.AllSellerView.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height, self.AllSellerView.frame.size.width, self.AllSellerView.frame.size.height);
                if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"]){
                    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+5, self.tblReview.frame.size.width, 50);
                    
                }
                else if ([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0){
                    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width, 0);
                    
                }
                else{
                    
                self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width, 280+(142*reviewArray.count));
                }

            }
            self.viewStore.frame=CGRectMake(self.viewStore.frame.origin.x, self.tblReview.frame.origin.y+self.tblReview.frame.size.height+10, self.viewStore.frame.size.width, self.viewStore.frame.size.height);
            
            
            self.tblRelated.frame=CGRectMake(self.tblRelated.frame.origin.x, self.viewStore.frame.origin.y+self.viewStore.frame.size.height+10, self.tblRelated.frame.size.width, 308*relatedItem.count);
  self.scrollViewObj.contentSize=CGSizeMake(0, self.tblRelated.frame.origin.y+self.tblRelated.frame.size.height+30);
        }
        else
        {
            [desSelRow removeAllIndexes];
            [desSelRow addIndex:indexPath.section];
            if ([[[DescriptionArray objectAtIndex:indexPath.section]valueForKey:@"table"] isEqualToString:@"yes"])
            {
                self.tblDescription.frame=CGRectMake(self.tblDescription.frame.origin.x, self.tblDescription.frame.origin.y, self.tblDescription.frame.size.width,  ((specificationArray.count*40)+40));

            }
            else
            {
                self.tblDescription.frame=CGRectMake(self.tblDescription.frame.origin.x, self.tblDescription.frame.origin.y, self.tblDescription.frame.size.width, 202+ ((DescriptionArray.count-1)*100));

            }

            if ([sellerArray isKindOfClass:[NSNull class]]||sellerArray.count==0)
            {
                self.AllSellerView.frame=CGRectMake(self.AllSellerView.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height-1, self.AllSellerView.frame.size.width, 0);
                if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"]){
                    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+5, self.tblReview.frame.size.width, 50);
                    
                }
                else  if ([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0){
                    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height+10, self.tblReview.frame.size.width, 0);
                    
                }
                else{
                    
                self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height+10, self.tblReview.frame.size.width, 280+(142*reviewArray.count));
                }
            }
            else
            {
                self.AllSellerView.frame=CGRectMake(self.AllSellerView.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height+1, self.AllSellerView.frame.size.width, self.AllSellerView.frame.size.height);
                if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"]){
                    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+5, self.tblReview.frame.size.width, 50);
                    
                }
                else if ([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0){
                    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width,0);
                    
                }
                else{
                    
                self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width, 280+(142*reviewArray.count));
                }
            }

            self.viewStore.frame=CGRectMake(self.viewStore.frame.origin.x, self.tblReview.frame.origin.y+self.tblReview.frame.size.height+10, self.viewStore.frame.size.width, self.viewStore.frame.size.height);
            
            
            self.tblRelated.frame=CGRectMake(self.tblRelated.frame.origin.x, self.viewStore.frame.origin.y+self.viewStore.frame.size.height+10, self.tblRelated.frame.size.width, 308*relatedItem.count);
  self.scrollViewObj.contentSize=CGSizeMake(0, self.tblRelated.frame.origin.y+self.tblRelated.frame.size.height+30);
        }
        [self.tblDescription reloadData];
    }
    else if(tableView==self.tblImages)
    {
        if (optionSelectForimage==0)
        {
            if (indexPath.row==0)
            {
                NSString *strImgUrl=[DetailListAryData  valueForKey:@"productImage"];
                
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
                        urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
                    }
                 
                    if (appDelObj.isArabic) {
                        [self.largeImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                    } else {
                        [self.largeImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                    }
                }
                else{
                    
                    self.largeImage.image=[UIImage imageNamed:@"placeholder1.png"];
                    if (appDelObj.isArabic) {
                        self.largeImage.image=[UIImage imageNamed:@"placeholder1.png"];
                    }
                }
                
            }
            else
            {
                NSString *strImgUrl=[[[DetailListAryData valueForKey:@"images"] objectAtIndex:indexPath.row-1 ] valueForKey:@"productImage"] ;
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
                        urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
                    }
                    if (appDelObj.isArabic) {
                        [self.largeImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                    } else {
                        [self.largeImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                    }
                }
                else{
                    self.largeImage.image=[UIImage imageNamed:@"placeholder1.png"];
                    if (appDelObj.isArabic) {
                       self.largeImage.image=[UIImage imageNamed:@"place_holderar.png"];
                    } else {
                       self.largeImage.image=[UIImage imageNamed:@"placeholder1.png"];
                    }
                    
                }
                
            }

        }
        else
        {
            NSString *strImgUrl=[[multipleImage objectAtIndex:indexPath.row] valueForKey:@"productImage"] ;
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
                    urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
                }
                if (appDelObj.isArabic) {
                    [self.largeImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
                } else {
                    [self.largeImage sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
                }
            }
            else{
                if (appDelObj.isArabic) {
                    self.largeImage.image=[UIImage imageNamed:@"place_holderar.png"];
                } else {
                    self.largeImage.image=[UIImage imageNamed:@"placeholder1.png"];
                }
                
            }
        }
                self.timeView.alpha = 1;
        self.timeView.frame = CGRectMake(self.timeView.frame.origin.x, self.timeView.frame.origin.y, self.timeView.frame.size.width, self.timeView.frame.size.height);
        [self.view addSubview:self.timeView];
        self.timeView.tintColor = [UIColor blackColor];
        [UIView animateWithDuration:0.2
                         animations:^{
                             self.timeView.alpha = 1;
                         }
                         completion:^(BOOL finished) {
                             
                             //[_popupView addSubview:categoryViewObj.view];
                             CGRect rect = self.view.frame;
                             rect.origin.y = self.view.frame.size.height;
                             // categoryViewObj.view.frame = rect;
                             
                             rect.origin.y = -10;
                             
                             [UIView animateWithDuration:0.3
                                              animations:^{
                                                  self.timeView.frame = rect;
                                              }
                                              completion:^(BOOL finished) {
                                                  
                                                  CGRect rect = self.timeView.frame;
                                                  rect.origin.y = 0;
                                                  
                                                  [UIView animateWithDuration:0.5
                                                                   animations:^{
                                                                       self.timeView.frame = rect;
                                                                   }
                                                                   completion:^(BOOL finished) {
                                                                       
  
                                                                   }];
                                              }];
                         }];
        
        
    }
}
-(void)productSimilarDetailDel:(NSString *)pid
{
//    if (appDelObj.isArabic) {
//        [Loading showWithStatus:@"أرجو الإنتظار..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//    }
//    else
//    {
//        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//    }
//    [optionSelect removeAllIndexes];
//    [desSelRow removeAllIndexes];
//    allAttributeArray=customOption=[[NSMutableArray alloc]init];
//    productOptionID=@"";
//    chooseOption=@"";
//    fav=@"";
//    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/productDetails/languageID/",appDelObj.languageId];
//     NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:pid,@"productID",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID", nil];
//    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    if(appDelObj.isArabic==YES )
    {
        ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
        listDetail.productID=pid ;
        //listDetail.productName=[[ListAryData objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
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
        listDetail.productID=pid ;
        [self.navigationController pushViewController:listDetail animated:YES];
    }
}
-(void)productSimilarAddCartDel:(NSArray *)array
{
    loginorNot=@"login";
    addtoCart=@"AddCart";
    NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
    if (CAID.length==0||[CAID isEqualToString:@""])
    {
        CAID=@"";
    }
     NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    NSString *urlStr;
    NSMutableDictionary *dicPost;
   
    
        urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",[array valueForKey:@"productID"],@"productID",[array valueForKey:@"productID"],@"productOptionID",@"1",@"quantity",[array valueForKey:@"productTitle"],@"productTitle",[array valueForKey:@"productTitle"],@"productOptionName",[array valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",CAID,@"cartID",[array valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",@"",@"strcombinationValues",@"",@"subAttr",@"",@"purchase",@"",@"customOptionValues",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
     [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
   /* NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
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
    NSMutableDictionary*   dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:User,@"userID",[array valueForKey:@"itemID"],@"productID",[array valueForKey:@"productOptionID"],@"productOptionID",[NSString stringWithFormat:@"%@",[array valueForKey:@"productMinBuyLimit"]],@"quantity",[array valueForKey:@"itemName"],@"productOptionName",[array valueForKey:@"itemName"],@"productTitle",[array valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",CAID,@"cartID",[array valueForKey:@"itemIcon"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",@"",@"strcombinationValues",@"",@"subAttr",@"onetime",@"purchase",@"",@"customOptionValues",@"No",@"freeProduct",@"",@"freeBaseProductID",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];*/
    
}
-(void)timeSelect:(int)tag
{
}

-(void)informationAbout:(int)tag
{
    NSString *str=@"Ok";
    if (appDelObj.isArabic) {
        str=@" موافق ";
    }
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[[customOption objectAtIndex:tag]valueForKey:@"helpText"] preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)uploadFile:(int)tag
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle: nil
                                                             delegate: self
                                                    cancelButtonTitle: @"Cancel"
                                               destructiveButtonTitle: nil
                                                    otherButtonTitles: @"Take a new photo",
                                  @"Choose from gallery", nil];
    [actionSheet showInView:self.view];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    int i = (int)buttonIndex;
    switch(i)
    {
        case 0:
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
            {
                picker.sourceType = UIImagePickerControllerSourceTypeCamera;
            }
            else
            {
                NSString *strMsg,*okMsg;
                if (appDelObj.isArabic)
                {
                    strMsg=@"الكاميرا غير متوفرة";
                    okMsg=@" موافق ";
                }
                else
                {
                    strMsg=@"Camera not available";
                    okMsg=@"Ok";
                }
                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
                [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
                [self presentViewController:alertController animated:YES completion:nil];
            }
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
        case 1:
        {
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            picker.delegate = self;
            picker.allowsEditing = YES;
            picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
            [self presentViewController:picker animated:YES completion:nil];
        }
            break;
    }
}
-(void)imagepickerfromCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    [self presentViewController:picker animated:YES completion:nil];
}
-(void)imagepickerfromGallery
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.delegate = self;
    picker.allowsEditing = YES;
    picker.sourceType = UIImagePickerControllerSourceTypeSavedPhotosAlbum;
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
        picker.mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera];
    }
    [self presentViewController:picker animated:YES completion:nil];
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
     fav=@"UploadFile";
    loginorNot=@"";
    [picker dismissViewControllerAnimated:YES completion:^{
        NSURL *imageURL = [info valueForKey:UIImagePickerControllerReferenceURL];
        ALAssetsLibraryAssetForURLResultBlock resultblock = ^(ALAsset *myasset)
        {
            ALAssetRepresentation *representation = [myasset defaultRepresentation];
            fileName = [representation filename];
            NSLog(@"fileName : %@",fileName);
            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:indexPathCusOpt.section];
            CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
            cell.txtDay.text=fileName;
        };
        ALAssetsLibrary* assetslibrary = [[ALAssetsLibrary alloc] init] ;
        [assetslibrary assetForURL:imageURL
                       resultBlock:resultblock
                      failureBlock:nil];
        imagePro = [info objectForKey:UIImagePickerControllerOriginalImage] ;
        imgSel.image=imagePro;
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        NSString *urlString = [NSString stringWithFormat:@"%@mobileapp/Cart/getFileUpload/",appDelObj.baseURL ];
        NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
        if (CAID.length!=0||!([CAID isEqualToString:@""]))
        {
            CAID=@"";
        }
        NSDate *date=[NSDate date];
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-mm-dd"];
        
        //Optionally for time zone conversions
        [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"..."]];
        
        NSString *stringFromDate = [formatter stringFromDate:date];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.productID,@"productID",[[customOption objectAtIndex:indexPathCusOpt.section]valueForKey:@"customOptionID"],@"customAttributeID",stringFromDate,@"currentTime",[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",CAID,@"cartID", nil];
        NSMutableDictionary *imageParams = [NSMutableDictionary dictionaryWithObject:imgSel.image forKey:@"customOptionFile"];
        [webServiceObj getUrlReqForUpdatingProfileBaseUrl:urlString andTextData:dicPost andImageData:imageParams];
        
    }];
   
   
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
    responseData = [[NSMutableData alloc] init];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data{
    // Append the new data to the instance variable you declared
    [responseData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse {
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // The request is complete and data has been received
    // You can parse the stuff in your instance variable now
    NSDictionary* results;
    NSString *jsonString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
    NSLog(@"Your json is****%@",jsonString);
    [Loading dismiss];
   
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    // The request has failed for some reason!
    // Check the error var
    id err=error;
    
    NSLog(@"%@",err);
    
    [Loading dismiss];
}

-(void)combinationAction:(NSString *)com1 second:(NSString *)com2
{
    NSString *combinationString=[NSString stringWithFormat:@"%@_%@_%@",[DetailListAryData valueForKey:@"productID"],com1,com2];
    int t=0;
    for (int com=0; com<encodedCombinations.count; com++)
    {
        if([combinationString isEqualToString:[[encodedCombinations objectAtIndex:com]valueForKey:@"combination"]])
        {
            t=1;
            combinationHash=[[encodedCombinations objectAtIndex:com]valueForKey:@"combinationHash"];
        }
        else
        {
        }
    }
    if (t==0)
    {
        NSString *str=@"Ok";
        NSString *msg=@"THIS COMBINATION DOES NOT EXIST FOR THIS PRODUCT";
        if (appDelObj.isArabic) {
            str=@" موافق ";
            msg=@"هذا الجمع لا يوجد لهذا المنتج";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
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
        NSString *OPTID;
        fav=@"ApplyCombination";
        if ([chooseOption isEqualToString:@"yes"])
        {
            OPTID=productOptionID;
        }
        else
        {
            OPTID=[DetailListAryData valueForKey:@"productOptionID"];
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/ajaxGetCombinationImages/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[DetailListAryData valueForKey:@"productID"],@"productID",OPTID,@"productOptionID",combinationHash,@"combinationID", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
}
-(void)writeReview
{
    NSString *OPTID;
    if ([chooseOption isEqualToString:@"yes"])
    {
        OPTID=productOptionID;
    }
    else
    {
        OPTID=[DetailListAryData valueForKey:@"productOptionID"];
    }
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    LoginViewController *login=[[LoginViewController alloc]init];
    login.fromWhere=@"WriteReview";
    appDelObj.fromWhere=@"WriteReview";

    login.productID=[DetailListAryData valueForKey:@"productID"];
    login.productOptID=OPTID;
    ArabicLoginViewController *loginAra=[[ArabicLoginViewController alloc]init];
    loginAra.fromWhere=@"WriteReview";
    loginAra.productID=[DetailListAryData valueForKey:@"productID"];
    loginAra.productOptID=OPTID;
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
    WiriteReviewViewController *write=[[WiriteReviewViewController alloc]init];
    write.productID=[DetailListAryData valueForKey:@"productID"];
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:write animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:write animated:YES];
    }
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

- (IBAction)optionCloseAction:(id)sender {
}
- (IBAction)optionCancelAction:(id)sender
{
    CGRect rect = self.optionsView.frame;
        [UIView animateWithDuration:0.0
                     animations:^{
                         self.optionsView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.optionsView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.optionsView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.optionsView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.optionsView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.optionsView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}

- (IBAction)optionApplyAction:(id)sender
{
    CGRect rect = self.optionsView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.optionsView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.optionsView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.optionsView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.optionsView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.optionsView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.optionsView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}

- (IBAction)backAction:(id)sender
{
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

- (IBAction)searchAction:(id)sender
{
    NSString *cartCount=[[NSUserDefaults standardUserDefaults]objectForKey:@"CART_COUNT"];
    if (cartCount.length==0)
    {
    }
    else
    {
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    LoginViewController *login=[[LoginViewController alloc]init];
    CartViewController *cart=[[CartViewController alloc]init];
        appDelObj.fromWhere=@"Cart";
        login.fromWhere=@"Cart";

    appDelObj.frommenu=@"no";
            ArabicLoginViewController *loginARA=[[ArabicLoginViewController alloc]init];
        loginARA.fromWhere=@"Cart";

        [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"FROM"];
        [[NSUserDefaults standardUserDefaults]synchronize];
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
            [self.navigationController pushViewController:loginARA animated:NO];
        }
        else
        {
            [self.navigationController pushViewController:login animated:YES];
        }
    }
    else
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
            [self.navigationController pushViewController:cart animated:NO];
        }
        else
        {
            [self.navigationController pushViewController:cart animated:YES];
        }
    }
    }
}
- (IBAction)favouriteAction:(id)sender
{
    LoginViewController *login=[[LoginViewController alloc]init];
    ArabicLoginViewController *loginAra=[[ArabicLoginViewController alloc]init];
    login.fromWhere=@"Favourite";
       loginAra.fromWhere=@"Favourite";
    appDelObj.fromWhere=@"Favourite";
    login.productID=[DetailListAryData valueForKey:@"productID"];
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
            if ([btn.currentBackgroundImage isEqual: [UIImage imageNamed:@"wish2.png"]])
            {
                fav=@"fav";
                loginorNot=@"";
              // [_btnFav setBackgroundImage:[UIImage imageNamed:@"wish111.png"] forState:UIControlStateNormal];
 rmvWish=1;
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
                [_btnFav setBackgroundImage:[UIImage imageNamed:@"wish2.png"] forState:UIControlStateNormal];
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                fav=@"fav";
                loginorNot=@"";
                NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/ajaxWishList/languageID/",appDelObj.languageId];
                NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[DetailListAryData valueForKey:@"productID"],@"productID", nil];
                
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
            }
            
       // }
        
        
   
     }
}
- (IBAction)shareAction:(id)sender
{
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    LoginViewController *login=[[LoginViewController alloc]init];
    login.fromWhere=@"Share";
    appDelObj.fromWhere=@"Share";
    login.productID=[DetailListAryData valueForKey:@"productID"];
    login.productOptID=[DetailListAryData valueForKey:@"productOptionID"];
    login.qty=@"1";
    login.productImg=[DetailListAryData valueForKey:@"productImage"];
    NSString *sname=self.productName;
    NSString *strname=[sname stringByReplacingOccurrencesOfString:@"&amp;" withString:@"&"];
    login.productName=strname;
    ArabicLoginViewController *loginAra=[[ArabicLoginViewController alloc]init];
    loginAra.fromWhere=@"Share";
    loginAra.productID=[DetailListAryData valueForKey:@"productID"];
    loginAra.productOptID=[DetailListAryData valueForKey:@"productOptionID"];
    loginAra.qty=@"1";
    loginAra.productImg=[DetailListAryData valueForKey:@"productImage"];
    loginAra.productName=strname;
    CartViewController *cart=[[CartViewController alloc]init];
    appDelObj.frommenu=@"no";
    [[NSUserDefaults standardUserDefaults]setObject:@"no" forKey:@"FROM"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    cart.fromDetail=@"yes";
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
    NSString * message = @"";
    NSString *strImgUrl=[DetailListAryData  valueForKey:@"productImage"] ;
        NSString *urlIMG;
        if (strImgUrl.length!=0)
        {
            NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
            
            if([s isEqualToString:@"http"])
            {
                urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];// @"http://pan02.ispghosting.com/couponmed/public/uploads/widgets/images/Banner_1.png";
            }
            else
            {
                urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
            }
        }
        else{
            urlIMG=@"";
        }
    
    NSArray * shareItems = @[message, urlIMG];
    UIActivityViewController * avc = [[UIActivityViewController alloc] initWithActivityItems:shareItems applicationActivities:nil];
        if ( [avc respondsToSelector:@selector(popoverPresentationController)] )
        {
            // iOS8
            //avc.view.frame=CGRectMake(avc.view.frame.origin.x, self.view.frame.size.height-avc.view.frame.size.height, self.view.frame.size.width, avc.view.frame.size.height);
            avc.popoverPresentationController.sourceView =self.view ;   }
    [self presentViewController:avc animated:YES completion:nil];
    }
}
- (IBAction)buyNowAction:(id)sender
{
    int productQty=[[DetailListAryData valueForKey:@"productOptionQuantity"]intValue];
    int productOptQty=[[DetailListAryData valueForKey:@"productQuantityUnlimited"]intValue];
    int stock=productQty+productOptQty;
//    if (stock<1) {
//        NSString *str=@"Stock not available";
//        NSString *ok=@"Ok";
//        if (appDelObj.isArabic) {
//            str=@"المخزون غير متوفر";
//            ok=@" موافق ";
//        }
//        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
//        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
//        [self presentViewController:alertController animated:YES completion:nil];
//    }
//    else
//    {
    NSString *combinationHash=@"";
    NSString *optionHash=@"";
    NSString *selectAllCustomOption=@"Yes";
    NSString *comPriceString=@"";
    NSString *strCombinationValues=@"";
    if ([customOption isKindOfClass:[NSNull class]]||customOption.count==0)
    {
        selectAllCustomOption=@"Yes";
    }
    else
    {
        for (int i=0; i<customOption.count; i++)
        {
            NSString *st=[[customOption objectAtIndex:i]valueForKey:@"validateRule"] ;
            NSArray *a=[st componentsSeparatedByString:@"~"];
            
            if ([[a objectAtIndex:0]isEqualToString:@"required"]||[[a objectAtIndex:0]isEqualToString:@"Required"])
            {
                if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
                {
                    NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:1]valueForKey:@"inputType"],multiSelVarientAry);
                    if (multiSelVarientAry.count==0)
                    {
                        selectAllCustomOption=@"No";
                    }
                    else
                    {
                        //selectAllCustomOption=@"Yes";
                    }
                }
                else
                {
                    
                    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:i];
                    CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:path];
                    
                    if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"file"])
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtDay.text);
                        NSString *str=cell.txtDay.text;
                        NSLog(@"Select************* val=%@  ",str);
                        
                        if (cell.txtDay.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                    }
                    else if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"datetime"])
                    {
                        NSLog(@"Select val=%@ label=%@ label=%@",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtDay.text,cell.txtHour.text);
                        
                        if (cell.txtHour.text.length==0||cell.txtDay.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                        
                        
                    }
                    else if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"time"])
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtHour.text);
                        
                        if (cell.txtHour.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                        
                    }
                    else if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"date"])
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtDay.text);
                        
                        if (cell.txtDay.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                        
                    }
                    else if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"textbox"])
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtDay.text);
                        
                        if (cell.txtDay.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                    }
                    else if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"textarea"])
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.text.text);
                        
                        if (cell.text.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                    }
                    
                    else
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtDay.text);
                        
                        if (cell.txtDay.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                    }
                    
                    
                    
                }
                
            }
        }
    }
    if ([selectAllCustomOption isEqualToString:@"Yes"])
    {
        if (encodedCombinations.count!=0)
        {
            strCombinationValues=@"";
            int flagAdd=0,selComIndex = 0;
            NSString *errorMSg=@"";
            NSLog(@"Sel  %@ \n  All   %@",includeCombinationArray,encodedCombinations);
            if(includeCombinationArray.count==0)
            {
                combinationHash=[[encodedCombinations objectAtIndex:0]valueForKey:@"combinationHash"];
                optionHash=[[encodedCombinations objectAtIndex:0]valueForKey:@"combination"];
                CombPrice=[[encodedCombinations objectAtIndex:0]valueForKey:@"combinationPrice"];
                combPriceDiff=[[encodedCombinations objectAtIndex:0]valueForKey:@"combinationPriceDiffType"];
                comSKU=[[encodedCombinations objectAtIndex:0]valueForKey:@"combinationSKU"];
                
                comPriceString=[NSString stringWithFormat:@"->combinationSKU~*%@->combinationPrice~*%@->combinationPriceDiffType~*%@",comSKU,CombPrice,combPriceDiff];
            }
            else
            {
                combinationHash=@"";
                optionHash=@"";
                NSString *creatComp=[NSString stringWithFormat:@"%@",self.productID];
                //NSString *selectedHashCreation;
                for (int i=0; i<includeCombinationArray.count; i++)
                {
                    creatComp=[NSString stringWithFormat:@"%@_%@",creatComp,[includeCombinationArray objectAtIndex:i]];
                }
                
                for (int j=0; j<encodedCombinations.count; j++)
                {
                    NSString *exisComp=[[encodedCombinations objectAtIndex:j]valueForKey:@"combination"];
                    if ([exisComp isEqualToString:creatComp])
                    {
                        NSString *qtYsel=self.lblQtySelected.text;
                        NSString *combYsel=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combinationQty"]];
                        int a=[qtYsel intValue];
                        int b=[combYsel intValue];
                        if (b==0||a>b)
                        {
                            errorMSg=@"THIS PRODUCT IS NO LONGER IN STOCK WITH THOSE ATTRIBUTES";
                            if (appDelObj.isArabic) {
                                
                                errorMSg=@"هذا المنتج لم يعد في الأوراق المالية مع تلك السمات";
                            }
                            flagAdd=1;
                            selComIndex=j;
                        }
                        else
                        {
                            flagAdd=0;
                            selComIndex=j;
                            
                            combinationHash=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combinationHash"]];
                            optionHash=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combination"]];
                            CombPrice=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combinationPrice"]];
                            combPriceDiff=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combinationPriceDiffType"]];
                            comSKU=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combinationSKU"]];
                            
                            comPriceString=[NSString stringWithFormat:@"->combinationSKU~*%@->combinationPrice~*%@->combinationPriceDiffType~*%@",comSKU,CombPrice,combPriceDiff];
                        }
                        
                        break;
                        
                    }
                    else
                    {
                        if (combinationHash.length==0)
                        {
                            NSArray *firstArr=[exisComp componentsSeparatedByString:@"_"];
                            NSArray *secondArr=[creatComp componentsSeparatedByString:@"_"];
                            
                            //                            BOOL arraysContainTheSameObjects = YES;
                            //                            NSEnumerator *otherEnum = [secondArr objectEnumerator];
                            //                            for (NSString *myObject in firstArr) {
                            //                                if (myObject != [otherEnum nextObject]) {
                            //                                    //We have found a pair of two different objects.
                            //                                    arraysContainTheSameObjects = NO;
                            //                                    break;
                            //                                }
                            //                            }
                            
                            if (firstArr.count==secondArr.count)
                            {
                                
                                for (int k=1; k<firstArr.count; k++)
                                {
                                    NSString *valFirst=[firstArr objectAtIndex:k];
                                    for (int l=1; l<secondArr.count; l++)
                                    {
                                        if ([valFirst isEqualToString:[secondArr objectAtIndex:l]])
                                        {
                                            flagAdd=0;
                                        }
                                        else
                                        {
                                            flagAdd=1;
                                            
                                        }
                                    }
                                    if (flagAdd==1)
                                    {
                                        errorMSg=@"THIS COMBINATION DOES NOT EXIST FOR THIS PRODUCT";
                                        if (appDelObj.isArabic) {
                                            
                                            errorMSg=@"هذه المجموعة غير موجودة لهذا المنتج";
                                        }
                                        break;
                                    }
                                }
                                
                            }
                            else
                            {
                                flagAdd=1;
                                errorMSg=@"THIS COMBINATION DOES NOT EXIST FOR THIS PRODUCT";
                               
                                if (appDelObj.isArabic) {
                                  
                                    errorMSg=@"هذه المجموعة غير موجودة لهذا المنتج";
                                }
                                //break;
                            }
                        }
                        
                    }
                    
                    
                }
                if (flagAdd==1)
                {
                    NSString *str=@"Ok";
                    if (appDelObj.isArabic) {
                        str=@" موافق ";
                    }
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:errorMSg preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    
                    NSString *qtYsel=self.lblQtySelected.text;
                    NSString *combYsel=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combinationQty"]];
                    int a=[qtYsel intValue];
                    int b=[combYsel intValue];
                    if (b==0||a>b)
                    {
                        errorMSg=@"THIS PRODUCT IS NO LONGER IN STOCK WITH THOSE ATTRIBUTES";
                        flagAdd=1;
                        
                    }
                    else
                    {
                        
                        
                        combinationHash=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combinationHash"]];
                        optionHash=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combination"]];
                        CombPrice=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combinationPrice"]];
                        combPriceDiff=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combinationPriceDiffType"]];
                        comSKU=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combinationSKU"]];
                        
                        comPriceString=[NSString stringWithFormat:@"->combinationSKU~*%@->combinationPrice~*%@->combinationPriceDiffType~*%@",comSKU,CombPrice,combPriceDiff];
                        
                    }
                    
                }
                
                if (flagAdd==1)
                {
                    NSString *str=@"Ok";
                    if (appDelObj.isArabic) {
                        str=@" موافق ";
                    }
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:errorMSg preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:str style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    NSString *gotoAddCart=@"";
                    NSString *Sub;
                    if ([[DetailListAryData valueForKey:@"subscribeSave"]isEqualToString:@"Yes"]||[[DetailListAryData valueForKey:@"subscribeSave"]isEqualToString:@"YES"]||[[DetailListAryData valueForKey:@"subscribeSave"]isEqualToString:@"yes"])
                    {
                        if([selSubscriptionname isEqualToString:@"subscribe"])
                        {
                            if (subID.length==0||selSubOptID.length==0||deliveriesvalue.length==0)
                            {
                                gotoAddCart=@"No";
                                
                            }
                            else{
                                Sub=[NSString stringWithFormat:@"%@-%@-%@",subID,selSubOptID,deliveriesvalue];
                                subscribe=@"subscribe";
                                gotoAddCart=@"Yes";
                            }
                        }
                        else
                        {
                            Sub=@"";
                            subscribe=@"";
                            gotoAddCart=@"Yes";
                        }
                        
                    }
                    else
                    {
                        gotoAddCart=@"Yes";
                        Sub=@"";
                        subscribe=@"";
                        
                    }
                    if ([gotoAddCart isEqualToString:@"Yes"])
                    {
                        NSString *customString=@"!";
                        for (int i=0; i<customOption.count; i++)
                        {
                            NSString *st=[[customOption objectAtIndex:i]valueForKey:@"validateRule"] ;
                            NSArray *a=[st componentsSeparatedByString:@"~"];
                            
                            //                    if ([[a objectAtIndex:0]isEqualToString:@"required"]||[[a objectAtIndex:0]isEqualToString:@"Required"])
                            //                    {
                            NSLog(@"%@",[customOption objectAtIndex:i]);
                            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                            CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                            if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"file"])
                            {
                                customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",fileName,fileName,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"datetime"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                                [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                                NSString *dateString;
                                dateString = [NSString stringWithFormat:@"%@ %@",cell.txtDay.text,cell.txtHour.text];
                                if (cell.txtDay.text.length==0&&cell.txtHour.text.length==0) {
                                    
                                }
                                else
                                {
                                    //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"time"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                                [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                                NSString *dateString;
                                dateString = [NSString stringWithFormat:@"%@",cell.txtHour.text];
                                //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                                if (cell.txtHour.text.length==0) {
                                    
                                }
                                else
                                {
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"date"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                                [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                                NSString *dateString;
                                dateString = [NSString stringWithFormat:@"%@",cell.txtHour.text];
                                //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                                if (cell.txtHour.text.length==0) {
                                    
                                }
                                else
                                {
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"textbox"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                if (cell.txtDay.text.length==0) {
                                    
                                }
                                else
                                {
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",cell.txtDay.text,cell.txtDay.text,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"textarea"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                if (cell.txtDay.text.length==0) {
                                    
                                }
                                else
                                {
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",cell.txtDay.text,cell.txtDay.text,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                if (multiSelVarientAry.count==0)
                                {
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",@"",@"",[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                                else
                                {
                                    NSArray *a=[[customOption objectAtIndex:i]valueForKey:@"variants"];
                                    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.customOptionID contains[cd] %@",[[customOption objectAtIndex:i]valueForKey:@"customOptionID"]];
                                    NSArray * listArr = [multiSelVarientAry filteredArrayUsingPredicate:bPredicate];
                                    // NSString *s=[[multiSelVarientAry objectAtIndex:0]valueForKey:@"value"];
                                    for (int t=0; t<listArr.count; t++)
                                    {
                                        customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[listArr objectAtIndex:t]valueForKey:@"customOptionVariantID"],[[listArr objectAtIndex:t]valueForKey:@"value"],[[listArr objectAtIndex:t]valueForKey:@"value"],[[listArr objectAtIndex:t]valueForKey:@"priceDiff"],[[listArr objectAtIndex:t]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                        
                                        //                                        s=[NSString stringWithFormat:@"%@,%@",s,[[multiSelVarientAry objectAtIndex:t]valueForKey:@"value"]];
                                    }
                                    //customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[listArr objectAtIndex:0] valueForKey:@"customOptionVariantID"],s,s,[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else
                            {
                                
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                if (cell.txtDay.text.length==0) {
                                    
                                }
                                else
                                {
                                    NSArray *a=[[customOption objectAtIndex:i]valueForKey:@"variants"];
                                    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.value contains[cd] %@",cell.txtDay.text];
                                    NSArray * listArr = [a filteredArrayUsingPredicate:bPredicate];
                                    if (listArr.count!=0)
                                    {
                                        if ([[[customOption objectAtIndex:i]valueForKey:@"include_in_combination"] isEqualToString:@"Yes"])
                                        {
                                            strCombinationValues=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:inputType~*%@",strCombinationValues,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[listArr objectAtIndex:0] valueForKey:@"customOptionVariantID"],[[listArr objectAtIndex:0] valueForKey:@"value"],cell.txtDay.text,[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                            
                                            
                                        }
                                        else
                                        {
                                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[listArr objectAtIndex:0] valueForKey:@"customOptionVariantID"],[[listArr objectAtIndex:0] valueForKey:@"value"],cell.txtDay.text,[[listArr objectAtIndex:0] valueForKey:@"priceDiff"],[[listArr objectAtIndex:0] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                        }
                        customString=[NSString stringWithFormat:@"%@-> ",customString];
                        
                        NSString *finalCustomString=[customString stringByReplacingOccurrencesOfString:@"!" withString:@""];
                        if ([finalCustomString isEqualToString:@"->"]||[finalCustomString isEqualToString:@"->"]||[finalCustomString isEqualToString:@"!"]||finalCustomString.length==0) {
                            finalCustomString=@"";
                        }
                        if ([strCombinationValues isEqualToString:@"->"]||[strCombinationValues isEqualToString:@"->"]||[strCombinationValues isEqualToString:@"!"]||strCombinationValues.length==0) {
                            strCombinationValues=@"";
                        }
                        else
                        {
                            strCombinationValues=[NSString stringWithFormat:@"%@%@",comPriceString,strCombinationValues];
                        }
                        loginorNot=@"login";
                        UIButton *btn=(UIButton *)sender;
                        if ([subscribeORnot isEqualToString:@"Yes"])
                        {
                            addtoCart=@"";
                        }
                        else
                        {
                            addtoCart=@"AddCart";
                            
                        }
                        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                        NSString *OPTID=productOptionID;
                        if ([chooseOption isEqualToString:@"yes"])
                        {
                            OPTID=productOptionID;
                        }
                        else
                        {
                            OPTID=[DetailListAryData valueForKey:@"productOptionID"];
                        }
                        
                        if (appDelObj.isArabic)
                        {
                            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                        }
                        else
                        {
                            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                        }
                        if (userID.length==0)
                        {
                            userID=@"0";
                        }
                        NSString *urlStr;
                        NSMutableDictionary *dicPost;
                        NSString *currency=[DetailListAryData valueForKey:@"productDefaultCurrency"];
                        NSString *image=[DetailListAryData valueForKey:@"productImage"];
                        NSString *titileProduct=[DetailListAryData valueForKey:@"productTitle"];
                        NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
                        if (CAID.length==0||[CAID isEqualToString:@""])
                        {
                            CAID=@"";
                            urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
                            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",[DetailListAryData valueForKey:@"productID"],@"productID",productOptionID,@"productOptionID",self.lblQtySelected.text,@"quantity",[DetailListAryData valueForKey:@"productTitle"],@"productOptionName",[DetailListAryData valueForKey:@"productTitle"],@"productTitle",[DetailListAryData valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",@"",@"cartID",[DetailListAryData valueForKey:@"productImage"],@"productImage",optionHash,@"optionsHash",combinationHash,@"combinationHash",strCombinationValues,@"strcombinationValues",Sub,@"subAttr",selSubscriptionname,@"purchase",finalCustomString,@"customOptionValues",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
                            
                        }
                        else
                        {
                            urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
                            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",CAID,@"cartID",[DetailListAryData valueForKey:@"productID"],@"productID",productOptionID,@"productOptionID",self.lblQtySelected.text,@"quantity",[DetailListAryData valueForKey:@"productTitle"],@"productOptionName",[DetailListAryData valueForKey:@"productTitle"],@"productTitle",[DetailListAryData valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",[DetailListAryData valueForKey:@"productImage"],@"productImage",optionHash,@"optionsHash",combinationHash,@"combinationHash",strCombinationValues,@"strcombinationValues",Sub,@"subAttr",selSubscriptionname,@"purchase",finalCustomString,@"customOptionValues",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
                        }
                        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                        
                    }
                    else
                    {
                        if (subID.length==0&&selSubOptID.length==0&&deliveriesvalue.length==0)
                        {
                            
                            NSString *str=@"Ok";
                            NSString *msg=@"Please select a frequency and corresponding delivery!.";
                            if (appDelObj.isArabic) {
                                str=@" موافق ";
                                msg=@"Please select a frequency and corresponding delivery!.";
                            }
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:msg preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                            [self presentViewController:alertController animated:YES completion:nil];
                            
                        }
                        else if (subID.length==0)
                        {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select subscription!." preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                            [self presentViewController:alertController animated:YES completion:nil];
                            
                        }
                        else if (selSubOptID.length==0)
                        {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select a delivery!." preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                            [self presentViewController:alertController animated:YES completion:nil];
                            
                        }
                        else
                        {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select frequency!." preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                            [self presentViewController:alertController animated:YES completion:nil];
                        }
                    }
                    
                    
                    
                    
                    
                    
                }
            }
            
        }
        else
        {
            combinationHash=@"";
            NSString *Sub;
            NSString *gotoAddCart=@"";
           
            
                NSString *customString=@"!";
                for (int i=0; i<customOption.count; i++)
                {
                    NSString *st=[[customOption objectAtIndex:i]valueForKey:@"validateRule"] ;
                    NSArray *a=[st componentsSeparatedByString:@"~"];
                    
                    //                    if ([[a objectAtIndex:0]isEqualToString:@"required"]||[[a objectAtIndex:0]isEqualToString:@"Required"])
                    //                    {
                    
                    NSLog(@"%@",[customOption objectAtIndex:i]);
                    NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                    CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                    if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"file"])
                    {
                        customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",fileName,fileName,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"datetime"])
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                        NSString *dateString;
                        dateString = [NSString stringWithFormat:@"%@ %@",cell.txtDay.text,cell.txtHour.text];
                        if (cell.txtDay.text.length==0&&cell.txtHour.text.length==0) {
                            
                        }
                        else
                        {
                            //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"time"])
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                        NSString *dateString;
                        dateString = [NSString stringWithFormat:@"%@",cell.txtHour.text];
                        //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                        if (cell.txtHour.text.length==0) {
                            
                        }
                        else
                        {
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"date"])
                    {
                        
                        //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                        NSString *dateString;
                        dateString = [NSString stringWithFormat:@"%@",cell.txtDay.text];
                        if (cell.txtDay.text.length==0) {
                            
                        }
                        else
                        {
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"textbox"])
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        if (cell.txtDay.text.length==0) {
                            
                        }
                        else
                        {
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",cell.txtDay.text,cell.txtDay.text,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"textarea"])
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        if (cell.txtDay.text.length==0) {
                            
                        }
                        else
                        {
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",cell.txtDay.text,cell.txtDay.text,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        if (multiSelVarientAry.count==0)
                        {
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",@"",@"",[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                        else
                        {
                            NSArray *a=[[customOption objectAtIndex:i]valueForKey:@"variants"];
                            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.value contains[cd] %@",cell.txtDay.text];
                            NSArray * listArr = [a filteredArrayUsingPredicate:bPredicate];
                            NSString *s=[NSString stringWithFormat:@"%@",[[multiSelVarientAry objectAtIndex:0]valueForKey:@"value"]];
                            
                            for (int t=0; t<multiSelVarientAry.count; t++)
                            {
                                customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[multiSelVarientAry objectAtIndex:t]valueForKey:@"customOptionVariantID"],[[multiSelVarientAry objectAtIndex:t]valueForKey:@"value"],[[multiSelVarientAry objectAtIndex:t]valueForKey:@"value"],[[multiSelVarientAry objectAtIndex:t]valueForKey:@"priceDiff"],[[multiSelVarientAry objectAtIndex:t]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                
                                s=[NSString stringWithFormat:@"%@,%@",s,[[multiSelVarientAry objectAtIndex:t]valueForKey:@"value"]];
                            }
                        }
                    }
                    else
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        if (cell.txtDay.text.length==0) {
                            
                        }
                        else
                        {
                            NSArray *a=[[customOption objectAtIndex:i]valueForKey:@"variants"];
                            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.value contains[cd] %@",cell.txtDay.text];
                            NSArray * listArr = [a filteredArrayUsingPredicate:bPredicate];
                            if (listArr.count!=0)
                            {
                                customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[listArr objectAtIndex:0] valueForKey:@"customOptionVariantID"],[[listArr objectAtIndex:0] valueForKey:@"value"],cell.txtDay.text,[[listArr objectAtIndex:0]valueForKey:@"priceDiff"],[[listArr objectAtIndex:0]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                            }
                        }
                        
                    }
                }
                customString=[NSString stringWithFormat:@"%@-> ",customString];
                NSString *finalCustomString=[customString stringByReplacingOccurrencesOfString:@"!" withString:@""];
                loginorNot=@"login";
                UIButton *btn=(UIButton *)sender;
                if ([subscribeORnot isEqualToString:@"Yes"])
                {
                    addtoCart=@"";
                }
                else
                {
                    addtoCart=@"AddCart";
                    
                }
                NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                NSString *OPTID;
                if ([chooseOption isEqualToString:@"yes"])
                {
                    OPTID=productOptionID;
                }
                else
                {
                    OPTID=[DetailListAryData valueForKey:@"productOptionID"];
                }
                
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
                if (userID.length==0)
                {
                    userID=@"0";
                }
                NSString *urlStr;
                NSMutableDictionary *dicPost;
                NSString *currency=[DetailListAryData valueForKey:@"productDefaultCurrency"];
                NSString *image=[DetailListAryData valueForKey:@"productImage"];
                NSString *titileProduct=[DetailListAryData valueForKey:@"productTitle"];
                NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
                if (CAID.length==0||[CAID isEqualToString:@""])
                {
                    CAID=@"";
                    urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
                    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",[DetailListAryData valueForKey:@"productID"],@"productID",productOptionID,@"productOptionID",self.lblQtySelected.text,@"quantity",[DetailListAryData valueForKey:@"productTitle"],@"productOptionName",[DetailListAryData valueForKey:@"productTitle"],@"productTitle",[DetailListAryData valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",@"",@"cartID",[DetailListAryData valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",strCombinationValues,@"strcombinationValues",Sub,@"subAttr",selSubscriptionname,@"purchase",finalCustomString,@"customOptionValues",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
                    
                }
                else
                {
                    urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
                    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",CAID,@"cartID",[DetailListAryData valueForKey:@"productID"],@"productID",productOptionID,@"productOptionID",self.lblQtySelected.text,@"quantity",[DetailListAryData valueForKey:@"productTitle"],@"productOptionName",[DetailListAryData valueForKey:@"productTitle"],@"productTitle",[DetailListAryData valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",[DetailListAryData valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",strCombinationValues,@"strcombinationValues",Sub,@"subAttr",selSubscriptionname,@"purchase",finalCustomString,@"customOptionValues",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
                }
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                
            
            
            
        }
    }
    else
    {
        NSString *str=@"Please select all madatory fields!.";
        NSString *ok=@"Ok";
        if (appDelObj.isArabic) {
            str=@"يرجى تحديد جميع الحقول المجنونة!";
            ok=@" موافق ";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
//    }
    
}
- (IBAction)listOptionAction:(id)sender
{
    self.optionsView.alpha = 1;
    self.optionsView.frame = CGRectMake(self.optionsView.frame.origin.x, self.optionsView.frame.origin.y, self.optionsView.frame.size.width, self.optionsView.frame.size.height);
    [self.view addSubview:self.optionsView];
    self.optionsView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.optionsView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.optionsView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              CGRect rect = self.optionsView.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.optionsView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
}
- (IBAction)closeClockAction:(id)sender {
    UIButton *btn=(UIButton *)sender;
    NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:btn.tag];
    cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
    cell.txtHour.text=self.myLabel.text;
    CGRect rect = self.timeView.frame;
    
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.timeView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.timeView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.timeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.timeView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.timeView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.timeView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self optionCancelAction:nil];
}
- (IBAction)viewAllSellerAction:(id)sender {
    self.sleereAllView.alpha = 1;
    
    self.sleereAllView.frame = CGRectMake(self.sleereAllView.frame.origin.x, self.sleereAllView.frame.origin.y, self.sleereAllView.frame.size.width, self.sleereAllView.frame.size.height);
    [self.view addSubview:self.sleereAllView];
    self.sleereAllView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.sleereAllView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.sleereAllView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              CGRect rect = self.sleereAllView.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.sleereAllView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
}

- (IBAction)sellerBackAction:(id)sender {
    CGRect rect = self.sleereAllView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.sleereAllView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.sleereAllView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.sleereAllView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.sleereAllView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.sleereAllView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.sleereAllView removeFromSuperview];
                                                               }];
                                          }];
                     }];
}

- (IBAction)viewCartAction:(id)sender {
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

- (IBAction)pickerAction:(id)sender {
    
//    if (outStock<1) {
//
//            NSString *str=@"No stock available";
//            NSString *ok=@"Ok";
//            if (appDelObj.isArabic) {
//                str=@"لا يوجد مخزون متاح";
//                ok=@" موافق ";
//            }
//            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
//            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
//            [self presentViewController:alertController animated:YES completion:nil];
//        }
//        else
//        {
            UIButton *btn=(UIButton*)sender;
            int qtySel=[self.lblQtySelected.text intValue];
           
           
                if (qtySel>=maxQty)
                {
                    
                }
            
                else
                {
                    
                    if(btn.tag==1)
                    {
                        qtySel++;
                        self.lblQtySelected.text=[NSString stringWithFormat:@"%d",qtySel];
                        int xp=qtySel;
                        
                        float x=[[DetailListAryData  valueForKey:@"offerPrice"] floatValue];
                        
                        float p=x*xp;
                        price=p;
                        self.hidePrice.text=[NSString stringWithFormat:@"%.2f",p];
                        NSString *s3=[NSString stringWithFormat:@"%.02f",p] ;
                        float x1=[[DetailListAryData  valueForKey:@"productOptionRegularPrice"] floatValue];
                        optprice=x1;
                        //            NSString *s1=[NSString stringWithFormat:@"%.02f",x1] ;
                        NSString *p1=s3;
                        //            NSString *p2=s3;
                        //            if ([p1 isEqualToString:p2])
                        //            {
                        NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",p1],appDelObj.currencySymbol]];
                        
                        if (appDelObj.isArabic) {
                            [price addAttribute:NSFontAttributeName
                                          value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                                          range:NSMakeRange(0, [price length])];
                        }
                        [price addAttribute:NSForegroundColorAttributeName value:appDelObj.priceColor                               range:NSMakeRange(0, [price length])];
                        self.lblprice.attributedText=price;
                        self.lblBottomPrice.attributedText=price;
                          self.lblBottomPrice.textColor=[UIColor redColor];
                    }
                    else
                    {
                        if (qtySel<=minQty||qtySel==1)
                        {
                            
                        }
                        else
                        {
                            qtySel--;
                            self.lblQtySelected.text=[NSString stringWithFormat:@"%d",qtySel];
                            int xp=qtySel;
                            
                            float x=[[DetailListAryData  valueForKey:@"offerPrice"] floatValue];
                            
                            float p=x*xp;
                            price=p;
                            self.hidePrice.text=[NSString stringWithFormat:@"%.2f",p];
                            NSString *s3=[NSString stringWithFormat:@"%.02f",p] ;
                            float x1=[[DetailListAryData  valueForKey:@"productOptionRegularPrice"] floatValue];
                            optprice=x1;
                            //            NSString *s1=[NSString stringWithFormat:@"%.02f",x1] ;
                            NSString *p1=s3;
                            //            NSString *p2=s3;
                            //            if ([p1 isEqualToString:p2])
                            //            {
                            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",p1],appDelObj.currencySymbol]];
                            
                            if (appDelObj.isArabic) {
                                [price addAttribute:NSFontAttributeName
                                              value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
                                              range:NSMakeRange(0, [price length])];
                            }
                            [price addAttribute:NSForegroundColorAttributeName value:appDelObj.priceColor                               range:NSMakeRange(0, [price length])];
                            self.lblprice.attributedText=price;
                            self.lblBottomPrice.attributedText=price;
                              self.lblBottomPrice.textColor=[UIColor redColor];
                        }
                       
                    }
                    
               
            }
            
//            }
//            else{
//                NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
//                if (appDelObj.isArabic) {
//                    str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
//                }
//
//                NSMutableAttributedString *string= [[NSMutableAttributedString alloc]                                                    initWithAttributedString:str];
//                [string addAttribute:NSForegroundColorAttributeName value:appDelObj.priceOffer                               range:NSMakeRange(0, [string length])];
//                [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]                               range:NSMakeRange(0, [string length])];
//                if (appDelObj.isArabic) {
//                    [string addAttribute:NSFontAttributeName
//                                  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
//                                  range:NSMakeRange(0, [string length])];
//                }
//                [string addAttribute:NSStrikethroughStyleAttributeName value:@2                               range:NSMakeRange(0, [string length])];
//                NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
//                if (appDelObj.isArabic)
//                {
//                    price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
//                }
//                [price addAttribute:NSForegroundColorAttributeName   value:appDelObj.priceColor                              range:NSMakeRange(0, [price length])];
//                [price addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]                              range:NSMakeRange(0, [price length])];
//                if (appDelObj.isArabic) {
//                    [price addAttribute:NSFontAttributeName
//                                  value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
//                                  range:NSMakeRange(0, [price length])];
//                }
//                [price appendAttributedString:string];
//                self.lblprice.attributedText=price;
//   self.lblBottomPrice.attributedText=price;
//        }
//
//    }
//    else{
//        int qtySel=[self.lblQtySelected.text intValue];
//
//            if (qtySel>=maxQty)
//            {
//
//            }
//            else
//            {
//                UIButton *btn=(UIButton*)sender;
//                if(btn.tag==1)
//                {
//                    qtySel++;
//                    self.lblQtySelected.text=[NSString stringWithFormat:@"%d",qtySel];
//                }
//                else
//                {
//                    qtySel--;
//                    self.lblQtySelected.text=[NSString stringWithFormat:@"%d",qtySel];
//                }
//
//
//        }
//       int xp=qtySel;
//
//        float x=[[DetailListAryData  valueForKey:@"offerPrice"] floatValue];
//        float p=x*xp;
//        price=p;
//        self.hidePrice.text=[NSString stringWithFormat:@"%.2f",p];
//        NSString *s3=[NSString stringWithFormat:@"%.02f",p] ;
//        float x1=[[DetailListAryData  valueForKey:@"productOptionRegularPrice"] floatValue];
//        optprice=x1;
//        NSString *s1=[NSString stringWithFormat:@"%.02f",x1] ;
//        NSString *p1=s1;
//        NSString *p2=s3;
////        if ([p1 isEqualToString:p2])
////        {
////            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",p2],appDelObj.currencySymbol]];
////            if (appDelObj.isArabic) {
////                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",[NSString stringWithFormat:@"%@",p1],appDelObj.currencySymbol]];
////                if (appDelObj.isArabic) {
////                    [price addAttribute:NSFontAttributeName
////                                  value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
////                                  range:NSMakeRange(0, [price length])];
////                }
////            }
//            self.lblprice.attributedText=price;
//            self.lblBottomPrice.attributedText=price;
////        }
////        else{
////            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
////            if (appDelObj.isArabic) {
////                str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];
////            }
////
////            NSMutableAttributedString *string= [[NSMutableAttributedString alloc]                                                    initWithAttributedString:str];
////            [string addAttribute:NSForegroundColorAttributeName value:appDelObj.priceOffer                               range:NSMakeRange(0, [string length])];
////            [string addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]                               range:NSMakeRange(0, [string length])];
////            if (appDelObj.isArabic) {
////                [string addAttribute:NSFontAttributeName
////                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
////                              range:NSMakeRange(0, [string length])];
////            }
////            [string addAttribute:NSStrikethroughStyleAttributeName value:@2                               range:NSMakeRange(0, [string length])];
////            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
////            if (appDelObj.isArabic)
////            {
////                price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
////            }
////            [price addAttribute:NSForegroundColorAttributeName   value:appDelObj.priceColor                              range:NSMakeRange(0, [price length])];
////            [price addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]                              range:NSMakeRange(0, [price length])];
////            if (appDelObj.isArabic) {
////                [price addAttribute:NSFontAttributeName
////                              value:[UIFont systemFontOfSize:14.0 weight:UIFontWeightMedium]
////                              range:NSMakeRange(0, [price length])];
////            }
////            [price appendAttributedString:string];
////            self.lblprice.attributedText=price;
////            self.lblBottomPrice.attributedText=price;
////        }
//    }
//    //[UIView animateWithDuration:.5 animations:^{picker.frame=CGRectMake(0, self.view.frame.size.height-220, picker.frame.size.width, picker.frame.size.height);}];
//
//

}

- (IBAction)onetimeAction:(id)sender {
    selSubscriptionname=@"onetime";
    [self.btnAddtoCart setTitle:@"ADD TO CART" forState:UIControlStateNormal];

    self.imgOneSel.image=[UIImage imageNamed:@"lan-button-active.png"];
    self.lblOnetime.textColor=appDelObj.redColor;
    self.imgSubscribeSel.image=[UIImage imageNamed:@"lan-button.png"];
    self.lblSubscribe.textColor=appDelObj.titleColor;
    self.subscribeView.frame=CGRectMake(self.subscribeView.frame.origin.x, self.subscribeView.frame.origin.y, self.subscribeView.frame.size.width, 110);
    self.tblSubscription.alpha=0;
    self.checkDeliveryView.frame=CGRectMake(self.checkDeliveryView.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height+1, self.checkDeliveryView.frame.size.width, self.checkDeliveryView.frame.size.height);
    if (substituteMedArray.count==0)
    {
        self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height-1, self.tblSubstituteMedicine.frame.size.width, 0);
        self.tblSubstituteMedicine.alpha=0;
    }
    else{
        self.tblSubstituteMedicine.alpha=1;
        if (substituteMedArray.count<=3)
        {
            self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*substituteMedArray.count)+32);
        }
        else
        {
            self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*3)+92);

        }
        
    }
    
    self.tblDescription.frame=CGRectMake(self.tblDescription.frame.origin.x, self.tblSubstituteMedicine.frame.origin.y+self.tblSubstituteMedicine.frame.size.height+10, self.tblDescription.frame.size.width, heghtDes);    self.AllSellerView.alpha=0; self.AllSellerView.frame=CGRectMake(self.AllSellerView.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height, self.AllSellerView.frame.size.width, 0);
    if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"]){
        self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+5, self.tblReview.frame.size.width, 50);
        
    }
    else if ([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0){
        self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width, 0);
        
    }
    else{
        
    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width, 280+(142*reviewArray.count));
    }
    self.tblRelated.frame=CGRectMake(self.tblRelated.frame.origin.x, self.tblReview.frame.origin.y+self.tblReview.frame.size.height+10, self.tblRelated.frame.size.width, 308*relatedItem.count);
 self.scrollViewObj.contentSize=CGSizeMake(0, self.tblRelated.frame.origin.y+self.tblRelated.frame.size.height);

}

- (IBAction)subsCribeAction:(id)sender {
    selSubscriptionname=@"subscribe";
    [self.btnAddtoCart setTitle:@"SUBSCRIBE" forState:UIControlStateNormal];

    self.imgOneSel.image=[UIImage imageNamed:@"lan-button.png"];
    self.lblOnetime.textColor=appDelObj.titleColor;
    self.imgSubscribeSel.image=[UIImage imageNamed:@"lan-button-active.png"];
    self.lblSubscribe.textColor=appDelObj.redColor;
    self.subscribeView.frame=CGRectMake(self.subscribeView.frame.origin.x, self.subscribeView.frame.origin.y, self.subscribeView.frame.size.width, 180);
    self.checkDeliveryView.frame=CGRectMake(self.checkDeliveryView.frame.origin.x, self.subscribeView.frame.origin.y+self.subscribeView.frame.size.height+1, self.checkDeliveryView.frame.size.width, self.checkDeliveryView.frame.size.height);
    if (substituteMedArray.count==0)
    {
        self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height-1, self.tblSubstituteMedicine.frame.size.width, 0);
        self.tblSubstituteMedicine.alpha=0;
    }
    else{
        self.tblSubstituteMedicine.alpha=1;
        self.tblSubstituteMedicine.alpha=1;
        if (substituteMedArray.count<=3)
        {
            self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*substituteMedArray.count)+32);
        }
        else
        {
            self.tblSubstituteMedicine.frame=CGRectMake(0, self.checkDeliveryView.frame.origin.y+self.checkDeliveryView.frame.size.height+10, self.tblSubstituteMedicine.frame.size.width, (62*3)+92);
            
        }    }
    
    self.tblDescription.frame=CGRectMake(self.tblDescription.frame.origin.x, self.tblSubstituteMedicine.frame.origin.y+self.tblSubstituteMedicine.frame.size.height+10, self.tblDescription.frame.size.width, heghtDes);    self.AllSellerView.alpha=0; self.AllSellerView.frame=CGRectMake(self.AllSellerView.frame.origin.x, self.tblDescription.frame.origin.y+self.tblDescription.frame.size.height, self.AllSellerView.frame.size.width, 0);
    if (([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0)&&[enableReview isEqualToString:@"Yes"]){
        self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+5, self.tblReview.frame.size.width, 50);
        
    }
    else if ([reviewArray isKindOfClass:[NSNull class]]||reviewArray.count==0){
        self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width, 0);
        
    }
    else{
        
    self.tblReview.frame=CGRectMake(self.tblReview.frame.origin.x, self.AllSellerView.frame.origin.y+self.AllSellerView.frame.size.height+10, self.tblReview.frame.size.width, 280+(142*reviewArray.count));
    }
    self.tblRelated.frame=CGRectMake(self.tblRelated.frame.origin.x, self.tblReview.frame.origin.y+self.tblReview.frame.size.height+10, self.tblRelated.frame.size.width, 308*relatedItem.count);
 self.scrollViewObj.contentSize=CGSizeMake(0, self.tblRelated.frame.origin.y+self.tblRelated.frame.size.height);
    //[UIView animateWithDuration:.5 animations:^{self}];
}
- (IBAction)subscribeDataAction:(id)sender {
    if(deliveriesvalue.length==0)
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select one option" preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        [self buyNowAction:nil];
    }
}
- (IBAction)checkDeliveryAction:(id)sender {
    if (appDelObj.isArabic)
    {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
 fav=@"Delivery";
    NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/product/checkPincodeAvailability/"];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.txtCheckdelivery.text,@"pincode", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];

}
-(void)textFieldDidBeginEditing:(UITextField *)textField
{
     picker.alpha=0;
    if (textField==self.txtCountryCoun)
    {
        if (appDelObj.isArabic)
        {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        textfield=1;
        NSString *restMessage = [NSString stringWithFormat:@"%@mobileapp/Deal/countriesList/languageID/%@",appDelObj.baseURL,appDelObj.languageId];
        NSURL *url = [NSURL URLWithString:restMessage];
        NSURLRequest *theRequest = [NSURLRequest requestWithURL:url];
        NSURLResponse  *res;
        NSError *err;
        NSData *data = [NSURLConnection sendSynchronousRequest:theRequest returningResponse:&res error:&err];
        //[connection start];
        
        NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
        stateArray =[dic objectForKey:@"result"];
        CID=[[stateArray objectAtIndex:0]valueForKey:@"countryID"];
        cName  =[[stateArray objectAtIndex:0]valueForKey:@"countryName"];
    }
    else if (textField==self.txtregionCon)
    {
        if (CID.length==0)
        {
            NSString *str=@"";
            NSString *ok=@"";
            if (appDelObj.isArabic) {
                ok=@"يرجى اختيار الدولة";
                str=@"";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
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
            }
            textfield=2;
            
            NSString *postUrl = [NSString stringWithFormat:@"%@mobileapp/Deal/stateList/languageID/%@",appDelObj.baseURL,appDelObj.languageId];
            NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[NSURL URLWithString:postUrl] cachePolicy:NSURLRequestReloadIgnoringCacheData timeoutInterval:30];
            [request setHTTPMethod:@"POST"];
            
            NSMutableData *body = [NSMutableData data];
            
            NSString *boundary = @"---------------------------14737809831466499882746641449";
            NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", boundary];
            [request addValue:contentType forHTTPHeaderField:@"Content-Type"];
            
            [body appendData:[[NSString stringWithFormat:@"--%@\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n", @"countryID"] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithString:CID] dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [body appendData:[[NSString stringWithFormat:@"--%@--\r\n", boundary] dataUsingEncoding:NSUTF8StringEncoding]];
            
            // set request body
            [request setHTTPBody:body];
            NSURLResponse  *res;
            NSError *err;
            
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&res error:&err];
            //[connection start];
            
            NSDictionary *dic =[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
            stateArray =[dic objectForKey:@"result"];
            SID=[[stateArray objectAtIndex:0]valueForKey:@"stateID"];
            sName  =[[stateArray objectAtIndex:0]valueForKey:@"stateName"];
        }
        
    }
    [picker2 reloadAllComponents];
    if (stateArray.count==0) {
        [Loading dismiss];
    }
     [Loading dismiss];
}
-(void)chooseData1
{
    if (textfield==1)
    {
        self.txtCountryCoun.text=cName;
    }
    else
    {
        self.txtregionCon.text=sName;
    }
    [self.txtregionCon resignFirstResponder];
    [self.txtCountryCoun resignFirstResponder];
}
- (IBAction)consultingAction:(id)sender {
   
//        loginorNot=@"";
//    [self closeConsutViewAction:nil];
//    fav=@"Consult";
//    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//  NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/product/onlineconsultation/"];
//    NSMutableDictionary *dicPost;
//        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
//        if (userID.length==0) {
//            userID=@"";
//        }
//    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:self.productID,@"productID",userID,@"userID",@"add",@"action",self.txtNameCoun.text,@"consultName",self.txtPinCoun.text,@"reqemailID",self.txtFullAddrCoun.text,@"address",self.txtPhoneCoun.text,@"mobileNo",CID,@"countryID",SID,@"stateID", nil];
//    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    
    
}

- (IBAction)closeConsutViewAction:(id)sender {
    CGRect rect = self.consultView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.consultView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.consultView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.consultView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.consultView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.consultView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [self.consultView removeFromSuperview];
                                                                   
                                                               }];
                                          }];
                     }];

}

- (IBAction)showConsView:(id)sender {
    self.consultView.alpha = 1;
    self.consultView.frame = CGRectMake(self.consultView.frame.origin.x, self.consultView.frame.origin.y, self.consultView.frame.size.width, self.consultView.frame.size.height);
    [self.view addSubview:self.consultView];
    self.consultView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.consultView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.consultView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              CGRect rect = self.consultView.frame;
                                              rect.origin.y = 0;
                                              
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.consultView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                               }];
                                          }];
                     }];
}
-(void)FavouriteAddAction:(NSString *)pid second:(NSString*)sender
{
    LoginViewController *login=[[LoginViewController alloc]init];
    ArabicLoginViewController *loginAra=[[ArabicLoginViewController alloc]init];
    login.fromWhere=@"Favourite";
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
          
//            transition = [CATransition animation];
//            [transition setDuration:0.3];
//            transition.type = kCATransitionPush;
//            transition.subtype = kCATransitionFromRight;
//            [transition setFillMode:kCAFillModeBoth];
//            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//           // [self.navigationController popViewControllerAnimated:NO];
            [self.navigationController pushViewController:login animated:NO];
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
            fav=@"fav";
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Product/ajaxWishList/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",pid,@"productID", nil];
            
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        
        // }
        
        
        
    }
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField==self.txtPhoneCoun)
    {
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        if ([string isEqualToString:filtered])
        {
            return newLength <= 10;
        }
        else{
            NSString *str=@"Please enter a valid phone number";
            NSString *ok=@"Ok";
            if (appDelObj.isArabic) {
                str=@"يرجى إدخال رقم هاتف صالح";
                ok=@" موافق ";
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];            [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            return [string isEqualToString:filtered];
            
        }
    }
    else if (textField==self.txtCheckdelivery)
    {
        if(range.length + range.location > textField.text.length)
        {
            return NO;
        }
        
        NSUInteger newLength = [textField.text length] + [string length] - range.length;
        return newLength <= 6;
    }
    return YES;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
     if (collectionView==self.colFree) {
    return CGSizeMake(150, 135);
     }
    
    return CGSizeMake(150, 255);
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    //if (colItemAry.count>2) {
    return freeProducts.count;
    //}
    
    //return 2;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ItemCollectionViewCell *cell = (ItemCollectionViewCell*) [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    NSString *strImgUrl=[[freeProducts objectAtIndex:indexPath.row ] valueForKey:@"productImage"] ;
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
            urlIMG=[NSString stringWithFormat:@"%@%@",imgUrl,strImgUrl];
        }
       
        if (appDelObj.isArabic) {
             [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"place_holderar.png"]];
        } else {
             [cell.itemImg sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
        }
    }
    else{
        
        if (appDelObj.isArabic) {
            cell.itemImg .image=[UIImage imageNamed:@"place_holderar.png"];
        } else {
            cell.itemImg .image=[UIImage imageNamed:@"placeholder1.png"];
        }
    }
    if(appDelObj.isArabic)
    {
        cell.itemName.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemPrice.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffer.transform = CGAffineTransformMakeScale(-1, 1);
        cell.itemImg.transform = CGAffineTransformMakeScale(-1, 1);
        cell.btnAdd.transform = CGAffineTransformMakeScale(-1, 1);
        [cell.btnAdd setTitle:@"إضافة الى العربة" forState:UIControlStateNormal];
        //cell.itemName.textAlignment=NSTextAlignmentRight;
        cell.lblHot.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblOffLabel.transform = CGAffineTransformMakeScale(-1, 1);
        cell.lblHot.text=@"مميز";
    }
    NSString *hotStr=[[freeProducts objectAtIndex:indexPath.row ]   valueForKey:@"featuredStatus"];
    if ([hotStr isEqualToString:@"Yes"]||[hotStr isEqualToString:@"YES"]||[hotStr isEqualToString:@"yes"]) {
        cell.lblHot.alpha=1;
    }
    cell.btnAdd.alpha=0;
    cell.itemName.text=[[freeProducts objectAtIndex:indexPath.row]valueForKey:@"productTitle"];
    cell.lblOffer.alpha=0;
    if (collectionView==self.colFreeLarge) {
      cell.btnAdd.alpha=1;
        cell.btnAdd.tag=indexPath.row;
    }
    
    NSString *offerStr=[[freeProducts objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"];
    NSArray *offArr=[offerStr componentsSeparatedByString:@"."];
    if ([[offArr objectAtIndex:0]isEqualToString:@"0"]) {
        cell.lblOffer.alpha=0;
        cell.offview.alpha=0;
    }
    else{
        cell.lblOffer.text=[NSString stringWithFormat:@"%@%@ Off",[[freeProducts objectAtIndex:indexPath.row ]   valueForKey:@"productOptionOfferDiscount"],@"%"];
    }
    NSString *freeStr=[[freeProducts objectAtIndex:indexPath.row ]   valueForKey:@"freeProductsExists"];
    if ([freeStr isEqualToString:@"Yes"]||[freeStr isEqualToString:@"YES"]||[freeStr isEqualToString:@"yes"])
    {
        cell.imgfree.alpha=1;
    }
    else
    {
        cell.imgfree.alpha=0;
    }
    float x=[[[freeProducts objectAtIndex:indexPath.row ]   valueForKey:@"offerPrice"] floatValue];
    float x1=[[[freeProducts objectAtIndex:indexPath.row ]   valueForKey:@"productOptionRegularPrice"] floatValue];
    NSString *s1=[NSString stringWithFormat:@"%.02f",x1] ;
    NSString *s2=[NSString stringWithFormat:@"%.02f",x ];
    
    if (s1.length!=0&&s2.length!=0)
    {
        NSArray *a=[s1 componentsSeparatedByString:@"."];
        NSArray *a1=[s2 componentsSeparatedByString:@"."];
        NSString *p1=[a objectAtIndex:0];
        NSString *p2=[a1 objectAtIndex:0];
        if ([s1 isEqualToString:s2])
        {
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",s2,appDelObj.currencySymbol]];
            [price addAttribute:NSForegroundColorAttributeName value:appDelObj.priceColor                           range:NSMakeRange(0, [price length])];
            if (appDelObj.isArabic) {
                [price addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:15.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [price length])];
            }
            cell.itemPrice.attributedText=price;
        }
        else{
            NSMutableAttributedString *str=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@",p1,appDelObj.currencySymbol]];                        NSMutableAttributedString *string= [[NSMutableAttributedString alloc]                                                initWithAttributedString:str];
            [string addAttribute:NSForegroundColorAttributeName value:appDelObj.priceColor                           range:NSMakeRange(0, [string length])];
            [string addAttribute:NSFontAttributeName
                           value:[UIFont systemFontOfSize:10.0 weight:UIFontWeightRegular]
                           range:NSMakeRange(0, [string length])];
            if (appDelObj.isArabic) {
                [string addAttribute:NSFontAttributeName
                              value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]
                              range:NSMakeRange(0, [string length])];
            }
            [string addAttribute:NSStrikethroughStyleAttributeName value:@2 range:NSMakeRange(0, [string length])];
            
            NSMutableAttributedString *price=[[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%@ %@  ",p2,appDelObj.currencySymbol]];
            [price addAttribute:NSForegroundColorAttributeName  value:appDelObj.redColor                          range:NSMakeRange(0, [price length])];
            [price addAttribute:NSFontAttributeName  value:[UIFont systemFontOfSize:12.0 weight:UIFontWeightMedium]                          range:NSMakeRange(0, [price length])];
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
    cell.FavDEL=self;
    
    cell.btnFav.tag=indexPath.row;
    cell.btnf1.tag=indexPath.row;
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (collectionView==self.colFree) {
        if(appDelObj.isArabic==YES )
        {
            ListDetailViewController *listDetail=[[ListDetailViewController alloc]init];
            listDetail.productID=[[freeProducts objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
            listDetail.productName=[[freeProducts objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
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
            listDetail.productID=[[freeProducts objectAtIndex:indexPath.row ]   valueForKey:@"productID"] ;
            listDetail.productName=[[freeProducts objectAtIndex:indexPath.row ]   valueForKey:@"productTitle"] ;
            [self.navigationController pushViewController:listDetail animated:YES];
        }
    }
    else
    {
        
    }
   
}
- (IBAction)closeFree:(id)sender {
   
    CGRect rect = self.FreeView.frame;
    
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.FreeView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.FreeView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.FreeView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.FreeView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.FreeView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   
                                                                   [self.FreeView removeFromSuperview];
                                                               }];
                                          }];
                     }];
    
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
        [self.navigationController pushViewController:cart animated:NO];
    }
    
    
}
-(void)AddToCartvActionDel:(int)tag
{
    freeProductOption=[[freeProducts objectAtIndex:tag ]   valueForKey:@"encodedCustomOption"];
    
//       // self.colFreeLarge.frame=CGRectMake(self.colFreeLarge.frame.origin.x, self.selfreeCount.frame.origin.y+self.selfreeCount.frame.size.height+3, self.colFreeLarge.frame.size.width, self.colFreeLarge.frame.size.height);
//
//    if (freeProductOption.count==0)
//    {
//        freeProductID=[[freeProducts objectAtIndex:tag ]   valueForKey:@"productID"];
//        fName=[[freeProducts objectAtIndex:tag ]   valueForKey:@"productTitle"];
//        freeImage=[[freeProducts objectAtIndex:tag ]   valueForKey:@"productImage"];
//
//        if (freeProductsAry.count==0)
//        {
//            [freeProductsAry addObject:freeProductID];
//            addtoCart=@"AddCartFreeProduct";
//            self.selfreeCount.text=[NSString stringWithFormat:@"%d gift product(s) Selected",freeProductsAry.count];
//            [self addToCart];
//        }
//        else
//        {
//            if (freeProductsAry.count==freecount)
//            {
//                UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@", [NSString stringWithFormat:@"%d gift product(s) Selected",freecount]] preferredStyle:UIAlertControllerStyleAlert];
//                [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
//                [self presentViewController:alertController animated:YES completion:nil];
//            }
//            else
//            {
//                for (int t=0; t<freeProductsAry.count;t++)
//                {
//                    NSString *str=[freeProductsAry objectAtIndex:t];
//                    if ([str isEqualToString:freeProductID])
//                    {
//                        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[NSString stringWithFormat:@"%@ already added to cart",fName] preferredStyle:UIAlertControllerStyleAlert];
//                        [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
//                        [self presentViewController:alertController animated:YES completion:nil];
//                        break;
//                    }
//                    else
//                    {
//                        [freeProductsAry addObject:freeProductID];
//                        self.selfreeCount.text=[NSString stringWithFormat:@"%d gift product(s) Selected",freeProductsAry.count];
//
//                        addtoCart=@"AddCartFreeProduct";
//                        [self addToCart];
//                        break;
//                    }
//                }
//            }
//        }
//    }
//    else
//    {
        if(appDelObj.isArabic==YES )
        {
            SubstituteViewController *listDetail=[[SubstituteViewController alloc]init];
            listDetail.pid=[DetailListAryData   valueForKey:@"productID"] ;
            listDetail.pname=[DetailListAryData    valueForKey:@"productTitle"] ;
            listDetail.pimg=[DetailListAryData    valueForKey:@"productImage"] ;
            listDetail.pseller=[DetailListAryData    valueForKey:@"businessName"] ;
            listDetail.freecount=[NSString stringWithFormat:@"%@",[DetailListAryData    valueForKey:@"freeProductsCount"] ];
            listDetail.dedCount=[NSString stringWithFormat:@"%@",[DetailListAryData    valueForKey:@"totAddedFreeGifts"] ];
            listDetail.PRODUCTID=[DetailListAryData   valueForKey:@"productID"] ;

            listDetail.imgUrl=imgUrl;
            listDetail.arrayFree=freeProducts;
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
            listDetail.pid=[DetailListAryData   valueForKey:@"productID"] ;
            listDetail.pname=[DetailListAryData    valueForKey:@"productTitle"] ;
            listDetail.pimg=[DetailListAryData    valueForKey:@"productImage"] ;
            listDetail.pseller=[DetailListAryData    valueForKey:@"businessName"] ;
            listDetail.freecount=[NSString stringWithFormat:@"%@",[DetailListAryData    valueForKey:@"freeProductsCount"] ];
            listDetail.dedCount=[NSString stringWithFormat:@"%@",[DetailListAryData    valueForKey:@"totAddedFreeGifts"] ];
            listDetail.PRODUCTID=[DetailListAryData   valueForKey:@"productID"] ;

            listDetail.imgUrl=imgUrl;
            listDetail.arrayFree=freeProducts;
            [self.navigationController pushViewController:listDetail animated:YES];
        }
//    }
    
    
    
   
    
}
-(void)addToCart
{
    NSString *combinationHash=@"";
    NSString *optionHash=@"";
    NSString *selectAllCustomOption=@"Yes";
    NSString *comPriceString=@"";
    NSString *strCombinationValues=@"";
    if (customOption.count==0)
    {
        selectAllCustomOption=@"Yes";
    }
    else
    {
        for (int i=0; i<customOption.count; i++)
        {
            NSString *st=[[customOption objectAtIndex:i]valueForKey:@"validateRule"] ;
            NSArray *a=[st componentsSeparatedByString:@"~"];
            
            if ([[a objectAtIndex:0]isEqualToString:@"required"]||[[a objectAtIndex:0]isEqualToString:@"Required"])
            {
                if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
                {
                    NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:1]valueForKey:@"inputType"],multiSelVarientAry);
                    if (multiSelVarientAry.count==0)
                    {
                        selectAllCustomOption=@"No";
                    }
                    else
                    {
                        //selectAllCustomOption=@"Yes";
                    }
                }
                else
                {
                    
                    NSIndexPath *path = [NSIndexPath indexPathForRow:0 inSection:i];
                    CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:path];
                    
                    if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"file"])
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtDay.text);
                        NSString *str=cell.txtDay.text;
                        NSLog(@"Select************* val=%@  ",str);
                        
                        if (cell.txtDay.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                    }
                    else if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"datetime"])
                    {
                        NSLog(@"Select val=%@ label=%@ label=%@",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtDay.text,cell.txtHour.text);
                        
                        if (cell.txtHour.text.length==0||cell.txtDay.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                        
                        
                    }
                    else if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"time"])
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtHour.text);
                        
                        if (cell.txtHour.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                        
                    }
                    else if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"date"])
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtDay.text);
                        
                        if (cell.txtDay.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                        
                    }
                    else if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"textbox"])
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtDay.text);
                        
                        if (cell.txtDay.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                    }
                    else if ([[[customOption objectAtIndex:path.section]valueForKey:@"inputType"]isEqualToString:@"textarea"])
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.text.text);
                        
                        if (cell.text.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                    }
                    
                    else
                    {
                        NSLog(@"Select val=%@ label=%@ ",[[customOption objectAtIndex:path.section]valueForKey:@"inputType"],cell.txtDay.text);
                        
                        if (cell.txtDay.text.length==0)
                        {
                            selectAllCustomOption=@"No";
                        }
                    }
                    
                    
                    
                }
                
            }
        }
    }
    if ([selectAllCustomOption isEqualToString:@"Yes"])
    {
        if (encodedCombinations.count!=0)
        {
            strCombinationValues=@"";
            int flagAdd=0,selComIndex = 0;
            NSString *errorMSg=@"";
            NSLog(@"Sel  %@ \n  All   %@",includeCombinationArray,encodedCombinations);
            if(includeCombinationArray.count==0)
            {
                combinationHash=[[encodedCombinations objectAtIndex:0]valueForKey:@"combinationHash"];
                optionHash=[[encodedCombinations objectAtIndex:0]valueForKey:@"combination"];
                CombPrice=[[encodedCombinations objectAtIndex:0]valueForKey:@"combinationPrice"];
                combPriceDiff=[[encodedCombinations objectAtIndex:0]valueForKey:@"combinationPriceDiffType"];
                comSKU=[[encodedCombinations objectAtIndex:0]valueForKey:@"combinationSKU"];
                
                comPriceString=[NSString stringWithFormat:@"->combinationSKU~*%@->combinationPrice~*%@->combinationPriceDiffType~*%@",comSKU,CombPrice,combPriceDiff];
            }
            else
            {
                combinationHash=@"";
                optionHash=@"";
                NSString *creatComp=[NSString stringWithFormat:@"%@",self.productID];
                //NSString *selectedHashCreation;
                for (int i=0; i<includeCombinationArray.count; i++)
                {
                    creatComp=[NSString stringWithFormat:@"%@_%@",creatComp,[includeCombinationArray objectAtIndex:i]];
                }
                
                for (int j=0; j<encodedCombinations.count; j++)
                {
                    NSString *exisComp=[[encodedCombinations objectAtIndex:j]valueForKey:@"combination"];
                    if ([exisComp isEqualToString:creatComp])
                    {
                        NSString *qtYsel=self.lblQtySelected.text;
                        NSString *combYsel=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combinationQty"]];
                        int a=[qtYsel intValue];
                        int b=[combYsel intValue];
                        if (b==0||a>b)
                        {
                            errorMSg=@"THIS PRODUCT IS NO LONGER IN STOCK WITH THOSE ATTRIBUTES";
                            flagAdd=1;
                            selComIndex=j;
                        }
                        else
                        {
                            flagAdd=0;
                            selComIndex=j;
                            
                            combinationHash=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combinationHash"]];
                            optionHash=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combination"]];
                            CombPrice=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combinationPrice"]];
                            combPriceDiff=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combinationPriceDiffType"]];
                            comSKU=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:j]valueForKey:@"combinationSKU"]];
                            
                            comPriceString=[NSString stringWithFormat:@"->combinationSKU~*%@->combinationPrice~*%@->combinationPriceDiffType~*%@",comSKU,CombPrice,combPriceDiff];
                        }
                        
                        break;
                        
                    }
                    else
                    {
                        if (combinationHash.length==0)
                        {
                            NSArray *firstArr=[exisComp componentsSeparatedByString:@"_"];
                            NSArray *secondArr=[creatComp componentsSeparatedByString:@"_"];
                            
                            //                            BOOL arraysContainTheSameObjects = YES;
                            //                            NSEnumerator *otherEnum = [secondArr objectEnumerator];
                            //                            for (NSString *myObject in firstArr) {
                            //                                if (myObject != [otherEnum nextObject]) {
                            //                                    //We have found a pair of two different objects.
                            //                                    arraysContainTheSameObjects = NO;
                            //                                    break;
                            //                                }
                            //                            }
                            
                            if (firstArr.count==secondArr.count)
                            {
                                
                                for (int k=1; k<firstArr.count; k++)
                                {
                                    NSString *valFirst=[firstArr objectAtIndex:k];
                                    for (int l=1; l<secondArr.count; l++)
                                    {
                                        if ([valFirst isEqualToString:[secondArr objectAtIndex:l]])
                                        {
                                            flagAdd=0;
                                        }
                                        else
                                        {
                                            flagAdd=1;
                                            
                                        }
                                    }
                                    if (flagAdd==1)
                                    {
                                        errorMSg=@"THIS COMBINATION DOES NOT EXIST FOR THIS PRODUCT";
                                        break;
                                    }
                                }
                                
                            }
                            else
                            {
                                flagAdd=1;
                                errorMSg=@"THIS COMBINATION DOES NOT EXIST FOR THIS PRODUCT";
                                //break;
                            }
                        }
                        
                    }
                    
                    
                }
                if (flagAdd==1)
                {
                    NSString *str=@"Please enter a valid phone number";
                    NSString *ok=@"Ok";
                    if (appDelObj.isArabic) {
                        str=@"يرجى إدخال رقم هاتف صالح";
                        ok=@" موافق ";
                    }
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:errorMSg preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    
                    NSString *qtYsel=self.lblQtySelected.text;
                    NSString *combYsel=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combinationQty"]];
                    int a=[qtYsel intValue];
                    int b=[combYsel intValue];
                    if (b==0||a>b)
                    {
                        errorMSg=@"THIS PRODUCT IS NO LONGER IN STOCK WITH THOSE ATTRIBUTES";
                      
                        if (appDelObj.isArabic) {
                          
                             errorMSg=@"هذا المنتج لم يعد في الأوراق المالية مع تلك السمات";
                        }
                        flagAdd=1;
                        
                    }
                    else
                    {
                        
                        
                        combinationHash=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combinationHash"]];
                        optionHash=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combination"]];
                        CombPrice=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combinationPrice"]];
                        combPriceDiff=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combinationPriceDiffType"]];
                        comSKU=[NSString stringWithFormat:@"%@",[[encodedCombinations objectAtIndex:selComIndex]valueForKey:@"combinationSKU"]];
                        
                        comPriceString=[NSString stringWithFormat:@"->combinationSKU~*%@->combinationPrice~*%@->combinationPriceDiffType~*%@",comSKU,CombPrice,combPriceDiff];
                        
                    }
                    
                }
                
                if (flagAdd==1)
                {
                  
                    NSString *ok=@"Ok";
                    if (appDelObj.isArabic) {
                       
                        ok=@" موافق ";
                        
                    }
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:errorMSg preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
                else
                {
                    NSString *gotoAddCart=@"";
                    NSString *Sub;
                    if ([[DetailListAryData valueForKey:@"subscribeSave"]isEqualToString:@"Yes"]||[[DetailListAryData valueForKey:@"subscribeSave"]isEqualToString:@"YES"]||[[DetailListAryData valueForKey:@"subscribeSave"]isEqualToString:@"yes"])
                    {
                        if([selSubscriptionname isEqualToString:@"subscribe"])
                        {
                            if (subID.length==0||selSubOptID.length==0||deliveriesvalue.length==0)
                            {
                                gotoAddCart=@"No";
                                
                            }
                            else{
                                Sub=[NSString stringWithFormat:@"%@-%@-%@",subID,selSubOptID,deliveriesvalue];
                                subscribe=@"subscribe";
                                gotoAddCart=@"Yes";
                            }
                        }
                        else
                        {
                            Sub=@"";
                            subscribe=@"";
                            gotoAddCart=@"Yes";
                        }
                        
                    }
                    else
                    {
                        gotoAddCart=@"Yes";
                        Sub=@"";
                        subscribe=@"";
                        
                    }
                    if ([gotoAddCart isEqualToString:@"Yes"])
                    {
                        NSString *customString=@"!";
                        for (int i=0; i<customOption.count; i++)
                        {
                            NSString *st=[[customOption objectAtIndex:i]valueForKey:@"validateRule"] ;
                            NSArray *a=[st componentsSeparatedByString:@"~"];
                            
                            //                    if ([[a objectAtIndex:0]isEqualToString:@"required"]||[[a objectAtIndex:0]isEqualToString:@"Required"])
                            //                    {
                            NSLog(@"%@",[customOption objectAtIndex:i]);
                            NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                            CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                            if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"file"])
                            {
                                customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",fileName,fileName,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"datetime"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                                [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                                NSString *dateString;
                                dateString = [NSString stringWithFormat:@"%@ %@",cell.txtDay.text,cell.txtHour.text];
                                if (cell.txtDay.text.length==0&&cell.txtHour.text.length==0) {
                                    
                                }
                                else
                                {
                                    //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"time"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                                [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                                NSString *dateString;
                                dateString = [NSString stringWithFormat:@"%@",cell.txtHour.text];
                                //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                                if (cell.txtHour.text.length==0) {
                                    
                                }
                                else
                                {
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"date"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                NSDateFormatter *df = [[NSDateFormatter alloc] init];
                                [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                                NSString *dateString;
                                dateString = [NSString stringWithFormat:@"%@",cell.txtHour.text];
                                //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                                if (cell.txtHour.text.length==0) {
                                    
                                }
                                else
                                {
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"textbox"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                if (cell.txtDay.text.length==0) {
                                    
                                }
                                else
                                {
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",cell.txtDay.text,cell.txtDay.text,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"textarea"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                if (cell.txtDay.text.length==0) {
                                    
                                }
                                else
                                {
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",cell.txtDay.text,cell.txtDay.text,[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
                            {
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                if (multiSelVarientAry.count==0)
                                {
                                    customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",@"",@"",[[customOption objectAtIndex:i] valueForKey:@"priceDiff"],[[customOption objectAtIndex:i] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                                else
                                {
                                    NSArray *a=[[customOption objectAtIndex:i]valueForKey:@"variants"];
                                    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.customOptionID contains[cd] %@",[[customOption objectAtIndex:i]valueForKey:@"customOptionID"]];
                                    NSArray * listArr = [multiSelVarientAry filteredArrayUsingPredicate:bPredicate];
                                    // NSString *s=[[multiSelVarientAry objectAtIndex:0]valueForKey:@"value"];
                                    for (int t=0; t<listArr.count; t++)
                                    {
                                        customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[listArr objectAtIndex:t]valueForKey:@"customOptionVariantID"],[[listArr objectAtIndex:t]valueForKey:@"value"],[[listArr objectAtIndex:t]valueForKey:@"value"],[[listArr objectAtIndex:t]valueForKey:@"priceDiff"],[[listArr objectAtIndex:t]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                        
                                        //                                        s=[NSString stringWithFormat:@"%@,%@",s,[[multiSelVarientAry objectAtIndex:t]valueForKey:@"value"]];
                                    }
                                    //customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[listArr objectAtIndex:0] valueForKey:@"customOptionVariantID"],s,s,[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                }
                            }
                            else
                            {
                                
                                NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                                CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                                if (cell.txtDay.text.length==0) {
                                    
                                }
                                else
                                {
                                    NSArray *a=[[customOption objectAtIndex:i]valueForKey:@"variants"];
                                    NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.value contains[cd] %@",cell.txtDay.text];
                                    NSArray * listArr = [a filteredArrayUsingPredicate:bPredicate];
                                    if (listArr.count!=0)
                                    {
                                        if ([[[customOption objectAtIndex:i]valueForKey:@"include_in_combination"] isEqualToString:@"Yes"])
                                        {
                                            strCombinationValues=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:inputType~*%@",strCombinationValues,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[listArr objectAtIndex:0] valueForKey:@"customOptionVariantID"],[[listArr objectAtIndex:0] valueForKey:@"value"],cell.txtDay.text,[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                            
                                            
                                        }
                                        else
                                        {
                                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[listArr objectAtIndex:0] valueForKey:@"customOptionVariantID"],[[listArr objectAtIndex:0] valueForKey:@"value"],cell.txtDay.text,[[listArr objectAtIndex:0] valueForKey:@"priceDiff"],[[listArr objectAtIndex:0] valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                        }
                                    }
                                    
                                }
                                
                                
                            }
                        }
                        customString=[NSString stringWithFormat:@"%@-> ",customString];
                        
                        NSString *finalCustomString=[customString stringByReplacingOccurrencesOfString:@"!" withString:@""];
                        if ([finalCustomString isEqualToString:@"->"]||[finalCustomString isEqualToString:@"->"]||[finalCustomString isEqualToString:@"!"]||finalCustomString.length==0) {
                            finalCustomString=@"";
                        }
                        if ([strCombinationValues isEqualToString:@"->"]||[strCombinationValues isEqualToString:@"->"]||[strCombinationValues isEqualToString:@"!"]||strCombinationValues.length==0) {
                            strCombinationValues=@"";
                        }
                        else
                        {
                            strCombinationValues=[NSString stringWithFormat:@"%@%@",comPriceString,strCombinationValues];
                        }
                        loginorNot=@"login";
                       
                        if ([subscribeORnot isEqualToString:@"Yes"])
                        {
                            addtoCart=@"";
                        }
                        else
                        {
                            addtoCart=@"AddCart";
                            
                        }
                        NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                        NSString *OPTID=productOptionID;
                        if ([chooseOption isEqualToString:@"yes"])
                        {
                            OPTID=productOptionID;
                        }
                        else
                        {
                            OPTID=[DetailListAryData valueForKey:@"productOptionID"];
                        }
                        
                        if (appDelObj.isArabic)
                        {
                            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                        }
                        else
                        {
                            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                        }
                        if (userID.length==0)
                        {
                            userID=@"0";
                        }
                        NSString *urlStr;
                        NSMutableDictionary *dicPost;
                        NSString *currency=[DetailListAryData valueForKey:@"productDefaultCurrency"];
                        NSString *image=[DetailListAryData valueForKey:@"productImage"];
                        NSString *titileProduct=[DetailListAryData valueForKey:@"productTitle"];
                        NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
                        if (CAID.length==0||[CAID isEqualToString:@""])
                        {
                            CAID=@"";
                            urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
                            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",[DetailListAryData valueForKey:@"productID"],@"productID",productOptionID,@"productOptionID",self.lblQtySelected.text,@"quantity",[DetailListAryData valueForKey:@"productTitle"],@"productOptionName",[DetailListAryData valueForKey:@"productTitle"],@"productTitle",[DetailListAryData valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",@"",@"cartID",[DetailListAryData valueForKey:@"productImage"],@"productImage",optionHash,@"optionsHash",combinationHash,@"combinationHash",strCombinationValues,@"strcombinationValues",Sub,@"subAttr",selSubscriptionname,@"purchase",finalCustomString,@"customOptionValues",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
                            
                        }
                        else
                        {
                            urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
                            dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",CAID,@"cartID",[DetailListAryData valueForKey:@"productID"],@"productID",productOptionID,@"productOptionID",self.lblQtySelected.text,@"quantity",[DetailListAryData valueForKey:@"productTitle"],@"productOptionName",[DetailListAryData valueForKey:@"productTitle"],@"productTitle",[DetailListAryData valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",[DetailListAryData valueForKey:@"productImage"],@"productImage",optionHash,@"optionsHash",combinationHash,@"combinationHash",strCombinationValues,@"strcombinationValues",Sub,@"subAttr",selSubscriptionname,@"purchase",finalCustomString,@"customOptionValues",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
                        }
                        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                        
                    }
                    else
                    {
                        if (subID.length==0&&selSubOptID.length==0&&deliveriesvalue.length==0)
                        {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select a frequency and corresponding delivery!." preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                            [self presentViewController:alertController animated:YES completion:nil];
                            
                        }
                        else if (subID.length==0)
                        {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select subscription!." preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                            [self presentViewController:alertController animated:YES completion:nil];
                            
                        }
                        else if (selSubOptID.length==0)
                        {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select a delivery!." preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                            [self presentViewController:alertController animated:YES completion:nil];
                            
                        }
                        else
                        {
                            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select frequency!." preferredStyle:UIAlertControllerStyleAlert];
                            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                            [self presentViewController:alertController animated:YES completion:nil];
                        }
                    }
                    
                    
                    
                    
                    
                    
                }
            }
            
        }
        else
        {
            combinationHash=@"";
            NSString *Sub;
            NSString *gotoAddCart=@"";
            
            if ([[DetailListAryData valueForKey:@"subscribeSave"]isEqualToString:@"Yes"]||[[DetailListAryData valueForKey:@"subscribeSave"]isEqualToString:@"YES"]||[[DetailListAryData valueForKey:@"subscribeSave"]isEqualToString:@"yes"])
            {
                if([selSubscriptionname isEqualToString:@"subscribe"])
                {
                    if (subID.length==0||selSubOptID.length==0||deliveriesvalue.length==0)
                    {
                        gotoAddCart=@"No";
                        
                    }
                    else{
                        Sub=[NSString stringWithFormat:@"%@-%@-%@",subID,selSubOptID,deliveriesvalue];
                        subscribe=@"subscribe";
                        gotoAddCart=@"Yes";
                    }
                }
                else
                {
                    Sub=@"";
                    subscribe=@"";
                    gotoAddCart=@"Yes";
                }
                
            }
            else
            {
                gotoAddCart=@"Yes";
                Sub=@"";
                subscribe=@"";
                
            }
            if ([gotoAddCart isEqualToString:@"Yes"])
            {
                NSString *customString=@"!";
                for (int i=0; i<customOption.count; i++)
                {
                    NSString *st=[[customOption objectAtIndex:i]valueForKey:@"validateRule"] ;
                    NSArray *a=[st componentsSeparatedByString:@"~"];
                    
                    //                    if ([[a objectAtIndex:0]isEqualToString:@"required"]||[[a objectAtIndex:0]isEqualToString:@"Required"])
                    //                    {
                    
                    NSLog(@"%@",[customOption objectAtIndex:i]);
                    NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                    CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                    if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"file"])
                    {
                        customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",fileName,fileName,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"datetime"])
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                        NSString *dateString;
                        dateString = [NSString stringWithFormat:@"%@ %@",cell.txtDay.text,cell.txtHour.text];
                        if (cell.txtDay.text.length==0&&cell.txtHour.text.length==0) {
                            
                        }
                        else
                        {
                            //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"time"])
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                        NSString *dateString;
                        dateString = [NSString stringWithFormat:@"%@",cell.txtHour.text];
                        //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                        if (cell.txtHour.text.length==0) {
                            
                        }
                        else
                        {
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"date"])
                    {
                        
                        //NSString *str=[NSString stringWithFormat:@"%@",dateString];
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        NSDateFormatter *df = [[NSDateFormatter alloc] init];
                        [df setDateFormat:@"dd/MM/YYYY hh:mm"];
                        NSString *dateString;
                        dateString = [NSString stringWithFormat:@"%@",cell.txtDay.text];
                        if (cell.txtDay.text.length==0) {
                            
                        }
                        else
                        {
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",dateString,dateString,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"textbox"])
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        if (cell.txtDay.text.length==0) {
                            
                        }
                        else
                        {
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",cell.txtDay.text,cell.txtDay.text,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"textarea"])
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        if (cell.txtDay.text.length==0) {
                            
                        }
                        else
                        {
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",cell.txtDay.text,cell.txtDay.text,[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                    }
                    else if ([[[customOption objectAtIndex:i]valueForKey:@"inputType"]isEqualToString:@"multiselect"])
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        if (multiSelVarientAry.count==0)
                        {
                            customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],@"0",@"",@"",[[customOption objectAtIndex:i]valueForKey:@"priceDiff"],[[customOption objectAtIndex:i]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                        }
                        else
                        {
                            NSArray *a=[[customOption objectAtIndex:i]valueForKey:@"variants"];
                            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.value contains[cd] %@",cell.txtDay.text];
                            NSArray * listArr = [a filteredArrayUsingPredicate:bPredicate];
                            NSString *s=[NSString stringWithFormat:@"%@",[[multiSelVarientAry objectAtIndex:0]valueForKey:@"value"]];
                            
                            for (int t=0; t<multiSelVarientAry.count; t++)
                            {
                                customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[multiSelVarientAry objectAtIndex:t]valueForKey:@"customOptionVariantID"],[[multiSelVarientAry objectAtIndex:t]valueForKey:@"value"],[[multiSelVarientAry objectAtIndex:t]valueForKey:@"value"],[[multiSelVarientAry objectAtIndex:t]valueForKey:@"priceDiff"],[[multiSelVarientAry objectAtIndex:t]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                                
                                s=[NSString stringWithFormat:@"%@,%@",s,[[multiSelVarientAry objectAtIndex:t]valueForKey:@"value"]];
                            }
                        }
                    }
                    else
                    {
                        NSIndexPath *ip = [NSIndexPath indexPathForRow:0 inSection:i];
                        CusOptCell*cell = [self.tblCustomoptions cellForRowAtIndexPath:ip];
                        if (cell.txtDay.text.length==0) {
                            
                        }
                        else
                        {
                            NSArray *a=[[customOption objectAtIndex:i]valueForKey:@"variants"];
                            NSPredicate *bPredicate = [NSPredicate predicateWithFormat:@"SELF.value contains[cd] %@",cell.txtDay.text];
                            NSArray * listArr = [a filteredArrayUsingPredicate:bPredicate];
                            if (listArr.count!=0)
                            {
                                customString=[NSString stringWithFormat:@"%@->customOptionID~*%@~:customOptionName~*%@~:customOptionVariantID~*%@~:variantValueText~*%@~:variantValue~*%@~:priceDiff~*%@~:priceDiffType~*%@~:inputType~*%@",customString,[[customOption objectAtIndex:i]valueForKey:@"customOptionID"],[[customOption objectAtIndex:i]valueForKey:@"customOptionName"],[[listArr objectAtIndex:0] valueForKey:@"customOptionVariantID"],[[listArr objectAtIndex:0] valueForKey:@"value"],cell.txtDay.text,[[listArr objectAtIndex:0]valueForKey:@"priceDiff"],[[listArr objectAtIndex:0]valueForKey:@"priceDiffType"],[[customOption objectAtIndex:i]valueForKey:@"inputType"]];
                            }
                        }
                        
                    }
                }
                customString=[NSString stringWithFormat:@"%@-> ",customString];
                NSString *finalCustomString=[customString stringByReplacingOccurrencesOfString:@"!" withString:@""];
                loginorNot=@"login";
              
                if ([subscribeORnot isEqualToString:@"Yes"])
                {
                    addtoCart=@"";
                }
                else
                {
                    addtoCart=@"AddCart";
                    
                }
                NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
                NSString *OPTID;
                if ([chooseOption isEqualToString:@"yes"])
                {
                    OPTID=productOptionID;
                }
                else
                {
                    OPTID=[DetailListAryData valueForKey:@"productOptionID"];
                }
                
                if (appDelObj.isArabic)
                {
                    [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                else
                {
                    [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                }
                if (userID.length==0)
                {
                    userID=@"0";
                }
                NSString *urlStr;
                NSMutableDictionary *dicPost;
                NSString *currency=[DetailListAryData valueForKey:@"productDefaultCurrency"];
                NSString *image=[DetailListAryData valueForKey:@"productImage"];
                NSString *titileProduct=[DetailListAryData valueForKey:@"productTitle"];
                NSString *CAID= [[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
                if (CAID.length==0||[CAID isEqualToString:@""])
                {
                    CAID=@"";
                    urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
                    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",[DetailListAryData valueForKey:@"productID"],@"productID",productOptionID,@"productOptionID",self.lblQtySelected.text,@"quantity",[DetailListAryData valueForKey:@"productTitle"],@"productOptionName",[DetailListAryData valueForKey:@"productTitle"],@"productTitle",[DetailListAryData valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",@"",@"cartID",[DetailListAryData valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",strCombinationValues,@"strcombinationValues",Sub,@"subAttr",selSubscriptionname,@"purchase",finalCustomString,@"customOptionValues",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
                    
                }
                else
                {
                    urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/addItem/languageID/",appDelObj.languageId];
                    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",CAID,@"cartID",[DetailListAryData valueForKey:@"productID"],@"productID",productOptionID,@"productOptionID",self.lblQtySelected.text,@"quantity",[DetailListAryData valueForKey:@"productTitle"],@"productOptionName",[DetailListAryData valueForKey:@"productTitle"],@"productTitle",[DetailListAryData valueForKey:@"productDefaultCurrency"],@"productDefaultCurrency",[DetailListAryData valueForKey:@"productImage"],@"productImage",@"",@"optionsHash",@"",@"combinationHash",strCombinationValues,@"strcombinationValues",Sub,@"subAttr",selSubscriptionname,@"purchase",finalCustomString,@"customOptionValues",@"iPhone",@"deviceType",appDelObj.devicetocken,@"deviceID", nil];
                }
                [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                
            }
            else
            {
                if (subID.length==0&&selSubOptID.length==0&&deliveriesvalue.length==0)
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select a frequency and corresponding delivery!." preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                else if (subID.length==0)
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select subscription!." preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                else if (selSubOptID.length==0)
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select a delivery!." preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                    
                }
                else
                {
                    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"Please select frequency!." preferredStyle:UIAlertControllerStyleAlert];
                    [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
                    [self presentViewController:alertController animated:YES completion:nil];
                }
            }
            
            
        }
    }
    else
    {
        NSString *str=@"Please select all madatory fields!.";
        NSString *ok=@"Ok";
        if (appDelObj.isArabic) {
            str=@"يرجى تحديد جميع الحقول المجنونة!";
            ok=@" موافق ";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:ok style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    
    
    
    
}
- (IBAction)favMerchantAction:(id)sender {
    fav=@"Merchant";
    NSString *userID=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (userID.length==0)
    {
        userID=@"0";
    }
    
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
    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:userID,@"userID",@"",@"action",@"",@"", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    
}

- (IBAction)allStoreAction:(id)sender {
    rmvWish=1;
    appDelObj.frommenu=appDelObj.fromSide=@"det";
    NSLog(@"%@",[DetailListAryData valueForKey:@"businessID"]);
    if(appDelObj.isArabic==YES )
    {
        ListViewController *listDetail=[[ListViewController alloc]init];
        listDetail.businessName=[DetailListAryData valueForKey:@"businessName"] ;
        listDetail.businessID=[DetailListAryData valueForKey:@"businessID"] ;
        listDetail.favOrNotMer=[NSString stringWithFormat:@"%@",[DetailListAryData valueForKey:@"userBusinesssFollowed"]] ;
        listDetail.isFollowMerchant=[NSString stringWithFormat:@"%@",[DetailListAryData valueForKey:@"settingsEnableFollowBusiness"]] ;

        listDetail.Brate=[DetailListAryData valueForKey:@"busAvgRating"] ;
        listDetail.review=[[DetailListAryData valueForKey:@"listBusinessRating"] valueForKey:@"ratingCount"] ;
        appDelObj.mainBusiness=[NSString stringWithFormat:@"%@",[DetailListAryData valueForKey:@"businessID"]];
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
        ListViewController *listDetail=[[ListViewController alloc]init];
        listDetail.businessName=[DetailListAryData valueForKey:@"businessName"] ;
        listDetail.businessID=[DetailListAryData valueForKey:@"businessID"] ;
        listDetail.favOrNotMer=[NSString stringWithFormat:@"%@",[DetailListAryData valueForKey:@"userBusinesssFollowed"]] ;
        listDetail.isFollowMerchant=[NSString stringWithFormat:@"%@",[DetailListAryData valueForKey:@"settingsEnableFollowBusiness"]] ;

        listDetail.Brate=[DetailListAryData valueForKey:@"busAvgRating"] ;
        listDetail.review=[[DetailListAryData valueForKey:@"listBusinessRating"] valueForKey:@"ratingCount"] ;
        appDelObj.mainBusiness=[NSString stringWithFormat:@"%@",[DetailListAryData valueForKey:@"businessID"]];

        [self.navigationController pushViewController:listDetail animated:YES];
    }
}
- (IBAction)viewReviewListAction:(id)sender {
    self.scrollViewObj.contentOffset=CGPointMake(0, self.tblReview.frame.origin.y);
}
- (IBAction)askMerchantAction:(id)sender {
    
    NSString *User=[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"];
    if (User.length==0)
    {
        if(appDelObj.isArabic==YES )
        {
            ArabicLoginViewController *listDetail=[[ArabicLoginViewController alloc]init];
            listDetail.fromWhere=@"Message";
            appDelObj.fromWhere=@"Message";
            listDetail.MsgPID=self.productID;
            listDetail.MsgPname=self.productName;
            listDetail.MsgMerchant=self.lblBusinessName1.text;
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
            LoginViewController *listDetail=[[LoginViewController alloc]init];
             listDetail.fromWhere=@"Message";
              appDelObj.fromWhere=@"Message";
            listDetail.MsgPID=self.productID;
            listDetail.MsgPname=self.productName;
            listDetail.MsgMerchant=self.lblBusinessName1.text;
            [self.navigationController pushViewController:listDetail animated:YES];
        }
    }
    else
    {
//        if(appDelObj.isArabic==YES )
//        {
            MessageViewController *listDetail=[[MessageViewController alloc]init];
            listDetail.pID=self.productID;
            listDetail.Pname=[DetailListAryData valueForKey:@"productTitle"];
            listDetail.mname=self.lblBusinessName1.text;
        self.modalPresentationStyle = UIModalPresentationCurrentContext;

        [self presentViewController:listDetail animated:YES completion:nil];

//            transition = [CATransition animation];
//            [transition setDuration:0.3];
//            transition.type = kCATransitionPush;
//            transition.subtype = kCATransitionFromLeft;
//            [transition setFillMode:kCAFillModeBoth];
//            [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
//            [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
//            [self.navigationController pushViewController:listDetail animated:NO];
//        }
//        else
//        {
//            MessageViewController *listDetail=[[MessageViewController alloc]init];
//            listDetail.pID=self.productID;
//            listDetail.Pname=self.productName;
//            listDetail.mname=self.lblBusinessName1.text;
//            [self.navigationController pushViewController:listDetail animated:YES];
//        }
    }
}

@end
