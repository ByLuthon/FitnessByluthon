//
//  CustomPickerView.h
//
//  Created by Darshan Kunjadiya on 21/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol PickerActionDelegate

@optional;
- (void)didClickCancel:(id)picker;
- (void)didClickDone:(id)picker;

@end

@interface CustomPickerView : UIView <UIPickerViewDataSource, UIPickerViewDelegate> {

}

@property (nonatomic, assign) IBOutlet UIButton *_btnCancel;
@property (nonatomic, assign) IBOutlet UIButton *_btnDone;

@property (nonatomic, assign) IBOutlet UIPickerView *pickerView;

@property (nonatomic, assign) id<PickerActionDelegate> delegate;
@property (nonatomic, readwrite) int resultIndex;

@property (nonatomic, strong) NSMutableArray *lists;

- (IBAction)actionCancel;
- (IBAction)actionDone;

@end
