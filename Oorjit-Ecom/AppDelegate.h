//
//  AppDelegate.h
//  Oorjit-Ecom
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreData/CoreData.h>
#import "RESideMenu.h"
#import "HomeViewController.h"
#import "MenuViewController.h"
#import "ArabicHomeViewController.h"
#import "ArabicMenuViewController.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import "WebService.h"
//#import <ZDCChat/ZDCChat.h>
#import "CartViewController.h"
@interface AppDelegate : UIResponder <UIApplicationDelegate,RESideMenuDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (weak, nonatomic) UIViewController *paymentOptionVC;


/*common settings*/
@property(nonatomic,strong)UIColor *headderColor,*titleColor,*textColor,*subtext,*priceColor,*priceOffer,*qty,*cartID,*updateQtyn,*redColor,*menubgtable,*menuBgCellSel,*BlueColor,*cartBg,*catColor,*bgViewColor;
@property(nonatomic)BOOL isArabic;

@property(nonatomic,strong)UINavigationController *rootNavObj;

@property(nonatomic)int menuTag;
@property(nonatomic,strong)NSMutableArray *filterBrandID,*UploadedPrescription,*shipARRAY,*billARRAY;
@property(nonatomic,strong)NSString *baseURL,*baseURLS,*homeImgURL,*listImgURL,*DetailImgURL,*ImgURL,*languageId,*frommenu,*listTitle,*combination1,*combination2,*wishImg,*currencySymbol,*CatID,*CatPArID,*widgetImgURL,*fromListPrescription,*fromWhere,*profileURl,*OrderID,*dealBundle,*fromSide,*devicetocken,*mainPrice,*mainDiscount,*mainBrand,*mainBusiness,*mainSearch,*CancelBillAddressOnCheckout,*cmsTitle;

@property (readonly, strong) NSPersistentContainer *persistentContainer;
@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSManagedObjectModel  *managedObjectModel;
@property (strong, nonatomic) NSPersistentStoreCoordinator  *persistentStoreCoordinator;
- (void)saveContext;

-(void)arabicMenuAction;

-(void)englishMenuAction;
-(void)arabicRoot;

-(void)englishRoot;
@end

