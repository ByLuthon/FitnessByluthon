//
//  MobileNumberViewController.m
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 21/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import "MobileNumberViewController.h"

@interface MobileNumberViewController ()

@end

@implementation MobileNumberViewController
@synthesize dataRows = _dataRows;

- (void)viewDidLoad {
    
    customPicker = (CustomPickerView *)[[[NSBundle mainBundle] loadNibNamed:@"CustomPickerView" owner:nil options:nil] objectAtIndex:0];
    customPicker.delegate = self;
    [self.view addSubview:customPicker];
    customPicker.autoresizingMask = UIViewAutoresizingFlexibleTopMargin;
    [self showPicker:NO animated:NO];
    
    CountryListDataSource *dataSource = [[CountryListDataSource alloc] init];
    _dataRows = [dataSource countries];
    
    NSMutableArray *listCountry = [NSMutableArray array];
    for (NSDictionary *dict in _dataRows) {
        [listCountry addObject:[NSString stringWithFormat:@"%@ (%@)",[dict objectForKey:kCountryName],[dict objectForKey:kCountryCallingCode]]];
    }
    
    customPicker.lists = listCountry;
    strCurrentCode = @"+1";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

#pragma mark CountryCode Action
- (IBAction)btnCountryCode:(id)sender {
    [self.view endEditing:YES];
    [self showPicker:YES animated:YES];
}
- (void)showPicker:(BOOL)bShow animated:(BOOL)bAnimated
{
    CGRect pickerFrame = CGRectMake(0, self.view.frame.size.height - customPicker.frame.size.height * bShow, 320, customPicker.frame.size.height);
    if (bAnimated) {
        
        [UIView animateWithDuration:0.25f animations:^{
            customPicker.frame = pickerFrame;
        }];
    }
    else {
        customPicker.frame = pickerFrame;
    }
}
#pragma mark Picker Action Delegate
- (void)didClickDone:(id)picker
{
    strCurrentCode = [[_dataRows objectAtIndex:customPicker.resultIndex] valueForKey:kCountryCallingCode];
    strCountryCode = [[_dataRows objectAtIndex:customPicker.resultIndex] valueForKey:kCountryCode];
    [_refBtnCountryCode setTitle:strCurrentCode forState:UIControlStateNormal];
    
    [self showPicker:NO animated:YES];
}

- (void)didClickCancel:(id)picker
{
    [self showPicker:NO animated:YES];
}

#pragma mark Continue Button Action
- (IBAction)btnContinue:(id)sender {
    
    if ([_txtMobilenumber.text length] == 0) {
        [_globalGDXData showAlertTitle:kAlertFailed message:kAlertMobileNumber ViewControllerOBJ:self];
        
    } else {
        
        NBPhoneNumberUtil *phoneUtil = [[NBPhoneNumberUtil alloc] init];
        NSError *anError = nil;
        NBPhoneNumber *myNumber = [phoneUtil parse:_txtMobilenumber.text
                                     defaultRegion:strCountryCode error:&anError];
        if (anError == nil) {
            NSLog(@"isValidPhoneNumber ? [%@]", [phoneUtil isValidNumber:myNumber] ? @"YES":@"NO");
            if ([phoneUtil isValidNumber:myNumber]) {
                
            } else {
                [_globalGDXData showAlertTitle:kAlertFailed message:kAlertValidMobileNumber ViewControllerOBJ:self];
            }
        } else {
            NSLog(@"Error : %@", [anError localizedDescription]);
            [_globalGDXData showAlertTitle:kAlertFailed message:[anError localizedDescription] ViewControllerOBJ:self];
        }
    }
}

- (IBAction)btnBack:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
