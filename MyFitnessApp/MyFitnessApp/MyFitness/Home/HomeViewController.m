//
//  HomeViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 23/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "HomeViewController.h"
#import "LandingPageViewController.h"
#import "CreateActivityViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController

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
    tbl_previous.frame = CGRectMake(0, 0, WIDTH, scrl.frame.size.height);
    tbl_now.frame = CGRectMake(WIDTH*1, 0, WIDTH, scrl.frame.size.height);
    tbl_upcoming.frame = CGRectMake(WIDTH*2, 0, WIDTH, scrl.frame.size.height);

    scrl.contentSize = CGSizeMake(WIDTH * 3 , scrl.frame.size.height);
    scrl.pagingEnabled = TRUE;
    
    CGPoint scrollPoint = CGPointMake(WIDTH, 0);
    [scrl setContentOffset:scrollPoint animated:YES];
    [scrl setDelegate:self];//Set delegate

    //Set Line Under Button
    [self setLineFrameUnderMenu:lbl_now];

    [self.view addSubview:view_matchfound];
    view_matchfound.frame = self.view.frame;
    view_matchfound.hidden = TRUE;
    
    [self.tabBarController.view addSubview:view_matchfound];

    
    [_globalGDXData addBorderToView:0 color:kColorClear cornerRadius:_refBtnCreateActivity.bounds.size.height/2 objView:_refBtnCreateActivity];

    [_globalGDXData addBorderToView:1.0 color:[UIColor lightGrayColor] cornerRadius:subview_user1.frame.size.height/2 objView:img1];
    [_globalGDXData addBorderToView:1.0 color:[UIColor lightGrayColor] cornerRadius:subview_user1.frame.size.height/2 objView:img2];
    
    [_globalGDXData addBorderToView:1.0 color:[UIColor whiteColor] cornerRadius:5.0 objView:view_chat];
    [_globalGDXData addBorderToView:1.0 color:[UIColor whiteColor] cornerRadius:5.0 objView:view_home];
}

