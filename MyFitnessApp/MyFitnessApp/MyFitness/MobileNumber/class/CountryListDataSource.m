//
//  CountryListDataSource.m
//  Country List
//
//  Created by Darshan Kunjadiya on 21/11/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//


#import "CountryListDataSource.h"

#define kCountriesFileName @"countries.json"

@interface CountryListDataSource () {
    NSArray *countriesList;
}

@end

@implementation CountryListDataSource

- (id)init
{
    self = [super init];
    if (self) {
        [self parseJSON];
    }
    
    return self;
}

- (void)parseJSON
{
    NSData *data = [NSData dataWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"countries" ofType:@"json"]];
    NSError *localError = nil;
    NSDictionary *parsedObject = [NSJSONSerialization JSONObjectWithData:data options:0 error:&localError];
    
    if (localError != nil) {
        NSLog(@"%@", [localError userInfo]);
    }
    
    countriesList = (NSArray *)parsedObject;
}

- (NSArray *)countries
{
    return countriesList;
}
@end
