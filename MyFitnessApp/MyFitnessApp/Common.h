


#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

//----------------------------------------------------------------------------------------------------
#define WIDTH [[UIScreen mainScreen] bounds].size.width
#define HEIGHT [[UIScreen mainScreen] bounds].size.height

//----------------------------------------------------------------------------------------------------
#define BACKTOVCM(VC) NSArray *arrayNavContollers = [self.navigationController viewControllers];  NSMutableArray *arrVC = [[NSMutableArray alloc] init];  for (id controller in arrayNavContollers) { if ([controller isKindOfClass:[VC class]]) { [arrVC addObject:controller]; } }  id controller = [arrVC lastObject];  if ([controller isKindOfClass:[VC class]]) { [self.navigationController popToViewController:controller animated:YES]; }

//----------------------------------------------------------------------------------------------------

#define IS_OS_8_OR_LATER ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
//--------------------------------------------------------------------------------------------------

/*
#ifdef DEBUG
#   define DLog(str) NSLog(@"%@", str)
#else
#   define DLog(...) (void)0
#endif
*/

//--------------------------------------------------------------------------------------------------

@class GDXSync;
@class GlobalGDXData;

#pragma mark - Define Variable -
extern GlobalGDXData *_globalGDXData;
extern GDXSync *_gdxSync;


#define APP_DELEGATE ((AppDelegate *)[[UIApplication sharedApplication] delegate])
#define UserDefaults  [NSUserDefaults standardUserDefaults]


#define NULLTOEMPTY(obj) ((obj) ? (obj) : @"")

#define QUSTIONMARKNULL(obj) ((obj) ? (obj) : @"?")// For Adjust Bet View

#define NULL_TO_NIL(obj) ({ __typeof__ (obj) __obj = (obj); __obj == [NSNull null] ? nil : obj; })

#define iPad ((UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad))
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define IS_OS_7    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_IPHONE_4 ([[UIScreen mainScreen] bounds].size.height == 480.0)
#define IS_IPHONE_5 ([[UIScreen mainScreen] bounds].size.height == 568.0)
#define IS_IPHONE_6 ([[UIScreen mainScreen] bounds].size.height == 667.0)
#define IS_IPHONE_6PLUS ([[UIScreen mainScreen] nativeScale] == 3.0f)
#define IS_IPHONE_6_PLUS ([[UIScreen mainScreen] bounds].size.height == 736.0)
#define IS_RETINA ([[UIScreen mainScreen] scale] == 2.0)
#define IS_RETINA_DISPLAY ([[UIScreen mainScreen] respondsToSelector:@selector(displayLinkWithTarget:selector:)] && ([UIScreen mainScreen].scale == 2.0))
#define IS_PORTRAIT                 UIInterfaceOrientationIsPortrait([[UIApplication sharedApplication] statusBarOrientation])
#define IS_LANDSCAPE                UIInterfaceOrientationIsLandscape([[UIApplication sharedApplication] statusBarOrientation])



#define kScreenWidth [[UIScreen mainScreen] bounds].size.width
#define kScreenHeight [[UIScreen mainScreen] bounds].size.height

// Trim String
#define TRIM(string) [string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]]
#define SpaceRemover(string) [string stringByReplacingOccurrencesOfString:@"\n" withString:@""]
// Status Code
#define kSuccessStatus          200



// Logs
#define DKShowLogs  0

#define IS_IOS_8 [[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0 ? YES : NO

#define ToSTRING(...) [NSString stringWithFormat:@"%@",__VA_ARGS__]
#define NULLTOEMPTY(obj) ((obj) ? (obj) : @"")

#define QUSTIONMARKNULL(obj) ((obj) ? (obj) : @"?")// For Adjust Bet View


// Default USER Image
#define kDefaultImageURL          [NSURL URLWithString:@"default.jpg"]
#define kDefaultImage             [UIImage imageNamed:@"defaultUserIcon.jpg"]


#define kMALE                       @"male"
#define kFEMALE                     @"female"


