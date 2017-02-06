//
//  FitnessViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 18/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "FitnessViewController.h"
#import "WorkoutCVCell.h"
#import "HomeViewController.h"

@interface FitnessViewController ()

@end

@implementation FitnessViewController
@synthesize selectedCategoryArray,isCreateActivity,webrequest;

- (void)viewDidLoad {
    
    fitnessArray=[[NSMutableArray alloc] init];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"CategoryList" ofType:@"plist"];
    // Load the file content and read the data into arrays
    NSDictionary *dict = [[NSDictionary alloc] initWithContentsOfFile:path];
    
    fitnessArray=[[NSMutableArray alloc] init];
    for (int i=0; i < [selectedCategoryArray count]; i++) {
        
        NSMutableArray *arraySubData=[dict objectForKey:[selectedCategoryArray objectAtIndex:i]];
        for (int j=0; j <[arraySubData count]; j++) {
            [fitnessArray addObject:[arraySubData objectAtIndex:j]];
        }
    }
  
    webrequest = [[WebService alloc] init];
    webrequest.delegate = self;

    /*
    NSMutableArray *arraySubData=[dict objectForKey:@"Family"];
    for (int j=0; j <[arraySubData count]; j++) {
        [fitnessArray addObject:[arraySubData objectAtIndex:j]];
    }*/
    
    
    NSLog(@"%@",fitnessArray);
    
    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    _refBtnDone.alpha=0.5;
    _refBtnDone.enabled=false;
    
    [self.collectionViewAddWorkout registerClass:[WorkoutCVCell class] forCellWithReuseIdentifier:@"WorkoutCVCell"];
    
    imgArray=[[NSMutableArray alloc] initWithObjects:@"cycling.png",@"running.png",@"Golf.png",@"core.png",@"tennis.png",@"gym.png",@"walking.png",@"soccer.png",@"sailing.png",@"boxing.png",@"hiking.png",@"triathlon.png",@"gym.png",@"Golf.png",@"walking.png",@"soccer.png",@"sailing.png",@"cycling.png",@"running.png",@"Golf.png",@"core.png",@"tennis.png",@"gym.png",@"walking.png",@"soccer.png",@"sailing.png",@"boxing.png",@"hiking.png",@"triathlon.png",@"cycling.png",@"running.png",@"Golf.png",@"core.png",@"tennis.png",@"gym.png",@"walking.png",@"soccer.png",@"sailing.png",@"boxing.png",@"hiking.png",@"triathlon.png",@"cycling.png",@"running.png",@"Golf.png",@"core.png",@"tennis.png",@"gym.png",@"walking.png",@"soccer.png",@"sailing.png",@"boxing.png",@"hiking.png",@"triathlon.png",@"cycling.png",@"running.png",@"Golf.png",@"core.png",@"tennis.png",@"gym.png",@"walking.png",@"soccer.png",@"sailing.png",@"boxing.png",@"hiking.png",@"triathlon.png",@"cycling.png",@"running.png",@"Golf.png",@"core.png",@"tennis.png",@"gym.png",@"walking.png",@"soccer.png",@"sailing.png",@"boxing.png",@"hiking.png",@"triathlon.png",@"cycling.png",@"running.png",@"Golf.png",@"core.png",@"tennis.png",@"gym.png",@"walking.png",@"soccer.png",@"sailing.png",@"boxing.png",@"hiking.png",@"triathlon.png",@"cycling.png",@"running.png",@"Golf.png",@"core.png",@"tennis.png",@"gym.png",@"walking.png",@"soccer.png",@"sailing.png",@"boxing.png",@"hiking.png",@"triathlon.png",@"cycling.png",@"running.png",@"Golf.png",@"core.png",@"tennis.png",@"gym.png",@"walking.png",@"soccer.png",@"sailing.png",@"boxing.png",@"hiking.png",@"triathlon.png", nil];
    
    
    skView = [[SKView alloc] initWithFrame:self.viewInterest.bounds];
    [self.viewInterest insertSubview:skView atIndex:0];
    animatedMenuScene = [[AnimatedMenuScene alloc] initWithSize:skView.bounds.size];
    animatedMenuScene.animatedSceneDelegate = self;// If you want to get notify when an item get selected
    animatedMenuScene.allowMultipleSelection=YES;
    animatedMenuScene.menuNodes = fitnessArray;
    animatedMenuScene.backgroundColor = [UIColor whiteColor];
    [skView presentScene:animatedMenuScene];
    
    
    selectionArray=[[NSMutableArray alloc] init];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)animatedMenuScene:(AnimatedMenuScene*)animatedScene didSelectNodeAtIndex:(NSInteger)index
{
    [selectionArray addObject:[fitnessArray objectAtIndex:index]];
    
    if (selectionArray.count == 0) {
        _refBtnDone.alpha=0.5;
        _refBtnDone.enabled=false;
    } else {
        _refBtnDone.alpha=1.0;
        _refBtnDone.enabled=true;
    }
    
    NSLog(@"%@",selectionArray);
}
- (void)animatedMenuScene:(AnimatedMenuScene *)animatedScene didDeSelectNodeAtIndex:(NSInteger)index
{
    [selectionArray removeObject:[fitnessArray objectAtIndex:index]];
    
    if (selectionArray.count == 0) {
        _refBtnDone.alpha=0.5;
        _refBtnDone.enabled=false;
    } else {
        _refBtnDone.alpha=1.0;
        _refBtnDone.enabled=true;
    }
}

