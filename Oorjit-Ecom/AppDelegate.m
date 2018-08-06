//
//  AppDelegate.m
//  Oorjit-Ecom
//
//  Created by Remya Das on 11/05/17.
//  Copyright © 2017 ISPG. All rights reserved.
//

#import "AppDelegate.h"
#import <GoogleSignIn/GoogleSignIn.h>
#import <UserNotifications/UserNotifications.h>
#import <ZDCChatAPI/ZDCChatAPI.h>
#import <Crashlytics/Crashlytics.h>
#import <Fabric/Fabric.h>
#import <ZDCChat/ZDCChat.h>


#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
@import Firebase;
@import FirebasePerformance;

@interface AppDelegate ()<GIDSignInDelegate,UIApplicationDelegate,UNUserNotificationCenterDelegate,passDataAfterParsing>
{
    RESideMenu *sideMenuViewController;
    HomeViewController *homeViewObj;
    WebService *webServiceObj;
}
@end
static NSString * const kClientID =@"1058965638207-gr0vth5hjfd38j0pdsv1hmlcbbf9dgfi.apps.googleusercontent.com";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.CatPArID=self.CatID=@"";
[FIRApp configure];
    self.CancelBillAddressOnCheckout=@"";
  //  FIRTrace *trace = [FIRPerformance startTraceWithName:@"test trace"];
   // [Fabric.sharedSDK setDebug:YES];
    [Fabric with:@[[Crashlytics class]]];
 // [[Crashlytics sharedInstance] crash];
    //[trace incrementMetric:@"retry" by:1];
   //self.baseURL=@"http://pan02-private.ispghosting.com/resmi/jihazi/";
// self.baseURL=@"https://v2-test.jihazi.com/";
    // self.baseURL=@"https://test.jihazi.com/";
    
   self.baseURL=@"https://www.jihazi.com/";
    NSString* Identifier = [[[UIDevice currentDevice] identifierForVendor] UUIDString]; // IOS 6+
    NSLog(@"output is : %@", Identifier);
    webServiceObj=[[WebService alloc]init];
    webServiceObj.PDA=self;
    self.dealBundle=@"";
//    if( SYSTEM_VERSION_LESS_THAN( @"10.0" ) ) {
//        [[UIApplication sharedApplication] registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound |    UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
//        [[UIApplication sharedApplication] registerForRemoteNotifications];
//
//    } else {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        center.delegate = self;
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge) completionHandler:^(BOOL granted, NSError * _Nullable error) {
            if( !error ) {
                // required to get the app to do anything at all about push notifications
                dispatch_async(dispatch_get_main_queue(), ^{
                    [[UIApplication sharedApplication] registerForRemoteNotifications];
                });
                NSLog( @"Push registration success." );
            } else {
                NSLog( @"Push registration FAILED" );
                NSLog( @"ERROR: %@ - %@", error.localizedFailureReason, error.localizedDescription );
                NSLog( @"SUGGESTIONS: %@ - %@", error.localizedRecoveryOptions, error.localizedRecoverySuggestion );
            }
        }];