#define kUserEmail                  @"email"
#define kUserFBID                   @"fbId"
#define kUserFirstName              @"firstname"
#define kUserLastName               @"lastname"
#define kUserUserName               @"username"
#define kUserFullName               @"fullname"
#define kUserProfilePicture         @"profilePicture"
#define kUserGender                 @"gender"
#define kUserPassword               @"password"
#define kUserMobilePhone            @"phone"
// Alerts
#define kAlertSuccess                     @"Success"
#define kAlertError                       @"Error"
#define kAlertFailed                      @"Failed"
#define kAlertPasswordsMatch              @"Passwords don't match !!"
#define kAlertEmailValid                  @"Email is not valid"
#define kAlertMobileNumber                @"Please enter mobile number!!"
#define kAlertValidMobileNumber           @"Mobile number is not valid!!"
#define kAlertEmptyFieldValid             @"All Field Are necessary.Please Fill All Detail"
#define kAlertPasswordValidation          @"Please Ensure that you have at least six characters (caps or small) and one digit in your password"
#define kAlertPasswordWordValidation      @"Please Enter at least 7 password"
#define kAlertUploadErrorTitle            @"Upload Error"
#define kAlertUploadError                 @"Error uploading image. Please try again."
#define kAlertUploadCompalsary            @"Please upload your profile picture to improve your profile."
#define kAlertTryAgainError               @"Please try again."

// KeyBoard Offset

#define kOFFSET_FOR_KEYBOARD    130.0;
#define HIDE_KEYBOARD [[[UIApplication sharedApplication] keyWindow] endEditing:YES];


#define SUCCESS_RESPONCE               @"Success"
#define Error_RESPONCE                 @"error"


//--------------------------------------------------------------------------------------------------
// Color

#define kColorWhite               [UIColor whiteColor]
#define kColorBlack               [UIColor blackColor]
#define kColorClear               [UIColor clearColor]
#define kColorLightGray           [UIColor lightGrayColor]
#define kColorDarkGray            [UIColor darkGrayColor]
#define kColorYellow              ColorFromHEX(@"#FAC701")
#define kColorRed                 ColorFromHEX(@"#FD5052")
#define kColorGreen               ColorFromHEX(@"#54C354")
#define RGBA(r,g,b,a)             [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:a]
#define kColorCell                [UIColor colorWithRed:195.0/255.0 green:200.0/255.0 blue:212.0/255.0 alpha:1.0]
#define kColorApp                 [UIColor colorWithRed:130.0/255.0 green:180.0/255.0 blue:84.0/255.0 alpha:1.0]

//--------------------------------------------------------------------------------------------------
// Alerts
#define kAlertSuccess                     @"Success"
#define kAlertError                       @"Error"
#define kAlertFailed                      @"Failed"
#define kAlertPasswordsMatch              @"Passwords don't match !!"
#define kAlertEmailValid                  @"Email is not valid"
#define kAlertEmptyFieldValid             @"All Field Are necessary.Please Fill All Detail"
// My Message
#define kAlertEmptyMessage                @"Please add message for your friend !"
#define kAlertEmptyFriendId               @"Please add any friend email id !"
#define kAlertSendMessageSuccessfully     @"Your message successfully sent"
#define kAlertSaveBetError                @"Save bet error"

//--------------------------------------------------------------------------------------------------
#define APP_API_KEY               @"zxcvfdggjhdygjuysaaskujyjhasdv@#@#@$SHD125458"
//--------------------------------------------------------------------------------------------------


// GlobalGDXData Variable

#pragma mark - Define Variable -
extern GDXSync *_gdxSync;


//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------

#pragma mark -
#pragma mark - Font

#define FONT [UIFont fontWithName:@"HelveticaNeue" size:16]

 #define setFont(s) [UIFont fontWithName:@"SFUIText-Regular" size:s]
 #define setFontMedium(s) [UIFont fontWithName:@"SFUIText-SemiBold" size:s]
 #define setFontLight(s) [UIFont fontWithName:@"SFUIText-Light" size:s]
 #define setFontItalic(s) [UIFont fontWithName:@"SFUIText-Italic" size:s]
 #define setFontBold(s) [UIFont fontWithName:@"SFUIText-Bold" size:s]

/*
#define setFont(s) [UIFont fontWithName:@"TitilliumWeb-Bold" size:s]
#define setFontMedium(s) [UIFont fontWithName:@"HelveticaNeue-Medium" size:s]
#define setFontLight(s) [UIFont fontWithName:@"MyriadPro-LightSemiExt" size:s]
*/
//--------------------------------------------------------------------------------------------------
//--------------------------------------------------------------------------------------------------


//--------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark - Languages
#define ENGLSIH_LANGUAGE 1

//--------------------------------------------------------------------------------------------------
#define API_TimeInterval 60
//----------------------------------------------------------------------------------------------------



//----------------------------------------------------------------------------------------------------

#pragma mark -
#define TEXT_LIMIT 200
//----------------------------------------------------------------------------------------------------


