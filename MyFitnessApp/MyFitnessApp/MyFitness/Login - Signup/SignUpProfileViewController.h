//
//  SignUpProfileViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 28/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SignUpProfileViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate,CommsDelegate>
{
    NSData *userPhotoData;
    UIImage *image;
    MBProgressHUD *HUD;
    
    NSString *GenderType;
    
    __weak IBOutlet UIButton *btn_male;
    __weak IBOutlet UIButton *btn_female;
}
- (IBAction)genderTapped:(id)sender;


@property (weak, nonatomic) IBOutlet UITextField *txtFirstName;
@property (weak, nonatomic) IBOutlet UITextField *txtLastName;
@property (weak, nonatomic) IBOutlet UITextField *txtEmail;
- (IBAction)btnContinue:(id)sender;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnUserProfile:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *refBtnUserProfile;

@end
