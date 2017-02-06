//
//  EditProfileViewController.h
//  MyFitnessApp
//
//  Created by macmini on 04/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditProfileViewController : UIViewController <UIActionSheetDelegate>
{
    __weak IBOutlet UIButton *btnProfile;
    __weak IBOutlet UITextField *txtFirstname;
    __weak IBOutlet UITextField *txtLastname;
    __weak IBOutlet UITextField *txtEmail;
    __weak IBOutlet UITextField *txtPassword;
    __weak IBOutlet UITextField *txtMobile;
}
- (IBAction)btnBack:(id)sender;
- (IBAction)btnProfileTapped:(id)sender;

@end
