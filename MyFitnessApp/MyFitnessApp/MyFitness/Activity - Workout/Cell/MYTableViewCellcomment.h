//
//  MYTableViewCell.h
//  NextBelt
//
//  Created by Bhavesh Nayi on 5/6/14.
//
//

#import <UIKit/UIKit.h>

@class AppDelegate;

@interface MYTableViewCellcomment : UITableViewCell 
{
    AppDelegate *app;
}
@property (strong, nonatomic) IBOutlet UILabel *lbl_BG;
@property (strong, nonatomic) IBOutlet UIImageView *img_user;
@property (strong, nonatomic) IBOutlet UILabel *lbl_username;
@property (strong, nonatomic) IBOutlet UILabel *lbl_time;
@property (strong, nonatomic) IBOutlet UILabel *lbl_cmt;

@property (strong, nonatomic) IBOutlet UIButton *btnUser;


@end