#pragma mark -
#pragma mark - ColorFromHEX
#define  ColorFromHEX(hexValue) ({ unsigned rgbValue = 0;  NSScanner *scanner = [NSScanner scannerWithString:hexValue];  [scanner setScanLocation:1];  [scanner scanHexInt:&rgbValue];  [UIColor colorWithRed:((rgbValue & 0xFF0000) >> 16)/255.0 green:((rgbValue & 0xFF00) >> 8)/255.0 blue:(rgbValue & 0xFF)/255.0 alpha:1.0]; })


#pragma mark - Alpha numeric
#define ALPHA                   @"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
#define NUMERIC                 @"0123456789@$ +!=*&    "
#define ALPHA_NUMERIC           ALPHA NUMERIC
//-------------------------------------------------------------------------------------------


//-------------------------------------------------------------------------------------------
#define MAXLENGTH 50
#define maxLengthOfPassword 16

#define PhoneType @"Phone"
#define ApplicationType @"1"

//-------------------------------------------------------------------------------------------

#define PASSCODE_LENGTH 4

//-------------------------------------------------------------------------------------------

#define is_internet [AppDelegate checkInternetStatus]

//-------------------------------------------------------------------------------------------

#define internetError                       @"internet Error"

//----------------------------------------------------------------------------------------------------


//Error codes
static int errorCode1 = -1001;  //The request timed out.
static int errorCode2 = -1009;  //Time out
static int errorCode3 = -1003;  //
static int errorCode4 = -1005;  //Network connection lost
static int errorCode5 = -999;   // cancel Request
static int errorCode6 = -1004;  // could not connect to server

//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------
//----------------------------------------------------------------------------------------------------

#pragma mark -
#pragma mark - Importing Class
#import "AppDelegate.h"
#import "CategoryViewController.h"
#import "startWorkoutViewController.h"
#import "CategoryViewController.h"
#import "CreateActivityViewController.h"
#import "SettingViewController.h"
#import "MyProfileViewController.h"
#import "FriendsViewController.h"
#import "EditProfileViewController.h"
#import "MapViewController.h"
#import "MessageViewController.h"
#import "HomeViewController.h"
#import "ActivityDetailsViewController.h"
#import "ChangePWDViewController.h"
#import "ContactViewController.h"
#import "LandingPageViewController.h"
#import "LoginViewController.h"
#import "IntroductionViewController.h"
#import "ActivityViewController.h"
#import "UserProfileViewController.h"


#pragma mark - Tableview Cell
#import "Cell_Fitness.h"
#import "Cell_Friends.h"
#import "MYTableViewCellcomment.h"
#import "Cell_Activity.h"


#pragma mark - Importing Framework
#import <QuartzCore/QuartzCore.h>
#import <CoreLocation/CoreLocation.h>
#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>


#pragma mark - Importing Other Class and SDK (third party)
#import "GlobalGDXData.h"
#import "GDXSync.h"
#import "WebService.h"
#import "iToast.h"
#import "ZFTokenField.h"
#import "AssetsLibrary/AssetsLibrary.h"
#import "UIImage+Resize.h"
#import "ELCImagePickerHeader.h"
#import "GDXSync.h"
#import <MBProgressHUD/MBProgressHUD.h>
#import "UIButton+EventBlocks.h"
//#import "UIImage+AFNetworking.h"
#import "UIImageView+AFNetworking.h"
#import "BasicMapAnnotation.h"
#import "CallOutAnnotationVifew.h"
#import "CalloutMapAnnotation.h"
#import "MyAnnotation.h"
#import "A3ParallaxScrollView.h"
#import "ISEmojiView.h"

//--------------------------------------------------------------------------------------------------
#pragma mark -
#pragma mark - Common URL LIST

#define common_URL @"http://cdn.rlogical.com/fitnessapp/users/"


#define API_signup                  @"signup"
#define API_signin                  @"signin"
#define API_forgotPassword          @"forgotPassword"
#define API_changePassword          @"changePassword"
#define API_profileUpdate           @"profileUpdate"