#pragma mark -
#pragma mark - UICollectionViewwDataSource

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section{
    
    if (IS_IPHONE_5 || IS_IPHONE_4) {
        return UIEdgeInsetsMake(5, 5, 5, 5);
    } else {
        return UIEdgeInsetsMake(20, 20, 20, 20);
    }
}
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    
    return [fitnessArray count];
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *cellIdentifier = @"WorkoutCVCell";
    WorkoutCVCell *cell = (WorkoutCVCell *)[collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.lblCatName.text=[fitnessArray objectAtIndex:indexPath.row];
    
    NSPredicate *sPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF contains[cd] '%@'",[fitnessArray objectAtIndex:indexPath.row]]];
    NSArray *filteredArr = [selectionArray filteredArrayUsingPredicate:sPredicate];
    
    if (filteredArr.count != 0) {
        [cell.refBtnCategory setImage:[UIImage imageNamed:@"workoutSelection.png"] forState:UIControlStateNormal];
    } else {
        [cell.refBtnCategory setImage:[UIImage imageNamed:[imgArray objectAtIndex:indexPath.row]] forState:UIControlStateNormal];
    }
    
    // Return the cell
    return cell;
}

-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    NSPredicate *sPredicate = [NSPredicate predicateWithFormat:[NSString stringWithFormat:@"SELF contains[c] '%@'",[fitnessArray objectAtIndex:indexPath.row]]];
    NSArray *filteredArr = [selectionArray filteredArrayUsingPredicate:sPredicate];
    
    if (filteredArr.count == 0) {
        [selectionArray addObject:[fitnessArray objectAtIndex:indexPath.row]];
    } else {
        [selectionArray removeObject:[fitnessArray objectAtIndex:indexPath.row]];
    }
    [_collectionViewAddWorkout reloadData];
    
    if (selectionArray.count == 0) {
        _refBtnDone.alpha=0.5;
        _refBtnDone.enabled=false;
    } else {
        _refBtnDone.alpha=1.0;
        _refBtnDone.enabled=true;
    }
}

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (IBAction)btnDone:(id)sender {
    
    if (isCreateActivity)
    {
        startWorkoutViewController *fitnessVC=[self.storyboard instantiateViewControllerWithIdentifier:@"startWorkoutViewController"];
        [self.navigationController pushViewController:fitnessVC animated:YES];
    }
    else
    {
        /*
        [HUD show:YES];
        
        // Using this i am able to update currentUser Data in DB
        PFUser *user=[PFUser currentUser];
        [user addObject:selectionArray forKey:@"workoutList"];
        [user addObject:selectedCategoryArray forKey:@"categoryList"];
        [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError * _Nullable error)
         {
             [HUD hide:YES];
             if (succeeded)
             {
                 [APP_DELEGATE redirectHome];

                 [_globalGDXData showAlertTitle:kAlertSuccess message:@"Welocome to the app!!" ViewControllerOBJ:self];
             }
             else
             {
                 [_globalGDXData showAlertTitle:kAlertError message:error.description ViewControllerOBJ:self];
             }
         }];
         */
        
        //api_key, firstname, lastname, email, username, password, phone, gender, longitude, latitude, profile, categories[], subcategories[]

        [self PhotoUploadFormPosting];
        
        /*
        NSMutableDictionary *dicParams = [[NSMutableDictionary alloc]init];

        [dicParams setValue:APP_API_KEY forKey:@"api_key"];
        [dicParams setValue:[UserDefaults objectForKey:kUserFirstName] forKey:@"firstname"];
        [dicParams setValue:[UserDefaults objectForKey:kUserLastName] forKey:@"lastname"];
        [dicParams setValue:[UserDefaults objectForKey:kUserEmail] forKey:@"email"];
        [dicParams setValue:[UserDefaults objectForKey:kUserUserName] forKey:@"username"];
        [dicParams setValue:[UserDefaults objectForKey:kUserPassword] forKey:@"password"];
        [dicParams setValue:[UserDefaults objectForKey:kUserMobilePhone] forKey:@"phone"];
        [dicParams setValue:[UserDefaults objectForKey:kUserGender] forKey:@"gender"];
        [dicParams setValue:[UserDefaults objectForKey:@"lat"] forKey:@"longitude"];
        [dicParams setValue:[UserDefaults objectForKey:@"long"] forKey:@"latitude"];
        //[dicParams setValue:[UserDefaults objectForKey:kUserProfilePicture] forKey:@"profile"];
        [dicParams setValue:selectedCategoryArray forKey:@"categories"];
        [dicParams setValue:selectionArray forKey:@"subcategories"];

        
        [webrequest callPostWebServicWithImagedata:API_signup uploadImage:(NSData *)[UserDefaults objectForKey:kUserProfilePicture] WithImageParams:@"profile" alongWithOtherParams:dicParams];
        dicParams = nil;
         */
    }
}

