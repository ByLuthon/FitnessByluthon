//
//  GlobalGDXData.m
//  CreatorApp
//



#import "GlobalGDXData.h"
#import <objc/runtime.h>

GlobalGDXData *_globalGDXData = nil;


@implementation GlobalGDXData

+ (id)sharedData
{
    @synchronized(self)
    {
        if (_globalGDXData == nil){
            (void)[[self alloc] init]; // assignment not done here
        }
    }
    
    return _globalGDXData;
}

//==================================================================================

+ (id)allocWithZone:(NSZone *)zone
{
    @synchronized(self)
    {
        if (_globalGDXData == nil){
            _globalGDXData = [super allocWithZone:zone];
            
            return _globalGDXData;
        }
    }
    
    return nil; //on subsequent allocation attempts return nil
}

//==================================================================================

- (id)init
{
    if ((self = [super init])) {
        // @todo
    }
    
    return self;
}

//==================================================================================

- (id)copyWithZone:(NSZone *)zone
{
    return self;
}


// For Save Login UserData To USERDEFAULTS
- (void)saveLoginUserData :(NSDictionary *)dictUser
{
    [UserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:dictUser] forKey:@"loginUser"];
    [UserDefaults synchronize];
}

// For Save Login User Token To USERDEFAULTS
- (void)saveLoginUserToken :(NSDictionary *)dictToken
{
    [UserDefaults setObject:[NSKeyedArchiver archivedDataWithRootObject:dictToken] forKey:@"loginToken"];
    [UserDefaults synchronize];
}

// This is for Get Login UserData from USERDEFAULTS
-(NSMutableDictionary *)userLoginData
{
    NSData *dictionaryData = [UserDefaults objectForKey:@"loginUser"];
    NSMutableDictionary *dictionary = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    return dictionary;
}

// This is for Get Login Token from USERDEFAULTS
-(NSMutableDictionary *)userLoginToken
{
    NSData *dictionaryData = [UserDefaults objectForKey:@"loginToken"];
    NSMutableDictionary *dictionary = [NSKeyedUnarchiver unarchiveObjectWithData:dictionaryData];
    return dictionary;
}



//==================================================================================
#pragma mark - Extension
- (BOOL)isValidEmail:(NSString *)checkString
{
    BOOL stricterFilter = YES; // Discussion http://blog.logichigh.com/2010/09/02/validating-an-e-mail-address/
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:checkString];
}

//==================================================================================
- (BOOL)isValidatePhone:(NSString *)phoneNumber
{
    NSString *phoneRegex = @"^((\\+)|(00))[0-9]{6,14}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", phoneRegex];
    
    return [phoneTest evaluateWithObject:phoneNumber];
}
//==================================================================================

#pragma mark - Hide-Show Animation
- (void)animateWithShow:(BOOL)show withView:(UIView *)animatedView
{
    if (show == YES)
    {
        animatedView.alpha = 0;
        animatedView.hidden = NO;
        [UIView animateWithDuration:0.3 animations:^{
            animatedView.alpha = 1;
        }];
    }
    else
    {
        [UIView animateWithDuration:0.3 animations:^{
            animatedView.alpha = 0;
        } completion: ^(BOOL finished) {
            animatedView.alpha = 0;
            animatedView.hidden = finished;//if animation is finished ("finished" == *YES*), then hidden = "finished" ... (aka hidden = *YES*)
        }];
    }
}

//==================================================================================

-(void)showAlertTitle:(NSString *)titleStr message:(NSString *)messageStr ViewControllerOBJ:(UIViewController *)VC
{
    
    if ([UIAlertController class])
    {
        // Use new API to create alert controller, add action button and display it
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:titleStr message:messageStr preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* ok = [UIAlertAction actionWithTitle: @"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
            [alertController dismissViewControllerAnimated:YES completion:nil];
        }];
        [alertController addAction: ok];
        [VC presentViewController:alertController animated:YES completion:nil];
    } else {
        // We are running on old SDK as the new class is not available
        // Hide the compiler errors about deprecation and use the class available on older SDK
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:titleStr
                                                        message:messageStr
                                                       delegate:self
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles:nil];
        [alert show];
    }
}


//==================================================================================

