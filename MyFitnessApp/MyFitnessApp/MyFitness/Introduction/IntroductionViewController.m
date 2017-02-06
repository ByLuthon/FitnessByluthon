//
//  IntroductionViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 29/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "IntroductionViewController.h"
#import "LandingPageViewController.h"

@interface IntroductionViewController ()

@end

@implementation IntroductionViewController

- (void)viewDidLoad {
    
    self.navigationController.navigationBarHidden=true;
    
    int x=0;
    for (int i=0; i < 4; i++) {
        
        UIImageView *imgIntro=[[UIImageView alloc] init];
        imgIntro.frame=CGRectMake(x, 0, kScreenWidth, _scrlIntroduction.bounds.size.height);
        imgIntro.image=[UIImage imageNamed:[NSString stringWithFormat:@"splash_%d",i]];
        [_scrlIntroduction addSubview:imgIntro];
        x+=kScreenWidth;
    }
    

    NSLog(@"%d",x);
    
    _refPageControl.numberOfPages=4;
    _refPageControl.currentPage=0;
    _scrlIntroduction.pagingEnabled=true;
    _scrlIntroduction.contentSize=CGSizeMake(x, 50);
    
    [_scrlIntroduction.superview bringSubviewToFront:_imgW];
    [_scrlIntroduction.superview bringSubviewToFront:_txtWorkOutText];
    [_scrlIntroduction.superview bringSubviewToFront:_imgSplashHover];
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView;
{
    int x = _scrlIntroduction.contentOffset.x/kScreenWidth;
    _refPageControl.currentPage=x;
}

- (IBAction)pageControlClickEvent:(id)sender {
    
}
- (IBAction)btnNext:(id)sender {
    
    if (_refPageControl.currentPage == 3)
    {
        NSLog(@"Last screen");
        
        [UserDefaults setBool:true forKey:@"isIntroductionDone"];
        [UserDefaults synchronize];
        
        LandingPageViewController *landingVC=[self.storyboard instantiateViewControllerWithIdentifier:@"LandingPageViewController"];
        [self.navigationController pushViewController:landingVC animated:YES];

    }
    else
    {
        _refPageControl.currentPage=_refPageControl.currentPage+1;
        CGRect frame = _scrlIntroduction.frame;
        frame.origin.x = kScreenWidth * _refPageControl.currentPage;
        frame.origin.y = 0;
        [_scrlIntroduction scrollRectToVisible:frame animated:YES];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