#pragma mark Form Posting methods
-(void)PhotoUploadFormPosting
{
    
    @try
    {
        NSString *stringBoundary = @"----------V2ymHFg03ehbqgZCaKO6jy";
        // string constant for the post parameter 'file'. My server uses this name: `file`. Your's may differ
        NSString* FileParamConstant = @"profile";
        // the server url to which the image (or the media) is uploaded. Use your server url here
        NSURL* requestURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@%@",common_URL,API_signup]];

        // create request
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
        [request setCachePolicy:NSURLRequestReloadIgnoringLocalCacheData];
        [request setHTTPShouldHandleCookies:NO];
        [request setTimeoutInterval:60];
        [request setHTTPMethod:@"POST"];
        
        // set Content-Type in HTTP header
        NSString *contentType = [NSString stringWithFormat:@"multipart/form-data; boundary=%@", stringBoundary];
        [request setValue:contentType forHTTPHeaderField: @"Content-Type"];
        
        // post body
        NSMutableData *postBody = [NSMutableData data];
        
        //Image uploading is here...
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"api_key"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[APP_API_KEY dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"firstname"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[UserDefaults objectForKey:kUserFirstName] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"lastname"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[UserDefaults objectForKey:kUserLastName] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"email"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[UserDefaults objectForKey:kUserEmail] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"username"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[UserDefaults objectForKey:kUserUserName] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"password"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[UserDefaults objectForKey:kUserPassword] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"phone"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[UserDefaults objectForKey:kUserMobilePhone] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"gender"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[UserDefaults objectForKey:kUserGender] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"longitude"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[UserDefaults objectForKey:@"long"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"latitude"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[UserDefaults objectForKey:@"lat"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        //[dicParams setValue:[UserDefaults objectForKey:kUserProfilePicture] forKey:@"profile"];
        
        
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"subcategories"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[self commaSeperatedStringFromArr:selectionArray] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
        
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",@"categories"] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[[self commaSeperatedStringFromArr:selectedCategoryArray] dataUsingEncoding:NSUTF8StringEncoding]];
        [postBody appendData:[@"\r\n" dataUsingEncoding:NSUTF8StringEncoding]];

        
        // add image data
        NSData *imageData = [UserDefaults objectForKey:kUserProfilePicture];
        if ([imageData length] > 0)
        {
            [postBody appendData:[[NSString stringWithFormat:@"--%@\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"image.jpg\"\r\n", FileParamConstant] dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:[@"Content-Type: image/jpeg\r\n\r\n" dataUsingEncoding:NSUTF8StringEncoding]];
            [postBody appendData:imageData];
            [postBody appendData:[[NSString stringWithFormat:@"\r\n"] dataUsingEncoding:NSUTF8StringEncoding]];
        }
        
        [postBody appendData:[[NSString stringWithFormat:@"--%@--\r\n", stringBoundary] dataUsingEncoding:NSUTF8StringEncoding]];
        
        // setting the body of the post to the reqeust
        [request setHTTPBody:postBody];
        
        // set the content-length
        NSString *postLength = [NSString stringWithFormat:@"%lu", (unsigned long)[postBody length]];
        [request setValue:postLength forHTTPHeaderField:@"Content-Length"];
        
        // set URL
        [request setURL:requestURL];
        
        NSLog(@"Request URL--->> %@",request.URL);
        
        
        NSError *error;
        NSURLResponse *response;
        NSData *urlData=[NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];
        NSString *str=[[NSString alloc]initWithData:urlData encoding:NSUTF8StringEncoding];
        
        NSDictionary* json = [NSJSONSerialization JSONObjectWithData:urlData
                                                             options:kNilOptions
                                                               error:&error];
        
        if ([[json objectForKey:@"status"] isEqualToString:SUCCESS_RESPONCE])
        {
            [UserDefaults setBool:true forKey:@"isUserLoggin"];
            [UserDefaults synchronize];
            
            [APP_DELEGATE redirectHome];

        }
        else
        {
            [_globalGDXData showAlertTitle:@"Error" message:@"Please try again" ViewControllerOBJ:self];
        }
        //NSLog(@"%@",editProfileDict);
        NSLog(@"%@", error);

    }
    @catch (NSException *exception)
    {
        
    }
    @finally
    {
        
    }
}

-(void)UploadPhotoError
{

    
}
-(void)UploadPhotoSuccess:(NSDictionary *)ReturnDict
{

}

-(NSString *)commaSeperatedStringFromArr:(NSMutableArray *)arr
{
    NSString *strComma = @"";
    if ([arr count] > 0)
    {
        for (int i = 0; i < [arr count]; i++)
        {
            if ([strComma isEqualToString:@""])
            {
                strComma = [NSString stringWithFormat:@"%@",[arr objectAtIndex:i]];
            }
            else
            {
                strComma = [NSString stringWithFormat:@"%@,%@",strComma,[arr objectAtIndex:i]];
            }
        }
    }
    return strComma;
}
#pragma mark - Responce

-(void)response:(NSDictionary *)dicResponse ofOperation:(AFHTTPRequestOperation *)operation
{
    [APP_DELEGATE hideLoader];
    
    NSString *strOperation = [operation.request.URL absoluteString];
    NSArray *arr = [strOperation componentsSeparatedByString:@"/"];
    NSLog(@"%@",[arr lastObject]);
    
    NSArray *arr1 =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"%@",arr1);

    [UserDefaults setBool:true forKey:@"isUserLoggin"];
    [UserDefaults synchronize];

}

-(void)responseFail:(NSError *)error
{
    [APP_DELEGATE hideLoader];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
