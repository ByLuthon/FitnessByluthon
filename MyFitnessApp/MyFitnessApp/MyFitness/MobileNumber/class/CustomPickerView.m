//
//  CustomPickerView.m
//
//  Created by Darshan Kunjadiya on 21/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//


#import "CustomPickerView.h"

@implementation CustomPickerView

@synthesize resultIndex;
@synthesize delegate;
@synthesize lists = _lists;

@synthesize _btnCancel, _btnDone;
@synthesize pickerView;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _lists = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        _lists = [[NSMutableArray alloc] init];
    }
    
    return self;
}

- (void)actionCancel
{
    if ([(id)delegate respondsToSelector:@selector(didClickCancel:)]) {

        [delegate didClickCancel:self];
    }
}

- (void)actionDone
{
    resultIndex = (int)[pickerView selectedRowInComponent:0];

    if ([(id)delegate respondsToSelector:@selector(didClickDone:)]) {

        [delegate didClickDone:self];
    }
}

- (NSMutableArray *)lists
{
    return _lists;
}

- (void)setLists:(NSMutableArray *)lists
{
    _lists = lists;
    
    [pickerView reloadAllComponents];
}

#pragma mark - UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

// returns the # of rows in each component..
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [_lists count];
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [_lists objectAtIndex:row];
}

#pragma mark - UIPickerViewDelegate
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    return;
}

@end
