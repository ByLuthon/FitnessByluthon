//
//  Cell_Fitness.m
//  MyFitnessApp
//
//  Created by macmini on 30/12/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "Cell_Fitness.h"

@implementation Cell_Fitness

- (void)awakeFromNib
{
    
    _subview.layer.shadowColor = [[UIColor grayColor] CGColor];
    _subview.layer.shadowOffset = CGSizeMake(1.0, 0.8);
    _subview.layer.shadowRadius = 1;
    _subview.layer.shadowOpacity = 0.8;
    _subview.layer.cornerRadius = 4.0;
    _subview.layer.masksToBounds = NO;

    [_globalGDXData addBorderToView:1 color:ColorFromHEX(@"#AE71FE") cornerRadius:7 objView:_btn_join];
    [_globalGDXData addBorderToView:1 color:ColorFromHEX(@"#AE71FE") cornerRadius:7 objView:_btn_intrested];
    
    [_globalGDXData addBorderToView:1 color:kColorLightGray cornerRadius:self.img_profile.frame.size.height/2 objView:self.img_profile];

    
    gradient = [CAGradientLayer layer];
    gradient.frame = CGRectMake(0, 0, _img.frame.size.width , _img.frame.size.height);
    gradient.colors = @[(id)[[UIColor clearColor] CGColor],
                        (id)[[UIColor clearColor] CGColor],
                        //(id)[[UIColor clearColor] CGColor],
                        (id)[[UIColor darkGrayColor] CGColor]];
    [_img.layer insertSublayer:gradient atIndex:0];

    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.accessoryType = UITableViewCellAccessoryNone;
    
    
    [super awakeFromNib];
    // Initialization code
}
- (void)layoutSubviews
{
    [super layoutSubviews];
    [self.contentView layoutIfNeeded];

    gradient.frame = CGRectMake(0, 0, self.frame.size.width , _img.frame.size.height);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
