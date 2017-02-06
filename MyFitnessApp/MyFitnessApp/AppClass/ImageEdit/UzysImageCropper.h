//
//  UzysImageCropper.h
//  UzysImageCropper
//
//  Created by Uzys on 11. 12. 13..
//

#import <UIKit/UIKit.h>
#import "ARCHelper.h"

@protocol imageCropperDelegate <NSObject>

-(int)getHeight:(int)height;

@end

@interface UzysImageCropper : UIView <UIGestureRecognizerDelegate>
{
    id<imageCropperDelegate>delegate;
    
    double _imageScale; //frame : image
    double _translateX;
    double _translateY;
    
    CGRect _imgViewframeInitValue; //imgView는 가운데 정렬 되므로 초기값 위치가 (0,0)이 아니므로 위치를 알아야함
    CGPoint _imgViewcenterInitValue;
    CGSize _realCropsize;
    UIView* _cropperView;
    
    BOOL isFrame;
    CGRect imgframe;
}
@property (nonatomic,strong) id<imageCropperDelegate>delegate;
@property (nonatomic,strong) UIImage *inputImage;
@property (nonatomic,strong) UIImageView *imgView;
@property (nonatomic,assign) CGRect cropRect;

@property (nonatomic) int hei;
- (id)initWithImage:(UIImage*)newImage andframeSize:(CGSize)frameSize andcropSize:(CGSize)cropSize;
- (UIImage*) getCroppedImage;
- (BOOL) saveCroppedImage:(NSString *)path;
-(void)setImage:(UIImage *)setImage;
- (void) actionRotate;
- (void) actionRestore;
@end
