//
//  Comms.h
//  FBParse
//
//  Created by Darshan Kunjadiya on 30/11/2016.
//  Copyright (c) 2016 Darshan Kunjadiya. All rights reserved.
//

@protocol CommsDelegate <NSObject>
@optional
- (void) commsUploadImageProgress:(short)progress;
- (void) commsUploadImageComplete:(NSString *)imgURL;
@end


@interface Comms : NSObject

+ (void) uploadImage:(UIImage *)image withComment:(NSString *)comment forDelegate:(id<CommsDelegate>)delegate;

@end
