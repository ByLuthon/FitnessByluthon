//
//  UzysImageCropperViewController.m
//  UzysImageCropper
//
//  Created by Uzys on 11. 12. 13..
//

#import "UzysImageCropperViewController.h"
#import "UIImage-Extension.h"
#import "AppDelegate.h"

/*
@interface UzysImageCropperViewController ()<addPostDelegate>
{
    AppDelegate *appDel;
    AddItemViewController *objAddItemVC;
    UIButton *btnDone;
}
@end
*/
@implementation UzysImageCropperViewController
@synthesize cropperView,delegate,arrImages,strScreenName,strRatesId,GetDetailsDict,isRequestScreen,strScreen;

- (id)initWithImage:(UIImage*)newImage andframeSize:(CGSize)frameSize andcropSize:(CGSize)cropSize arrImages:(NSMutableArray *)array isFrmAddItemVC:(BOOL)isFromAddItemVC screenName:(NSString *)strViewName
{
    self = [super init];
	
	if (self)
    {
        self.strScreen = strViewName;
        
        self.view.frame = CGRectMake(0, 0, WIDTH, HEIGHT);
        self.view.backgroundColor = [UIColor blackColor];
        
        app = (AppDelegate *)[UIApplication sharedApplication].delegate;
        self.arrImages = array;
        idxOfSelImage = 0;

        newImage = [self.arrImages objectAtIndex:0];
        
        newImage = [newImage resizedImageToFitInSize:CGSizeMake(cropSize.width, cropSize.height) scaleIfSmaller:YES];

        /*
        if (app.isCamera)
        {
            newImage = [newImage resizedImageToFitInSize:CGSizeMake(cropSize.width, cropSize.height) scaleIfSmaller:YES];
        }
        else
        {
            newImage = [newImage resizedImageToFitInSize:CGSizeMake(newImage.size.width, newImage.size.height) scaleIfSmaller:YES];
        }
        */
        self.view.backgroundColor = [UIColor blackColor];
        cropperView = [[UzysImageCropper alloc] initWithImage:newImage andframeSize:frameSize andcropSize:cropSize];
        
        //[app setBorderToView:cropperView withBorderWidth:1 radious:cropperView.frame.size.height/2 color:[UIColor whiteColor]];
        
        NSString *str_Check = [[NSUserDefaults standardUserDefaults]valueForKey:@"SetCropImageInCropperView"];

        self.view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:cropperView];

        if ([str_Check isEqualToString:@"1"])
        {

        }
        else
        {
            img_bg_view = [[UIView alloc] initWithFrame:self.view.frame];
            img_bg_view.backgroundColor = [UIColor blackColor];
            img_bg_view.alpha = 0.6;
            
            UIImageView *img_cropper = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 51, 73)];
            img_cropper.image = [UIImage imageNamed:@"gester_zoom_profile.png"];
            [img_bg_view addSubview:img_cropper];
            img_cropper.center = cropperView.center;
            img_cropper = nil;
            
            [NSTimer scheduledTimerWithTimeInterval:2.0 target:self selector:@selector(aTime) userInfo:nil repeats:NO];
            
            [self.view addSubview:img_bg_view];

        }

        
        int viewHeight = cropperView.hei;
        
        view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, viewHeight)];
        view.backgroundColor = [UIColor blackColor];
        [self.view addSubview:view];
        
        [self.view bringSubviewToFront:view];
        
        
        
        UILabel *lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 25, WIDTH, 22)];
        lblTitle.textColor = [UIColor whiteColor];
        lblTitle.text = @"Please resize your photo to fit the frame";
        lblTitle.font = [UIFont fontWithName:@"HelveticaNeue-Medium" size:14];
        lblTitle.textAlignment = NSTextAlignmentCenter;
        [view addSubview:lblTitle];

        UIView *BottomView = [[UIView alloc] initWithFrame:CGRectMake(0, HEIGHT-50, WIDTH, 50)];
        BottomView.backgroundColor = [UIColor blackColor];

        
        UIButton *btnDone = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnDone setFrame:CGRectMake(WIDTH - 80 , 5 , 75, 40)];
        [_globalGDXData addBorderToView:0 color:[UIColor clearColor] cornerRadius:5.0 objView:btnDone];
        [[btnDone titleLabel] setFont:[UIFont boldSystemFontOfSize:16]];
        [[btnDone titleLabel] setShadowOffset:CGSizeMake(0, -1)];
        [btnDone setTitle:@"Done" forState:UIControlStateNormal];
        [btnDone setBackgroundColor:[UIColor purpleColor]];
        [btnDone setTitleShadowColor:[UIColor colorWithRed:0.118 green:0.247 blue:0.455 alpha:1] forState:UIControlStateNormal];
        [btnDone  addTarget:self action:@selector(_actionUse) forControlEvents:UIControlEventTouchUpInside];
        [BottomView addSubview:btnDone];

        
        /*
        viewBottom = [[UIView alloc]initWithFrame:CGRectMake(0,viewHeight+(WIDTH*Image_Height)+2, WIDTH, (HEIGHT - (viewHeight+(WIDTH*Image_Height))))];
        viewBottom.backgroundColor = [UIColor blackColor];
        [self.view addSubview:viewBottom];
        scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 10, WIDTH, 70)];
        scrollView.contentSize = CGSizeMake(400, 70);
        [viewBottom addSubview:scrollView];
        
        [self performSelector:@selector(setUpImages) withObject:nil afterDelay:1.0];
         */
        

        UIButton *btn_rotation = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_rotation.titleLabel.font = setFont(16);
        [btn_rotation setFrame:CGRectMake(WIDTH/2 - 19 , 10 , 38, 39)];
        [btn_rotation addTarget:self action:@selector(actionRotation:) forControlEvents:UIControlEventTouchUpInside];
        [btn_rotation setImage:[UIImage imageNamed:@"rotate.png"] forState:UIControlStateNormal];
        [btn_rotation setImage:[UIImage imageNamed:@"rotate.png"] forState:UIControlStateHighlighted];
        btn_rotation.alpha = 1.0;
        [BottomView addSubview:btn_rotation];

        
        UIButton *btn_Cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        [btn_Cancel setFrame:CGRectMake(10 , 5 , 75, 40)];
        [_globalGDXData addBorderToView:0 color:[UIColor clearColor] cornerRadius:5.0 objView:btn_Cancel];
        [[btn_Cancel titleLabel] setFont:[UIFont boldSystemFontOfSize:16]];
        [[btn_Cancel titleLabel] setShadowOffset:CGSizeMake(0, -1)];
        [btn_Cancel setTitle:@"cancel" forState:UIControlStateNormal];
        [btn_Cancel setBackgroundColor:[UIColor purpleColor]];
        [btn_Cancel setTitleShadowColor:[UIColor colorWithRed:0.118 green:0.247 blue:0.455 alpha:1] forState:UIControlStateNormal];
        [btn_Cancel  addTarget:self action:@selector(_actionCancel) forControlEvents:UIControlEventTouchUpInside];
        [BottomView addSubview:btn_Cancel];

        
        [self.view addSubview:BottomView];
        [self.view bringSubviewToFront:BottomView];
        
        /*
        UIButton *btn_Crop = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_Crop.titleLabel.font = setFont(16);
        [btn_Crop setFrame:CGRectMake(viewBottom.frame.size.width -70 , viewBottom.frame.size.height - 40 , 60, 35)];
        [btn_Crop addTarget:self action:@selector(finishCropping) forControlEvents:UIControlEventTouchUpInside];
        [btn_Crop setImage:[UIImage imageNamed:@"crop.png"] forState:UIControlStateNormal];
        [btn_Crop setImage:[UIImage imageNamed:@"crop.png"] forState:UIControlStateHighlighted];
        btn_Crop.alpha = 1.0;
        [viewBottom addSubview:btn_Crop];
         */
        
    }
    return self;    
}

