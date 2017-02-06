//
//  ActivityDetailsViewController.h
//  MyFitnessApp
//
//  Created by macmini on 05/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "A3ParallaxScrollView.h"
#import "ISEmojiView.h"


@interface ActivityDetailsViewController : UIViewController <UIScrollViewDelegate, ISEmojiViewDelegate>
{
    
    IBOutlet UIImageView *img_activity;
    IBOutlet UIView *subview_activity;

    __weak IBOutlet UILabel *lbl_activityTitle;
    
    __weak IBOutlet UIView *subview_joinusers;
    __weak IBOutlet UIScrollView *scrl_JoinUsers;
    
    __weak IBOutlet UITableView *tbl_comment;
    
    __weak IBOutlet UIView *viewAddComment;
    __weak IBOutlet UILabel *lbl_placeholder;
    __weak IBOutlet UITextView *txtview_comment;
    __weak IBOutlet UIButton *btn_emoji;
    
    ISEmojiView *emojiView;
    BOOL isEmojiTapped;

    
    float keyboardHeight;
}
@property (nonatomic, retain) A3ParallaxScrollView *parallaxScrollView;

- (IBAction)btnBack:(id)sender;
- (IBAction)btnEmojiTapped:(id)sender;

@end
