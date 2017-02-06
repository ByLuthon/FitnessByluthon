//
//  Cell_Activity.m
//  MyFitnessApp
//
//  Created by macmini on 09/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import "Cell_Activity.h"

@implementation Cell_Activity

- (void)awakeFromNib
{
    [_globalGDXData addBorderToView:1.0 color:[UIColor grayColor] cornerRadius:_img_user.frame.size.height/2 objView:_img_user];
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
