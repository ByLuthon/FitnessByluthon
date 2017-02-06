//
//  HomeViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 23/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface HomeViewController : UIViewController <UIScrollViewDelegate>
{
    
    __weak IBOutlet UIScrollView *scrl;
    __weak IBOutlet UILabel *lbl_previous;
    __weak IBOutlet UILabel *lbl_now;
    __weak IBOutlet UILabel *lbl_upcoming;
    __weak IBOutlet UILabel *lbl_underline;

    __weak IBOutlet UITableView *tbl_previous;
    __weak IBOutlet UITableView *tbl_now;
    __weak IBOutlet UITableView *tbl_upcoming;
    
    __weak IBOutlet UIView *view_matchfound;
    __weak IBOutlet UIImageView *img_matchuserlogo;
    __weak IBOutlet UILabel *lbl_matchuserbg;
    __weak IBOutlet UILabel *lbl_matchfound;
    __weak IBOutlet UIView *subview_user1;
    __weak IBOutlet UIImageView *img1;
    __weak IBOutlet UIImageView *img_check1;
    __weak IBOutlet UIView *subview_user2;
    __weak IBOutlet UIImageView *img2;
    __weak IBOutlet UIImageView *img_check2;
    __weak IBOutlet UIButton *btn_chat_match;
    __weak IBOutlet UIButton *btn_home;
    __weak IBOutlet UIView *view_chat;
    __weak IBOutlet UIView *view_home;

}
- (IBAction)tabTapped:(id)sender;
- (IBAction)btnCreateActivity:(id)sender;
- (IBAction)btnViewProfile:(id)sender;

- (IBAction)chatTapped:(id)sender;
- (IBAction)homeTapped:(id)sender;


@property (weak, nonatomic) IBOutlet UIButton *refBtnCreateActivity;

@end
