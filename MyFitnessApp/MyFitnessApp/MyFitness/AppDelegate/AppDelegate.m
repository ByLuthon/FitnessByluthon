//
//  AppDelegate.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 04/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate
@synthesize isInternet;
@synthesize myLocation          = _myLocation;
@synthesize locationManager     = _locationManager;
@synthesize locationGeocoder    = _locationGeocoder;
@synthesize navigationControllerAppDelegate;
@synthesize tabbar;
@synthesize lblLoader;
@synthesize isChatVC;
@synthesize strDeviceToken;



- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    // For initialize GlobalGDXData class
    [GlobalGDXData sharedData];
    
    [_globalGDXData internetCheck];
    
    // For initialize GlobalGDXData class
        [GDXSync sharedData];
    _gdxSync=[[GDXSync alloc] init];
    
    //[_globalGDXData setNavigationBarSetting]; // For Set Navigationbar Color and image and other settings
    
    // ****************************************************************************
    tabbar = [[UITabBarController alloc] init];
    [tabbar setDelegate:self];
    // ****************************************************************************

    
    // ****************************************************************************
    // Initialize Parse SDK
    // ****************************************************************************
    
    //[Parse setApplicationId:@"aEep0iaemPI65pVpRldE1M95QwnKv5xAcr0xqLbD" clientKey:@"bkojlM1X7J7t3WdptQgRIcIkAb6rVylA9HnrQloU"];
    
    
    [Parse initializeWithConfiguration:[ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration>  _Nonnull configuration) {
        
        // Add your Parse applicationId:
        configuration.applicationId = @"rlogical1!@!dasd";
        
        // Uncomment and add your clientKey (it's not required if you are using Parse Server):
        configuration.clientKey = @"asdop&asd32234sdfsdfFDF";
        
        // Uncomment the following line and change to your Parse Server address;
        configuration.server = @"https://rlogical1.herokuapp.com/parse";
        
        // Enable storing and querying data from Local Datastore. Remove this line if you don't want to
        // use Local Datastore features or want to use cachePolicy.
        configuration.localDatastoreEnabled = YES;
        
        
        // Enable storing and querying data from Local Datastore. Remove this line if you don't want to
        // use Local Datastore features or want to use cachePolicy.
        [Parse enableLocalDatastore];
        
    }]];
    
    
    
    // ****************************************************************************
    // If you are using Facebook, uncomment and add your FacebookAppID to your bundle's plist as
    [PFFacebookUtils initialize];
    // ****************************************************************************
        
    PFACL *defaultACL = [PFACL ACL];
    
    // If you would like all objects to be private by default, remove this line.
    defaultACL.publicReadAccess = YES;
    
    [PFACL setDefaultACL:defaultACL withAccessForCurrentUser:YES];
    
    // Override point for customization after application launch.
    
    
    if (application.applicationState != UIApplicationStateBackground)
    {
        // Track an app open here if we launch with a push, unless
        // "content_available" was used to trigger a background push (introduced in iOS 7).
        // In that case, we skip tracking here to avoid double counting the app-open.
        BOOL oldPushHandlerOnly = ![self respondsToSelector:@selector(application:didReceiveRemoteNotification:fetchCompletionHandler:)];
        BOOL noPushPayload = !launchOptions[UIApplicationLaunchOptionsRemoteNotificationKey];
        if (oldPushHandlerOnly || noPushPayload)
        {
            [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];
        }
    }
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)])
    {
        UIUserNotificationType userNotificationTypes = (UIUserNotificationTypeAlert |
                                                        UIUserNotificationTypeBadge |
                                                        UIUserNotificationTypeSound);
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:userNotificationTypes
                                                                                 categories:nil];
        [application registerUserNotificationSettings:settings];
        [application registerForRemoteNotifications];
    }
    else
    {
        [application registerForRemoteNotificationTypes:(UIRemoteNotificationTypeBadge |
                                                         UIRemoteNotificationTypeAlert |
                                                         UIRemoteNotificationTypeSound)];
    }
    
    
    // This is for get Current Location Latitude and Longitude
    [self getLocationPermission];
    
    
    self.window = [[UIWindow alloc] initWithFrame:UIScreen.mainScreen.bounds];
    
    if ([UserDefaults boolForKey:@"isIntroductionDone"])
    {
        if ([UserDefaults boolForKey:@"isUserLoggin"])
        {
            [self redirectHome];
        }
        else
        {
            [self redirectLogin];
        }

    } else
    {
        
        [self introduction];
    }
    
    [PFFacebookUtils initializeFacebookWithApplicationLaunchOptions:launchOptions];
    
    return YES;
}