-(void)internetCheck
{
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        NSLog(@"Reachability: %@", AFStringFromNetworkReachabilityStatus(status));
        
        if ([AFStringFromNetworkReachabilityStatus(status) isEqualToString:@"Not Reachable"]) {
            
            [UserDefaults setBool:NO forKey:@"IStatus"];
            [UserDefaults synchronize];
            
            APP_DELEGATE.isInternet = NO;
            
        } else {
            
            APP_DELEGATE.isInternet=YES;
            
            [UserDefaults setBool:YES forKey:@"IStatus"];
            [UserDefaults synchronize];
        }
    }];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}


//==================================================================================

- (UIViewController*)topViewController {
    return [self topViewControllerWithRootViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

- (UIViewController*)topViewControllerWithRootViewController:(UIViewController*)rootViewController {
    if ([rootViewController isKindOfClass:[UITabBarController class]]) {
        UITabBarController* tabBarController = (UITabBarController*)rootViewController;
        return [self topViewControllerWithRootViewController:tabBarController.selectedViewController];
    } else if ([rootViewController isKindOfClass:[UINavigationController class]]) {
        UINavigationController* navigationController = (UINavigationController*)rootViewController;
        return [self topViewControllerWithRootViewController:navigationController.visibleViewController];
    } else if (rootViewController.presentedViewController) {
        UIViewController* presentedViewController = rootViewController.presentedViewController;
        return [self topViewControllerWithRootViewController:presentedViewController];
    } else {
        return rootViewController;
    }
}

//==================================================================================

-(void)setNavigationBarSetting
{
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent animated:YES];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:kColorClear,
       NSFontAttributeName: setFontMedium(16)
       } forState:UIControlStateNormal];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:kColorClear,
       NSFontAttributeName: setFontMedium(16)
       } forState:UIControlStateSelected];
    
    [[UIBarButtonItem appearanceWhenContainedIn:[UINavigationBar class], nil] setTitleTextAttributes:
     @{NSForegroundColorAttributeName:kColorClear,
       NSFontAttributeName: setFontMedium(16)
       } forState:UIControlStateHighlighted];
    
    
    
    if (iPad){//Device is iPad
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              setFontBold(30),
                                                              NSFontAttributeName,kColorWhite,NSForegroundColorAttributeName, nil]];
    }else{
        [[UINavigationBar appearance] setTitleTextAttributes:[NSDictionary dictionaryWithObjectsAndKeys:
                                                              setFontBold(17),
                                                              NSFontAttributeName,kColorWhite,NSForegroundColorAttributeName, nil]];
    }
    
    
    [[UINavigationBar appearance] setTintColor:kColorWhite];
    
    if (iPad){
        // Uncomment to assign a custom backgroung image
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_ipad.jpg"] forBarMetrics:UIBarMetricsDefault];
    }else{
        // Uncomment to assign a custom backgroung image
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar.png"] forBarMetrics:UIBarMetricsDefault];
    }
    
    // Uncomment to change the back indicator image
    
    [[UINavigationBar appearance] setBackgroundColor:kColorClear];
    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:[UIImage imageNamed:@""]];
    
    // Uncomment to change the font style of the title
    
    [[UINavigationBar appearance] setTitleVerticalPositionAdjustment:2.0 forBarMetrics:UIBarMetricsDefault];
}


//==================================================================================

-(void)changeNavigationBarImageToTransparant :(UIViewController *)ViewControll
{
    [[UINavigationBar appearance]setShadowImage:[[UIImage alloc] init]];
    
    if (iPad){
        // Uncomment to assign a custom backgroung image
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_ipad_transparant.png"] forBarMetrics:UIBarMetricsDefault];
    }else{
        // Uncomment to assign a custom backgroung image
        [[UINavigationBar appearance] setBackgroundImage:[UIImage imageNamed:@"navigationbar_transparant.png"] forBarMetrics:UIBarMetricsDefault];
        
    }
}


//==================================================================================

