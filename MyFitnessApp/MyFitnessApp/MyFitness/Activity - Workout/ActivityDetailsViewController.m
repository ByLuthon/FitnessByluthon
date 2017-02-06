//
//  ActivityDetailsViewController.m
//  MyFitnessApp
//
//  Created by macmini on 05/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import "ActivityDetailsViewController.h"

@interface ActivityDetailsViewController ()

@end

@implementation ActivityDetailsViewController

- (void)viewDidLoad
{
    
    [self SetInitParam];

    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self registerForKeyboardNotifications];
   
    [txtview_comment resignFirstResponder];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [txtview_comment resignFirstResponder];
    
    [self deregisterFromKeyboardNotifications];
    [super viewWillDisappear:animated];
}


-(void)SetInitParam
{
    CAGradientLayer *gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, WIDTH , img_activity.frame.size.height);
    gradient.colors = @[(id)[[UIColor clearColor] CGColor],
                        (id)[[UIColor clearColor] CGColor],
                        (id)[[UIColor clearColor] CGColor],
                        (id)[[UIColor darkGrayColor] CGColor]];
    [img_activity.layer insertSublayer:gradient atIndex:0];
    
    // create ParallaxScrollView
    self.parallaxScrollView = [[A3ParallaxScrollView alloc] initWithFrame:CGRectMake(0, 65, WIDTH, HEIGHT - (65 + viewAddComment.frame.size.height))];
    self.parallaxScrollView.delegate = self;
    [self.view addSubview:self.parallaxScrollView];
    CGSize contentSize = self.parallaxScrollView.frame.size;
    
    // add header and content
    CGRect headerFrame = img_activity.frame;
    //headerFrame.origin.x = 60.0;
    //headerFrame.origin.y -= 122.0f;
    headerFrame.size.width = WIDTH;

    img_activity.frame = headerFrame;
    [self.parallaxScrollView addSubview:img_activity withAcceleration:CGPointMake(0.0f, 0.5f)];
    
    CGRect contentFrame = subview_activity.frame;
    contentFrame.origin.y += 122.0f;
    contentFrame.size.width = WIDTH;
    contentFrame.size.height = tbl_comment.frame.origin.y + (55*10);
    subview_activity.frame = contentFrame;
    [self.parallaxScrollView addSubview:subview_activity];
    
    
    contentSize.height = contentFrame.size.height + contentFrame.origin.y;
    self.parallaxScrollView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    self.parallaxScrollView.contentSize = contentSize;

    [self.view bringSubviewToFront:viewAddComment];
    tbl_comment.frame = CGRectMake(tbl_comment.frame.origin.x, tbl_comment.frame.origin.y, tbl_comment.frame.size.width, 55*10);
    tbl_comment.scrollEnabled = FALSE;
    
    
    [self setJoinUsers];
    
    
    isEmojiTapped = NO;
    lbl_placeholder.text = @"Write a comment";
}

-(void)setJoinUsers
{
    int x = 0;
    for (int i = 0; i < 15; i++)
    {
        UIView *subview = [[UIView alloc] initWithFrame:CGRectMake(x, 0, 80, scrl_JoinUsers.frame.size.height)];
        subview.backgroundColor = [UIColor clearColor];
        
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(10, 5, 60, 60)];
        img.image = [UIImage imageNamed:@"profile_img.png"];
        [_globalGDXData addBorderToView:1.0 color:[UIColor lightGrayColor] cornerRadius:img.frame.size.height/2 objView:img];
        [subview addSubview:img];
        
        UILabel *lblname = [[UILabel alloc] initWithFrame:CGRectMake(0, subview.frame.size.height - 20, subview.frame.size.width, 20)];
        lblname.text = @"Cory";
        lblname.textColor = [UIColor darkGrayColor];
        lblname.font = setFont(14);
        lblname.textAlignment = NSTextAlignmentCenter;
        [subview addSubview:lblname];
        
        [scrl_JoinUsers addSubview:subview];
        
        UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:img.frame];
        [btn setOnTouchUpInside:^(id sender, UIEvent *event)
         {
             UserProfileViewController *move = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
             [self.navigationController pushViewController:move animated:YES];
         }];
        [subview addSubview:btn];
        
        x = x + subview.frame.size.width;
    }
    scrl_JoinUsers.contentSize = CGSizeMake(80*15, scrl_JoinUsers.frame.size.height);
    scrl_JoinUsers.showsHorizontalScrollIndicator = FALSE;
    scrl_JoinUsers.showsVerticalScrollIndicator = FALSE;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)btnBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
