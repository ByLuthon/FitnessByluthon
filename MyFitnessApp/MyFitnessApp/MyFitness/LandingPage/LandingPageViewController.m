//
//  LandingPageViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 28/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "LandingPageViewController.h"
#import "LoginViewController.h"
#import "RegistrationViewController.h"
#import "HomeViewController.h"

@interface LandingPageViewController ()

@end

@implementation LandingPageViewController

- (void)viewDidLoad {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    [_globalGDXData addBorderToView:2 color:kColorWhite cornerRadius:1 objView:_refBtnLogin];
    [_globalGDXData addBorderToView:2 color:kColorWhite cornerRadius:1 objView:_refBtnSignUp];
    
    self.navigationController.navigationBarHidden=true;
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnFacebookLogin:(id)sender {
    
    [HUD show:YES];
    
    [PFFacebookUtils logInInBackgroundWithPublishPermissions:@[ @"publish_actions" ] block:^(PFUser *user, NSError *error) {
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else {
            NSLog(@"User now has publish permissions!");
            NSLog(@"%@",user.email);
            NSLog(@"%@",user[@"_id"]);
            NSLog(@"%@",user[kUserLastName]);
            NSLog(@"%@",user[kUserProfilePicture]);
            
            /*
            HomeViewController *homeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            [self.navigationController pushViewController:homeVC animated:YES];
             */
            [APP_DELEGATE redirectHome];

        }
        [HUD hide:YES];
    }];
}
- (IBAction)btnLogin:(id)sender {
}

- (IBAction)btnSignUp:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