// For View move up when keyboard is visible
- (void)setViewMovedUp:(BOOL)movedUp :(UIViewController *)upViewController
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = upViewController.view.frame;
    rect.origin.y = 0.0;
    
    if (movedUp){
        
        if(!IS_OS_7){
            rect.origin.y -= 150;
        }else{
            rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        }
    }
    if(!movedUp){
        rect.origin.y = 0.0f;
    }
    upViewController.view.frame = rect;
    [UIView commitAnimations];
}

// For View move up when keyboard is visible manually
- (void)setViewMovedUpManually:(BOOL)movedUp :(UIViewController *)upViewController upHeight :(float)upHeight;
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3];
    CGRect rect = upViewController.view.frame;
    rect.origin.y = 0.0;
    
    if (movedUp){
        
        if(!IS_OS_7){
            rect.origin.y -= upHeight;
        }else{
            rect.origin.y -= upHeight;
        }
    }
    if(!movedUp){
        rect.origin.y = 0.0f;
    }
    upViewController.view.frame = rect;
    [UIView commitAnimations];
}


//==================================================================================

// For check String is null or not
-(BOOL)checkStringisNull :(NSString *)checkString
{
    if (checkString == (NSString*) [NSNull null] || checkString.length == 0 )
    {
        return TRUE;
    }
    else
    {
        return FALSE;
    }
    return FALSE;
}

//==================================================================================

// This is for change searchbar text color and font
-(void)setSearchBarFontAndTextColor:(UIViewController *)viewController
{
    if (iPad){
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:kColorWhite, NSFontAttributeName:setFontMedium(17.0)}];
    }else{
        [[UITextField appearanceWhenContainedIn:[UISearchBar class], nil] setDefaultTextAttributes:@{NSForegroundColorAttributeName:kColorWhite, NSFontAttributeName:setFontMedium(14.0)}];
    }
}


// This is for convert NSObject to NSDictionary
//Add this utility method in your class.
- (NSDictionary *) dictionaryWithPropertiesOfObject:(id)obj
{
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    
    unsigned count;
    objc_property_t *properties = class_copyPropertyList([obj class], &count);
    
    for (int i = 0; i < count; i++) {
        NSString *key = [NSString stringWithUTF8String:property_getName(properties[i])];
        [dict setObject:NULLTOEMPTY([obj valueForKey:key]) forKey:key];
    }
    
    free(properties);
    
    return [NSDictionary dictionaryWithDictionary:dict];
}

//==================================================================================



//==================================================================================
// Change HTML String Font

-(NSAttributedString *)htmlStringFontChange :(NSString *)htmlString
{
    @try {
        float fontSize=0.0f;
        if (iPad) {
            fontSize=17.0f;
        } else {
            fontSize = 13.0f;
        }
        
        htmlString = [NULLTOEMPTY(htmlString) stringByAppendingString:[NSString stringWithFormat:@"<style>body{font-family: '%@'; font-size:%fpx;}</style>",
                                                                       @"Montserrat-Regular",
                                                                       fontSize]];
        NSAttributedString *attributedText = [[NSAttributedString alloc] initWithData:[htmlString dataUsingEncoding:NSUnicodeStringEncoding]
                                                                              options:@{NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
                                                                                        NSCharacterEncodingDocumentAttribute: @(NSUTF8StringEncoding)}
                                                                   documentAttributes:nil
                                                                                error:nil];
        
        return attributedText;
    }
    @catch (NSException *exception) {
        NSLog(@"%@",exception);
    }
    @finally {
        
    }
}

//==================================================================================

// For Change UITextField Placeholder Color and font
-(void)changePlaceHolderColorTextField :(UITextField *)txtField Color:(UIColor *)colorR font:(UIFont*)fontR textPlaceholder :(NSString *)strPlaceholder
{
    if ([txtField respondsToSelector:@selector(setAttributedPlaceholder:)]) {
        txtField.attributedPlaceholder = [[NSAttributedString alloc]
                                          initWithString:strPlaceholder
                                          attributes:@{
                                                       NSForegroundColorAttributeName: colorR,
                                                       NSFontAttributeName:fontR,
                                                       NSBaselineOffsetAttributeName:[NSNumber numberWithFloat:-1]
                                                       }];
    } else {
        NSLog(@"Cannot set placeholder text's color, because deployment target is earlier than iOS 6.0");
    }
}

//==================================================================================

