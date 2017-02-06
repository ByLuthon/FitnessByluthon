//
//  UserProfileViewController.m
//  MyFitnessApp
//
//  Created by macmini on 09/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import "UserProfileViewController.h"

@interface UserProfileViewController ()

@end

@implementation UserProfileViewController

- (void)viewDidLoad
{
    [self setInitParams];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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

-(void)setInitParams
{
    [_globalGDXData addBorderToView:1.0 color:[UIColor whiteColor] cornerRadius:img_user.frame.size.height/2 objView:img_user];

    tbl.tableHeaderView = subview_profile;
    subview_profile.layer.masksToBounds = YES;
}

#pragma mark - Back
- (IBAction)btnBacktapped:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - Tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 300;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell %ld %ld",(long)indexPath.row,(long)indexPath.section];
    
    Cell_Fitness *cell = (Cell_Fitness *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //cell = nil;
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Cell_Fitness" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[Cell_Fitness class]])
            {
                cell = (Cell_Fitness *)currentObject;
                break;
            }
        }
        
        cell.backgroundColor = ColorFromHEX(@"#FAFAFA");
        
        [cell.btn_user setOnTouchUpInside:^(id sender, UIEvent *event)
         {
             UserProfileViewController *move = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
             [self.navigationController pushViewController:move animated:YES];
         }];

        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
}

@end
