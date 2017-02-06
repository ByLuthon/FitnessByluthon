//
//  CountryListDataSource.h
//  Country List
//
//  Created by Darshan Kunjadiya on 21/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kCountryName        @"name"
#define kCountryCallingCode @"dial_code"
#define kCountryCode        @"code"

@interface CountryListDataSource : NSObject

- (NSArray *)countries;

@end
