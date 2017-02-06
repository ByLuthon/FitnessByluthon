//
//  MessageViewController.m
//  MyFitnessApp
//
//  Created by macmini on 04/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import "MessageViewController.h"

@interface MessageViewController ()

@end

@implementation MessageViewController

- (void)viewDidLoad
{
    self.navigationController.navigationBarHidden = TRUE;
    
    [self initParam];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = TRUE;
    
    
    [super viewWillAppear:animated];
}
#pragma mark - Init
-(void)initParam
{
    
}

- (void)didReceiveMemoryWarning {
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

#pragma mark - Tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell %ld %ld",(long)indexPath.row,(long)indexPath.section];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = nil;
    
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] ;
        

        UIImageView *img_userChat = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 40, 40)];
        [img_userChat setImageWithURL:nil placeholderImage:[UIImage imageNamed:@"emptyProfilePic.png"]];
        img_userChat.contentMode = UIViewContentModeScaleAspectFill;
        [_globalGDXData addBorderToView:1.0 color:[UIColor grayColor] cornerRadius:img_userChat.frame.size.height/2 objView:img_userChat];
        [cell.contentView addSubview:img_userChat];
        
        UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];

        [btn setFrame:img_userChat.frame];
        [btn setOnTouchUpInside:^(id sender, UIEvent *event)
         {
             /*
             UserProfileViewController *move = [[UserProfileViewController alloc] initWithNibName:@"UserProfileViewController" bundle:nil];
             move.str_custId = [[ArrConversation objectAtIndex:indexPath.row] objectForKey:@"customerId"];
             move.str_custName = [[ArrConversation objectAtIndex:indexPath.row] objectForKey:@"name"];
             [self.navigationController pushViewController:move animated:YES];
              */
         }];
        [cell.contentView addSubview:btn];
        
        
        
        UILabel *lblline = [[UILabel alloc] initWithFrame:CGRectMake(0, 49, WIDTH, 1)];
        lblline.backgroundColor = [UIColor lightGrayColor];
        lblline.alpha = 0.4;
        [cell.contentView addSubview:lblline];
        
        
        
        
        UIButton *buttonChatNow =  [UIButton buttonWithType:UIButtonTypeCustom];
        [buttonChatNow setImage:[UIImage imageNamed:@"Manage_userchat.png"] forState:UIControlStateNormal];
        buttonChatNow.tag = indexPath.row+100;
        [buttonChatNow setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [buttonChatNow setTitle:@"Chat Now" forState:UIControlStateNormal];
        buttonChatNow.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 10);
        buttonChatNow.titleEdgeInsets = UIEdgeInsetsMake(0, 5, 0, 0);
        [buttonChatNow setFrame:CGRectMake(WIDTH-95, 10, 100, 30)];
        buttonChatNow.titleLabel.font = setFont(12);
        [buttonChatNow setOnTouchUpInside:^(id sender, UIEvent *event)
         {
             /*
             AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
             NSString *selfPhotoUrl = @"";
             
             NSMutableArray *TempArr = [appDel.DicUserDetails objectForKey:@"galleryList"];
             for (int i = 0; i < [TempArr count]; i++)
             {
                 if ([[[TempArr objectAtIndex:i] objectForKey:@"IsProfilephoto"]integerValue] == 1)
                 {
                     selfPhotoUrl = [NSString stringWithFormat:@"%@",[[TempArr objectAtIndex:i] objectForKey:@"Photo"]];
                     
                     break;
                 }
             }
             
             NSString *selfUserId = [NSString stringWithFormat:@"%d",appDel.userID];
             NSString *selfUserName = [NSString stringWithFormat:@"%@",[app.DicUserDetails objectForKey:@"firstName"]];
             NSString *selfUserPhoto = [NSString stringWithFormat:@"%@",selfPhotoUrl];
             
             NSMutableDictionary *selfUser = [NSMutableDictionary new];
             [selfUser setObject:selfUserId forKey:Chat_selfuserid];
             [selfUser setObject:selfUserName forKey:Chat_selfusername];
             [selfUser setObject:selfUserPhoto forKey:Chat_selfuserphoto];
             
             
             NSString *oppUserId = [NSString stringWithFormat:@"%@",ArrConversation[indexPath.row][@"customerId"]];
             NSString *oppUserName = [NSString stringWithFormat:@"%@",ArrConversation[indexPath.row][@"name"]];
             NSString *oppUserPhoto = [NSString stringWithFormat:@"%@",ArrConversation[indexPath.row][@"profilePhoto"]];
             
             NSMutableDictionary *oppUser = [NSMutableDictionary new];
             [oppUser setObject:oppUserId forKey:Chat_oppuserid];
             [oppUser setObject:oppUserName forKey:Chat_oppusername];
             [oppUser setObject:oppUserPhoto forKey:Chat_oppuserphoto];
             
             
             NSString *languageId = [NSString stringWithFormat:@"%d",appDel.selectedLanguage];
             NSString *timeZone = [NSString stringWithFormat:@"%@",[AppDelegate local_TimeZone_Format]];
             
             ChatVC *chatVC = [[ChatVC alloc]initWithNibName:@"ChatVC" bundle:nil];
             chatVC.dictSelfChatUser = selfUser;
             chatVC.dictOppChatUser = oppUser;
             chatVC.languageId = languageId;
             chatVC.timeZone = timeZone;
             chatVC.isChatInitialize = YES;
             chatVC.appTotalBadgeCount = (int)appDel.AppBegde;
             chatVC.appTotalChatBadgeCount = (int)appDel.AppChatBegde;
             chatVC.appUserChatBadgeCount = 0;
             [self.navigationController pushViewController:chatVC animated:YES];
              */
             
         }];
        [cell.contentView addSubview:buttonChatNow];
        
        

        UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(60, 5, 150, 30)];
            lbl.font = setFont(15);
            lbl.text = [NSString stringWithFormat:@"Florence Williams"];
            lbl.textColor = [UIColor blackColor];
            [cell.contentView addSubview:lbl];
            
            NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
            [dateFormat setDateFormat:@"yyyy-MM-dd"];
            NSDate *date = [dateFormat dateFromString:@"2016/12/11"];
            //[dateFormat setDateFormat:@"dd MMM yyyy"]; // Date formater
            [dateFormat setDateFormat:@"yyyy/MM/dd"];
            NSString *str_date = [dateFormat stringFromDate:date]; // Convert date to string
            
            UILabel *lbldate = [[UILabel alloc] initWithFrame:CGRectMake(60, 26, 200, 20)];
            lbldate.font = setFont(11);
            lbldate.text = [NSString stringWithFormat:@"%@",str_date];
            lbldate.textColor = [UIColor grayColor];
            [cell.contentView addSubview:lbldate];
            
            NSString *valueEmoj = [NSString stringWithFormat:@"5"];
            UIFont *font = setFont(14);
            CGRect textRect = [valueEmoj boundingRectWithSize:CGSizeMake(150, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:font} context:nil];
            CGSize size = textRect.size;
            if (size.height > size.width)
            {
                size.width = size.height;
            }
            
            //NSLog(@"%f",buttonChatNow.frame.origin.x + size.width + 10);
            
            UILabel *lbl_Badge = [[UILabel alloc] initWithFrame:CGRectMake(buttonChatNow.frame.origin.x - (size.width+5) ,15,size.width +8, size.height+8)];
            lbl_Badge.numberOfLines = 0;
            lbl_Badge.font = font;
            lbl_Badge.textColor = [UIColor blackColor];
            lbl_Badge.textAlignment = NSTextAlignmentCenter;
            lbl_Badge.text = (valueEmoj ? valueEmoj : @"");
            lbl_Badge.layer.masksToBounds = YES;
            lbl_Badge.layer.backgroundColor = [UIColor whiteColor].CGColor;
            lbl_Badge.layer.cornerRadius = lbl_Badge.bounds.size.height / 2;
            lbl_Badge.layer.masksToBounds = YES;
            lbl_Badge .layer.borderWidth = 1.5;
            lbl_Badge.layer.borderColor = [[UIColor colorWithRed:0 green:155.0/255.0 blue:207.0/255.0 alpha:1.0] CGColor];
            [cell.contentView addSubview:lbl_Badge];

            
        
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    /*
    AppDelegate *appDel = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    NSString *selfPhotoUrl = @"";
    
    NSMutableArray *TempArr = [appDel.DicUserDetails objectForKey:@"galleryList"];
    for (int i = 0; i < [TempArr count]; i++)
    {
        if ([[[TempArr objectAtIndex:i] objectForKey:@"IsProfilephoto"]integerValue] == 1)
        {
            selfPhotoUrl = [NSString stringWithFormat:@"%@",[[TempArr objectAtIndex:i] objectForKey:@"Photo"]];
            
            break;
        }
    }
    
    NSString *selfUserId = [NSString stringWithFormat:@"%d",appDel.userID];
    NSString *selfUserName = [NSString stringWithFormat:@"%@",[app.DicUserDetails objectForKey:@"firstName"]];
    NSString *selfUserPhoto = [NSString stringWithFormat:@"%@",selfPhotoUrl];
    
    NSMutableDictionary *selfUser = [NSMutableDictionary new];
    [selfUser setObject:selfUserId forKey:Chat_selfuserid];
    [selfUser setObject:selfUserName forKey:Chat_selfusername];
    [selfUser setObject:selfUserPhoto forKey:Chat_selfuserphoto];
    
    
    NSString *oppUserId = [NSString stringWithFormat:@"%@",ArrConversation[indexPath.row][@"customerId"]];
    NSString *oppUserName = [NSString stringWithFormat:@"%@",ArrConversation[indexPath.row][@"name"]];
    NSString *oppUserPhoto = [NSString stringWithFormat:@"%@",ArrConversation[indexPath.row][@"profilePhoto"]];
    
    NSMutableDictionary *oppUser = [NSMutableDictionary new];
    [oppUser setObject:oppUserId forKey:Chat_oppuserid];
    [oppUser setObject:oppUserName forKey:Chat_oppusername];
    [oppUser setObject:oppUserPhoto forKey:Chat_oppuserphoto];
    
    
    NSString *languageId = [NSString stringWithFormat:@"%d",appDel.selectedLanguage];
    NSString *timeZone = [NSString stringWithFormat:@"%@",[AppDelegate local_TimeZone_Format]];
    
    ChatVC *chatVC = [[ChatVC alloc]initWithNibName:@"ChatVC" bundle:nil];
    chatVC.dictSelfChatUser = selfUser;
    chatVC.dictOppChatUser = oppUser;
    chatVC.languageId = languageId;
    chatVC.timeZone = timeZone;
    chatVC.isChatInitialize = YES;
    chatVC.appTotalBadgeCount = (int)appDel.AppBegde;
    chatVC.appTotalChatBadgeCount = (int)appDel.AppChatBegde;
    chatVC.appUserChatBadgeCount = 0;
    [self.navigationController pushViewController:chatVC animated:YES];
     */
    
}
- (UITableViewCellEditingStyle) tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tbl)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIButton *btn = (UIButton *)[cell viewWithTag:indexPath.row+100];
        NSLog(@"%@",btn);
        [btn setUserInteractionEnabled:false];
        //[cell.buttonChatNow setUserInteractionEnabled:false];
        //[cell.button_SENDMESSAGE setUserInteractionEnabled:false];
        return UITableViewCellEditingStyleDelete;
    }
    return UITableViewCellEditingStyleNone;
}
-(void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == tbl)
    {
        UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
        UIButton *btn = (UIButton *)[cell viewWithTag:indexPath.row+100];
        //NSLog(@"%@",btn);
        [btn setUserInteractionEnabled:true];
    }
}
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return YES if you want the specified item to be editable.
    return YES;
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {

        /*
        [ChatService sharedService].selfuserid = [NSString stringWithFormat:@"%d",app.userID];
        [ChatService sharedService].self.sessionid = [NSString stringWithFormat:@"%@",ArrConversation[indexPath.row][@"chatSessionId"]];
        [ChatService sharedService].languageid = [NSString stringWithFormat:@"%d",app.selectedLanguage];
        
        //add code here for when you hit delete
        [[ChatService sharedService] clearIndividualChatHistory];
        
        
        [ArrConversation removeObjectAtIndex:indexPath.row];
        [tbl deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationLeft];
        
        
        int NotifyCount = 0;
        for (int i = 0; i < [ArrConversation count]; i++)
        {
            NotifyCount = NotifyCount + [[[ArrConversation objectAtIndex:i] objectForKey:@"isReadCount"] intValue];
        }
        app.AppChatBegde = NotifyCount;
        
        
        //Update data
        NSMutableDictionary *mutableDict = [app.DicUserDetails mutableCopy];
        [mutableDict setObject:[NSString stringWithFormat:@"%ld",(long)app.AppChatBegde] forKey:@"conversationnotif"];
        
        app.DicUserDetails = [mutableDict mutableCopy];
        
        
        NSInteger temp = [[app.DicUserDetails objectForKey:@"adminnotif"]integerValue] + [[app.DicUserDetails objectForKey:@"conversationnotif"]integerValue] + [[app.DicUserDetails objectForKey:@"generalnotif"]integerValue] + [[app.DicUserDetails objectForKey:@"publicmomentnotif"]integerValue] + [[app.DicUserDetails objectForKey:@"scnotif"]integerValue];
        
        app.AppBegde = temp;
        
        
        //[[NSUserDefaults standardUserDefaults] removeObjectForKey:@"UserData"];
        [[NSUserDefaults standardUserDefaults] setValue:app.DicUserDetails forKey:@"UserData"];
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"UpdateConversationBedgeCount" object:[NSString stringWithFormat:@"%d",NotifyCount] userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"HomeScreen_NotifyUpdate" object:[NSString stringWithFormat:@"%ld",(long)app.AppBegde] userInfo:nil];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"Notification_NotifyUpdate" object:[NSString stringWithFormat:@"%d",NotifyCount] userInfo:nil];
        */
        
    }
}

@end
