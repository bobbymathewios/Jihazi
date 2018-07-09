//
//  OrderSummery.m
//  MedMart
//
//  Created by Remya Das on 05/12/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "OrderSummery.h"
#define ACCEPTABLE_CHARACTERS @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"

@interface OrderSummery ()<passDataAfterParsing,EditProtocol>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    int show,tag;
    NSString *fileName,*Delete,*selectedAddressID;
    UIImage *imagePro;
    NSMutableArray *imagePrescriptionAry;
    NSArray *addressArray;
    NSMutableIndexSet *indexSel;
}

@end

@implementation OrderSummery

- (void)viewDidLoad {
    [super viewDidLoad];
    Delete=@"";
    tag=0;
    selectedAddressID=@"";
    // Do any additional setup after loading the view from its nib.
    self.navigationController.navigationBarHidden=YES;
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
   // self.view.backgroundColor=appDelObj.menubgtable;
    self.topView.backgroundColor=appDelObj.headderColor;
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    show=0;
    imagePrescriptionAry=[[NSMutableArray alloc]init];
    indexSel=[[NSMutableIndexSet alloc]init];
    //self.scroll.contentSize=CGSizeMake(0, self.prescriptionGuideView.frame.origin.y+self.prescriptionGuideView.frame.size.height);
        self.btbAddNew.clipsToBounds=YES;
        self.btbAddNew.layer.cornerRadius=3;
        [[self.btbAddNew layer] setBorderWidth:1.0f];
        [[self.btbAddNew layer] setBorderColor:[appDelObj.BlueColor CGColor]];
    if(appDelObj.isArabic==YES)
    {
        self.imgAra.alpha=1;
        self.btnAra.alpha=1;
        self.imgEng.alpha=0;
        self.btnEng.alpha=0;
       
    }
    else
    {
        self.imgAra.alpha=0;
        self.btnAra.alpha=0;
        self.imgEng.alpha=1;
        self.btnEng.alpha=1;
       
    }
    [_comPrescription registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    
    
}
-(void)viewWillAppear:(BOOL)animated
{
    [self getDataFromService];
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    // Prevent crashing undo bug – see note below.
    if (textField==self.txtCoupon)
    {
        
        NSCharacterSet *cs = [[NSCharacterSet characterSetWithCharactersInString:ACCEPTABLE_CHARACTERS] invertedSet];
        
        NSString *filtered = [[string componentsSeparatedByCharactersInSet:cs] componentsJoinedByString:@""];
        
        
            return [string isEqualToString:filtered];
            
       
        
    }
    return YES;
}
-(void)getDataFromService
{
    if (appDelObj.isArabic) {
        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }
    else
    {
        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
    }    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/address/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[NSString stringWithFormat:@"%@", self.p_order_id],@"pr_order_id",@"list",@"action", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
}
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
        if ([Delete isEqualToString:@"Delete"])
        {
            
            Delete=@"";
            NSString *strMsg,*okMsg;
            if (appDelObj.isArabic)
            {
                strMsg=@"تمت إزالة العنوان بنجاح";
                okMsg=@" موافق ";
                
            }
            else
            {
                strMsg=@"Address successfully removed";
                okMsg=@"Ok";
                
            }
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];            [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)                                        {
                [self getDataFromService];                                                                                    }]];
            [self presentViewController:alertController animated:YES completion:nil];
            
        }
        else if ([Delete isEqualToString:@"Update"])
        {
            [Loading dismiss];
        }
        else if ([Delete isEqualToString:@"Apply"])
        {
            UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
            [self presentViewController:alertController animated:YES completion:nil];
            [Loading dismiss];
        }
        else if ([Delete isEqualToString:@"PlaceOrder"])
        {
            ThankYouViewController *thank=[[ThankYouViewController alloc]init];
            thank.frompre=@"yes";
                thank.strResponse=@"Your order has been placed and is being processed. When items are shipped, you will receive an email with the details. You can track this order through . My order Page.";
            if (appDelObj.isArabic) {
                thank.strResponse=@"لقد تم اكمال طلبك بنجاح،سوف تتلقى رسالة تأكيد الطلب بالبريد الإلكتروني مع تفاصيل طلبك .";
            }
                [self.navigationController pushViewController:thank animated:YES];
            [Loading dismiss];
        }
        else
        {
            addressArray=[[dictionary objectForKey:@"result"]objectForKey:@"shippingAddress"];
            if (addressArray.count==0) {
                self.lblNo.alpha=1;
            }
            else{
                self.lblNo.alpha=0;
            }
            self.tblAddress.frame=CGRectMake(self.tblAddress.frame.origin.x, self.tblAddress.frame.origin.y, self.tblAddress.frame.size.width, (164*addressArray.count)+60);
            self.adH.constant = self.tblAddress.frame.size.height;
            [self.tblAddress needsUpdateConstraints];
            self.lblAttachPres.frame=CGRectMake(self.lblAttachPres.frame.origin.x, self.tblAddress.frame.origin.y+self.tblAddress.frame.size.height+00, self.lblAttachPres.frame.size.width, self.lblAttachPres.frame.size.height);
            self.lblatt.frame=CGRectMake(self.lblatt.frame.origin.x, self.lblAttachPres.frame.origin.y+self.lblAttachPres.frame.size.height+10, self.lblatt.frame.size.width, self.lblatt.frame.size.height);
            self.btnAttach.frame=CGRectMake(self.btnAttach.frame.origin.x, self.lblAttachPres.frame.origin.y+self.lblAttachPres.frame.size.height+10, self.btnAttach.frame.size.width, self.btnAttach.frame.size.height);
            self.imArr.frame=CGRectMake(self.btnAttach.frame.size.width-self.imArr.frame.size.width-5, self.lblAttachPres.frame.origin.y+self.lblAttachPres.frame.size.height+10, self.imArr.frame.size.width, self.imArr.frame.size.height);
            self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.btnAttach.frame.origin.y+self.btnAttach.frame.size.height+10, self.comPrescription.frame.size.width, 0);
            
 self.couponview.frame=CGRectMake(0, self.comPrescription.frame.origin.y, self.view.frame.size.width, self.couponview.frame.size.height);
            self.scroll.contentSize=CGSizeMake(0, self.couponview.frame.origin.y+self.couponview.frame.size.height);
           
            [self.tblAddress reloadData];
            
        }
        
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];            [alertController addAction:[UIAlertAction actionWithTitle:@"Ok" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    [Loading dismiss];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return addressArray.count;
    
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AddressTableViewCell *listCell=[tableView dequeueReusableCellWithIdentifier:@"listCell"];    NSArray *listCellAry;
    if (listCell==nil)
    {
        listCellAry=[[NSBundle mainBundle]loadNibNamed:@"AddressTableViewCell" owner:self options:nil];
        
    }
    if (appDelObj.isArabic==YES)
    {
        listCell=[listCellAry objectAtIndex:1];
        
    }
    else
    {
        listCell=[listCellAry objectAtIndex:0];
        
    }
    listCell.EDITDelegate=self;
    listCell.selectionStyle=UITableViewCellSelectionStyleNone;
    NSString *name;
    listCell.imgSel.alpha=1;
    if (addressArray.count==1)
    {
        listCell.imgSel.image=[UIImage imageNamed:@"lan-button-active.png"];
         selectedAddressID=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"userShippingID"];
    }
    else
    {
        if ([indexSel containsIndex:indexPath.section])
        {
            listCell.imgSel.image=[UIImage imageNamed:@"lan-button-active.png"];
        }
        else{
            
            listCell.imgSel.image=[UIImage imageNamed:@"lan-button.png"];
        }
    }
    
    
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingFname"]  isKindOfClass: [NSNull class]])
    {
        
    }
    else
    {
        if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingFname"]  isKindOfClass: [NSNull class]])
        {
            name=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingFname"];
            
        }
        else
        {
            name=[NSString stringWithFormat:@"%@ %@",[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingFname"],[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingLname"]];
            
        }
        
    }
    listCell.lblName.text=name;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingPhone"]  isKindOfClass: [NSNull class]])
    {
        
    }
    else
    {    listCell.lblPhone.text=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingPhone"];
        
    }
    NSString *addressStr=@"";
    NSString *addr1=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingAddress1"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingAddress1"]  isKindOfClass: [NSNull class]]||addr1.length==0)
    {
        
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",addr1];
            
        }
        else
        {
            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,addr1];
            
        }
        
    }
    NSString *addr2=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingAddress2"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingAddress2"]  isKindOfClass: [NSNull class]]||addr2.length==0)
    {
        
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",addr2];
            
        }
        else
        {
            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,addr2];
            
        }
        
    }
    NSString *country=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"countryName"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"countryName"]  isKindOfClass: [NSNull class]]||country.length==0)
    {
        
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",country];
            
        }
        else
        {
            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,country];
            
        }
        
    }
    NSString *state=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"stateName"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"stateName"]  isKindOfClass: [NSNull class]]||state.length==0)
    {
        
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",state];
            
        }
        else
        {            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,state];
            
        }
        
    }
    NSString *city=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingCity"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingCity"]  isKindOfClass: [NSNull class]]||city.length==0)
    {
        
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",city];
        }
        else
        {
            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,city];
            
        }
        
    }
    NSString *pin=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingZip"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingZip"]  isKindOfClass: [NSNull class]]||pin.length==0)
    {
        
    }
    else
    {
        if (addressStr.length==0)
        {
            addressStr=[NSString stringWithFormat:@"%@",pin];
            
        }
        else
        {
            addressStr=[NSString stringWithFormat:@"%@,%@",addressStr,pin];
            
        }
        
    }
    NSString *ph=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingPhone"] ;
    if ([[[addressArray objectAtIndex:indexPath.section]valueForKey:@"shippingPhone"]  isKindOfClass: [NSNull class]]||ph.length==0)
    {
        listCell.lblPhone.text=@"nil";
        
    }
    else
    {
        listCell.lblPhone.text=ph;
        
    }
    NSString *addR=[addressStr stringByReplacingOccurrencesOfString:@" ," withString:@""];
    listCell.addressTxtView.text=addR;
    listCell.btne.tag=indexPath.section;
    listCell.btnr.tag=indexPath.section;
    return listCell;
    
}
-(void)editAddressDelegate:(int)tag
{
    AddressDetailViewController *wallet=[[AddressDetailViewController alloc]init];
    wallet.detailsAry=[addressArray objectAtIndex:tag];
    wallet.editOrDel=@"edit";
    wallet.fromPrescription=@"Yes";
    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:wallet animated:NO];
        
    }
    else
    {
        [self.navigationController pushViewController:wallet animated:YES];
        
    }
    
}
-(void)removeAddressDelegate:(int)tag
{
    UIAlertController * alert=[UIAlertController                                                              alertControllerWithTitle:@"" message:@"Are you sure want to remove this address"preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction* yesButton = [UIAlertAction                                actionWithTitle:@"Yes"                                style:UIAlertActionStyleDefault                                handler:^(UIAlertAction * action)
                                {
                                    Delete=@"Delete";
                                    if (appDelObj.isArabic) {
                                        [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                                    }
                                    else
                                    {
                                        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
                                    }                                    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/User/shipping/languageID/",appDelObj.languageId];                                    NSMutableDictionary *dicPost;
                                    dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"delete",@"action",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingFname"],@"shippingFname",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingLname"],@"shippingLname",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingAddress1"],@"shippingAddress1",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingCity"],@"shippingCity",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingCountryID"],@"shippingCountryID",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingZip"],@"shippingZip",[[addressArray objectAtIndex:tag ] valueForKey:@"shippingStateID"],@"shippingstateID",@"",@"shippingProvince",[[addressArray objectAtIndex:tag ] valueForKey:@"userShippingID"],@"userShippingID",@"yes",@"makeAddressAsPrimary", nil];
                                    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
                                    
                                }];
    UIAlertAction* noButton = [UIAlertAction                               actionWithTitle:@"No"                               style:UIAlertActionStyleDefault                               handler:^(UIAlertAction * action)
    {
        [self dismissViewControllerAnimated:YES completion:nil];                               }];        [alert addAction:yesButton];
    [alert addAction:noButton];
    [self presentViewController:alert animated:YES completion:nil];
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexSel containsIndex:indexPath.section])
    {
        [indexSel removeAllIndexes];
        selectedAddressID=@"";
        [self.tblAddress reloadData];
    }
    else{
         [indexSel removeAllIndexes];
        [indexSel addIndex:indexPath.section];
        selectedAddressID=[[addressArray objectAtIndex:indexPath.section]valueForKey:@"userShippingID"];
        [self.tblAddress reloadData];

//        Delete=@"Delete";
//        [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
//        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/updateAddress/languageID/",appDelObj.languageId];                                    NSMutableDictionary *dicPost;
//        dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",@"delete",@"action",[[addressArray objectAtIndex:indexPath.section ] valueForKey:@"shippingFname"],@"shippingFname",[[addressArray objectAtIndex:indexPath.section ] valueForKey:@"shippingLname"],@"shippingLname",[[addressArray objectAtIndex:indexPath.section ] valueForKey:@"shippingAddress1"],@"shippingAddress1",[[addressArray objectAtIndex:indexPath.section ] valueForKey:@"shippingCity"],@"shippingCity",[[addressArray objectAtIndex:indexPath.section ] valueForKey:@"shippingCountryID"],@"shippingCountryID",[[addressArray objectAtIndex:indexPath.section ] valueForKey:@"shippingZip"],@"shippingZip",[[addressArray objectAtIndex:indexPath.section ] valueForKey:@"shippingStateID"],@"shippingstateID",@"",@"shippingProvince",[[addressArray objectAtIndex:indexPath.section ] valueForKey:@"userShippingID"],@"userShippingID",@"yes",@"makeAddressAsPrimary", nil];
//        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.comPrescription.frame.size.width/3)-10, 110);
    
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.prescription.count;
    
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
    NSString *strImgUrl=[NSString stringWithFormat:@"%@",[[self.prescription objectAtIndex:indexPath.row ]valueForKey:@"imageName"] ];
    if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
    {
        img1.image=[UIImage imageNamed:@"placeholder1.png"];
    }
    else{
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG=[self.prescription objectAtIndex:indexPath.row ];
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",self.URl,strImgUrl];
            
        }
        [img1 sd_setImageWithURL:[NSURL URLWithString:urlIMG] placeholderImage:[UIImage imageNamed:@"placeholder1.png"]];
    }
    
    return cell;
    
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *strImgUrl=[NSString stringWithFormat:@"%@",[[self.prescription objectAtIndex:indexPath.row ]valueForKey:@"imageName"] ];
    if ([strImgUrl isKindOfClass:[NSNull class]]||strImgUrl.length==0)
    {
        self.imgLarge.image=[UIImage imageNamed:@"placeholder1.png"];
    }
    else{
        NSString *s=[strImgUrl substringWithRange:NSMakeRange(0, 4)];
        NSString *urlIMG=[self.prescription objectAtIndex:indexPath.row ];
        if([s isEqualToString:@"http"])
        {
            urlIMG=[NSString stringWithFormat:@"%@",strImgUrl];
        }
        else
        {
            urlIMG=[NSString stringWithFormat:@"%@%@",_URl,strImgUrl];
            
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

- (IBAction)addnewAddressAction:(id)sender {
    AddressDetailViewController *wallet=[[AddressDetailViewController alloc]init];
    wallet.editOrDel=@"add";
    wallet.fromPrescription=@"Yes";

    if(appDelObj.isArabic==YES )
    {
        transition = [CATransition animation];
        [transition setDuration:0.3];
        transition.type = kCATransitionPush;
        transition.subtype = kCATransitionFromLeft;
        [transition setFillMode:kCAFillModeBoth];
        [transition setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
        [self.navigationController.view.layer addAnimation:transition forKey:kCATransition];
        [self.navigationController pushViewController:wallet animated:NO];
    }
    else
    {
        [self.navigationController pushViewController:wallet animated:YES];
    }

}

- (IBAction)placeOrderAction:(id)sender {
    if (addressArray.count==1)
    {
         selectedAddressID=[[addressArray objectAtIndex:0]valueForKey:@"userShippingID"];
        Delete=@"PlaceOrder";
        if (appDelObj.isArabic) {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/submitprescriptionupload/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@", self.p_order_id],@"preorderid",selectedAddressID,@"addressid", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
    else if (addressArray.count==0)
    {
        NSString *okMsg,*str;
        okMsg=@"Ok";
        str=@"Please add address";
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
    if (selectedAddressID.length==0)
    {
        NSString *okMsg,*str;
        okMsg=@"Ok";
        str=@"Please select address";
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        Delete=@"PlaceOrder";
        if (appDelObj.isArabic) {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }        NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/submitprescriptionupload/languageID/",appDelObj.languageId];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[NSString stringWithFormat:@"%@", self.p_order_id],@"preorderid",selectedAddressID,@"addressid", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    }
        
    }
    
}

- (IBAction)cancelCouponAction:(id)sender {
    CGRect rect = self.couponAddView.frame;
    [UIView animateWithDuration:0.0
                     animations:^{
                         self.couponAddView.frame = rect;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.couponAddView.frame;
                         rect.origin.y = self.view.frame.size.height;
                         [UIView animateWithDuration:0.4
                                          animations:^{
                                              self.couponAddView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              
                                              [self.couponAddView removeFromSuperview];
                                              [UIView animateWithDuration:0.2
                                                               animations:^{
                                                                   self.couponAddView.alpha = 0;
                                                               }
                                                               completion:^(BOOL finished) {
                                                                   [self.couponAddView removeFromSuperview];
                                                                   
                                                               }];
                                          }];
                     }];

}
-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
- (IBAction)applyAction:(id)sender {
    NSString *s=[NSString stringWithFormat:@"%@",self.txtCoupon.text];
    if(s.length==0)
    {
        NSString *okMsg,*str;
        
        if (appDelObj.isArabic)
        {
            okMsg=@" موافق ";
            str=@"يرجى ادخال كوبون خصم صحيح";
        }
        else
        {
            okMsg=@"Ok";
            str=@"Please enter a valid coupon code";
        }
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    else
    {
        self.txtAterEnterPromo.text=self.txtCoupon.text;
        Delete=@"Apply";
        if (appDelObj.isArabic) {
            [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }
        else
        {
            [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
        }        NSString *cart=[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"];
        if (cart.length==0) {
            cart=@"";
        }
        NSString *urlStr=[NSString stringWithFormat:@"%@%@",appDelObj.baseURL,@"mobileapp/prescriptionorder/setPromoCode/"];
        NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",[NSString stringWithFormat:@"%@",self.txtCoupon.text],@"promoCode",[NSString stringWithFormat:@"%@",self.p_order_id],@"pr_order_id", nil];
        [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        [self cancelCouponAction:nil];
    }
}

- (IBAction)showCouponView:(id)sender {
    self.couponAddView.alpha = 1;
    self.couponAddView.frame = CGRectMake(self.couponAddView.frame.origin.x, self.couponAddView.frame.origin.y, self.couponAddView.frame.size.width, self.couponAddView.frame.size.height);
    [self.view addSubview:self.couponAddView];
    self.couponAddView.tintColor = [UIColor blackColor];
    [UIView animateWithDuration:0.2
                     animations:^{
                         self.couponAddView.alpha = 1;
                     }
                     completion:^(BOOL finished) {
                         CGRect rect = self.view.frame;
                         rect.origin.y = self.view.frame.size.height;
                         rect.origin.y = -10;
                         [UIView animateWithDuration:0.3
                                          animations:^{
                                              self.couponAddView.frame = rect;
                                          }
                                          completion:^(BOOL finished) {
                                              CGRect rect = self.couponAddView.frame;
                                              rect.origin.y = 0;
                                              [UIView animateWithDuration:0.5
                                                               animations:^{
                                                                   self.couponAddView.frame = rect;
                                                               }
                                                               completion:^(BOOL finished) {
                                                               }];
                                          }];
                     }];
}

- (IBAction)attachAction:(id)sender {
    if (tag==0)
    {
        tag=1;
        self.comPrescription.alpha=1;
        
        
        if (self.prescription.count<=3)
        {
            self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.btnAttach.frame.origin.y+self.btnAttach.frame.size.height, self.comPrescription.frame.size.width, 110);
            
        }
        else{
            if (self.prescription.count/3==0)
            {
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.btnAttach.frame.origin.y+self.btnAttach.frame.size.height, self.comPrescription.frame.size.width, (self.prescription.count/3)*110);
                
            }
            else{
                self.comPrescription.frame=CGRectMake(self.comPrescription.frame.origin.x, self.btnAttach.frame.origin.y+self.btnAttach.frame.size.height, self.comPrescription.frame.size.width, ((self.prescription.count/3)*110)+110);
                
            }
            
        }
       
       
        //self.comPrescription.frame=CGRectMake(0, self.lblAttachPres.frame.origin.y+self.lblAttachPres.frame.size.height, self.comPrescription.frame.size.width, ((self.prescription.count/3)*110)+110);
        self.couponview.frame=CGRectMake(0, self.comPrescription.frame.origin.y+self.comPrescription.frame.size.height+10, self.view.frame.size.width, self.couponview.frame.size.height);            self.scroll.contentSize=CGSizeMake(0, self.couponview.frame.origin.y+self.couponview.frame.size.height);
        //self.couponH.constant = self.couponview.frame.size.height;
        [self.couponview needsUpdateConstraints];
    }
    else{
        tag=0;
        self.comPrescription.alpha=0;
        
        self.couponview.frame=CGRectMake(0, self.comPrescription.frame.origin.y, self.view.frame.size.width, self.couponview.frame.size.height);
        
        self.scroll.contentSize=CGSizeMake(0, self.couponview.frame.origin.y+self.couponview.frame.size.height);
    }
    self.colH.constant = self.comPrescription.frame.size.height;
    [self.comPrescription needsUpdateConstraints];
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
