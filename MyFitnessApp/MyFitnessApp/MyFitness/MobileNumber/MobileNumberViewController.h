//
//  MobileNumberViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 21/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CountryListDataSource.h"
#import "CustomPickerView.h"

@interface MobileNumberViewController : UIViewController<PickerActionDelegate>
{
    CustomPickerView *customPicker;
    NSString *strCurrentCode;
    NSString *strCountryCode;
}
@property (nonatomic, strong) NSArray *dataRows;
- (IBAction)btnBack:(id)sender;
- (IBAction)btnCountryCode:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *refBtnCountryCode;
- (IBAction)btnContinue:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *txtMobilenumber;

@end
