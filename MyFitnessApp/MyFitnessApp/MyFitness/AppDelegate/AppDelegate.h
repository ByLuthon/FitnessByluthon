//
//  AppDelegate.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 04/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MBProgressHUD/MBProgressHUD.h>
#import "Common.h"
#import "GDXSync.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate,CLLocationManagerDelegate, UITabBarControllerDelegate>
{
    
}
@property (nonatomic, retain) UILabel *lblLoader;
@property (nonatomic, retain) UITabBarController *tabbar;
@property (nonatomic, retain) NSString *strDeviceToken;

@property (strong, nonatomic)UINavigationController *navigationControllerAppDelegate;
@property (strong, nonatomic) UIWindow *window;
@property (readwrite) BOOL isInternet;
@property (readwrite) BOOL isChatVC;

-(void)introduction;
-(void)redirectLogin;
-(void)redirectHome;

// For get GPS location
@property (nonatomic, strong) CLLocation *myLocation;
@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, strong) CLGeocoder *locationGeocoder;


-(void)showLoader:(NSString *)str;
-(void)hideLoader;


@end