/*
#define addCrashReport common_URL@"ApiWebService.asmx/addCrashReport"
#define apiTracking common_URL@"ApiWebService.asmx/apiTracking_Version1"

//#define checkAppVersion common_URL@"ApiWebService.asmx/checkAppVersion"
#define checkAppVersion common_URL@"ApiWebService.asmx/checkAppVersion_Version1"
#define verifyCustomer common_URL@"ApiWebService.asmx/verifyCustomer"
#define getCityList common_URL@"ApiWebService.asmx/getCityList"
#define contentDetails common_URL@"ApiWebService.asmx/contentDetails"
#define registerCustomer common_URL@"ApiWebService.asmx/registerCustomer"
#define forgotPassword common_URL@"ApiWebService.asmx/forgotPassword"
#define loginCustomer common_URL@"ApiWebService.asmx/loginCustomer"
#define logoutCustomer common_URL@"ApiWebService.asmx/logoutCustomer"
#define searchCustomer common_URL@"ApiWebService.asmx/searchCustomer"
//#define searchCustomerNew common_URL@"ApiWebService.asmx/searchCustomerNew"
#define searchCustomerNew common_URL@"ApiWebService.asmx/searchCustomerNew_Version1"
#define getsearchCustomerDetails common_URL@"ApiWebService.asmx/getsearchCustomerDetails"
#define likeDislike common_URL@"ApiWebService.asmx/likeDislike"
#define UrlProfileEdit common_URL@"AppPostingData.ashx?"
#define addFavoriteCustomer common_URL@"ApiWebService.asmx/addFavoriteCustomer"
#define blockCustomer common_URL@"ApiWebService.asmx/blockCustomer"
#define reportUserAPI common_URL@"ApiWebService.asmx/reportUser"
#define disLikeUser common_URL@"ApiWebService.asmx/disLikeUser"

#define editShowMePreference common_URL@"ApiWebService.asmx/editShowMePreference"
#define editHideMeFromPreference common_URL@"ApiWebService.asmx/editHideMeFromPreference"
#define editMomentPreference common_URL@"ApiWebService.asmx/editMomentPreference"
#define editMomentPreference_Version1 common_URL@"ApiWebService.asmx/editMomentPreference_Version1"
#define getZodiacAnimal common_URL@"ApiWebService.asmx/getZodiacAnimal"

#define getMomentList common_URL@"ApiWebService.asmx/getMomentList"
#define getAllMomentByCustomerId common_URL@"ApiWebService.asmx/getAllMomentByCustomerId"
#define likeMoment common_URL@"ApiWebService.asmx/likeMoment"
#define getMomentComment common_URL@"ApiWebService.asmx/getMomentComment"
#define addMomentComment common_URL@"ApiWebService.asmx/addMomentComment"
#define deleteMomentComment common_URL@"ApiWebService.asmx/deleteMomentComment"
#define deleteMomentComment_Version1 common_URL@"ApiWebService.asmx/deleteMomentComment_Version1"

#define submitMomentCommentReport common_URL@"ApiWebService.asmx/submitMomentCommentReport"
#define submitMomentReport common_URL@"ApiWebService.asmx/submitMomentReport"
#define deleteMoment common_URL@"ApiWebService.asmx/deleteMoment"
#define getselfieParticiapteDetails common_URL@"ApiWebService.asmx/getselfieParticiapteDetails"

#define getCurrentSelfieContest common_URL@"ApiWebService.asmx/getCurrentSelfieContest"
#define getCurrentSelfieContest_Version1 common_URL@"ApiWebService.asmx/getCurrentSelfieContest_Version1"
#define getCurrentSelfieContest_Version2 common_URL@"ApiWebService.asmx/getCurrentSelfieContest_Version2"
#define getSelfieComment common_URL@"ApiWebService.asmx/getSelfieComment"
#define addSelfieComment common_URL@"ApiWebService.asmx/addSelfieComment"
#define submitCommentReport common_URL@"ApiWebService.asmx/submitCommentReport"
#define deleteComment common_URL@"ApiWebService.asmx/deleteComment"
#define deleteComment_Version1 common_URL@"ApiWebService.asmx/deleteComment_Version1"
#define addLikeToSelfieProfile common_URL@"ApiWebService.asmx/addLikeToSelfieProfile"
#define addLikeToSelfieProfile_Version1 common_URL@"ApiWebService.asmx/addLikeToSelfieProfile_Version1"
#define addLikeToSelfieProfile_Version2 common_URL@"ApiWebService.asmx/addLikeToSelfieProfile_Version2"
#define selfieLikeListing common_URL@"ApiWebService.asmx/selfieLikeListing"


#define getLikeContributorList common_URL@"ApiWebService.asmx/getLikeContributorList"
#define AddselfieContest common_URL@"selfieContest.ashx?"

#define updateSetting common_URL@"ApiWebService.asmx/updateSetting"
#define updatePassword common_URL@"ApiWebService.asmx/updatePassword"

#define getWalletListing common_URL@"ApiWebService.asmx/getWalletListing"
#define getPointPackageList common_URL@"ApiWebService.asmx/getPointPackageList"
#define purchaseLikes common_URL@"ApiWebService.asmx/purchaseLikes"
#define getLikesPackageList common_URL@"ApiWebService.asmx/getLikesPackageList"
#define addPaymentDetail common_URL@"ApiWebService.asmx/addPaymentDetail"

#define getGiftList common_URL@"ApiWebService.asmx/getGiftList"
#define sendGift common_URL@"ApiWebService.asmx/sendGift"
#define getReceiveGiftList common_URL@"ApiWebService.asmx/getReceiveGiftList"
#define updateMysteryHongbaoStatus common_URL@"ApiWebService.asmx/updateMysteryHongbaoStatus"


#define getMembershipList common_URL@"ApiWebService.asmx/getMembershipList"

#define getUserList common_URL@"ApiWebService.asmx/getUserList"
#define manageUser common_URL@"ApiWebService.asmx/manageUser"

#define getNotificationList common_URL@"ApiWebService.asmx/getNotificationList"
#define getMyMatchProfile common_URL@"ApiWebService.asmx/getMyMatchProfile"
#define myChatList common_URL@"ApiWebService.asmx/myChatList_Version1"

#define contactUs common_URL@"ApiWebService.asmx/contactUs"
#define updateLanguage common_URL@"ApiWebService.asmx/updateLanguage"
#define updateDeviceToken common_URL@"ApiWebService.asmx/updateDeviceToken"

#define weChatRegistrationResponseCheck common_URL@"ApiWebService.asmx/weChatRegistrationResponseCheck"
#define deleteChatHistory common_URL@"ApiWebService.asmx/deleteChatHistory"
#define getMyMatchForwardList common_URL@"ApiWebService.asmx/getMyMatchForwardList"
*/