-(void)introduction
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    navigationControllerAppDelegate = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];

    IntroductionViewController *introVC = [storyboard instantiateViewControllerWithIdentifier:@"IntroductionViewController"];
    navigationControllerAppDelegate = [[UINavigationController alloc] initWithRootViewController:introVC];
    
    self.navigationControllerAppDelegate.navigationBarHidden=true;
    self.window.rootViewController = navigationControllerAppDelegate;
    [self.window makeKeyAndVisible];
}
-(void)redirectLogin
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    navigationControllerAppDelegate = [storyboard instantiateViewControllerWithIdentifier:@"navigationController"];
    
    LandingPageViewController *introVC = [storyboard instantiateViewControllerWithIdentifier:@"LandingPageViewController"];
    navigationControllerAppDelegate = [[UINavigationController alloc] initWithRootViewController:introVC];
    
    self.navigationControllerAppDelegate.navigationBarHidden=true;
    self.window.rootViewController = navigationControllerAppDelegate;
    [self.window makeKeyAndVisible];
}
-(void)redirectHome
{
    //UITabBarController *tabbar = [[UITabBarController alloc] init];
    //tabbar.viewControllers = hom

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];

    HomeViewController *vc1 = [storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
    vc1.view.backgroundColor = [UIColor whiteColor];
    //vc1.tabBarItem.badgeValue = @"23";
    vc1.title = @"Feeds";
    vc1.tabBarItem.tag = 0;
    vc1.tabBarItem.image = [UIImage imageNamed:@"tabbar_home.png"];
    vc1.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected.png"];
    
    ActivityViewController *vc2= [storyboard instantiateViewControllerWithIdentifier:@"ActivityViewController"];
    //vc2.view.backgroundColor = [UIColor cyanColor];
    //vc2.tabBarItem.badgeValue = @"1";
    vc2.title = @"Activity";
    vc2.tabBarItem.tag = 1;
    vc2.tabBarItem.image = [UIImage imageNamed:@"tabbar_home.png"];
    vc2.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_home_selected.png"];
    
    CategoryViewController *vc3 = [storyboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
    vc3.isCreateActivity = TRUE;
    vc3.title = @"";
    vc3.tabBarItem.tag = 2;
    vc3.tabBarItem.image = [UIImage imageNamed:@"camera.png"];
    vc3.tabBarItem.selectedImage = [UIImage imageNamed:@"camera.png"];
    
    MessageViewController *vc4 = [storyboard instantiateViewControllerWithIdentifier:@"MessageViewController"];
    //vc4.tabBarItem.badgeValue = @"99+";
    vc4.title = @"Message";
    vc4.tabBarItem.tag = 4;
    vc4.tabBarItem.image = [UIImage imageNamed:@"tabbar_message_center.png"];
    vc4.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_message_center_selected.png"];


    MapViewController *vc5 = [storyboard instantiateViewControllerWithIdentifier:@"MapViewController"];
    vc3.tabBarItem.tag = 5;
    //vc5.tabBarItem.badgeValue = @"99+";
    vc5.title = @"Discover";
    vc5.tabBarItem.image = [UIImage imageNamed:@"tabbar_discover.png"];
    vc5.tabBarItem.selectedImage = [UIImage imageNamed:@"tabbar_discover_selected.png"];

    UINavigationController *navC1 = [[UINavigationController alloc] initWithRootViewController:vc1];
    UINavigationController *navC2 = [[UINavigationController alloc] initWithRootViewController:vc2];
    UINavigationController *navC3 = [[UINavigationController alloc] initWithRootViewController:vc3];
    UINavigationController *navC4 = [[UINavigationController alloc] initWithRootViewController:vc4];
    UINavigationController *navC5 = [[UINavigationController alloc] initWithRootViewController:vc5];


    tabbar.viewControllers        = @[navC1, navC2, navC3, navC4, navC5];
   
    self.window.rootViewController = tabbar;
    [self.window makeKeyAndVisible];


}
-(void) tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{

}


#pragma mark Push Notifications

- (void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *token = [[deviceToken description] stringByTrimmingCharactersInSet: [NSCharacterSet characterSetWithCharactersInString:@"<>"]];
    token = [token stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    //[[iToast makeText:[NSString stringWithFormat:@"%@",token]] show];
    
    self.strDeviceToken = token;

}

- (void)application:(UIApplication *)application didFailToRegisterForRemoteNotificationsWithError:(NSError *)error
{
    self.strDeviceToken = @"000000000000000";

    if (error.code == 3010)
    {
        NSLog(@"Push notifications are not supported in the iOS Simulator.");
    }
    else
    {
        // show some alert or otherwise handle the failure to register.
        NSLog(@"application:didFailToRegisterForRemoteNotificationsWithError: %@", error);
    }
}

- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    [PFPush handlePush:userInfo];
    
    if (application.applicationState == UIApplicationStateInactive) {
        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
    }
}

///////////////////////////////////////////////////////////
// Uncomment this method if you want to use Push Notifications with Background App Refresh
///////////////////////////////////////////////////////////
//- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo fetchCompletionHandler:(void (^)(UIBackgroundFetchResult))completionHandler {
//    if (application.applicationState == UIApplicationStateInactive) {
//        [PFAnalytics trackAppOpenedWithRemoteNotificationPayload:userInfo];
//    }
//}

#pragma mark Facebook SDK Integration

///////////////////////////////////////////////////////////
// Uncomment this method if you are using Facebook
///////////////////////////////////////////////////////////
- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return  [[FBSDKApplicationDelegate sharedInstance] application:application
                                                           openURL:url
                                                 sourceApplication:sourceApplication
                                                        annotation:annotation];
}



