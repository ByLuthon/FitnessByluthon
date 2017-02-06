//
//  SettingViewController.m
//  MyFitnessApp
//
//  Created by macmini on 04/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad
{
    [self setInitParam];

    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setInitParam
{
    
    ArrData_notification = [[NSMutableArray alloc] init];
    ArrData_Account = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dict1 = [[NSMutableDictionary alloc] init];
    [dict1 setObject:@"General Notification" forKey:@"text"];
    [dict1 setObject:@"conversation.png" forKey:@"image"];
    [dict1 setObject:@"1" forKey:@"value"];
    [ArrData_notification addObject:dict1];
    dict1 = nil;
    
    /*
    NSMutableDictionary *dict8 = [[NSMutableDictionary alloc] init];
    [dict8 setObject:[app languageSelectedStringForKey:@"str_general_notification"] forKey:@"text"];
    [dict8 setObject:@"spcl_offers.png" forKey:@"image"];
    [dict8 setObject:[NSString stringWithFormat:@"%d",generalnotif_Value] forKey:@"value"];
    [ArrData_notification addObject:dict8];
    dict8 = nil;
    
    
    NSMutableDictionary *dict3 = [[NSMutableDictionary alloc] init];
    [dict3 setObject:[app languageSelectedStringForKey:@"str_selfie_contest_notification"] forKey:@"text"];
    [dict3 setObject:@"selfie_contest.png" forKey:@"image"];
    [dict3 setObject:[NSString stringWithFormat:@"%d",SelfieContect_Value] forKey:@"value"];
    [ArrData_notification addObject:dict3];
    dict3 = nil;
    
    
    NSMutableDictionary *dict4 = [[NSMutableDictionary alloc] init];
    [dict4 setObject:[app languageSelectedStringForKey:@"str_public_moment_notification"] forKey:@"text"];
    [dict4 setObject:@"public_moment.png" forKey:@"image"];
    [dict4 setObject:[NSString stringWithFormat:@"%d",PublicMoment_Value] forKey:@"value"];
    [ArrData_notification addObject:dict4];
    dict4 = nil;
    
    
    NSMutableDictionary *dict6 = [[NSMutableDictionary alloc] init];
    [dict6 setObject:[app languageSelectedStringForKey:@"str_special_20_notification"] forKey:@"text"];
    [dict6 setObject:@"spcl_offers.png" forKey:@"image"];
    [dict6 setObject:[NSString stringWithFormat:@"%d",SpecialOffer_Value] forKey:@"value"];
    [ArrData_notification addObject:dict6];
    dict6 = nil;
    */
    
    
    
    NSMutableDictionary *dict5 = [[NSMutableDictionary alloc] init];
    [dict5 setObject:@"Change Password" forKey:@"text"];
    [dict5 setObject:@"lock.png" forKey:@"image"];
    [ArrData_Account addObject:dict5];
    dict5 = nil;
    
    NSMutableDictionary *dict7 = [[NSMutableDictionary alloc] init];
    [dict7 setObject:@"Clear Chat History" forKey:@"text"];
    [dict7 setObject:@"iphone-chat-history.png" forKey:@"image"];
    [ArrData_Account addObject:dict7];
    dict7 = nil;
    
    NSMutableDictionary *dict10 = [[NSMutableDictionary alloc] init];
    [dict10 setObject:@"Contact Us" forKey:@"text"];
    [dict10 setObject:@"ContactUs.png" forKey:@"image"];
    [ArrData_Account addObject:dict10];
    dict10 = nil;
    
    
    NSMutableDictionary *dict9 = [[NSMutableDictionary alloc] init];
    [dict9 setObject:@"Sign Out" forKey:@"text"];
    [dict9 setObject:@"Sign Out.png" forKey:@"image"];
    [ArrData_Account addObject:dict9];
    dict9 = nil;
    
    [tbl reloadData];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)back:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Tableview Cell

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (section == 0)
    {
        return [ArrData_notification count];
    }
    else
    {
        return [ArrData_Account count];
    }
}
-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerVw = [[UIView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 40)] ;
    headerVw.backgroundColor=[UIColor whiteColor];  // set color of header
    
    UILabel *lblline = [[UILabel alloc] initWithFrame:CGRectMake(0, headerVw.frame.size.height-1, WIDTH, 1)];
    lblline.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:53.0/255.0 blue:102.0/255.0 alpha:1.0];
    lblline.text = @"";
    [headerVw addSubview:lblline];
    
    UILabel *lbl_header = [[UILabel alloc]initWithFrame:CGRectMake(15, 10, 100, 30)];
    lbl_header.font = setFontMedium(16);
    lbl_header.backgroundColor = [UIColor colorWithRed:249.0/255.0 green:53.0/255.0 blue:102.0/255.0 alpha:1.0];
    lbl_header.textColor = [UIColor whiteColor];
    lbl_header.textAlignment = NSTextAlignmentCenter;
    if (section == 0)
    {
        lbl_header.text = [NSString stringWithFormat:@"Notifications"];
    }
    else
    {
        lbl_header.text = [NSString stringWithFormat:@"Account"];
    }
    
    

    
    CGRect textRect = [lbl_header.text boundingRectWithSize:CGSizeMake(WIDTH-50, 20) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:lbl_header.font} context:nil];
    CGSize size = textRect.size;
    
    lbl_header.frame = CGRectMake(lbl_header.frame.origin.x, lbl_header.frame.origin.y, size.width + 10, 30);
    
    UIBezierPath *maskPath = [UIBezierPath bezierPathWithRoundedRect:lbl_header.bounds byRoundingCorners:( UIRectCornerTopLeft | UIRectCornerTopRight) cornerRadii:CGSizeMake(5.0, 5.0)];
    CAShapeLayer *maskLayer = [[CAShapeLayer alloc] init];
    maskLayer.frame = lbl_header.bounds;
    maskLayer.path  = maskPath.CGPath;
    
    lbl_header.layer.mask = maskLayer;

    
    //[_globalGDXData addBorderToView:0.0 color:[UIColor lightGrayColor] cornerRadius:5.0 objView:lbl_header];
    [headerVw addSubview:lbl_header];
    
    return headerVw;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
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
        
        if (indexPath.section == 0)
        {
            
            cell.imageView.image = [UIImage imageNamed:[[ArrData_notification objectAtIndex:indexPath.row] objectForKey:@"image"]];

            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 200, 50)];
            lbl.font = setFont(16);
            lbl.text = [NSString stringWithFormat:@"%@",[[ArrData_notification objectAtIndex:indexPath.row] objectForKey:@"text"]];
            lbl.textColor = [UIColor blackColor];
            [cell.contentView addSubview:lbl];
            
            
            UISwitch *switchView = [[UISwitch alloc] initWithFrame:CGRectZero];
            cell.accessoryView = switchView;
            switchView.onTintColor = [UIColor colorWithRed:249.0/255.0 green:53.0/255.0 blue:102.0/255.0 alpha:1.0];
            switchView.tintColor = [UIColor colorWithRed:249.0/255.0 green:53.0/255.0 blue:102.0/255.0 alpha:1.0];
            switchView.tag = indexPath.row;
            if ([[[ArrData_notification objectAtIndex:indexPath.row] objectForKey:@"value"] isEqualToString:@"0"])
            {
                [switchView setOn:NO animated:NO];
            }
            else
            {
                [switchView setOn:YES animated:NO];
            }
            [switchView addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        }
        else
        {
            cell.imageView.image = [UIImage imageNamed:[[ArrData_Account objectAtIndex:indexPath.row] objectForKey:@"image"]];
            
            
            UILabel *lbl = [[UILabel alloc] initWithFrame:CGRectMake(45, 0, 200, 50)];
            lbl.font = setFont(16);
            lbl.text = [NSString stringWithFormat:@"%@",[[ArrData_Account objectAtIndex:indexPath.row] objectForKey:@"text"]];
            lbl.textColor = [UIColor colorWithRed:59.0/255.0 green:151.0/255.0 blue:211.0/255.0 alpha:1.0];
            [cell.contentView addSubview:lbl];
            
            
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            /*
            UILabel *lblline = [[UILabel alloc] initWithFrame:CGRectMake(10, 49, WIDTH, 1)];
            lblline.backgroundColor = [UIColor lightGrayColor];
            [cell.contentView addSubview:lblline];
             */
        }
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if (indexPath.section == 0)
    {
    }
    else
    {
        if ([[[ArrData_Account objectAtIndex:indexPath.row] objectForKey:@"text"] isEqualToString:@"Change Password"])
        {
            //Change password
            ChangePWDViewController *move = [self.storyboard instantiateViewControllerWithIdentifier:@"ChangePWDViewController"];
            [self.navigationController pushViewController:move animated:YES];
        }
        else if ([[[ArrData_Account objectAtIndex:indexPath.row] objectForKey:@"text"] isEqualToString:@"Clear Chat History"])
        {
            //Clear chat

            NSString *message = @"Are you sure you want to clear chat history?";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                                message:message
                                                               delegate:self
                                                      cancelButtonTitle:@"No"
                                                      otherButtonTitles:@"Yes", nil];
            alert.tag = 10;
            [alert show];
        }
        else if ([[[ArrData_Account objectAtIndex:indexPath.row] objectForKey:@"text"] isEqualToString:@"Contact Us"])
        {
            //Contact Us
            ContactViewController *move = [self.storyboard instantiateViewControllerWithIdentifier:@"ContactViewController"];
            [self.navigationController pushViewController:move animated:YES];

        }
        else if ([[[ArrData_Account objectAtIndex:indexPath.row] objectForKey:@"text"] isEqualToString:@"Sign Out"])
        {
            //Logout
            
            NSString *message = @"Are you sure you want to sign out?";
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@""
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"No"
                                                  otherButtonTitles:@"Yes", nil];
            alert.tag = 20;
            [alert show];
        }
    }
}
#pragma mark - switch

- (void) switchChanged:(id)sender
{
    UISwitch* switchControl = (UISwitch *)sender;
    NSLog(@"%ld",(long)switchControl.tag);
    
    if (switchControl.on)
    {

    }
    else
    {

    }
    
    //NSLog( @"The switch is %@", switchControl.on ? @"ON" : @"OFF" );
}

#pragma mark - Alertview delegate
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"%ld",(long)buttonIndex);
    if (alertView.tag == 10)
    {
        if (buttonIndex == 1)
        {

        }
    }
    else if (alertView.tag == 20)
    {
        if (buttonIndex == 1)
        {
            [UserDefaults removeObjectForKey:@"isIntroductionDone"];
            
            [APP_DELEGATE.tabbar.view removeFromSuperview];
            [APP_DELEGATE redirectLogin];
        }
    }
}


@end