-(void)aTime
{
    [img_bg_view removeFromSuperview];
    
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"SetCropImageInCropperView"];
    [[NSUserDefaults standardUserDefaults] setValue:@"1" forKey:@"SetCropImageInCropperView"];
    [[NSUserDefaults standardUserDefaults] synchronize];
}


-(void)setUpImages
{
    int x = 5;
    
    for (int i = 0; i < arrImages.count; i++)
    {
        UIButton *btnImg = [UIButton buttonWithType:UIButtonTypeCustom];
        
        [btnImg setImage:[arrImages objectAtIndex:i] forState:UIControlStateNormal];
        [btnImg setImage:[arrImages objectAtIndex:i] forState:UIControlStateSelected];
        [btnImg setImage:[arrImages objectAtIndex:i] forState:UIControlStateHighlighted];

        [[btnImg imageView] setContentMode: UIViewContentModeScaleAspectFit];
        
        btnImg.backgroundColor = [UIColor whiteColor];
        
        btnImg.frame= CGRectMake(x, 5, 60, (60 * 1.26));
        btnImg.tag = i;
        [btnImg addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        
        if (btnImg.tag == 0)
        {
            btnImg.layer.borderColor = [[UIColor darkGrayColor] CGColor];
            btnImg.layer.borderWidth = 2.0;
            
        }
        
        [scrollView addSubview:btnImg];
        x = x + 65;
    }
    
   // btnDone.enabled = YES;
}
-(IBAction)btnClick:sender
{
    UIButton *btn = sender;
    
    if (btn.tag == idxOfSelImage)
    {
        return;
    }
    
    for (UIView *v in scrollView.subviews) {
        
        if ([v isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)v;
            btn.layer.borderColor = [[UIColor clearColor] CGColor];
            btn.layer.borderWidth = 0.0;
        }
    }
    
   
    btn.layer.borderColor = [[UIColor darkGrayColor] CGColor];
    btn.layer.borderWidth = 2.0;
    
    [cropperView removeFromSuperview];
    cropperView = nil;
    
    UIImage * newImage = btn.imageView.image;
    
    CGSize cropSize = CGSizeMake(WIDTH, (WIDTH * 1.26));
    newImage = [newImage resizedImageToFitInSize:CGSizeMake(cropSize.width, cropSize.height) scaleIfSmaller:NO];
    
    self.view.backgroundColor = [UIColor blackColor];
    cropperView = [[UzysImageCropper alloc]
                   initWithImage:newImage
                   andframeSize:CGSizeMake(WIDTH, HEIGHT)
                   andcropSize:cropSize];
    [self.view addSubview:cropperView];
    
    [self.view bringSubviewToFront:view];
    [self.view bringSubviewToFront:viewBottom];
    idxOfSelImage = (int)btn.tag;
}
-(void) actionRestore:(id) senders
{
    [cropperView actionRestore];
}
-(void) actionRotation:(id) senders
{
    [cropperView actionRotate];
    [self performSelector:@selector(cropImage) withObject:nil afterDelay:0.5];
}
-(void)cropImage
{
    UIImage *cropped =[cropperView getCroppedImage];
    
    for (UIView *v in scrollView.subviews) {
        
        if ([v isKindOfClass:[UIButton class]])
        {
            UIButton *btn = (UIButton *)v;
            if (btn.tag == idxOfSelImage)
            {
                [btn setImage:cropped forState:UIControlStateNormal];
            }
        }
    }
}
- (void)cancelCropping
{
  //  [[NSNotificationCenter defaultCenter] postNotificationName:@"setFrame_Contest" object:nil userInfo:nil];
	[self.delegate imageCropperDidCancel:self];
}
-(IBAction)DoneTapped:(id)sender
{
//    [self dismissViewControllerAnimated:YES completion:nil];
  
    [APP_DELEGATE.navigationControllerAppDelegate dismissViewControllerAnimated:YES completion:nil];
    
    /*
        NSMutableArray *arrPhotos = [[NSMutableArray alloc]init];
        
        for (int i = 0; i < arrImages.count; i++)
        {
            for (UIView *btnView in scrollView.subviews)
            {
                if ([btnView isKindOfClass:[UIButton class]]) {
                    
                    UIButton *btn = (UIButton *)btnView;
                    
                    if (btn.tag == i)
                    {
                        [arrPhotos addObject:btn.imageView.image];
                        break;
                    }
                    
                }
            }
        }
        
        AddItemViewController *addItemVC = [[AddItemViewController alloc]initWithNibName:@"AddItemViewController" bundle:nil];
        addItemVC.delegate = self;
        addItemVC.ImgArr = arrPhotos;
        addItemVC.StrCheckScreen = strScreen;
        addItemVC.strRatersID = strRatesId;
        addItemVC.GetClosetDict = GetDetailsDict;
        addItemVC.isFromReqRateAndParticipate = isRequestScreen;
        [appDel.navigationController pushViewController:addItemVC animated:YES];
        */

}

- (void)_actionCancel
{
    [self.delegate imageCropperDidCancel:self];
}

- (void)_actionUse
{
    UIImage *cropped =[cropperView getCroppedImage];

    [self.delegate imageCropper:self didFinishCroppingWithImage:cropped];
   // [app.navigation dismissViewControllerAnimated:YES completion:nil];
}

- (void)finishCropping
{
    UIImage *cropped =[cropperView getCroppedImage];
    
    [cropperView removeFromSuperview];
    cropperView = [[UzysImageCropper alloc]
                   initWithImage:cropped
                   andframeSize:self.view.frame.size
                   andcropSize:CGSizeMake(WIDTH, (WIDTH * 1.26))];
    [self.view addSubview:cropperView];

    [self.view bringSubviewToFront:view];
    [self.view bringSubviewToFront:viewBottom];
    
    for (UIView *v in scrollView.subviews) {
        
                if ([v isKindOfClass:[UIButton class]])
                {
                    UIButton *btn = (UIButton *)v;
                    if (btn.tag == idxOfSelImage)
                    {
        
                        [btn setImage:cropped forState:UIControlStateNormal];
                        
                    }
                }
            }

    
//	[delegate imageCropper:self didFinishCroppingWithImage:cropped];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle
// Implement loadView to create a view hierarchy programmatically, without using a nib.
//- (void)loadView
//{
// 
//
//}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.cropperView = nil;
    
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [cropperView release];
    [super ah_dealloc];
}
@end
