//
//  PendingPaymentView.m
//  MedMart
//
//  Created by Remya Das on 02/01/18.
//  Copyright © 2018 ISPG. All rights reserved.
//

#import "PendingPaymentView.h"

@interface PendingPaymentView ()<passDataAfterParsing>
{
    AppDelegate *appDelObj;
    CATransition * transition;
    WebService *webServiceObj;
    NSArray *listArray;
    NSMutableIndexSet *methodSelect;
    NSString *isPaymentOptionSelect,*payID,*payMetho,*paynow;
}

@end

@implementation PendingPaymentView
@synthesize selectedBillAdr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    isPaymentOptionSelect=@"";
    payID=@"";
    payMetho=@"";
    appDelObj=(AppDelegate *)[UIApplication sharedApplication].delegate;
    [self.col registerNib:[UINib nibWithNibName:@"MethodCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"cellIdentifier"];
   // [_col registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cellIdentifier"];
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    methodSelect=[[NSMutableIndexSet alloc]init];
    NSString *s=[NSString stringWithFormat:@"PAY NOW %@ %@",appDelObj.currencySymbol,self.strAmt];
    self.lblYouPay.text=[NSString stringWithFormat:@"You pay: %@ %@",appDelObj.currencySymbol,self.strAmt];
    [self.btnpay setTitle:s forState:UIControlStateNormal];
    [self getDataFromService];
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
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/listPaymentmethods/languageID/",appDelObj.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.strID,@"cartID", nil];  [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    
}
-(void)failServiceMSg
{
    NSString *strMsg,*okMsg;
    
    strMsg=@"Network busy! please try again or after sometime.";
    okMsg=@"Ok";
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action)
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
        if ([paynow isEqualToString:@"EBS"])
        {
            PaymentModeViewController *paymentView = [[PaymentModeViewController alloc]init];                                paymentView.ACC_ID = [[[dictionary objectForKey:@"result"]objectForKey:@"payment_account_id"]objectForKey:@"paySetValue"];
            //Merchant has to configure the Account ID
            paymentView.SECRET_KEY = [[[dictionary objectForKey:@"result"]objectForKey:@"payment_secret_key"]objectForKey:@"paySetValue"];   //Merchant has to configure the Secret Key
            if ([[[[dictionary objectForKey:@"result"]objectForKey:@"payment_test"]objectForKey:@"paySetValue"]isEqualToString:@"On"])
            {
                paymentView.MODE = @"TEST";
                //Merchant has to configure the Mode either TEST or LIVE
                
            }
            else{
                paymentView.MODE = @"LIVE";
                //Merchant has to configure the Mode either TEST or LIVE
                
            }
            paymentView.ALGORITHM = @"2";
            //Merchant has to configure the Algorithm 0 for md5, 1 for sha1, 2 for sha512
            NSString *price=[self.strAmt stringByReplacingOccurrencesOfString:[NSString stringWithFormat:@"%@ ",appDelObj.currencySymbol] withString:@""];                paymentView.strSaleAmount=[NSString stringWithFormat:@"%.2f",[price floatValue]];
            paymentView.reference_no=[NSString stringWithFormat:@"%@",[[dictionary objectForKey:@"result"]objectForKey:@"order_number"]]; //Merchant has to change it dynamically
            //paymentView.reference_no=@"223";
            //Merchant has to change it dynamically
            paymentView.descriptionString = @"Online Payment";                paymentView.strCurrency =@"INR";
            //paymentView.strCurrency =[[[dictionary objectForKey:@"result"]objectForKey:@"payment_currency"]objectForKey:@"paySetValue"];
            // paymentView.strDisplayCurrency =[[[dictionary objectForKey:@"result"]objectForKey:@"payment_currency"]objectForKey:@"paySetValue"];
            paymentView.strDisplayCurrency =@"INR";
            paymentView.strDescription = @"Online payment";                paymentView.channel=0;
            paymentView.strBillingName = [selectedBillAdr valueForKey:@"billingFirstName"];                paymentView.strBillingAddress = [selectedBillAdr valueForKey:@"billingAddress"];
            paymentView.strBillingCity =[selectedBillAdr valueForKey:@"billingCity"];                paymentView.strBillingState = [selectedBillAdr valueForKey:@"billingState"];                paymentView.strBillingPostal =[selectedBillAdr valueForKey:@"billingZip"];                paymentView.strBillingCountry =@"Ind";//                paymentView.strBillingCountry = [selectedBillAdr valueForKey:@"billingCountry"];                paymentView.strBillingEmail =[selectedBillAdr valueForKey:@"billingEmail"];                paymentView.strBillingTelephone =[selectedBillAdr valueForKey:@"billingPhone"];
            paymentView.strDeliveryName = [selectedBillAdr valueForKey:@"billingFirstName"];                    paymentView.strDeliveryAddress = [selectedBillAdr valueForKey:@"billingAddress"];                    paymentView.strDeliveryCity =[selectedBillAdr valueForKey:@"billingCity"];                    paymentView.strDeliveryState = [selectedBillAdr valueForKey:@"billingState"];                    paymentView.strDeliveryPostal =[selectedBillAdr valueForKey:@"billingZip"];                    paymentView.strDeliveryCountry =@"Ind";
            //paymentView.strDeliveryCountry = [selectedBillAdr valueForKey:@"billingCountry"];                    paymentView.strDeliveryTelephone =[selectedBillAdr valueForKey:@"billingPhone"];
            [self.navigationController pushViewController:paymentView animated:NO];
        }
        else if ([paynow isEqualToString:@"normal"])
        {
            [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_COUNT"];                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"CART_PRICE"];                [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"cartID"];                [[NSUserDefaults standardUserDefaults]synchronize];                ThankYouViewController *thank=[[ThankYouViewController alloc]init];
            thank.strResponse=@"Your order has been placed and is being processed. When items are shipped, you will receive an email with the details. You can track this order through . My order Page.";
            if (appDelObj.isArabic) {
                thank.strResponse=@"لقد تم اكمال طلبك بنجاح،سوف تتلقى رسالة تأكيد الطلب بالبريد الإلكتروني مع تفاصيل طلبك .";
            }
            [self.navigationController pushViewController:thank animated:YES];
        }
        
        else{
        listArray=[dictionary objectForKey:@"result"];
        [self.col reloadData];
        }
    }
    else
    {
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:[dictionary objectForKey:@"errorMsg"] preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
        
    }
    [Loading dismiss];
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(self.view.frame.size.width-10, 50);
    
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return  listArray.count;
    
}
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MethodCollectionViewCell *catCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    if ([methodSelect containsIndex:indexPath.row])
    {
        catCell.lblIm.image=[UIImage imageNamed:@"lan-button-active.png"];
        
    }
    else
    {
        catCell.lblIm.image=[UIImage imageNamed:@"lan-button.png"];
        
    }
    catCell.lblMethod.text=[[listArray objectAtIndex:indexPath.row]valueForKey:@"label"];
    if ([[[listArray objectAtIndex:indexPath.row]valueForKey:@"label"]isEqualToString:@"Redeem Points"])
    {
        catCell.lblMethod.alpha=0;
        catCell.lblIm.alpha=0;
        
    }
    return catCell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([methodSelect containsIndex:indexPath.row])
    {
        [methodSelect removeAllIndexes];
        isPaymentOptionSelect=@"";
        payID=@"";
        payMetho=@"";
        
    }
    else
    {
        [methodSelect removeAllIndexes];
        [methodSelect addIndex:indexPath.row];
        isPaymentOptionSelect=@"Select";
        payID=[[listArray objectAtIndex:indexPath.row]valueForKey:@"paySetGroupID"];            payMetho=[[listArray objectAtIndex:indexPath.row]valueForKey:@"paySetGroupKey"];
        
    }
    [self.col reloadData];
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

