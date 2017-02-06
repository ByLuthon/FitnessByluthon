//
//  WorkoutCVCell.m
//  MyFitnessApp
//
//  Created by macmini on 01/12/16.
//
//

#import "WorkoutCVCell.h"

@implementation WorkoutCVCell

- (void)awakeFromNib {
    // Initialization code
    
    [_globalGDXData addBorderToView:0 color:kColorClear cornerRadius:self.refBtnCategory.bounds.size.height/2 objView:self.refBtnCategory];
    [_globalGDXData addBorderToView:0 color:kColorClear cornerRadius:7 objView:self];
    
    CABasicAnimation* anim = [CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    [anim setToValue:[NSNumber numberWithFloat:0.0f]];
    [anim setFromValue:[NSNumber numberWithDouble:M_PI/30]];
    [anim setDuration:0.1];
    [anim setRepeatCount:NSUIntegerMax];
    [anim setAutoreverses:YES];
    //self.refBtnCategory.layer.shouldRasterize = YES;
    [self.refBtnCategory.layer addAnimation:anim forKey:@"SpringboardShake"];

    //self.lblCatName.layer.shouldRasterize = YES;
    [self.lblCatName.layer addAnimation:anim forKey:@"SpringboardShake"];
    
    /*
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    animation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    animation.duration = 0.9;
    animation.autoreverses=YES;
    animation.repeatCount=NSUIntegerMax;
    animation.values = @[ @(-3), @(3), @(-3), @(2), @(-2), @(2), @(-1), @(1), @(0)];
    [self.refBtnCategory.layer addAnimation:animation forKey:@"shake"];
    */

    [super awakeFromNib];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSArray *arrayOfViews;
        arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"WorkoutCVCell" owner:self options:nil];
        if ([arrayOfViews count] < 1) {
            return nil;
        }
        
        if (![[arrayOfViews objectAtIndex:0] isKindOfClass:[UICollectionViewCell class]]) {
            return nil;
        }
        
        self = [arrayOfViews objectAtIndex:0];
    }
    
    return self;
    
}
@end
