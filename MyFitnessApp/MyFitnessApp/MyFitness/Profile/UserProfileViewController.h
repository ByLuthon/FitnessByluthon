//
//  UserProfileViewController.h
//  MyFitnessApp
//
//  Created by macmini on 09/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface UserProfileViewController : UIViewController
{
    
    IBOutlet UIView *subview_profile;
    __weak IBOutlet UIImageView *img_user;
    __weak IBOutlet UITableView *tbl;
}
- (IBAction)btnBacktapped:(id)sender;

@end