//    }
   [ZDCChat initializeWithAccountKey:@"4gIZ13NPRA4FxjgZ8PfYwqePqzyem7l9"];
 [self  registerForRemoteNotifications];

    UIView *statusBar = [[[UIApplication sharedApplication] valueForKey:@"statusBarWindow"] valueForKey:@"statusBar"];
    if ([statusBar respondsToSelector:@selector(setBackgroundColor:)]) {
        statusBar.backgroundColor = [UIColor blackColor];
    }

    self.languageId=[[NSUserDefaults standardUserDefaults]objectForKey:@"LANGUAGEID"];
    _filterBrandID=[[NSMutableArray alloc]init];
    _UploadedPrescription=[[NSMutableArray alloc]init];
    _shipARRAY=[[NSMutableArray alloc]init];
    _billARRAY=[[NSMutableArray alloc]init];
    
    /*common settings*/
    self.headderColor=[UIColor whiteColor];
    self.bgViewColor=[UIColor colorWithRed:0.976 green:0.976 blue:0.976 alpha:1.00];
    self.titleColor=[UIColor colorWithRed:0.259 green:0.231 blue:0.259 alpha:1.00];
    self.textColor=[UIColor colorWithRed:0.169 green:0.137 blue:0.169 alpha:1.00];
    self.subtext=[UIColor colorWithRed:0.753 green:0.773 blue:0.804 alpha:1.00];
    self.priceColor=[UIColor colorWithRed:0.153 green:0.612 blue:0.788 alpha:1.00];
    self.priceOffer= [UIColor colorWithRed:0.584 green:0.569 blue:0.584 alpha:1.00];
    self.qty=[UIColor colorWithRed:0.984 green:0.541 blue:0.467 alpha:1.00];
    self.redColor=[UIColor colorWithRed:0.965 green:0.482 blue:0.114 alpha:1.00];
    self.menubgtable=[UIColor colorWithRed:0.965 green:0.965 blue:0.973 alpha:1.00];
    self.menuBgCellSel=[UIColor colorWithRed:0.965 green:0.965 blue:0.973 alpha:1.00];
    self.BlueColor=[UIColor colorWithRed:0.482 green:0.169 blue:0.486 alpha:1.00];
    self.cartBg=[UIColor colorWithRed:0.953 green:0.498 blue:0.184 alpha:1.00];
    self.catColor=[UIColor colorWithRed:0.169 green:0.137 blue:0.169 alpha:1.00];
    self.CatID=@"";
    self.mainBrand=@"";
    self.mainPrice=@"";
    self.mainSearch=@"";
    self.mainBusiness=@"";
    self.mainDiscount=@"";
    self.window.frame=[[UIScreen mainScreen]bounds];
    //statusBar.frame=CGRectMake(0, 0, self.window.frame.size.width, 40);
    NSDictionary *userInfo = [launchOptions valueForKey:@"UIApplicationLaunchOptionsRemoteNotificationKey"];
    NSDictionary *apsInfo = [userInfo objectForKey:@"aps"];

//    UIApplication.sharedApplication.accessibilityLanguage=@"Arabic";
//     [[NSLocale preferredLanguages] arrayByAddingObject:@"ar"];
    
//    [NSLocaleLanguageCode setValue:@"Arabic" forKey:[[NSLocale preferredLanguages] firstObject]];
 //   [[NSBundle mainBundle]setla]
   // [[ZDCChatUI appearance] setbackchat];
    
//    NSString* language = @"ar";
//    NSString* path =[[NSBundle mainBundle]pathForResource:language ofType:@"lproj"];
//    //NSString* path = NSBundle.mainBundle().pathForResource(language, ofType: "lproj")
//    NSString* bundle = [[NSBundle mainBundle]bundlePath];; //NSBundle(path: path!)
//    //NSString* string =  bundl;e?: .localizedStringForKey[("key", value: nil, table: nil);
//    [[ NSBundle mainBundle]localizedStringForKey:@"key" value:path table:nil];
    [[ZDCChatUI appearance] setBackChatButtonImage:@"backZen.png"];
    [[ZDCChatUI appearance] setEndChatButtonImage:@"closeZen.png"];
    //    [[ZDCTextEntryView appearance] setTextEntryColor:[UIColor greenColor]];
    [[ZDCTextEntryView appearance] setSendButtonImage:@"sendZen.png"];
