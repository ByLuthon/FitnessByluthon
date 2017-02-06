//
//  FriendsViewController.h
//  MyFitnessApp
//
//  Created by macmini on 04/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface FriendsViewController : UIViewController <UIScrollViewDelegate>
{
    
    __weak IBOutlet UIView *view_segment;
    __weak IBOutlet UILabel *lbl_underline;
    __weak IBOutlet UILabel *lbl_nearby;
    __weak IBOutlet UILabel *lbl_following;
    __weak IBOutlet UILabel *lbl_followers;
   
    __weak IBOutlet UIScrollView *scrl;
    __weak IBOutlet UITableView *tbl_nearby;
    __weak IBOutlet UITableView *tbl_following;
    __weak IBOutlet UITableView *tbl_followers;
}
- (IBAction)segmentTapped:(id)sender;
- (IBAction)btnBAck:(id)sender;

@end
