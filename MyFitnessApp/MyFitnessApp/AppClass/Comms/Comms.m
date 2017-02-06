//
//  Comms.m
//  FBParse
//
//  Created by Darshan Kunjadiya on 30/11/2016.
//  Copyright (c) 2016 Darshan Kunjadiya. All rights reserved.
//

#import "Comms.h"

@implementation Comms

+ (void) uploadImage:(UIImage *)image withComment:(NSString *)comment forDelegate:(id<CommsDelegate>)delegate
{
    // 1
    NSData *imageData = UIImagePNGRepresentation(image);
	
    // 2
    PFFile *imageFile = [PFFile fileWithName:comment data:imageData];
    [imageFile saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error) {
        if (succeeded) {
            // 3
            if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
                [delegate commsUploadImageComplete:imageFile.url];
            }
        } else {
			// 4
            if ([delegate respondsToSelector:@selector(commsUploadImageComplete:)]) {
                [delegate commsUploadImageComplete:@""];
            }
        }
    } progressBlock:^(int percentDone) {
		// 5
		if ([delegate respondsToSelector:@selector(commsUploadImageProgress:)]) {
			[delegate commsUploadImageProgress:percentDone];
		}
    }];
}


@end
