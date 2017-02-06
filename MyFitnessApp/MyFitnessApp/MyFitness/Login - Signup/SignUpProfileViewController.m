//
//  SignUpProfileViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 28/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "SignUpProfileViewController.h"
#import "CategoryViewController.h"

@interface SignUpProfileViewController ()

@end

@implementation SignUpProfileViewController

- (void)viewDidLoad {
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    [self SelectGender:kMALE];

    [_globalGDXData addBorderToView:2 color:RGBA(59, 67, 79, 1) cornerRadius:5 objView:_refBtnUserProfile];
    
    _txtFirstName.text = [UserDefaults objectForKey:kUserFirstName];
    _txtLastName.text=[UserDefaults objectForKey:kUserLastName];
    _txtEmail.text=[UserDefaults objectForKey:kUserEmail];

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (IBAction)btnContinue:(id)sender {
    
    if (image == nil)
    {
        [_globalGDXData showAlertTitle:@"" message:kAlertUploadCompalsary ViewControllerOBJ:self];
    }
    else
    {
        [UserDefaults setObject:UIImageJPEGRepresentation(image, 0.6) forKey:kUserProfilePicture];
        [UserDefaults setObject:GenderType forKey:kUserGender];
        [UserDefaults setObject:_txtEmail.text forKey:kUserEmail];
        [UserDefaults setObject:_txtFirstName.text forKey:kUserFirstName];
        [UserDefaults setObject:_txtLastName.text forKey:kUserLastName];

        CategoryViewController *categoryVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
        categoryVC.isCreateActivity = FALSE;
        [self.navigationController pushViewController:categoryVC animated:YES];
    }
}

- (IBAction)btnUserProfile:(id)sender {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
        
        UIImagePickerController* picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.mediaTypes = [NSArray arrayWithObjects:(NSString *)kUTTypeImage, nil];
        picker.allowsEditing = YES;
        picker.title=@"";
        picker.navigationBar.tintColor = kColorWhite;//Cancel button text color
        [picker.navigationBar setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:kColorClear, NSForegroundColorAttributeName, nil]];// title color
        [self presentViewController:picker animated:YES completion:nil];
    }
}

#pragma mark - UIImagePickerController Delegate Method
- (void)imagePickerController:(UIImagePickerController *)photoPicker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    image = [info objectForKey:UIImagePickerControllerEditedImage];
    [_refBtnUserProfile setImage:image forState:UIControlStateNormal];
    [photoPicker dismissViewControllerAnimated:YES completion:nil];
}

- (void)commsUploadImageComplete:(NSString *)strImgURL
{
    [HUD hide:YES];
    // Did the upload work ?
    if (![strImgURL isEqualToString:@""]) {
        
        // Using this i am able to update currnetUser Data in DB
        PFUser *user=[PFUser currentUser];
        [user setObject:strImgURL forKey:kUserProfilePicture];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error) {
            NSLog(@"%d",succeeded);
            
            CategoryViewController *categoryVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
            categoryVC.isCreateActivity = FALSE;
            [self.navigationController pushViewController:categoryVC animated:YES];
        }];
        
    }
    else
    {
        [_globalGDXData showAlertTitle:kAlertUploadError message:kAlertUploadError ViewControllerOBJ:self];
    }
}

- (void) commsUploadImageProgress:(short)progress
{
    NSLog(@"Uploaded: %d%%", progress);
}

- (IBAction)btnBack:(id)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)genderTapped:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    if (btn.tag == 1)
    {
        [self SelectGender:kMALE];
    }
    else
    {
        [self SelectGender:kFEMALE];
    }
}

-(void)SelectGender:(NSString *)type
{
    if ([type isEqualToString:kMALE])
    {
        btn_male.selected = TRUE;
        btn_female.selected = FALSE;
        
        GenderType = type;
    }
    else
    {
        btn_male.selected = FALSE;
        btn_female.selected = TRUE;
    }
}


@end