//    [[NSBundle mainBundle] pathForResource:@"ar_SA" ofType:@"lproj" ];
    if(apsInfo) {
        [self notificationAction];
    }
    else{
        NSString *language=[[NSUserDefaults standardUserDefaults]objectForKey:@"SELECT_LANGUAGE_Name"];
        if([language isEqualToString:@"Arabic"]||[language isEqualToString:@"العربية"])
        {
              [[ZDCChatUI appearance]setAccessibilityLanguage:@"ar"];
            self.isArabic=YES;
              self.languageId=@"2";
            [self arabicMenuAction];
          
        }
        else
        {
            if (language.length==0)
            {
                [[ZDCChatUI appearance]setAccessibilityLanguage:@"ar"];
                self.isArabic=YES;
                self.languageId=@"2";

                [self arabicMenuAction];
            }
            else
            {
              [[ZDCChatUI appearance]setAccessibilityLanguage:@"en"];
            self.isArabic=NO;
            self.languageId=@"1";
            [self englishMenuAction];
            }
        }

    }
   // [[ZDCChatUI appearance] setBackChatButtonImage:@"grayback.png"];
   //   [[ZDCChatUI appearance] setEndChatButtonImage:@"history-clock-button.png"];
     //  [[ZDCTextEntryView appearance] setSendButtonImage:@"history-clock-button.png"];
    //ZDCChatViewController *controller = [ZDCChat instance].chatViewController;
    //controller.navigationController.navigationBar.barTintColor=[UIColor redColor];
  //  SearchView *s=[[SearchView alloc]init];
    //[[ZDCChat instance]setn];
    [GIDSignIn sharedInstance].clientID =kClientID;
    self.window.backgroundColor=[UIColor blackColor];
    return YES;
}
- (void)registerForRemoteNotifications {
    if (IS_OS_8_OR_LATER) {
        [[UIApplication sharedApplication] registerForRemoteNotifications];
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeBadge
                                                                                             |UIUserNotificationTypeSound
                                                                                             |UIUserNotificationTypeAlert) categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    else {
        [[UIApplication sharedApplication] registerForRemoteNotificationTypes:(UIRemoteNotificationTypeAlert | UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound)];
    }
    
}
-(void)userNotificationCenter:(UNUserNotificationCenter *)center willPresentNotification:(UNNotification *)notification withCompletionHandler:(void (^)(UNNotificationPresentationOptions options))completionHandler{
    NSLog(@"User Info********* : %@",notification.request.content.userInfo);
    NSString *cancelTitle = @"Ok";
    NSString *Title = @"Notification";
    if (self.isArabic) {
        cancelTitle = @" موافق ";
        Title = @"إشعارات";
    }
    [[NSUserDefaults standardUserDefaults]setObject:[[notification.request.content.userInfo objectForKey:@"aps"] objectForKey:@"badge"] forKey:@"Notification"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSString *message = [[notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"];
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Title message:message preferredStyle:UIAlertControllerStyleAlert];
    [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
        if ([[[notification.request.content.userInfo objectForKey:@"aps"] objectForKey:@"action"]isEqualToString:@"cart"]) {
            [[NSUserDefaults standardUserDefaults]setObject:[[notification.request.content.userInfo objectForKey:@"aps"] objectForKey:@"summaryText"] forKey:@"cartID" ];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self CartAction];
        }
        else
        {
            [self notificationAction];
        }
        
    }]];
    [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    completionHandler(UNAuthorizationOptionSound | UNAuthorizationOptionAlert | UNAuthorizationOptionBadge);
}

