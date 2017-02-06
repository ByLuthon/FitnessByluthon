//
//  startWorkoutViewController.m
//  MyFitnessApp
//
//  Created by macmini on 02/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import "startWorkoutViewController.h"

@interface startWorkoutViewController ()<ZFTokenFieldDataSource, ZFTokenFieldDelegate, UzysImageCropperDelegate>
{
    
}
@property (weak, nonatomic) IBOutlet ZFTokenField *tokenField;
@property (nonatomic, strong) NSMutableArray *tokens;

@property (nonatomic,retain) UzysImageCropperViewController *imgCropperViewController;
@property (nonatomic, strong) ALAssetsLibrary *specialLibrary;
@property (nonatomic, copy) NSArray *chosenImages;



@end

@implementation startWorkoutViewController

- (void)viewDidLoad
{
    [_globalGDXData animateWithShow:NO withView:view_goal];
    [_globalGDXData animateWithShow:NO withView:view_location];

    
    [self.view addSubview:view_goal];
    view_goal.frame = self.view.frame;
    view_goal.hidden = TRUE;
    
    [self.view addSubview:view_location];
    view_location.frame = self.view.frame;
    view_location.hidden = TRUE;

    [self setInitParam];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(operCameraPickerFromELC:) name:@"openCameraFromELCPicker" object:nil];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark - INIT
-(void)setInitParam
{

    //Goal
    arrGoal = [[NSMutableArray alloc] init];
    [arrGoal addObject:@"70 KGS"];
    [arrGoal addObject:@"80 KGS"];
    [arrGoal addObject:@"90 KGS"];
    [arrGoal addObject:@"100 KGS"];
    [arrGoal addObject:@"110 KGS"];
    [arrGoal addObject:@"120 KGS"];
    [arrGoal addObject:@"130 KGS"];
    [arrGoal addObject:@"140 KGS"];
    [arrGoal addObject:@"150 KGS"];
    [_globalGDXData addBorderToView:0.0 color:[UIColor lightGrayColor] cornerRadius:10.0 objView:subview_goal];
    
    
    //Location
    [_globalGDXData addBorderToView:0.0 color:[UIColor lightGrayColor] cornerRadius:10.0 objView:subview_location];

    //Camera icom
    [_globalGDXData addBorderToView:1.0 color:[UIColor lightGrayColor] cornerRadius:10.0 objView:btnAddImages ];

    
   //InviteFriends
    self.tokens = [NSMutableArray array];
    
    self.tokenField.dataSource = self;
    self.tokenField.delegate = self;
    self.tokenField.textField.placeholder = @"";
    
    [self.tokenField.textField becomeFirstResponder];
    
    [self.tokens addObject:@"Cory"];
    [self.tokens addObject:@"Amanda"];
    [self.tokens addObject:@"Ethan"];
    [self.tokens addObject:@"Eunice"];
    [self.tokens addObject:@"Jeffery"];
    [self.tokens addObject:@"Luna"];
    [self.tokens addObject:@"Florence"];
    [self.tokens addObject:@"Lydia"];
    [self.tokens addObject:@"Lisa"];
    [self.tokens addObject:@"Denis"];
    [self.tokens addObject:@"Martin"];
    [self.tokens addObject:@"Chloè"];
    [self.tokens addObject:@"Suzia"];
    [self.tokens addObject:@"Fortune"];
    [self.tokens addObject:@"Jeffery"];

    [self.tokenField reloadData];
        
    //Activity Type
    [self selectActivityType:1];

    [self setGapBetweenTextandImage:btn_public];
    [self setGapBetweenTextandImage:btn_private];

}
#pragma mark - Button specing

- (void)setGapBetweenTextandImage:(UIButton *)btn
{
    CGFloat spacing = 2; // the amount of spacing to appear between image and title
    btn.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 5, spacing);
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, spacing+5, 0, 0);
    [btn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
}

- (void)didReceiveMemoryWarning
{
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
- (IBAction)friendsTapped:(id)sender
{
    FriendsViewController * move = [self.storyboard instantiateViewControllerWithIdentifier:@"FriendsViewController"];
    [self.navigationController pushViewController:move animated:YES];
}

#pragma mark - Activity Type

- (IBAction)activityTypeTapped:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    //[self HideAllViewAndKeyBoard];
    [self selectActivityType:(int)btn.tag];
}

