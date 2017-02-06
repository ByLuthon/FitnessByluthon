//
//  MyProfileViewController.h
//  MyFitnessApp
//
//  Created by macmini on 04/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyProfileViewController : UIViewController
{
    
    __weak IBOutlet UITableView *tbl;
    __weak IBOutlet UIView *view_userInfo;
    __weak IBOutlet UIImageView *img_user;
    __weak IBOutlet UIButton *btn_editProfile;
    __weak IBOutlet UILabel *lbl_Activity;
    __weak IBOutlet UILabel *lbl_friends;
}
- (IBAction)btnBacktapped:(id)sender;
- (IBAction)Setting:(id)sender;
- (IBAction)editProfileTapped:(id)sender;
- (IBAction)activityTapped:(id)sender;
- (IBAction)friendsTapped:(id)sender;

@end
