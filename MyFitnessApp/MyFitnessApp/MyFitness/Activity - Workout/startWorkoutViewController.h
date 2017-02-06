//
//  startWorkoutViewController.h
//  MyFitnessApp
//
//  Created by macmini on 02/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"
#import "UzysImageCropperViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "ELCImagePickerHeader.h"


@interface startWorkoutViewController : UIViewController <UINavigationControllerDelegate, UIImagePickerControllerDelegate>
{
    
    
    __weak IBOutlet UILabel *lbl_goal;
    __weak IBOutlet UIView *view_goal;
    __weak IBOutlet UIView *subview_goal;
    __weak IBOutlet UIPickerView *picker;
    __weak IBOutlet UIButton *btn_goalCancel;
    __weak IBOutlet UIButton *btn_goalOK;
    
    __weak IBOutlet UIButton *btn_public;
    __weak IBOutlet UIButton *btn_private;
    __weak IBOutlet UIButton *btnAddImages;
    
    __weak IBOutlet UIView *view_location;
    __weak IBOutlet UIView *subview_location;
    __weak IBOutlet UIButton *btn_locationOK;
    __weak IBOutlet UIButton *btn_locationCancel;
    
    __weak IBOutlet UIDatePicker *date_picker;
    __weak IBOutlet UITextField *txt_startDate;
    __weak IBOutlet UITextField *txt_endDate;
    NSDate *startDate;
    
    NSMutableArray *arrGoal;
    
    BOOL isGoalpicker;
    BOOL isStartDate;
    
    int ActivityType;
}

@property (strong, nonatomic) IBOutlet UIScrollView *tokenscroll;
@property (nonatomic, retain) ALAssetsLibrary * assetsLibrary;

- (IBAction)back:(id)sender;
- (IBAction)goalTapped:(id)sender;
- (IBAction)startDate:(id)sender;
- (IBAction)endDate:(id)sender;
- (IBAction)cancelPicker:(id)sender;
- (IBAction)OkpickerTapped:(id)sender;
- (IBAction)locationTapped:(id)sender;
- (IBAction)addImage:(id)sender;
- (IBAction)friendsTapped:(id)sender;
- (IBAction)activityTypeTapped:(id)sender;

@end
