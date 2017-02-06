//
//  LoginViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 04/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "LoginViewController.h"
#import "HomeViewController.h"
#import "RegistrationViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {

    
    _gdxSync.delegate=self;
    [_gdxSync performSelector:@selector(loginMethod:) withObject:@{@"" : @""} afterDelay:0.1];
    // Add border to login Button
    [_globalGDXData addBorderToView:2 color:kColorWhite cornerRadius:0 objView:_refBtnLogin];
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    if ([PFUser currentUser] != nil) {
        
        NSLog(@"%@",[PFUser currentUser].username);
        NSLog(@"%@",[PFUser currentUser].password);
        NSLog(@"%@",[PFUser currentUser].email);
        
    } else {
        NSLog(@"User Is not login");
    }
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)loginData :(NSDictionary *)aLoginDict error:(NSError *)aError
{
    
}
- (IBAction)btnLogin:(id)sender {
    
    if ([_txtUserName.text length] == 0 || [_txtPassword.text length] == 0) {
        
        [_globalGDXData showAlertTitle:kAlertFailed message:kAlertEmptyFieldValid ViewControllerOBJ:self];
        
    } else {
        
        [HUD show:YES];
        [PFUser logInWithUsernameInBackground:_txtUserName.text password:_txtPassword.text block:^(PFUser * _Nullable user, NSError * _Nullable error) {
            
            NSLog(@"user.username %@",user.username);
            [HUD hide:YES];
            
            /*
            HomeViewController *homeVC=[self.storyboard instantiateViewControllerWithIdentifier:@"HomeViewController"];
            [self.navigationController pushViewController:homeVC animated:YES];
            */
            [_globalGDXData showAlertTitle:kAlertSuccess message:@"Login SuccessFull !!" ViewControllerOBJ:self];
            [APP_DELEGATE redirectHome];

        }];
    }
}

- (IBAction)btnSignUp:(id)sender {
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
@end
