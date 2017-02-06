//
//  MyAnnotation.m
//  Map
//
//  Created by Palak Patel on 12/03/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "MyAnnotation.h"


@implementation MyAnnotation

@synthesize coordinate, title, subtitle,tag;

- (NSString *)title
{
    return title;
}
- (NSNumber *)pinID {
	return tag;
}

// optional
- (NSString *)subtitle
{
    return subtitle;
}
-(void)dealloc 
{
	[title release];
	[subtitle release];
	[super dealloc];
}

@end