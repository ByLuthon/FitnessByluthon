//
//  GlobalGDXData.h
//  CreatorApp
//




#import <Foundation/Foundation.h>
#import "AppDelegate.h"


@interface GlobalGDXData : NSObject
{
    
}



+ (id)sharedData;


// For Save Login UserData from USERDEFAULTS
- (void)saveLoginUserData :(NSDictionary *)dictUser;

// For Save Login User Token from USERDEFAULTS
- (void)saveLoginUserToken :(NSDictionary *)dictToken;

// This is for Get Login UserData from USERDEFAULTS
-(NSMutableDictionary *)userLoginData;

// This is for Get Login Token from USERDEFAULTS
-(NSMutableDictionary *)userLoginToken;


// Set navigationbar image and color
-(void)setNavigationBarSetting;

- (void)setViewMovedUp:(BOOL)movedUp :(UIViewController *)upViewController;
- (void)setViewMovedUpManually:(BOOL)movedUp :(UIViewController *)upViewController upHeight :(float)upHeight; // manually up

-(void)internetCheck;


// check that an email address is valid.
- (BOOL)isValidEmail:(NSString *)checkString;
// check that an phonenumber is valid.
- (BOOL)isValidatePhone:(NSString *)phoneNumber;
-(void)showAlertTitle:(NSString *)titleStr message:(NSString *)messageStr ViewControllerOBJ:(UIViewController *)VC;


// This is for checking string is empty or not
-(BOOL)checkStringisNull :(NSString *)checkString;

// This is for change navigationbar image

-(void)changeNavigationBarImageToTransparant :(UIViewController *)ViewControll;

// This is for change searchbar text color and font

-(void)setSearchBarFontAndTextColor:(UIViewController *)viewController;

// This is for Convert NSObject to NSDictionary
- (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj;


// This is for Convert Timestamp to Date and ago
-(NSMutableString*) timeLeftSinceDate: (NSDate *) dateT;


// Change HTML string Font
-(NSAttributedString *)htmlStringFontChange :(NSString *)htmlString;

// Change Date Formate
-(NSString *)changeDateFormat :(NSString *)strDate :(NSString *)convertFormat currentFormat :(NSString *)strCurrentFormat;

// For convert TimeStamp to Date
-(NSString *)convertTimeStampToDate:(NSString *)strTimeStamp;

// Check String value null object
-(NSString *)checkStringNull :(NSString *)strCheckValue;

// Add border and corner to UIView
-(void)addBorderToView :(float)WidthB color:(UIColor *)borderColor cornerRadius:(float)cornerR objView :(UIView *)dView;

// Convert String TO Base64 String
- (NSString*)encodeStringTo64:(NSString*)fromString;
// For Change UITextField Placeholder Color and font
-(void)changePlaceHolderColorTextField :(UITextField *)txtField Color:(UIColor *)colorR font:(UIFont*)fontR textPlaceholder :(NSString *)strPlaceholder;

// This is for set Font Size as per device size
-(int)dynamicFontSize:(int)size;

// Check Password Validation
-(BOOL)passwordValidation :(UITextField *)txtPW;

// For check dictionary key is available or not
- (BOOL)containsKey: (NSString *)key Dictionary :(NSMutableDictionary *)dict;

// This for get current timeStamp
-(double)getCurrentTimestamp;

// Convert TimeStamp to NSDate
-(NSDate *)convertToDate:(NSString*)inputDate;

// Remove Document Directory File with Name
- (void)removeFileFromDocumentDirectoryWithName:(NSString *)filename;

// Get center Rect
- (CGRect)CGRectIntegralCenteredInRect:(CGRect)innerRect withRect:(CGRect)outerRect;

//Hide-Show animation
- (void)animateWithShow:(BOOL)show withView:(UIView *)animatedView;

@end
