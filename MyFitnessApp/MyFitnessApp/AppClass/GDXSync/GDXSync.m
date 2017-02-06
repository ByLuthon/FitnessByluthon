//
//  GDXSync.m
//  CreatorApp
//
#import "GDXSync.h"

GDXSync *_gdxSync = nil;

@implementation GDXSync

+ (id)sharedData
{
    @synchronized(self)
    {
        if (_gdxSync == nil){
            (void)[[self alloc] init]; // assignment not done here
        }
    }
    
    return _gdxSync;
}


//********************************************************************* LOGIN *********************************************************************\\

// Login
#pragma mark - Login Method
-(void)loginMethod :(NSDictionary *)aDictionary
{
    /*
    NSLog(@"Request Parameter %@",aDictionary);
    NSLog(@"%@",[UserDefaults objectForKey:@"AccessToken"]);
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:[NSString stringWithFormat:@"%@%@%@",kAPIBASE_URL,kAPIVersion,kAPILogin] parameters:aDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response data %@",responseObject);
        
        if ([[self delegate] respondsToSelector:@selector(loginData:error:)])
        {
            [[self delegate] loginData:responseObject error:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([operation.responseData length] != 0) {
            NSDictionary *ErrorDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options: NSJSONReadingMutableContainers error:nil];
            [_globalGDXData showAlertTitle:kAlertFailed message:[ErrorDict objectForKey:@"message"]];
        }
        
        if ([[self delegate] respondsToSelector:@selector(loginData:error:)])
        {
            [[self delegate] loginData:nil error:error];
        }
    }];
     */    
}

#pragma mark - Register Method
-(void)registerMethod :(NSMutableDictionary *)aDictionary
{
    /*
    NSLog(@"Request Parameter %@",aDictionary);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.requestSerializer setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [manager POST:[NSString stringWithFormat:@"%@%@%@",kAPIBASE_URL,kAPIVersion,kAPIRegister] parameters:aDictionary success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSLog(@"Response data %@",responseObject);
        if ([[self delegate] respondsToSelector:@selector(registerData:error:)])
        {
            [[self delegate] registerData:responseObject error:nil];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        if ([operation.responseData length] != 0) {
            NSDictionary *ErrorDict = [NSJSONSerialization JSONObjectWithData:operation.responseData options: NSJSONReadingMutableContainers error:nil];
            [_globalGDXData showAlertTitle:kAlertFailed message:[ErrorDict objectForKey:@"message"]];
            
            if ([[self delegate] respondsToSelector:@selector(registerData:error:)])
            {
                [[self delegate] registerData:ErrorDict error:error];
            }
        }
        NSLog(@"Error: %@", error);
    }];
     */
}


@end