#pragma mark - Tableview Delegate
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"cell %ld %ld",(long)indexPath.row,(long)indexPath.section];
    
    MYTableViewCellcomment *cell = (MYTableViewCellcomment *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    cell = nil;
    
    if (cell == nil)
    {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MYTableViewCellcomment" owner:nil options:nil];
        cell = [topLevelObjects objectAtIndex:0];
        cell.backgroundColor = [UIColor clearColor];
        
        
        __weak MYTableViewCellcomment *weakCell = cell;
        
        cell.backgroundColor = [UIColor clearColor];

        
        [_globalGDXData addBorderToView:0.0 color:[UIColor clearColor] cornerRadius:10 objView:cell.lbl_BG];
        [_globalGDXData addBorderToView:1.0 color:[UIColor grayColor] cornerRadius:cell.img_user.frame.size.height/2 objView:cell.img_user];
        
        
        [UIView transitionWithView:cell.img_user
                          duration:5.0f
                           options:UIViewAnimationOptionTransitionCrossDissolve
                        animations:^{
                            weakCell.img_user.image = [UIImage imageNamed:@"emptyProfilePic.png"];
                            //[cell.img_user setImageWithURL:[NSURL URLWithString:[[ArrCmt objectAtIndex:indexPath.row] objectForKey:@"photo"]] placeholderImage:[UIImage imageNamed:strUserPlaceholderImage]];
                        } completion:nil];
        
        
        
        cell.lbl_username.text = @"Lula Alexander";
        cell.lbl_time.text = @"10 min ago";
        cell.lbl_cmt.text = @"Lorem ipsum dolor sit amet, pri ea paulo dignissim urbanitas. Partem aperiri ut vel, eu per tale facer, eu his option tibique. Fuisset minimum sea ea, oblique efficiendi ea sit. Ut duo tantas facilisis,";
        
        UIButton *btn =  [UIButton buttonWithType:UIButtonTypeCustom];
        [btn setFrame:cell.img_user.frame];
        [btn setOnTouchUpInside:^(id sender, UIEvent *event)
         {
             UserProfileViewController *move = [self.storyboard instantiateViewControllerWithIdentifier:@"UserProfileViewController"];
             [self.navigationController pushViewController:move animated:YES];
         }];
        [cell.contentView addSubview:btn];


        //cell.btnUser.tag = indexPath.row;
        //[cell.btnUser addTarget:self action:@selector(UserProfileClick:) forControlEvents:UIControlEventTouchUpInside];
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    [txtview_comment resignFirstResponder];
}


#pragma mark - scrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    // accelerate header just with half speed down, but with normal speed up
    if (scrollView.contentOffset.y > 0)
    {
        [self.parallaxScrollView setAcceleration:CGPointMake(0.0f, 0.5f) forView:img_activity];
    }
    else
    {
        [self.parallaxScrollView setAcceleration:A3DefaultAcceleration forView:subview_activity];
    }
}

#pragma mark - keyboard notif

- (void)registerForKeyboardNotifications
{
    [self deregisterFromKeyboardNotifications];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

- (void)deregisterFromKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}
- (void)keyboardWasShown:(NSNotification *)notification
{
    lbl_placeholder.hidden = TRUE;
    
    NSDictionary* info = [notification userInfo];
    //CGSize currentKeyboardSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    CGSize currentKeyboardSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    
    keyboardHeight = currentKeyboardSize.height;
    [self setViewMovedUp:YES];
}

- (void)keyboardWillBeHidden:(NSNotification *)notification
{
    keyboardHeight = 0;
    [self setViewMovedUp:NO];
    
    //[self.scrollView setContentOffset:CGPointZero animated:YES];
}
- (void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = viewAddComment.frame;
    
    rect.origin.y = self.view.frame.size.height - viewAddComment.frame.size.height;
    if (movedUp)
    {
        rect.origin.y -= keyboardHeight;
        
        CGPoint bottomOffset = CGPointMake(0, self.parallaxScrollView.contentSize.height - self.parallaxScrollView.bounds.size.height + keyboardHeight);
        [self.parallaxScrollView setContentOffset:bottomOffset animated:YES];

        NSIndexPath *indexPath = [NSIndexPath indexPathForRow:10 inSection:0];
        [tbl_comment scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    }
    
    if(!movedUp)
    {
        rect.origin.y = HEIGHT - viewAddComment.frame.size.height;
    }
    
    viewAddComment.frame = rect;
    
    [UIView commitAnimations];
}

#pragma mark - emoji Delgate
- (IBAction)btnEmojiTapped:(id)sender
{
    [txtview_comment resignFirstResponder];
    
    if (isEmojiTapped == NO)
    {
        [btn_emoji setImage:[UIImage imageNamed:@"keyboard.png"] forState:UIControlStateNormal];
        isEmojiTapped = YES;
        emojiView = [[ISEmojiView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 216)];
        emojiView.delegate = self;
        emojiView.inputView = txtview_comment;
        txtview_comment.inputView = emojiView;
        [txtview_comment becomeFirstResponder];
        //keyboard.png
    }
    else
    {
        [btn_emoji setImage:[UIImage imageNamed:@"emoji.png"] forState:UIControlStateNormal];
        [emojiView removeFromSuperview];
        txtview_comment.inputView = nil;
        [txtview_comment becomeFirstResponder];
        isEmojiTapped = NO;
    }
}

//ISEMOJIs Delgate
-(void)emojiView:(ISEmojiView *)emojiView didSelectEmoji:(NSString *)emoji
{
    txtview_comment.text = [txtview_comment.text stringByAppendingString:emoji];
    //StrComment = [StrComment stringByAppendingString:emoji];
}

-(void)emojiView:(ISEmojiView *)emojiView didPressDeleteButton:(UIButton *)deletebutton
{
    if (txtview_comment.text.length > 0)
    {
        NSRange lastRange = [txtview_comment.text rangeOfComposedCharacterSequenceAtIndex:txtview_comment.text.length-1];
        //NSRange lastRangestr = [StrComment rangeOfComposedCharacterSequenceAtIndex:StrComment.length-1];
        
        txtview_comment.text = [txtview_comment.text substringToIndex:lastRange.location];
        //StrComment =  (NSMutableString *)[StrComment substringToIndex:lastRangestr.location];
    }
}

@end
