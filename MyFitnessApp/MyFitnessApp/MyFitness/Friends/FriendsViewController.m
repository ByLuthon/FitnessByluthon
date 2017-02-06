//
//  FriendsViewController.m
//  MyFitnessApp
//
//  Created by macmini on 04/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import "FriendsViewController.h"

@interface FriendsViewController ()

@end

@implementation FriendsViewController

- (void)viewDidLoad
{
    [self initParam];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Init
-(void)initParam
{
    tbl_nearby.frame = CGRectMake(0, 0, WIDTH, scrl.frame.size.height);
    tbl_following.frame = CGRectMake(WIDTH*1, 0, WIDTH, scrl.frame.size.height);
    tbl_followers.frame = CGRectMake(WIDTH*2, 0, WIDTH, scrl.frame.size.height);
    
    scrl.contentSize = CGSizeMake(WIDTH * 3 , scrl.frame.size.height);
    scrl.pagingEnabled = TRUE;
    
    CGPoint scrollPoint = CGPointMake(0, 0);
    [scrl setContentOffset:scrollPoint animated:YES];
    [scrl setDelegate:self];//Set delegate
    
    //Set Line Under Button
    [self setLineFrameUnderMenu:lbl_nearby];
    
    
}

-(void)resetButtontitleColor
{
    lbl_nearby.textColor = [UIColor grayColor];
    lbl_followers.textColor = [UIColor grayColor];
    lbl_following.textColor = [UIColor grayColor];
}

#pragma mark - UnderLine Button
-(void)setLineFrameUnderMenu:(UILabel *)lbl
{
    [self resetButtontitleColor];
    lbl.textColor = [UIColor blackColor];
    
    [UIView animateWithDuration:0.2
                          delay:0.0
                        options: UIViewAnimationOptionCurveEaseIn
                     animations:^{
                         lbl_underline.frame = CGRectMake(lbl.frame.origin.x, lbl_underline.frame.origin.y, lbl.frame.size.width, 2.0);
                     }
                     completion:^(BOOL finished){
                     }];
}
#pragma mark - ScrollView Delegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrllView
{
    if (scrllView == scrl)
    {
        CGFloat pageWidth = scrllView.frame.size.width;
        int page = floor((scrllView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
        
        //NSLog(@"%f",scrllView.contentOffset.x);
        
        CGPoint scrollPoint;
        
        
        [self resetButtontitleColor];
        UILabel *lbl;
        
        
        if (page == 0)
        {
            lbl = lbl_nearby;
            lbl.textColor = [UIColor blackColor];
            
            scrollPoint = CGPointMake(0, 0);
            [scrl setContentOffset:scrollPoint animated:YES];
        }
        else if (page == 1)
        {
            lbl = lbl_following;
            lbl.textColor = [UIColor blackColor];
            
            scrollPoint = CGPointMake(WIDTH*1, 0);
            [scrl setContentOffset:scrollPoint animated:YES];
        }
        else if (page == 2)
        {
            lbl = lbl_followers;
            lbl.textColor = [UIColor blackColor];
            
            scrollPoint = CGPointMake(WIDTH*2, 0);
            [scrl setContentOffset:scrollPoint animated:YES];
        }
        
        [UIView animateWithDuration:0.2
                              delay:0.0
                            options: UIViewAnimationOptionCurveEaseIn
                         animations:^{
                             lbl_underline.frame = CGRectMake(lbl.frame.origin.x, lbl_underline.frame.origin.y, lbl.frame.size.width, 2.0);
                         }
                         completion:^(BOOL finished){
                         }];
        
        //LoadingMenu = page+1;
        [self switchingtheSegments:page+1];
    }
}

- (IBAction)segmentTapped:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int indx = 0;
    indx = (int)btn.tag;
    
    
    switch (indx)
    {
        case 1:
            [self setLineFrameUnderMenu:lbl_nearby];
            break;
        case 2:
            
            [self setLineFrameUnderMenu:lbl_following];
            break;
        case 3:
            [self setLineFrameUnderMenu:lbl_followers];
            break;
            
        default:
            break;
    }
    
    [self switchingtheSegments:indx];
    
}


#pragma mark - switchSegments
-(void)switchSegments:(UIButton *)btn
{
    int indx = 0;
    indx = (int)btn.tag;
    [self switchingtheSegments:indx];
}
-(void)switchingtheSegments:(int)idx
{
    //LoadingMenu = idx;
    
    CGPoint scrollPoint;
    switch (idx)
    {
        case 1:
            scrollPoint = CGPointMake(0, 0);
            [scrl setContentOffset:scrollPoint animated:YES];
            break;
        case 2:
            
            scrollPoint = CGPointMake(WIDTH, 0);
            [scrl setContentOffset:scrollPoint animated:YES];
            break;
        case 3:
            scrollPoint = CGPointMake(WIDTH*2, 0);
            [scrl setContentOffset:scrollPoint animated:YES];
            break;
            
        default:
            break;
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark - BACK

- (IBAction)btnBAck:(id)sender
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
    return 60;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell %ld %ld",(long)indexPath.row,(long)indexPath.section];
    
    Cell_Friends *cell = (Cell_Friends *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    //cell = nil;
    
    if (cell == nil)
    {
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"Cell_Friends" owner:nil options:nil];
        
        for(id currentObject in topLevelObjects)
        {
            if([currentObject isKindOfClass:[Cell_Friends class]])
            {
                cell = (Cell_Friends *)currentObject;
                break;
            }
        }
        
        //cell.backgroundColor = ColorFromHEX(@"#FAFAFA");
        
        
        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    UserProfileViewController *move = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
    [self.navigationController pushViewController:move animated:YES];
}

@end