-(void)selectActivityType:(int)type
{
    if (type == 1)
    {
        btn_public.selected = TRUE;
        btn_private.selected = FALSE;
    }
    else if (type == 2)
    {
        btn_public.selected = FALSE;
        btn_private.selected = TRUE;
    }
    ActivityType = type;
}

#pragma mark - Textview Delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text;
{
    BOOL status = textView.text.length + (text.length - range.length) <= 170;
    
    if (status)
    {
        if([text isEqualToString:@"\n"])
        {
            [textView resignFirstResponder];
            
            return NO;
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
    
}

#pragma mark - ZFTokenField DataSource
- (CGFloat)lineHeightForTokenInField:(ZFTokenField *)tokenField
{
    return 35;
}

- (NSUInteger)numberOfTokenInField:(ZFTokenField *)tokenField
{
    return self.tokens.count;
}

- (UIView *)tokenField:(ZFTokenField *)tokenField viewForTokenAtIndex:(NSUInteger)index
{
    NSArray *nibContents = [[NSBundle mainBundle] loadNibNamed:@"TokenView" owner:nil options:nil];
    UIView *view = nibContents[0];
    UILabel *label = (UILabel *)[view viewWithTag:2];
    UIButton *button = (UIButton *)[view viewWithTag:3];
    
    [button addTarget:self action:@selector(tokenDeleteButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    label.text = self.tokens[index];
    CGSize size = [label sizeThatFits:CGSizeMake(1000, 30)];
    view.frame = CGRectMake(0, 0, size.width + 50, 30);
    return view;
}
- (void)tokenDeleteButtonPressed:(UIButton *)tokenButton
{
    NSUInteger index = [self.tokenField indexOfTokenView:tokenButton.superview];
    if (index != NSNotFound) {
        [self.tokens removeObjectAtIndex:index];
        [self.tokenField reloadData];
    }
}
- (void)getViewFrame:(CGRect)frame
{
    if ([self.tokens count] > 0)
    {
        //view_tokenfield.hidden = FALSE;
    }
    else
    {
        //view_tokenfield.hidden = TRUE;
    }
    _tokenscroll.contentSize = CGSizeMake(_tokenscroll.frame.size.width, frame.size.height-30);
}
#pragma mark - ZFTokenField Delegate

- (CGFloat)tokenMarginInTokenInField:(ZFTokenField *)tokenField
{
    return 5;
}

- (void)tokenField:(ZFTokenField *)tokenField didReturnWithText:(NSString *)text
{
    [self.tokens addObject:text];
    [tokenField reloadData];
}

- (void)tokenField:(ZFTokenField *)tokenField didRemoveTokenAtIndex:(NSUInteger)index
{
    [self.tokens removeObjectAtIndex:index];
}

- (BOOL)tokenFieldShouldEndEditing:(ZFTokenField *)textField
{
    return NO;
}


#pragma mark - HideShow picker

-(void)openPicker
{
    if (isGoalpicker)
    {
        date_picker.hidden = TRUE;
        picker.hidden = FALSE;
        
        [picker reloadAllComponents];
    }
    else
    {
        date_picker.hidden = FALSE;
        picker.hidden = TRUE;

    }
    [_globalGDXData animateWithShow:YES withView:view_goal];
}
-(void)HidePicker
{
    [_globalGDXData animateWithShow:NO withView:view_goal];
}
#pragma mark - Picker
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView
{
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arrGoal count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component;
{
    lbl_goal.text = [NSString stringWithFormat:@"%@",[arrGoal objectAtIndex:row]];
    
    [self HidePicker];
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arrGoal objectAtIndex:row];
}
- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view
{
    UILabel *retval = (id)view;
    if (!retval)
    {
        retval= [[UILabel alloc] initWithFrame:CGRectMake(0.0f, 0.0f, [pickerView rowSizeForComponent:component].width, [pickerView rowSizeForComponent:component].height)];
    }
    retval.textAlignment = NSTextAlignmentCenter;
    retval.textColor=[UIColor blackColor];
    retval.font = setFontMedium(16);
    retval.text = [NSString stringWithFormat:@"%@",[arrGoal objectAtIndex:row]];
    return retval;
}

#pragma mark - view touch
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event;
{
    [_globalGDXData animateWithShow:NO withView:view_location];
    [self HidePicker];
}
#pragma mark - GOAL

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)goalTapped:(id)sender
{
    isGoalpicker = TRUE;
    [self openPicker];
}

- (IBAction)startDate:(id)sender
{
    date_picker.minimumDate = nil;

    isGoalpicker = FALSE;
    isStartDate = TRUE;
    [self openPicker];
}

- (IBAction)endDate:(id)sender
{
    date_picker.minimumDate = startDate;
    
    isGoalpicker = FALSE;
    isStartDate = FALSE;
    [self openPicker];
}

- (IBAction)cancelPicker:(id)sender
{
    [self HidePicker];
}

- (IBAction)OkpickerTapped:(id)sender
{
    [self HidePicker];

    if (!isGoalpicker)
    {
        /*
        if ([self isEndDateIsSmallerThanCurrent:date_picker.date])
        {
            //12/12/2015
            NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
            dateFormat.dateStyle=NSDateFormatterMediumStyle;
            [dateFormat setDateFormat:@"MMM dd, hh:MM a"];
            //NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datepicker.date]];
            
            NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
            [dateFormat setLocale:usLocale];
            NSString *dateString = [dateFormat stringFromDate:date_picker.date];
            
            if (isStartDate)
            {
                txt_startDate.text = dateString;
                startDate = date_picker.date;
            }
            else
            {
                txt_endDate.text = dateString;
                startDate = nil;
            }

        }
        else
        {
            if (isStartDate)
            {
                [[iToast makeText:@"Start date must be earlier than current date"] show];
            }
            else
            {
                [[iToast makeText:@"End date must be earlier than current date"] show];
            }
        }
         */
        //12/12/2015
        NSDateFormatter *dateFormat=[[NSDateFormatter alloc]init];
        dateFormat.dateStyle=NSDateFormatterMediumStyle;
        [dateFormat setDateFormat:@"MMM dd, hh:mm a"];
        //NSString *str=[NSString stringWithFormat:@"%@",[dateFormat  stringFromDate:datepicker.date]];
        
        NSLocale *usLocale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
        [dateFormat setLocale:usLocale];
        NSString *dateString = [dateFormat stringFromDate:date_picker.date];
        
        if (isStartDate)
        {
            txt_startDate.text = dateString;
            startDate = date_picker.date;
        }
        else
        {
            txt_endDate.text = dateString;
            startDate = nil;
        }

        [self HidePicker];
    }
}

- (BOOL)isEndDateIsSmallerThanCurrent:(NSDate *)checkEndDate
{
    NSDate* enddate = checkEndDate;
    NSDate* currentdate = [NSDate date];
    NSTimeInterval distanceBetweenDates = [enddate timeIntervalSinceDate:currentdate];
    
    if (distanceBetweenDates < 0)
        return NO;
    else
        return YES;
}

#pragma mark - Location

- (IBAction)locationTapped:(id)sender
{
    [_globalGDXData animateWithShow:YES withView:view_location];
}

#pragma mark - displayPickerForGroup

- (IBAction)addImage:(id)sender
{
    ALAssetsLibrary *library = [[ALAssetsLibrary alloc] init];
    self.specialLibrary = library;
    NSMutableArray *groups = [NSMutableArray array];
    [_specialLibrary enumerateGroupsWithTypes:ALAssetsGroupSavedPhotos usingBlock:^(ALAssetsGroup *group, BOOL *stop)
     {
         if (group)
         {
             [groups addObject:group];
         } else {
             // this is the end
             [self displayPickerForGroup:[groups objectAtIndex:0]];
         }
     } failureBlock:^(NSError *error)
     {
         self.chosenImages = nil;
         
         NSString *alertText;
         NSString *alertButton;
         
         BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
         if (canOpenSettings)
         {
             alertText = @"It looks like your privacy settings are preventing us from accessing your camera. You can fix this by doing the following:\n\n1. Touch the Go button below to open the Settings app.\n\n2. Touch Privacy.\n\n3. Turn the Camera on.\n\n4. Open this app and try again.";
             alertButton = @"Ok";
         }
         else
         {
             alertText = @"It looks like your privacy settings are preventing us from accessing your camera. You can fix this by doing the following:\n\n1. Touch the Go button below to open the Settings app.\n\n2. Touch Privacy.\n\n3. Turn the Camera on.\n\n4. Open this app and try again.";
             alertButton = @"Ok";
         }
         
         UIAlertView *alert = [[UIAlertView alloc]
                               initWithTitle:@"Error"
                               message:alertText
                               delegate:self
                               cancelButtonTitle:alertButton
                               otherButtonTitles:nil];
         alert.tag = 3491832;
         [alert show];
         
     }];
}



- (void)displayPickerForGroup:(ALAssetsGroup *)group
{
    ELCAssetTablePicker *tablePicker = [[ELCAssetTablePicker alloc] initWithStyle:UITableViewStylePlain];
    tablePicker.singleSelection = YES;
    tablePicker.immediateReturn = YES;
    
    //ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initWithRootViewController:tablePicker];
    ELCImagePickerController *elcPicker = [[ELCImagePickerController alloc] initImagePicker];
    elcPicker.maximumImagesCount = 1;
    elcPicker.imagePickerDelegate = self;
    elcPicker.returnsOriginalImage = YES; //Only return the fullScreenImage, not the fullResolutionImage
    elcPicker.returnsImage = YES; //Return UIimage if YES. If NO, only return asset location information
    elcPicker.onOrder = NO; //For single image selection, do not display and return order of selected images
    tablePicker.parent = elcPicker;
    
    // Move me
    tablePicker.assetGroup = group;
    [tablePicker.assetGroup setAssetsFilter:[ALAssetsFilter allAssets]];
    
    [self presentViewController:elcPicker animated:YES completion:nil];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (alertView.tag == 3491832)
    {
        BOOL canOpenSettings = (&UIApplicationOpenSettingsURLString != NULL);
        if (canOpenSettings)
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:UIApplicationOpenSettingsURLString]];
    }
}


-(void)operCameraPickerFromELC:(NSNotification *)notify
{
    [self openCamera];
}
#pragma mark - Camera/gallery
-(void)openCamera
{
    UIImagePickerController *imagepicker = [[UIImagePickerController alloc] init];
    imagepicker.allowsEditing = NO;
    imagepicker.sourceType = UIImagePickerControllerSourceTypeCamera;
    imagepicker.delegate = self;
    imagepicker.navigationBar.tintColor = [UIColor redColor];
    [self presentViewController:imagepicker animated:YES completion:nil];
}

#pragma mark - ELCImagePickerControllerDelegate Methods

- (void)elcImagePickerController:(ELCImagePickerController *)picker didFinishPickingMediaWithInfo:(NSArray *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage* image;
    NSMutableArray *images = [NSMutableArray arrayWithCapacity:[info count]];
    for (NSDictionary *dict in info)
    {
        if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypePhoto)
        {
            if ([dict objectForKey:UIImagePickerControllerOriginalImage])
            {
                //image = [dict objectForKey:UIImagePickerControllerOriginalImage];
                
                image = [self normalizedImage:[dict objectForKey:UIImagePickerControllerOriginalImage]];
                
            }
            else
            {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }
        else if ([dict objectForKey:UIImagePickerControllerMediaType] == ALAssetTypeVideo)
        {
            if ([dict objectForKey:UIImagePickerControllerOriginalImage])
            {
                image=[dict objectForKey:UIImagePickerControllerOriginalImage];
            }
            else
            {
                NSLog(@"UIImagePickerControllerReferenceURL = %@", dict);
            }
        }
        else
        {
            NSLog(@"Uknown asset type");
        }
    }
    
    
    //[app animateWithShow:YES withView:view_addmoment];
    //[btn_addimage setImage:image forState:UIControlStateNormal];
    
    self.chosenImages = images;
    
    
    UIImage *scaledImage;
    if (image.size.width > (WIDTH * 2))
    {
        scaledImage = [self resizeImage:image];
    }
    else
    {
        scaledImage = image;
    }
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Perform long running process
        
        NSMutableArray *arrImgs = [[NSMutableArray alloc]init];
        [arrImgs addObject:scaledImage];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            _imgCropperViewController = [[UzysImageCropperViewController alloc] initWithImage:[arrImgs objectAtIndex:0] andframeSize:CGSizeMake(WIDTH, HEIGHT) andcropSize:CGSizeMake(WIDTH,(WIDTH * 1.26)) arrImages:arrImgs isFrmAddItemVC:NO screenName:@""];
            
            _imgCropperViewController.delegate = self;
            
            [self.navigationController presentViewController:_imgCropperViewController animated:YES completion:nil];
        });
    });
}