- (IBAction)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)payNowAction:(id)sender {
    if ([isPaymentOptionSelect isEqualToString:@"Select"])
    {
        if ([payMetho isEqualToString:@"EbsCreditCard"]||[payMetho isEqualToString:@"EbsDebitCard"]||[payMetho isEqualToString:@"EbsNetBanking"])
        {
            paynow=@"EBS";
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/paymentGatewaySettings/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",payMetho,@"paySetGroupKey",[[NSUserDefaults standardUserDefaults]objectForKey:@"cartID"],@"cartID", nil];
            [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
        else
        {
            paynow=@"normal";
            NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",appDelObj.baseURL,@"mobileapp/Cart/payment/languageID/",appDelObj.languageId];
            NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:[[NSUserDefaults standardUserDefaults]objectForKey:@"USER_ID"],@"userID",self.strID,@"cartID",payMetho,@"paymentSettingsGroupKey", nil];
            if (appDelObj.isArabic)
            {
                [Loading showWithStatus:@"يرجى الانتظار " maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }
            else
            {
                [Loading showWithStatus:@"Please wait..." maskType:SVProgressHUDMaskTypeClear Indicator:YES];
            }      [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
        }
    }
    else
    {
        NSString *strMsg,*okMsg;
        
            strMsg=@"Please Select Payment Method";
            okMsg=@"Ok";
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:strMsg preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:okMsg style:UIAlertActionStyleDefault handler:nil]];
        [self presentViewController:alertController animated:YES completion:nil];
    }
}
@end
