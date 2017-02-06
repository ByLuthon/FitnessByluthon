//
//  UzysImageCropperViewController.h
//  UzysImageCropper
//
//  Created by Uzys on 11. 12. 13..
//

#import <UIKit/UIKit.h>
#import "UzysImageCropper.h"
#import "ARCHelper.h"
#import "Common.h"
#import "AppDelegate.h"

@protocol UzysImageCropperDelegate;
@class  UzysImageCropper;
@class AppDelegate;
@interface UzysImageCropperViewController : UIViewController
{
  //  NSArray *arrImages;
    UIScrollView *scrollView;
    int idxOfSelImage;
    UIView *view;
    UIView *viewBottom;
    NSMutableArray *arrImages;
    NSMutableDictionary *GetDetailsDict;
    
    UIView *img_bg_view;
    
    AppDelegate *app;

}
@property (nonatomic,strong) NSMutableDictionary *GetDetailsDict;
@property (nonatomic) BOOL isRequestScreen;
@property (nonatomic) BOOL isFromAddPostVC;
@property (nonatomic,strong) NSMutableArray *arrImages;
@property (nonatomic,strong) NSString *strScreenName;
@property (nonatomic,strong) NSString *strScreen;
@property (nonatomic,strong) NSString *strRatesId;
@property (nonatomic,strong) UzysImageCropper *cropperView;
@property (nonatomic, assign) id <UzysImageCropperDelegate> delegate;
- (id)initWithImage:(UIImage*)newImage andframeSize:(CGSize)frameSize andcropSize:(CGSize)cropSize arrImages:(NSMutableArray *)array isFrmAddItemVC:(BOOL)isFromAddItemVC screenName:(NSString *)strViewName;

- (void)actionRotation:(id) senders;

@end

@protocol UzysImageCropperDelegate <NSObject>
@optional
- (void)getImage:(UIImage *)image;
- (void)imageCropper:(UzysImageCropperViewController *)cropper didFinishCroppingWithImage:(UIImage *)image;
- (void)imageCropperDidCancel:(UzysImageCropperViewController *)cropper;
@end
