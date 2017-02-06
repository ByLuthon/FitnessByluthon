//
//  CreateActivityViewController.h
//  MyFitnessApp
//
//  Created by rlogical-dev-21 on 08/12/16.
//  Copyright © 2016 rlogical-dev-21. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UzysImageCropperViewController.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "ELCImagePickerHeader.h"

@interface CreateActivityViewController : UIViewController
{

}
@property (nonatomic, retain) ALAssetsLibrary * assetsLibrary;

- (IBAction)btnBack:(id)sender;

@end
