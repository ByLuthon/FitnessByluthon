//
//  MYTableViewCell.m
//  NextBelt
//
//  Created by Bhavesh Nayi on 5/6/14.
//
//

#import "MYTableViewCellcomment.h"
#import "AppDelegate.h"

@implementation MYTableViewCellcomment

- (void)awakeFromNib
{
    app = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    
    [_btnUser setExclusiveTouch:TRUE];
    
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
