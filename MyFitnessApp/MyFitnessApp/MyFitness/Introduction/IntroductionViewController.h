//
//  IntroductionViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 29/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IntroductionViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIScrollView *scrlIntroduction;
- (IBAction)pageControlClickEvent:(id)sender;
@property (weak, nonatomic) IBOutlet UIPageControl *refPageControl;
- (IBAction)btnNext:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *imgW;
@property (weak, nonatomic) IBOutlet UIImageView *imgSplashHover;
@property (weak, nonatomic) IBOutlet UIImageView *txtWorkOutText;

@end
