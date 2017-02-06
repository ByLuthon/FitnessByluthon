//
//  RegistrationViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 04/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "RegistrationViewController.h"
#import "CategoryViewController.h"
#import "HomeViewController.h"
#import "SignUpProfileViewController.h"

@interface RegistrationViewController ()

@end

@implementation RegistrationViewController
@synthesize webrequest;

- (void)viewDidLoad {
    
    self.title=@"Registration";
    
    webrequest = [[WebService alloc] init];
    webrequest.delegate = self;

    HUD = [[MBProgressHUD alloc] initWithView:self.view];
    [self.view addSubview:HUD];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (IBAction)btnSignUp:(id)sender {
    
    if ([_txtUserName.text length]!=0 && [_txtEmail.text length] != 0 && [_txtPassword.text length] != 0 && [_txtMobileNumber.text length] !=0 && [_txtFirstName.text length] !=0)
    {
        [UserDefaults setObject:@"" forKey:kUserFBID];
        [UserDefaults setObject:_txtEmail.text forKey:kUserEmail];
        [UserDefaults setObject:_txtFirstName.text forKey:kUserFirstName];
        [UserDefaults setObject:_txtLastName.text forKey:kUserLastName];
        [UserDefaults setObject:_txtUserName.text forKey:kUserUserName];
        [UserDefaults setObject:_txtPassword.text forKey:kUserPassword];
        [UserDefaults setObject:_txtMobileNumber.text forKey:kUserMobilePhone];
        [UserDefaults setObject:[NSString stringWithFormat:@"%@ %@",_txtFirstName.text,_txtLastName.text] forKey:kUserFullName];
        [UserDefaults synchronize];

        SignUpProfileViewController *signUpProfile=[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpProfileViewController"];
        [self.navigationController pushViewController:signUpProfile animated:YES];
    }
    else
    {
        [_globalGDXData showAlertTitle:kAlertFailed message:kAlertEmptyFieldValid ViewControllerOBJ:self];
    }
}

- (IBAction)btnSignUpMobileNumber:(id)sender
{
    
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)btnFacebookLogin:(id)sender
{
    
    [HUD show:YES];
    
    NSArray *permission = [NSArray arrayWithObjects:@"email",@"public_profile",@"user_friends", nil];
    [PFFacebookUtils logInInBackgroundWithReadPermissions:permission block:^(PFUser *user, NSError *error) {
        // Was login successful ?
        if (!user) {
            if (!error) {
                NSLog(@"The user cancelled the Facebook login.");
            } else {
                NSLog(@"An error occurred: %@", error.localizedDescription);
            }
            [HUD hide:YES];
        } else {
            if (user.isNew) {
                NSLog(@"User signed up and logged in through Facebook!");
                
                NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
                [parameters setValue:@"id,name,email,first_name,last_name,picture.type(large),gender" forKey:@"fields"];
                
                NSLog(@"login with fb done:-->>");
                
                [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters ]
                 startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
                     NSDictionary *me = (NSDictionary *)result;
                     NSLog(@"%@",me);
                     
                     
                     [UserDefaults setObject:[result objectForKey:@"id"] forKey:kUserFBID];
                     [UserDefaults setObject:[result objectForKey:@"email"] forKey:kUserEmail];
                     [UserDefaults setObject:[result objectForKey:@"first_name"] forKey:kUserFirstName];
                     [UserDefaults setObject:[result objectForKey:@"last_name"] forKey:kUserLastName];
                     [UserDefaults setObject:[result objectForKey:@"name"] forKey:kUserFullName];
                     [UserDefaults setObject:[result objectForKey:@"gender"] forKey:kUserGender];
                     [UserDefaults setObject:[[[result objectForKey:@"picture"] objectForKey:@"data"] objectForKey:@"url"] forKey:kUserProfilePicture];
                     [UserDefaults synchronize];

                     
                     PFUser *user = [PFUser currentUser];
                     user.username = [result objectForKey:@"name"];
                     user.password = @"";
                     user.email = [result objectForKey:@"email"];
                     
                     // other fields can be set just like with PFObject
                     user[@"phone"] = @"";
                     user[@"firstname"] = [UserDefaults objectForKey:kUserFirstName];
                     user[@"lastname"] = [UserDefaults objectForKey:kUserLastName];
                     user[@"latitude"] = [UserDefaults objectForKey:@"lat"];
                     user[@"longitude"] = [UserDefaults objectForKey:@"long"];
                     user[@"fulladdress"]=[UserDefaults objectForKey:@"FullAddress"];
                     user[@"gender"]=[UserDefaults objectForKey:kUserGender];
                     user[@"profilePictureURL"]=[UserDefaults objectForKey:kUserProfilePicture];
                     user[@"isFBUSER"]=@"True";
                     
                     [user saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
                         if (!error) {
                             // Hooray! Let them use the app now.
                             NSLog(@"Yes It's working");
                             
                             SignUpProfileViewController *signUpProfile=[self.storyboard instantiateViewControllerWithIdentifier:@"SignUpProfileViewController"];
                             [self.navigationController pushViewController:signUpProfile animated:YES];
                             
                         } else {
                             
                             NSString *errorString = [error userInfo][@"error"];   // Show the errorString somewhere and let the user try again.
                             NSLog(@"%@",[error userInfo]);
                             
                             [_globalGDXData showAlertTitle:kAlertFailed message:errorString ViewControllerOBJ:self];
                         }
                         [HUD hide:YES];
                     }];
                     
                 }];
            } else {
                NSLog(@"User logged in through Facebook!");
                [_globalGDXData showAlertTitle:kAlertError message:@"User already exist !!" ViewControllerOBJ:self];
                [HUD hide:YES];
            }
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Get Response
-(void)response:(NSDictionary *)dicResponse ofOperation:(AFHTTPRequestOperation *)operation
{
    [APP_DELEGATE hideLoader];
    
    NSString *strOperation = [operation.request.URL absoluteString];
    NSArray *arr = [strOperation componentsSeparatedByString:@"/"];
    NSLog(@"%@",[arr lastObject]);
    
    NSArray *arr1 =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments | NSJSONReadingMutableContainers | NSJSONReadingMutableLeaves | NSJSONWritingPrettyPrinted error:nil];
    NSLog(@"%@",arr1);

    /*
    if ([[arr lastObject] isEqualToString:user_Details])
    {
        if ([arr1 isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *dict = (NSMutableDictionary *)arr1;
            
            if ([[dict objectForKey:@"Status"] isEqualToString:@"success"])
            {
                ArrCategory = [[dict objectForKey:@"Result"] objectForKey:@"Category"];
                NSMutableArray *TempArr = [[[dict objectForKey:@"Result"] objectForKey:@"PostInfo"] objectForKey:@"PostInfo"];
                DictUserInfo = [[dict objectForKey:@"Result"] objectForKey:@"UserInfo"];
                
                if (appDel.userID == [[dict valueForKeyPath:@"Result.UserInfo.UserId"] intValue])
                {
                    NSMutableDictionary *dic = [dict valueForKeyPath:@"Result.UserInfo"];
                    [appDel cleanDictionary:dic];
                    //                    [[NSUserDefaults standardUserDefaults] setValue:dic forKey:@"userData"];
                    [appDel storeDataInNSUSERDEFAULT:dic withKey:userDetails];
                    appDel.dicUserInfo = [[dict valueForKeyPath:@"Result.UserInfo"] mutableCopy];
                }
                
                if([DictUserInfo valueForKey:@"Availability"] != nil)
                {
                    BOOL checkstatus = [appDel CheckAvalibility:[DictUserInfo valueForKey:@"Availability"]];
                    
                    if (checkstatus)
                    {
                        _lbl_avalibility.hidden = FALSE;
                    }
                    else
                    {
                        _lbl_avalibility.hidden = TRUE;
                    }
                }
                else
                {
                    // No joy...
                }
                
                TotalRecord = (int)[[[[dict objectForKey:@"Result"] objectForKey:@"PostInfo"] objectForKey:@"TotalRecords"] integerValue];
                isReuqestFired = NO;
                
                if (isRefreshing == YES)
                {
                    ArrUserPost = [NSMutableArray array];
                    
                    [self.refreshControl endRefreshing];
                }
                
                if (isApplyFilter == YES)
                {
                    isApplyFilter = NO;
                    ArrUserPost = [NSMutableArray array];
                    [self.refreshControl endRefreshing];
                    
                }
                
                if (TotalRecord > 0)
                {
                    if (ArrUserPost.count == 0)
                    {
                        ArrUserPost = [TempArr mutableCopy];
                    }
                    else
                    {
                        [ArrUserPost addObjectsFromArray:TempArr];
                    }
                }
                
                if (TotalRecord == 0)
                {
                    ArrUserPost = [NSMutableArray array];
                }
                
                tablePost.hidden = FALSE;
                
                if ([ArrUserPost count] > 0 )
                {
                    tablePost.tableHeaderView = viewHeaderCount;
                    
                    tablePost.hidden = FALSE;
                    lblNoPost.hidden = TRUE;
                    checkTableHeader = 0;
                    tablePost.tableFooterView.hidden = TRUE;
                }
                else
                {
                    viewHeaderCount.hidden = FALSE;
                    // tablePost.tableHeaderView = nil;
                    checkTableHeader = 1;
                    tablePost.hidden = NO;
                    lblNoPost.hidden = NO;
                    [tablePost reloadData];
                    lblNoPost.text = [[[dict objectForKey:@"Result"] objectForKey:@"PostInfo"] objectForKey:@"Message"];
                }
                
                if (CheckCategory == 0)
                {
                    StrFilterCategory = @"";
                    
                    [ArrSelectCategory removeAllObjects];
                    for (int i = 0; i < [ArrCategory count]; i++)
                    {
                        [ArrSelectCategory addObject:@"0"];
                    }
                    
                    CheckCategory = 1;
                }
                
                [self SetUserInfo];
                isReuqestFired = NO;
                [tablePost reloadData];
                
                if (isRefreshing == YES)
                {
                    isRefreshing = NO;
                    [tablePost setContentOffset:CGPointZero animated:YES];
                }
                
                
            }
        }
    }
    else if ([[arr lastObject] isEqualToString:Follow])
    {
        [[NSNotificationCenter defaultCenter] postNotificationName:LAWO_post_Added object:nil userInfo:nil];
        
        if ([arr1 isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *dict = (NSMutableDictionary *)arr1;
            
            if (![[dict valueForKey:@"IsBlock"] isEqualToString:@"1"])
            {
                NSMutableDictionary *dicArray = [[appDel getValueFromNSUserDefaultFromKey:userDetails] mutableCopy];
                [dicArray setObject:[dict valueForKeyPath:@"Result.FollowersCount"] forKey:@"FollowersCount"];
                [dicArray setObject:[dict valueForKeyPath:@"Result.FollowingCount"] forKey:@"FollowingCount"];
                [dicArray setObject:[dict valueForKeyPath:@"Result.FriendsCount"] forKey:@"FriendsCount"];
                
                [appDel removeKeyValFromNSUSERDEFAULT:userDetails];
                [appDel storeDataInNSUSERDEFAULT:dicArray withKey:userDetails];
                
                appDel.dicUserInfo = [appDel getValueFromNSUserDefaultFromKey:userDetails];
                
                // [[NSNotificationCenter defaultCenter] postNotificationName:LAWO_changeUserCount object:dict];
                
                if ([[dict objectForKey:@"Status"] isEqualToString:@"success"])
                {
                    if ([StrProfileUserID integerValue] == appDel.userID)
                    {
                        [[NSNotificationCenter defaultCenter] postNotificationName:LAWO_UpdateUserFrndCount object:nil userInfo:dict];
                    }
                    
                    //                    [[NSNotificationCenter defaultCenter] postNotificationName:LAWO_UpdateFollowingFeed object:nil userInfo:dict];
                    
                    [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateUserFrndCount_sideMenu" object:nil userInfo:dict];
                    
                    [[iToast makeText:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"Result"] objectForKey:@"Message"]]] show];
                    
                    NSDictionary *dicUserID = [NSDictionary dictionaryWithObject:StrProfileUserID forKey:@"remove_userID"];
                    [[NSNotificationCenter defaultCenter] postNotificationName:LAWO_removeUserFromRecommandedList object:nil userInfo:dicUserID];
                    
                    [appDel showLoader];
                    [self performSelector:@selector(LoadProfileData) withObject:nil afterDelay:0.0];
                }
            }
            
            //Update User Count
            
        }
    }
    else if ([[arr lastObject] isEqualToString:user_block])
    {
        if ([arr1 isKindOfClass:[NSDictionary class]])
        {
            NSMutableDictionary *dict = (NSMutableDictionary *)arr1;
            
            NSLog(@"%@",dict);
            
            if ([[dict objectForKey:@"Status"] isEqualToString:@"success"])
            {
                if ([StrProfileUserID integerValue] == appDel.userID)
                {
                    [[NSNotificationCenter defaultCenter] postNotificationName:LAWO_UpdateUserFrndCount object:nil userInfo:dict];
                }
                
                //   [[NSNotificationCenter defaultCenter] postNotificationName:LAWO_UpdateFollowingFeed object:nil userInfo:dict];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateUserFrndCount_sideMenu" object:nil userInfo:dict];
                
                [[NSNotificationCenter defaultCenter] postNotificationName:LAWO_BlogScreenUpdate object:nil userInfo:dict];
                
                [[iToast makeText:[NSString stringWithFormat:@"%@",[[dict objectForKey:@"Result"] objectForKey:@"Message"]]] show];
                
                [appDel showLoader];
                [self performSelector:@selector(LoadProfileData) withObject:nil afterDelay:0.0];
            }
        }
    }
    else if ([[arr lastObject] isEqualToString:@"postadd.php"])
    {
        [appDel hideLoader];
        [[iToast makeText:[NSString stringWithFormat:@"%@",[[arr1 valueForKey:@"Result"] objectForKey:@"Message"]]] show];
        int totalItemVal = [lblTotalItemsValue.text intValue]-1;
        NSString *strLikeCount = [appDel abbreviateNumber:totalItemVal];
        lblTotalItemsValue.text = strLikeCount;
        
        //        lblTotalItemsValue.text = [NSString stringWithFormat:@"%d",[lblTotalItemsValue.text intValue]-1];
        [ArrUserPost removeObjectAtIndex:selcteIDX];
        [tablePost reloadData];
    }
     */
}

-(void)responseFail:(NSError *)error
{
    [APP_DELEGATE hideLoader];
}

@end