- (void)elcImagePickerControllerDidCancel:(ELCImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UIImage *)resizeImage:(UIImage *)foregroundimage
{
    UIImage *image = foregroundimage; // SomeImage-900x675.png
    CGFloat targetWidth = WIDTH*2;
    
    CGFloat scaleFactor = targetWidth / image.size.width;
    CGFloat targetHeight = image.size.height * scaleFactor;
    CGSize targetSize = CGSizeMake(targetWidth, targetHeight);
    
    return [image resizedImage:targetSize interpolationQuality:kCGInterpolationHigh];
}
-(UIImage *)normalizedImage:(UIImage *) thisImage
{
    if (thisImage.imageOrientation == UIImageOrientationUp) return thisImage;
    
    UIGraphicsBeginImageContextWithOptions(thisImage.size, NO, thisImage.scale);
    [thisImage drawInRect:(CGRect){0, 0, thisImage.size}];
    UIImage *normalizedImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return normalizedImage;
}

#pragma mark - UzysImageCropperViewControllerDelegate Methods

- (void)imageCropper:(UzysImageCropperViewController *)cropper didFinishCroppingWithImage:(UIImage *)image;
{
    [cropper dismissViewControllerAnimated:YES completion:nil];
    
    [btnAddImages setImage:image forState:UIControlStateNormal];
    
}
- (void)imageCropperDidCancel:(UzysImageCropperViewController *)cropper
{
    [cropper dismissViewControllerAnimated:YES completion:nil];
}
# pragma mark UIImagePickerDelegate Methods
-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    
    UIImage* tmpImage = [self normalizedImage:[info objectForKey:UIImagePickerControllerOriginalImage]];
    
    UIImage *scaledImage;
    
    NSMutableDictionary * tmpInfo =[info mutableCopy];
    NSMutableDictionary* metaData = [[tmpInfo objectForKey:@"UIImagePickerControllerMediaMetadata"] mutableCopy];
    
    [metaData setObject:[NSNumber numberWithInt:0] forKey:@"Orientation"];
    [tmpInfo setObject:tmpImage forKey:@"UIImagePickerControllerOriginalImage"];
    [tmpInfo setObject:metaData forKey:@"UIImagePickerControllerMediaMetadata"];
    
    info = tmpInfo;
    
    scaledImage =  [info objectForKey:UIImagePickerControllerOriginalImage];
    
    
    UIImage *image;
    if (scaledImage.size.width > (WIDTH * 2))
    {
        image = [self resizeImage:scaledImage];
    }
    else
    {
        image = scaledImage;
    }
    
    
    //self.chosenImages = images;
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        // Perform long running process
        
        NSMutableArray *arrImgs = [[NSMutableArray alloc]init];
        [arrImgs addObject:image];
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            _imgCropperViewController = [[UzysImageCropperViewController alloc] initWithImage:[arrImgs objectAtIndex:0] andframeSize:CGSizeMake(WIDTH, HEIGHT) andcropSize:CGSizeMake(WIDTH,(WIDTH * 1.26)) arrImages:arrImgs isFrmAddItemVC:NO screenName:@""];
            
            _imgCropperViewController.delegate = self;
            
            [self.navigationController presentViewController:_imgCropperViewController animated:YES completion:nil];
            
        });
    });
    
}
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    //[app animateWithShow:NO withView:view_addmoment];
    
    [picker dismissViewControllerAnimated:YES completion:nil];
}

@end