-(void)resetButtontitleColor
{
    lbl_now.textColor = [UIColor grayColor];
    lbl_previous.textColor = [UIColor grayColor];
    lbl_upcoming.textColor = [UIColor grayColor];
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
            lbl = lbl_previous;
            lbl.textColor = [UIColor blackColor];
            
            scrollPoint = CGPointMake(0, 0);
            [scrl setContentOffset:scrollPoint animated:YES];
        }
        else if (page == 1)
        {
            lbl = lbl_now;
            lbl.textColor = [UIColor blackColor];
            
            scrollPoint = CGPointMake(WIDTH*1, 0);
            [scrl setContentOffset:scrollPoint animated:YES];
        }
        else if (page == 2)
        {
            lbl = lbl_upcoming;
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

- (IBAction)tabTapped:(id)sender
{
    UIButton *btn = (UIButton *)sender;
    int indx = 0;
    indx = (int)btn.tag;
    
    
    switch (indx)
    {
        case 1:
            [self setLineFrameUnderMenu:lbl_previous];
            break;
        case 2:
            
            [self setLineFrameUnderMenu:lbl_now];
            break;
        case 3:
            [self setLineFrameUnderMenu:lbl_upcoming];
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

        
        [cell.btn_join setOnTouchUpInside:^(id sender, UIEvent *event)
         {
             [_globalGDXData animateWithShow:YES withView:view_matchfound];
             [self performSelector:@selector(AddMatchUserScreen) withObject:nil afterDelay:0.0];
         }];


        
    }
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    ActivityDetailsViewController *move = [self.storyboard instantiateViewControllerWithIdentifier:@"ActivityDetailsViewController"];
    [self.navigationController pushViewController:move animated:YES];
}

#pragma mark - button action
- (IBAction)btnLogout:(id)sender {
    //[self.navigationController popToRootViewControllerAnimated:YES];
    
    [PFUser logOut];
    
    for (UIViewController *controller in self.navigationController.viewControllers) {
        
        //Do not forget to import LandingPageViewController
        if ([controller isKindOfClass:[LandingPageViewController class]]) {
            
            [self.navigationController popToViewController:controller
                                                  animated:YES];
            break;
        }
    }
}

- (IBAction)btnViewProfile:(id)sender
{
    MyProfileViewController *userProfile=[self.storyboard instantiateViewControllerWithIdentifier:@"MyProfileViewController"];
    [self.navigationController pushViewController:userProfile animated:YES];
}

- (IBAction)btnCreateActivity:(id)sender
{
    /*
    CategoryViewController *categoryVC=[self.storyboard instantiateViewControllerWithIdentifier:@"CategoryViewController"];
    categoryVC.isCreateActivity = TRUE;
    [self.navigationController pushViewController:categoryVC animated:YES];
     */
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTabbarEnable:(BOOL)isEnable
{
    [[[[self.tabBarController tabBar]items]objectAtIndex:0]setEnabled:isEnable];
    [[[[self.tabBarController tabBar]items]objectAtIndex:1]setEnabled:isEnable];
    [[[[self.tabBarController tabBar]items]objectAtIndex:2]setEnabled:isEnable];
    [[[[self.tabBarController tabBar]items]objectAtIndex:3]setEnabled:isEnable];
    [[[[self.tabBarController tabBar]items]objectAtIndex:4]setEnabled:isEnable];
}

#pragma mark - MatchUserScreen
-(void)AddMatchUserScreen
{
    dispatch_async(dispatch_get_main_queue(), ^{
        // UI UPDATION 1
        
        CATransition* transition = [CATransition animation];
        transition.startProgress = 0;
        transition.endProgress = 1.0;
        transition.type = @"flip";
        transition.subtype = @"fromRight";
        transition.duration = 0.4;
        transition.repeatCount = 3;
        
        [img1.layer addAnimation:transition forKey:@"transition"];
        [img2.layer addAnimation:transition forKey:@"transition"];
        
        [view_chat setFrame:CGRectMake(view_chat.frame.origin.x, self.view.frame.size.height+view_chat.frame.size.height, view_chat.frame.size.width, view_chat.frame.size.height)];
        [view_home setFrame:CGRectMake(view_home.frame.origin.x, self.view.frame.size.height+view_home.frame.size.height, view_home.frame.size.width, view_home.frame.size.height)];
        
        [UIView animateWithDuration:1.00 animations:^{
            view_chat.frame =  CGRectMake(view_chat.frame.origin.x, 440, view_chat.frame.size.width, view_chat.frame.size.height);
            view_home.frame =  CGRectMake(view_home.frame.origin.x, 440, view_home.frame.size.width, view_home.frame.size.height);
        }];
        
        [img_check1 setAlpha:0.1];
        [img_check2 setAlpha:0.1];
        [lbl_matchuserbg setAlpha:0.1];
        [img_matchuserlogo setAlpha:0.1];
        
        [UIView animateWithDuration:1.50 animations:^{
            [img1 setAlpha:1.0];
            [img2 setAlpha:1.0];
            [lbl_matchuserbg setAlpha:0.8];
            [img_matchuserlogo setAlpha:1.0];
            
            [img_check1 setAlpha:1.0];
            [img_check2 setAlpha:1.0];
            
            [self setTabbarEnable:NO];
        }];
    });
}
- (IBAction)chatTapped:(id)sender
{
    [lbl_matchuserbg setAlpha:0.8];
    [UIView animateWithDuration:0.25 animations:^{
        [lbl_matchuserbg setAlpha:0.1];
        [_globalGDXData animateWithShow:NO withView:view_matchfound];
    }];
    
    [self setTabbarEnable:YES];

    self.tabBarController.selectedIndex = 3;

}

- (IBAction)homeTapped:(id)sender
{
    [lbl_matchuserbg setAlpha:0.8];
    [UIView animateWithDuration:0.25 animations:^{
        [lbl_matchuserbg setAlpha:0.1];
        [_globalGDXData animateWithShow:NO withView:view_matchfound];
    }];
    [self setTabbarEnable:YES];

}



@end
