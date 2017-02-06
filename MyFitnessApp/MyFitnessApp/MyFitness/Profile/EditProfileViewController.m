//
//  EditProfileViewController.m
//  MyFitnessApp
//
//  Created by macmini on 04/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import "EditProfileViewController.h"

@interface EditProfileViewController ()

@end

@implementation EditProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnProfileTapped:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Add photo"
                                                             delegate:self
                                                    cancelButtonTitle:@"Cancel"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"Camera", @"Photo album", nil];
    [actionSheet showInView:self.view];
    actionSheet.tag = 10;
}
#pragma mark - actionSheet Delegates
- (void)willPresentActionSheet:(UIActionSheet *)actionSheet
{
    SEL selector = NSSelectorFromString(@"_alertController");
    if ([actionSheet respondsToSelector:selector])
    {
        UIAlertController *alertController = [actionSheet valueForKey:@"_alertController"];
        if ([alertController isKindOfClass:[UIAlertController class]])
        {
            //alertController.view.tintColor = HEX_COLOR(@"#5D5ACD");
        }
    }
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{

    if (actionSheet.tag == 10)
    {
        switch (buttonIndex)
        {
            case 0:
            {
                //[self openCamera];
            }
                break;
            case 1:
            {
                /*
                app.isCamera = FALSE;
                app.strSelectCameraFromELC = ELC_PublicMoment;
                
                app.isRotatePhoto = FALSE;
                [app animateWithShow:NO withView:view_addmoment];
                
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                picker.allowsEditing = NO;
                picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                picker.delegate = self;
                picker.navigationBar.tintColor = [UIColor redColor];
                [self presentViewController:picker animated:YES completion:nil];
                 */
                
            }
                break;
            default:
                break;
        }
    }

}


@end
