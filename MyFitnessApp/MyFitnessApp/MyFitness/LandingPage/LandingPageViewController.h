//
//  LandingPageViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 28/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LandingPageViewController : UIViewController
{
    MBProgressHUD *HUD;
}
- (IBAction)btnLogin:(id)sender;
- (IBAction)btnSignUp:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *refBtnLogin;
@property (weak, nonatomic) IBOutlet UIButton *refBtnSignUp;
- (IBAction)btnFacebookLogin:(id)sender;

@end