// Change Date Formate
-(NSString *)changeDateFormat :(NSString *)strDate :(NSString *)convertFormat currentFormat :(NSString *)strCurrentFormat
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:strCurrentFormat];
    NSDate *date = [dateFormatter dateFromString:strDate];
    
    // Convert date object into desired format
    [dateFormatter setDateFormat:convertFormat];
    return [dateFormatter stringFromDate:date];
}

//==================================================================================

// For convert TimeStamp to Date
-(NSString *)convertTimeStampToDate:(NSString *)strTimeStamp
{
    NSTimeInterval _interval=[[NSString stringWithFormat:@"%@",strTimeStamp] doubleValue];
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:_interval/1000];
    NSDateFormatter *_formatter=[[NSDateFormatter alloc]init];
    [_formatter setDateFormat:@"dd/MM/yyyy 'at' kk:mm"];
    return [_formatter stringFromDate:date];
}

//==================================================================================

// Check String value null object

-(NSString *)checkStringNull :(NSString *)strCheckValue
{
    if ([strCheckValue isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return strCheckValue;
}

//==================================================================================

// Add border and corner to UIView
-(void)addBorderToView :(float)WidthB color:(UIColor *)borderColor cornerRadius:(float)cornerR objView :(UIView *)dView
{
    dView.layer.borderColor = [borderColor CGColor];
    dView.layer.borderWidth = WidthB;
    dView.layer.cornerRadius = cornerR;
    dView.layer.masksToBounds = YES;
}


//==================================================================================

// Convert String TO Base64 String
- (NSString*)encodeStringTo64:(NSString*)fromString
{
    NSData *plainData = [fromString dataUsingEncoding:NSUTF8StringEncoding];
    NSString *base64String;
    if ([plainData respondsToSelector:@selector(base64EncodedStringWithOptions:)]) {
        base64String = [plainData base64EncodedStringWithOptions:kNilOptions];  // iOS 7+
    }
    return base64String;
}

//==================================================================================

// This is for Convert Timestamp to Date and ago
-(NSMutableString*) timeLeftSinceDate: (NSDate *) dateT {
    
    NSMutableString *timeLeft = [[NSMutableString alloc]init];
    
    NSDate *today10am =[NSDate date];
    
    NSInteger seconds = [today10am timeIntervalSinceDate:dateT];
    
    NSInteger days = (int) (floor(seconds / (3600 * 24)));
    if(days) seconds -= days * 3600 * 24;
    
    NSInteger hours = (int) (floor(seconds / 3600));
    if(hours) seconds -= hours * 3600;
    
    NSInteger minutes = (int) (floor(seconds / 60));
    if(minutes) seconds -= minutes * 60;
    
    if(days) {
        [timeLeft appendString:[NSString stringWithFormat:@"%ld DAYS", (long)days*-1]];
        [timeLeft appendString:[NSString stringWithFormat:@" AGO"]];
        return timeLeft;
    }
    
    if(hours) {
        [timeLeft appendString:[NSString stringWithFormat: @"%ld HOURS ", (long)hours*-1]];
        [timeLeft appendString:[NSString stringWithFormat:@" AGO"]];
        return timeLeft;
    }
    
    if(minutes) {
        [timeLeft appendString: [NSString stringWithFormat: @"%ld MINUTES ",(long)minutes*-1]];
        [timeLeft appendString:[NSString stringWithFormat:@" AGO"]];
        return timeLeft;
    }
    if(seconds) {
        [timeLeft appendString:[NSString stringWithFormat: @"%ld SECONDS", (long)seconds*-1]];
        [timeLeft appendString:[NSString stringWithFormat:@" AGO"]];
        return timeLeft;
    }
    [timeLeft appendString:[NSString stringWithFormat:@" AGO"]];
    
    return timeLeft;
}


//==================================================================================

// This is for set Font Size as per device size
-(int)dynamicFontSize:(int)size
{
    if(IS_IPHONE_5||IS_IPHONE_4)
    {
        return size;
    }
    else
    {
        if (IS_IPHONE_6) {
            return size+2;
        } else {
            return size+4;
        }
    }
    return 0;
}

//==================================================================================

// Check Password Validation
-(BOOL)passwordValidation :(UITextField *)txtPW
{
    BOOL digit=FALSE;
    
    if([txtPW.text length] >= 7)
    {
        for (int i = 0; i < [txtPW.text length]; i++)
        {
            unichar c = [txtPW.text characterAtIndex:i];
            
            if(!digit)
            {
                digit = [[NSCharacterSet decimalDigitCharacterSet] characterIsMember:c];
            }
        }
        
        NSString *newString = [[txtPW.text componentsSeparatedByCharactersInSet:
                                [[NSCharacterSet letterCharacterSet] invertedSet]] componentsJoinedByString:@""];
        
        if(digit && [newString length] >= 6)
        {
            //do what u want
            return YES;
        }
        else
        {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAlertError
                                                            message:kAlertPasswordValidation
                                                           delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
        }
    }
    else
    {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:kAlertError
                                                        message:kAlertPasswordWordValidation
                                                       delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        
        return NO;
    }
    return NO;
}

//==================================================================================

// For check dictionary key is available or not
- (BOOL)containsKey: (NSString *)key Dictionary :(NSMutableDictionary *)dict {
    BOOL retVal = 0;
    NSArray *allKeys = [dict allKeys];
    retVal = [allKeys containsObject:key];
    return retVal;
}

//==================================================================================

// This for get current timeStamp
-(double)getCurrentTimestamp
{
    NSString * strtimestamp = [NSString stringWithFormat:@"%f",[[NSDate date] timeIntervalSince1970] * 1000];
    NSArray* foo = [strtimestamp componentsSeparatedByString: @"."];
    double ccTimestamp = [[foo objectAtIndex: 0] doubleValue];
    return ccTimestamp;
}

//==================================================================================

//==================================================================================

// Split String
-(NSMutableArray *)splitString :(NSString *)strSplit withCharacter:(NSString *)strChar
{
    return (NSMutableArray *)[strSplit componentsSeparatedByString:strChar];
}

//==================================================================================

// This is for filtered Id inTopicIndex
-(NSMutableArray *)getListenerIDSArray :(NSMutableArray *)idsArray strCheckGID :(NSString *)strGID
{
    NSMutableArray *listnerIDArray=[[NSMutableArray alloc] init];
    for (int i = 0; i < [idsArray count]; i++) {
        
        NSString *strSGID=[[idsArray objectAtIndex:i] substringToIndex:16];
        if ([strSGID isEqualToString:strGID]) {
            [listnerIDArray addObject:[idsArray objectAtIndex:i]];
        }
    }
    [listnerIDArray addObject:strGID];
    
    return listnerIDArray;
}

//==================================================================================

// Convert TimeStamp to NSDate
-(NSDate *)convertToDate:(NSString*)inputDate
{
    @try {
        NSTimeInterval _interval=[inputDate doubleValue];
        return[NSDate dateWithTimeIntervalSince1970:_interval];
    } @catch (NSException *exception) {
        NSLog(@"%@",exception);
    } @finally {
        
    }
}

//==================================================================================

// Remove Document Directory File with Name
- (void)removeFileFromDocumentDirectoryWithName:(NSString *)filename
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *filePath = [documentsPath stringByAppendingPathComponent:filename];
    NSError *error;
    BOOL success = [fileManager removeItemAtPath:filePath error:&error];
    if (success) {
        //        UIAlertView *removedSuccessFullyAlert = [[UIAlertView alloc] initWithTitle:@"Congratulations:" message:@"Successfully removed" delegate:self cancelButtonTitle:@"Close" otherButtonTitles:nil];
        //        [removedSuccessFullyAlert show];
        
        NSLog(@"File is Deleted now");
    }
    else
    {
        NSLog(@"Could not delete file -:%@ ",[error localizedDescription]);
    }
}

// Get center Rect
- (CGRect)CGRectIntegralCenteredInRect:(CGRect)innerRect withRect:(CGRect)outerRect
{
    CGFloat originX = floorf((outerRect.size.width - innerRect.size.width) * 0.5f);
    CGFloat originY = floorf((outerRect.size.height - innerRect.size.height) * 0.5f);
    CGRect bounds = CGRectMake(originX, originY, innerRect.size.width, innerRect.size.height);
    return bounds;
}


@end
