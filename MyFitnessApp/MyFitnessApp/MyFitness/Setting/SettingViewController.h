//
//  SettingViewController.h
//  MyFitnessApp
//
//  Created by macmini on 04/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface SettingViewController : UIViewController
{
    NSMutableArray *ArrData_notification;
    NSMutableArray *ArrData_Account;

    __weak IBOutlet UITableView *tbl;
}
- (IBAction)back:(id)sender;

@end