/*
#pragma mark - Common URL Tag list
// Tag list
#define tag_addCrashReport 110001
#define tag_apiTracking 110002

#define tag_checkAppVersion 1
#define tag_verifyCustomer 2
#define tag_getCityList 3
#define tag_contentDetails 4
#define tag_registerCustomer 5
#define tag_forgotPassword 6
#define tag_loginCustomer 7
#define tag_logoutCustomer 8
#define tag_UrlProfileEdit 9
#define tag_getCurrentSelfieContest 11
#define tag_searchCustomer 12
#define tag_getsearchCustomerDetails 13
#define tag_likeDislike 14
#define tag_getZodiacAnimal 15
#define tag_editShowMePreference 16
#define tag_editHideMeFromPreference 17
#define tag_editMomentPreference 18
#define tag_getMomentList 19
#define tag_addLikeToSelfieProfile 20
#define tag_getLikeContributorList 21
#define tag_getSelfieComment 22
#define tag_addSelfieComment 23
#define tag_submitCommentReport 24
#define tag_deleteComment 25
#define tag_getAllMomentByCustomerId 26
#define tag_getAddselfieContest 27
#define tag_updateSetting 28
#define tag_updatePassword 29
#define tag_getWalletListing 30
#define tag_getPointPackageList 31
#define tag_likeMoment 32
#define tag_getMomentComment 33
#define tag_addMomentComment 34
#define tag_deleteMomentComment 35
#define tag_submitMomentCommentReport 36
#define tag_searchCustomerNew 37
#define tag_getGiftList 38
#define tag_sendGift 39
#define tag_addFavoriteCustomer 40
#define tag_blockCustomer 41
#define tag_reportUserAPI 42
#define tag_getUserList 43
#define tag_submitMomentReport 44
#define tag_ReceiveGiftList 45
#define tag_MembershipList 46
#define tag_PaymentDetail 47
#define tag_getMembershipList 48
#define tag_addPaymentDetail 49
#define tag_getReceiveGiftList 50
#define tag_getNotificationList 51
#define tag_getMyMatchProfile 52
#define tag_myChatList 53
#define tag_contactUs 54
#define tag_manageUser 55
#define tag_purchaseLikes 56
#define tag_getLikesPackageList 57
#define tag_deleteMoment 58
#define tag_updateLanguage 59
#define tag_disLikeUser 60
#define tag_getselfieParticiapteDetails 61
#define tag_updateDeviceToken 62
#define tag_updateMysteryHongbaoStatus 63
#define tag_getCurrentSelfieContest_Version1 64
#define tag_getCurrentSelfieContest_Version2 71
#define tag_addLikeToSelfieProfile_Version1 65
#define tag_deleteComment_Version1 66
#define tag_deleteMomentComment_Version1 67
#define tag_deleteChatHistory 68
#define tag_getMyMatchForwardList 69
#define tag_editMomentPreference_Version1 70
#define tag_addLikeToSelfieProfile_Version2 72
#define tag_selfieLikeListing 73
*/

//------------------------------------------------------------------------------------------------





