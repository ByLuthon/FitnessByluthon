//
//  CreateActivityViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 08/12/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "CreateActivityViewController.h"

@interface CreateActivityViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UzysImageCropperDelegate>

@property (nonatomic,retain) UzysImageCropperViewController *imgCropperViewController;

@property (nonatomic, strong) ALAssetsLibrary *specialLibrary;
@property (nonatomic, copy) NSArray *chosenImages;

@end

@implementation CreateActivityViewController

- (void)viewDidLoad
{

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(operCameraPickerFromELC:) name:@"openCameraFromELCPicker" object:nil];
    
    [super viewWillAppear:animated];
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

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)openELC:(NSNotification *)notify
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


-(void)operCameraPickerFromELC:(NSNotification *)notify
{
    [self openCamera];
}
#pragma mark - Camera/gallery
-(void)openCamera
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    picker.allowsEditing = NO;
    picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    picker.delegate = self;
    picker.navigationBar.tintColor = [UIColor redColor];
    [self presentViewController:picker animated:YES completion:nil];
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
    
    CategoryViewController *categoryVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
    categoryVC.isCreateActivity = TRUE;
    [self.navigationController pushViewController:categoryVC animated:YES];

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