#pragma mark Location GPS Tracker
-(void)getLocationPermission
{
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self; // send loc updates to myself
    
    self.locationGeocoder = [[CLGeocoder alloc] init];
    
    BOOL hasGPS = [CLLocationManager locationServicesEnabled];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if (hasGPS) {
        [self.locationManager startUpdatingLocation];
    }
    [self.locationManager startUpdatingLocation];
    
    
    if(IS_IOS_8){
        
        NSUInteger code = [CLLocationManager authorizationStatus];
        if (code == kCLAuthorizationStatusNotDetermined && ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)] || [self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)])) {
            // choose one request according to your business.
            if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationAlwaysUsageDescription"]){
                [self.locationManager requestAlwaysAuthorization];
            } else if([[NSBundle mainBundle] objectForInfoDictionaryKey:@"NSLocationWhenInUseUsageDescription"]) {
                [self.locationManager  requestWhenInUseAuthorization];
            } else {
                NSLog(@"Info.plist does not contain NSLocationAlwaysUsageDescription or NSLocationWhenInUseUsageDescription");
            }
        } else if (code == kCLAuthorizationStatusDenied)
        {
            [self requestAlwaysAuthorization];
        }
    }
    
}

- (void)requestAlwaysAuthorization
{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"To use background location you must turn on 'Always' in the Location Services Settings";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        [self.locationManager requestAlwaysAuthorization];
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}



- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self; // send loc updates to myself
    
    BOOL hasGPS = [CLLocationManager locationServicesEnabled];
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    if (hasGPS) {
        [self.locationManager startUpdatingLocation];
    }
}

#pragma mark - CoreLocation delegate methods
- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    self.myLocation = newLocation;
    
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
    [geocoder reverseGeocodeLocation: APP_DELEGATE.myLocation completionHandler:^(NSArray *placemarks, NSError *error){
        CLPlacemark *placemarksData = [placemarks lastObject];
        
        //NSLog(@"%@",placemarksData.addressDictionary);
        //NSLog(@"%@",[[placemarksData.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "]);
        
        [UserDefaults setObject:[[placemarksData.addressDictionary valueForKey:@"FormattedAddressLines"] componentsJoinedByString:@", "] forKey:@"FullAddress"];
        [UserDefaults setObject:[NSString stringWithFormat:@"%f",self.myLocation.coordinate.latitude] forKey:@"lat"];
        [UserDefaults setObject:[NSString stringWithFormat:@"%f",self.myLocation.coordinate.longitude] forKey:@"long"];
        [UserDefaults synchronize];
    }
     ];
    
    //NSLog(@"AppDelegate locationManager Location: %@", [newLocation description]);
    
    [self.locationManager stopUpdatingLocation];
    
    _locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
}

- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
    if ([error code] == kCLErrorDenied) {
        // The user denied your app access to location information.
        [self.locationManager stopUpdatingLocation];
    }
    
    NSLog(@"AppDelegate locationManager Error: %@", [error description]);
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

/*
#pragma mark - Show-Hide Loader Loader
-(void)showLoader:(NSString *)str
{
    [self hideLoader];
    [GMDCircleLoader hideFromView:self.window animated:YES];
    
    [lblLoader removeFromSuperview];
    lblLoader = [[UILabel alloc]initWithFrame:self.window.frame];
    lblLoader.backgroundColor = [UIColor blackColor];
    lblLoader.alpha = 0.5;
    [self.window addSubview:lblLoader];
    self.window.userInteractionEnabled = NO;
    [GMDCircleLoader setOnView:self.window withTitle:@"" animated:YES];
}
-(void)hideLoader
{
    [GMDCircleLoader hideFromView:self.window animated:YES];
    self.window.userInteractionEnabled = YES;
    [lblLoader removeFromSuperview];
}
*/

@end
