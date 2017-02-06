//
//  Cell_Fitness.h
//  MyFitnessApp
//
//  Created by macmini on 30/12/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Common.h"

@interface Cell_Fitness : UITableViewCell
{
    CAGradientLayer *gradient;
}
@property (strong, nonatomic) IBOutlet UIView *subview;
@property (strong, nonatomic) IBOutlet UIImageView *img_profile;
@property (strong, nonatomic) IBOutlet UIImageView *img;
@property (strong, nonatomic) IBOutlet UIButton *btn_intrested;
@property (strong, nonatomic) IBOutlet UIButton *btn_join;
@property (weak, nonatomic) IBOutlet UIButton *btn_user;

@end
