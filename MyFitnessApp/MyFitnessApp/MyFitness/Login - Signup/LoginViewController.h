//
//  LoginViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 04/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LoginViewController : UIViewController<GDXApiDelegate>
{
    MBProgressHUD *HUD;
}
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnSignUp:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtUserName;
@property (weak, nonatomic) IBOutlet UITextField *txtPassword;
- (IBAction)btnBack:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *refBtnLogin;

@end

