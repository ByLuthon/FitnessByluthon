//
//  CustomTextField.m
//  Fitness
//
//  Created by rlogical-dev-21 on 09/01/17.
//  Copyright © 2017 rlogical-dev-21. All rights reserved.
//

#import "CustomTextField.h"

IB_DESIGNABLE
@implementation CustomTextField

@synthesize padding;

-(CGRect)textRectForBounds:(CGRect)bounds{
    return CGRectInset(bounds, padding, padding);
}

-(CGRect)editingRectForBounds:(CGRect)bounds{
    return [self textRectForBounds:bounds];
}

@end

