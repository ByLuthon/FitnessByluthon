//
//  RegistrationViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 04/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegistrationViewController : UIViewController <WebServiceCallDelegate>
{
    MBProgressHUD *HUD;
}
@property (strong, nonatomic) WebService *webrequest;

@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtMobileNumber;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;

- (IBAction)btnFacebookLogin:(id)sender;
- (IBAction)btnSignUp:(id)sender;
- (IBAction)btnSignUpMobileNumber:(id)sender;
- (IBAction)btnBack:(id)sender;

@end
