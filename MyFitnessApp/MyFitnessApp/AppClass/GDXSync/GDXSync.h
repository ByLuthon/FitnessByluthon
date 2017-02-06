//
//  GDXSync.h
//  CreatorApp
//

#import <Foundation/Foundation.h>
#import "AppDelegate.h"


@protocol GDXApiDelegate;

@interface GDXSync : NSObject
{
    
}

+ (id)sharedData;

// Login
-(void)loginMethod :(NSDictionary *)aDictionary;

// Register Method
-(void)registerMethod :(NSDictionary *)aDictionary;

@property (nonatomic,weak) id <GDXApiDelegate> delegate;
@end

@protocol GDXApiDelegate <NSObject>

@optional


// Login
-(void)loginData :(NSDictionary *)aLoginDict error:(NSError *)aError; // Login

// Register
-(void)registerData :(NSDictionary *)aRegisterDict error:(NSError *)aError; // Register

@end