//Called to let your app know which action was selected by the user for a given notification.
- (void)userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void(^)(void))completionHandler __IOS_AVAILABLE(10.0) __WATCHOS_AVAILABLE(3.0) __TVOS_PROHIBITED{
    NSLog(@"User Info : %@",response.notification.request.content.userInfo);
    
    NSString *cancelTitle = @"Ok";
    NSString *Title = @"Notification";
    if (self.isArabic) {
        cancelTitle = @" موافق ";
        Title = @"إشعارات";
    }
    //NSString *message = [[response.notification.request.content.userInfo valueForKey:@"aps"] valueForKey:@"alert"];
  //  UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Title message:message preferredStyle:UIAlertControllerStyleAlert];
    //[alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
    [[NSUserDefaults standardUserDefaults]setObject:[[response.notification.request.content.userInfo objectForKey:@"aps"] objectForKey:@"badge"] forKey:@"Notification"];
    [[NSUserDefaults standardUserDefaults]synchronize];
        if ([[[response.notification.request.content.userInfo objectForKey:@"aps"] objectForKey:@"action"]isEqualToString:@"cart"]) {
            [[NSUserDefaults standardUserDefaults]setObject:[[response.notification.request.content.userInfo objectForKey:@"aps"] objectForKey:@"summaryText"] forKey:@"cartID" ];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self CartAction];
        }
        else
        {
            [self notificationAction];
        }
        
    //}]];
   // [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];
    
    completionHandler();
}
-(void)application:(UIApplication *)app didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *str = [NSString stringWithFormat:@"%@",deviceToken];
    
    NSCharacterSet *trim = [NSCharacterSet characterSetWithCharactersInString:@"< >"];
    NSString *result = [[str componentsSeparatedByCharactersInSet:trim] componentsJoinedByString:@""];
    NSLog(@"%@", result);
    _devicetocken=result;
    [[NSUserDefaults standardUserDefaults]setObject:_devicetocken forKey:@"DEVICE"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    NSLog(@"tocknnnnnnn%@", str);
    
    
    NSString *urlStr=[NSString stringWithFormat:@"%@%@%@",self.baseURL,@"mobileapp/Push/index/languageID/",self.languageId];
    NSMutableDictionary *dicPost=[[NSMutableDictionary alloc]initWithObjectsAndKeys:@"iPhone",@"deviceType",self.devicetocken,@"deviceToken", nil];
    [webServiceObj getUrlReqForPostingBaseUrl:urlStr andTextData:dicPost];
    
    
}
-(void)failServiceMSg
{

    [Loading dismiss];
}
-(void)finishedParsingDictionary:(NSDictionary *)dictionary
{
    if ([[dictionary objectForKey:@"response"]isEqualToString:@"Success"])
    {
        NSLog(@"succeesss");
    }
    [Loading dismiss];
}
-(void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err {
    
    NSString *str = [NSString stringWithFormat: @"Error: %@", err];
    NSLog(@"errrrrrrr%@", str);
    
}

-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    for (id key in userInfo) {NSLog(@"key: %@, value: %@", key, [userInfo objectForKey:key]);
    }
    UIApplicationState state = [application applicationState];
    NSLog(@"NOTIFICATION     %@",userInfo);
    [[NSUserDefaults standardUserDefaults]setObject:[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] forKey:@"Notification"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if (state == UIApplicationStateActive) {
        [application setApplicationIconBadgeNumber:[[[userInfo objectForKey:@"aps"] objectForKey:@"badge"] intValue]];

        NSString *cancelTitle = @"Ok";
        NSString *Title = @"Notification";
        if (self.isArabic) {
            cancelTitle = @" موافق ";
            Title = @"إشعارات";
        }
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:Title message:message preferredStyle:UIAlertControllerStyleAlert];
        [alertController addAction:[UIAlertAction actionWithTitle:cancelTitle style:UIAlertActionStyleDefault handler:^(UIAlertAction* action){
            if ([[[userInfo objectForKey:@"aps"] objectForKey:@"action"]isEqualToString:@"cart"]) {
                [[NSUserDefaults standardUserDefaults]setObject:[[userInfo objectForKey:@"aps"] objectForKey:@"summaryText"] forKey:@"cartID" ];
                [[NSUserDefaults standardUserDefaults]synchronize];
                 [self CartAction];
            }
            else
            {
                 [self notificationAction];
            }
            
           }]];
        [self.window.rootViewController presentViewController:alertController animated:YES completion:nil];

    } else {
        //Do stuff that you would do if the application was not active
        if ([[[userInfo objectForKey:@"aps"] objectForKey:@"action"]isEqualToString:@"cart"]) {  [[NSUserDefaults standardUserDefaults]setObject:[[userInfo objectForKey:@"aps"] objectForKey:@"summaryText"] forKey:@"cartID" ];
            [[NSUserDefaults standardUserDefaults]synchronize];
            [self CartAction];
        }
        else
        {
            [self notificationAction];
        }
    }
    
}
-(void)notificationAction
{
    WishLlstViewController *order=[[WishLlstViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:order];
    order.fromMenu=@"AppDel";
    order.type=@"Notification";
//    self.window.rootViewController=nav;
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
   
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];

  
}
-(void)CartAction
{
    CartViewController *order=[[CartViewController alloc]init];
    UINavigationController *nav=[[UINavigationController alloc]initWithRootViewController:order];
    order.fromMenu=@"AppDel";
   
    //    self.window.rootViewController=nav;
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    
    self.window.rootViewController = nav;
    [self.window makeKeyAndVisible];
    
    
}
-(void)englishMenuAction
{
    self.isArabic=NO;
    self.languageId=@"1";
    [[NSUserDefaults standardUserDefaults]setObject:@"English" forKey:@"LANGUAGE"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"1" forKey:@"LANGUAGEID"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SELECT_LANGUAGE"];
    [[NSUserDefaults standardUserDefaults]setObject:@"English" forKey:@"SELECT_LANGUAGE_Name"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    homeViewObj=[[HomeViewController alloc]init];
    self.rootNavObj=[[UINavigationController alloc]initWithRootViewController:homeViewObj];
    self.rootNavObj.navigationBarHidden=YES;
    MenuViewController *sidemenu=[[MenuViewController alloc]init];
    if ([self.rootNavObj respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        self.rootNavObj.interactivePopGestureRecognizer.enabled = NO;
    }
    self.rootNavObj.navigationBar.hidden=YES;
    sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:self.rootNavObj
                                                        leftMenuViewController:sidemenu
                                                       rightMenuViewController:nil];
    sideMenuViewController.view.backgroundColor =  self.menubgtable;
    sideMenuViewController.menuPreferredStatusBarStyle = 1;
    sideMenuViewController.delegate = self;
    self.window.rootViewController = sideMenuViewController;
}
-(void)arabicMenuAction
{
    [[NSUserDefaults standardUserDefaults]setObject:@"Arabic" forKey:@"LANGUAGE"];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"2" forKey:@"LANGUAGEID"];

    [[NSUserDefaults standardUserDefaults]setObject:@"YES" forKey:@"SELECT_LANGUAGE"];
    [[NSUserDefaults standardUserDefaults]setObject:@"Arabic" forKey:@"SELECT_LANGUAGE_Name"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    self.isArabic=YES;
    self.languageId=@"2";
    
    ArabicHomeViewController *searchViewcontroller=[[ArabicHomeViewController alloc]init];
    ArabicMenuViewController *aSidemenu=[[ArabicMenuViewController alloc]init];
    UINavigationController *searchNav=[[UINavigationController alloc]initWithRootViewController:searchViewcontroller];
    if ([searchNav respondsToSelector:@selector(interactivePopGestureRecognizer)]) {
        searchNav.interactivePopGestureRecognizer.enabled = NO;
    }
    searchNav.navigationBar.hidden=YES;
    sideMenuViewController = [[RESideMenu alloc] initWithContentViewController:searchNav
                                                        leftMenuViewController:nil
                                                       rightMenuViewController:aSidemenu];
    sideMenuViewController.view.backgroundColor =  self.menubgtable;
    sideMenuViewController.menuPreferredStatusBarStyle = 1;
    sideMenuViewController.delegate = self;
    self.window.rootViewController = sideMenuViewController;
}



-(BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString*, id> *)options NS_AVAILABLE_IOS(9_0){        return [self application:app        processOpenURLAction:url           sourceApplication:options[UIApplicationOpenURLOptionsSourceApplicationKey]                  annotation:options[UIApplicationOpenURLOptionsAnnotationKey]                  iosVersion:9];
    
}
-(BOOL)application:(UIApplication *)application processOpenURLAction:(NSURL*)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation iosVersion:(int)version{
    if ([  [[NSUserDefaults standardUserDefaults]objectForKey:@"googleOrFb"]         isEqualToString:@"FB"]) {
        return [[FBSDKApplicationDelegate sharedInstance] application:application                                                              openURL:url                                                    sourceApplication:sourceApplication                                                           annotation:annotation];
        
    }    else
    {
        return [[GIDSignIn sharedInstance] handleURL:url                                   sourceApplication:sourceApplication                                          annotation:annotation];
        
    }
    
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    __block UIBackgroundTaskIdentifier backgroundTask; backgroundTask =
    [application beginBackgroundTaskWithExpirationHandler: ^ { [application endBackgroundTask:backgroundTask]; backgroundTask = UIBackgroundTaskInvalid; }];
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    FIRTrace *trace = [FIRPerformance startTraceWithName:@"test trace"];
    [trace stop];
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    // Saves changes in the application's managed object context before the application terminates.
    FIRTrace *trace = [FIRPerformance startTraceWithName:@"test trace"];
    [trace stop];
    [self saveContext];
}


#pragma mark - Core Data stack

@synthesize persistentContainer = _persistentContainer;

- (NSPersistentContainer *)persistentContainer {
    // The persistent container for the application. This implementation creates and returns a container, having loaded the store for the application to it.
    @synchronized (self) {
        if (_persistentContainer == nil) {
            _persistentContainer = [[NSPersistentContainer alloc] initWithName:@"Oorjit_Ecom"];
            [_persistentContainer loadPersistentStoresWithCompletionHandler:^(NSPersistentStoreDescription *storeDescription, NSError *error) {
                if (error != nil) {
                    // Replace this implementation with code to handle the error appropriately.
                    // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                    
                    /*
                     Typical reasons for an error here include:
                     * The parent directory does not exist, cannot be created, or disallows writing.
                     * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                     * The device is out of space.
                     * The store could not be migrated to the current model version.
                     Check the error message to determine what the actual problem was.
                     */
                    NSLog(@"Unresolved error %@, %@", error, error.userInfo);
                    abort();
                }
            }];
        }
    }
    
    return _persistentContainer;
}

#pragma mark - Core Data Saving support

- (void)saveContext {
    NSManagedObjectContext *context = self.persistentContainer.viewContext;
    NSError *error = nil;
    if ([context hasChanges] && ![context save:&error]) {
        // Replace this implementation with code to handle the error appropriately.
        // abort() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
        NSLog(@"Unresolved error %@, %@", error, error.userInfo);
        abort();
    }
}

@end


