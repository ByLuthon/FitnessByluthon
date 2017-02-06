//
//  CategoryCVCell.m
//  MyFitnessApp
//
//  Created by macmini on 30/11/16.
//
//

#import "CategoryCVCell.h"

@implementation CategoryCVCell

- (void)awakeFromNib {
    // Initialization code
    
    [_globalGDXData addBorderToView:0 color:kColorClear cornerRadius:7 objView:self.refBtnCategory];
    [_globalGDXData addBorderToView:0 color:kColorClear cornerRadius:7 objView:self];
    
    [super awakeFromNib];
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        // Initialization code
        NSArray *arrayOfViews;
        arrayOfViews = [[NSBundle mainBundle] loadNibNamed:@"CategoryCVCell" owner:self options:nil];
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
