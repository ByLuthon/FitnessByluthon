//
//  WebService.m
//  WebServiceCall
//
//  Created by Marwadi  on 03/08/15.
//  Copyright (c) 2015 Abbacus. All rights reserved.
//

#import "WebService.h"
#import "AppDelegate.h"
#import <sys/utsname.h>

@implementation WebService
@synthesize delegate;
- (id) init
{
    if (self = [super init])
    {
        
    }
    return self;
}
- (NSString*) deviceName
{
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString* code = [NSString stringWithCString:systemInfo.machine
                                        encoding:NSUTF8StringEncoding];
    
    static NSDictionary* deviceNamesByCode = nil;
    
    if (!deviceNamesByCode) {
        
        deviceNamesByCode = @{@"i386"      :@"Simulator",
                              @"x86_64"    :@"Simulator",
                              @"iPod1,1"   :@"iPod Touch",        // (Original)
                              @"iPod2,1"   :@"iPod Touch",        // (Second Generation)
                              @"iPod3,1"   :@"iPod Touch",        // (Third Generation)
                              @"iPod4,1"   :@"iPod Touch",        // (Fourth Generation)
                              @"iPod7,1"   :@"iPod Touch",        // (6th Generation)
                              @"iPhone1,1" :@"iPhone",            // (Original)
                              @"iPhone1,2" :@"iPhone",            // (3G)
                              @"iPhone2,1" :@"iPhone",            // (3GS)
                              @"iPad1,1"   :@"iPad",              // (Original)
                              @"iPad2,1"   :@"iPad 2",            //
                              @"iPad3,1"   :@"iPad",              // (3rd Generation)
                              @"iPhone3,1" :@"iPhone 4",          // (GSM)
                              @"iPhone3,3" :@"iPhone 4",          // (CDMA/Verizon/Sprint)
                              @"iPhone4,1" :@"iPhone 4S",         //
                              @"iPhone5,1" :@"iPhone 5",          // (model A1428, AT&T/Canada)
                              @"iPhone5,2" :@"iPhone 5",          // (model A1429, everything else)
                              @"iPad3,4"   :@"iPad",              // (4th Generation)
                              @"iPad2,5"   :@"iPad Mini",         // (Original)
                              @"iPhone5,3" :@"iPhone 5c",         // (model A1456, A1532 | GSM)
                              @"iPhone5,4" :@"iPhone 5c",         // (model A1507, A1516, A1526 (China), A1529 | Global)
                              @"iPhone6,1" :@"iPhone 5s",         // (model A1433, A1533 | GSM)
                              @"iPhone6,2" :@"iPhone 5s",         // (model A1457, A1518, A1528 (China), A1530 | Global)
                              @"iPhone7,1" :@"iPhone 6 Plus",     //
                              @"iPhone7,2" :@"iPhone 6",          //
                              @"iPhone8,1" :@"iPhone 6S",         //
                              @"iPhone8,2" :@"iPhone 6S Plus",    //
                              @"iPhone8,4" :@"iPhone SE",         //
                              @"iPhone9,1" :@"iPhone 7",          //
                              @"iPhone9,3" :@"iPhone 7",          //
                              @"iPhone9,2" :@"iPhone 7 Plus",     //
                              @"iPhone9,4" :@"iPhone 7 Plus",     //
                              
                              @"iPad4,1"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Wifi
                              @"iPad4,2"   :@"iPad Air",          // 5th Generation iPad (iPad Air) - Cellular
                              @"iPad4,4"   :@"iPad Mini",         // (2nd Generation iPad Mini - Wifi)
                              @"iPad4,5"   :@"iPad Mini",         // (2nd Generation iPad Mini - Cellular)
                              @"iPad4,7"   :@"iPad Mini",         // (3rd Generation iPad Mini - Wifi (model A1599))
                              @"iPad6,7"   :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1584)
                              @"iPad6,8"   :@"iPad Pro (12.9\")", // iPad Pro 12.9 inches - (model A1652)
                              @"iPad6,3"   :@"iPad Pro (9.7\")",  // iPad Pro 9.7 inches - (model A1673)
                              @"iPad6,4"   :@"iPad Pro (9.7\")"   // iPad Pro 9.7 inches - (models A1674 and A1675)
                              };
    }
    
    NSString* deviceName = [deviceNamesByCode objectForKey:code];
    
    if (!deviceName) {
        // Not found on database. At least guess main device type from string contents:
        
        if ([code rangeOfString:@"iPod"].location != NSNotFound) {
            deviceName = @"iPod Touch";
        }
        else if([code rangeOfString:@"iPad"].location != NSNotFound) {
            deviceName = @"iPad";
        }
        else if([code rangeOfString:@"iPhone"].location != NSNotFound){
            deviceName = @"iPhone";
        }
        else {
            deviceName = @"Unknown";
        }
    }
    
    return deviceName;
}
-(void)trackDNSfailedOrIPConnetionIssue:(NSString *)string andAPIName:(NSString *)strAPIName
{
    
    //    NSMutableDictionary *dic = [[NSMutableDictionary alloc]init];
    //    [dic setValue:[NSString stringWithFormat:@"Api_name : %@ Reason : %@, Device : %@, iOS : %@",strAPIName,string,[self deviceName],SystemVersion] forKey:@"Message"];
    //    [self API_Handle_DNS_OR_RecallingServerIP:crashReport withParams:dic];
    //    dic = nil;
}
#pragma mark - Get - Afnetworking
- (void)API_Handle_DNS_OR_RecallingServerIP:(NSString *)strFunction withParams:(NSMutableDictionary *)dic
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue cancelAllOperations];
    [manager.requestSerializer setTimeoutInterval:API_TimeInterval];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@",common_URL,strFunction]
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              // NSString *str = [[NSString alloc] initWithData:(NSData *)responseObject encoding:NSUTF8StringEncoding];
              //   NSLog(@"%@",str);
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              //  NSLog(@"error : %@",error);
              
          }];
}
#pragma mark - Get - Afnetworking
- (void)callGetWebService:(NSString *)strFunction withParams:(NSMutableDictionary *)dic
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    //  [manager.operationQueue cancelAllOperations];
    manager.securityPolicy.allowInvalidCertificates = YES;
    
    [manager.requestSerializer setTimeoutInterval:API_TimeInterval];
    [manager GET:[NSString stringWithFormat:@"%@%@",common_URL,strFunction]
      parameters:nil
         success:^(AFHTTPRequestOperation *operation, id responseObject) {
             
             NSDictionary *dicResponse = (NSDictionary *)responseObject;
             
             NSArray *arrResponse =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
             
             if(arrResponse.count == 0)
             {
                 [self internetNotAvailableOrOtherIssue:internetError];
             }
             else
             {
                 [self.delegate response:dicResponse ofOperation:operation];
             }
             
         } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
             
             if (error.code == errorCode4 || error.code == errorCode1)
             {
                 [self internetNotAvailableOrOtherIssue:internetError];
             }
             else
             {
                 [self internetNotAvailableOrOtherIssue:internetError];
             }
         }];
}
#pragma mark - POST JSON STRING : AFNETWORKING
- (void)callGETJSONStringWebService:(NSString *)strURL withParams:(NSString *)strPostParams
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // [manager.operationQueue cancelAllOperations];
    
    [manager.requestSerializer setTimeoutInterval:API_TimeInterval];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@",common_URL,strURL]
       parameters:strPostParams
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSDictionary *dicResponse = (NSDictionary *)responseObject;
              
              NSArray *arrResponse =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
              
              if(arrResponse.count == 0)
              {
                  [self internetNotAvailableOrOtherIssue:internetError];
              }
              else
              {
                  [self.delegate response:dicResponse ofOperation:operation];
              }
              
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              if (error.code == errorCode4 || error.code == errorCode1)
              {
                  [self internetNotAvailableOrOtherIssue:internetError];
              }
              else
              {
                  [self internetNotAvailableOrOtherIssue:internetError];
              }
              
          }];
}
#pragma mark - POST - Afnetworking
- (void)callGETWebService:(NSString *)strURL withParams:(NSMutableDictionary *)dic
{
    // NSLog(@"Start Req Time : %@",[NSDate date]);
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    [manager.requestSerializer setTimeoutInterval:API_TimeInterval];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@",common_URL,strURL]
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              //NSLog(@"End Wit success Req Time : %@",[NSDate date]);
              
              NSDictionary *dicResponse = (NSDictionary *)responseObject;
              
              NSArray *arrResponse =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
              
              if(arrResponse.count == 0)
              {
                  [self internetNotAvailableOrOtherIssue:internetError];
              }
              else
              {
                  [self.delegate response:dicResponse ofOperation:operation];
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error)
     {
         
         if (error.code == errorCode4 || error.code == errorCode1)
         {
             [self internetNotAvailableOrOtherIssue:internetError];
         }
         else
         {
             [self internetNotAvailableOrOtherIssue:internetError];
         }
     }];
    
}
- (void)callCITYWebService:(NSString *)strURL withParams:(NSMutableDictionary *)dic
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager.operationQueue cancelAllOperations];
    [manager.requestSerializer setTimeoutInterval:API_TimeInterval];
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    
    [manager POST:[NSString stringWithFormat:@"%@%@",common_URL,strURL]
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSDictionary *dicResponse = (NSDictionary *)responseObject;
              
              NSArray *arrResponse =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
              
              if(arrResponse.count == 0)
              {
                  [self internetNotAvailableOrOtherIssue:internetError];
              }
              else
              {
                  [self.delegate response:dicResponse ofOperation:operation];
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              if (error.code == errorCode4 || error.code == errorCode1)
              {
                  [self internetNotAvailableOrOtherIssue:internetError];
              }
              else
              {
                  [self internetNotAvailableOrOtherIssue:internetError];
              }
              
          }];
}
- (void)callGETWebService1:(NSString *)strURL withParams:(NSMutableDictionary *)dic
{
    
    // NSLog(@"Start Time : %@",[NSDate date]);
    // [managerCall.operationQueue cancelAllOperations];
    managerCall = [AFHTTPRequestOperationManager manager];
    [managerCall.requestSerializer setTimeoutInterval:API_TimeInterval];
    managerCall.securityPolicy.allowInvalidCertificates = YES;
    managerCall.responseSerializer = [AFHTTPResponseSerializer serializer];
    managerCall.responseSerializer.acceptableContentTypes = [managerCall.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [managerCall POST:[NSString stringWithFormat:@"%@%@",common_URL,strURL]
           parameters:dic
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  
                  NSDictionary *dicResponse = (NSDictionary *)responseObject;
                  //              NSLog(@"End Time : %@",[NSDate date]);
                  
                  NSArray *arrResponse =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
                  
                  [self.delegate response:dicResponse ofOperation:operation];
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  
                  if (error.code == errorCode5)
                  {
                      //Request Cancel
                      [self.delegate responseFail:error];
                  }
                  else if (error.code == errorCode4  || error.code == errorCode1)
                  {
                      [self internetNotAvailableOrOtherIssue:internetError];
                  }
                  else
                  {
                      [self internetNotAvailableOrOtherIssue:internetError];
                  }
              }];
}
- (void)callGETWebService2:(NSString *)strURL withParams:(NSMutableDictionary *)dic
{
    [managerCall.operationQueue cancelAllOperations];
    managerCall = [AFHTTPRequestOperationManager manager];
    [managerCall.requestSerializer setTimeoutInterval:API_TimeInterval];
    managerCall.securityPolicy.allowInvalidCertificates = YES;
    managerCall.responseSerializer = [AFHTTPResponseSerializer serializer];
    managerCall.responseSerializer.acceptableContentTypes = [managerCall.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [managerCall POST:[NSString stringWithFormat:@"%@%@",common_URL,strURL]
           parameters:dic
              success:^(AFHTTPRequestOperation *operation, id responseObject) {
                  
                  NSDictionary *dicResponse = (NSDictionary *)responseObject;
                  
                  NSArray *arrResponse =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
                  
                  if(arrResponse.count == 0)
                  {
                      [self internetNotAvailableOrOtherIssue:internetError];
                  }
                  else
                  {
                      [self.delegate responseTwo:dicResponse ofOperation:operation];
                  }
                  
              } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                  
                  NSLog(@"error: %ld",(long)error.code);
                  
                  if (error.code == errorCode5)
                  {
                      //Request Cancel
                      [self.delegate responseFail:error];
                  }
                  else if (error.code == errorCode4  || error.code == errorCode1)
                  {
                      [self internetNotAvailableOrOtherIssue:internetError];
                  }
                  else
                  {
                      [self internetNotAvailableOrOtherIssue:internetError];
                  }
              }];
}
- (void)callGETWebServiceForFilter:(NSString *)strURL withParams:(NSMutableDictionary *)dic
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    // [manager.operationQueue cancelAllOperations];
    
    manager.securityPolicy.allowInvalidCertificates = YES;
    manager.responseSerializer = [AFHTTPResponseSerializer serializer];
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager POST:[NSString stringWithFormat:@"%@%@",common_URL,strURL]
       parameters:dic
          success:^(AFHTTPRequestOperation *operation, id responseObject) {
              
              NSDictionary *dicResponse = (NSDictionary *)responseObject;
              
              NSArray *arrResponse =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
              
              if(arrResponse.count == 0)
              {
                  [self internetNotAvailableOrOtherIssue:internetError];
              }
              else
              {
                  [self.delegate responseFilter:dicResponse ofOperation:operation];
              }
              
          } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
              
              if (error.code == errorCode4 || error.code == errorCode1)
              {
                  [self internetNotAvailableOrOtherIssue:internetError];
              }
              else
              {
                  [self internetNotAvailableOrOtherIssue:internetError];
              }
              
          }];
}

- (void)callPostWebServicWithImagedata:(NSString *)strURL uploadImage:(NSData *)imageData WithImageParams:(NSString *)strImgParam alongWithOtherParams:(NSMutableDictionary *)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *imagePostUrl = [NSString stringWithFormat:@"%@%@",common_URL,strURL];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:imagePostUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        [formData appendPartWithFileData:imageData name:strImgParam fileName:[NSString stringWithFormat:@"%@.jpg",strImgParam] mimeType:@"image/jpeg"];
                                    }];
    
    AFHTTPRequestOperation *op = [manager HTTPRequestOperationWithRequest:request success: ^(AFHTTPRequestOperation *operation, id responseObject)
                                  {
                                      NSDictionary *dicResponse = (NSDictionary *)responseObject;
                                      
                                      NSArray *arrResponse =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
                                      
                                      if(arrResponse.count == 0)
                                      {
                                          [self internetNotAvailableOrOtherIssue:internetError];
                                      }
                                      else
                                      {
                                          [self.delegate response:dicResponse ofOperation:operation];
                                      }
                                      
                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                  {
                                      if (error.code == errorCode4 || error.code == errorCode1)
                                      {
                                          [self internetNotAvailableOrOtherIssue:internetError];
                                      }
                                      else
                                      {
                                          [self internetNotAvailableOrOtherIssue:internetError];
                                      }
                                  }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [[NSOperationQueue mainQueue] addOperation:op];
}


- (void)callPostWebServic:(NSString *)strURL uploadImage:(UIImage *)image WithImageParams:(NSString *)strImgParam alongWithOtherParams:(NSMutableDictionary *)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSData *imageData = UIImageJPEGRepresentation(image,0.6);
    NSString *imagePostUrl = [NSString stringWithFormat:@"%@%@",common_URL,strURL];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:imagePostUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData)
                                    {
                                        [formData appendPartWithFileData:imageData name:strImgParam fileName:[NSString stringWithFormat:@"%@.jpg",strImgParam] mimeType:@"image/jpeg"];
                                    }];
    
    AFHTTPRequestOperation *op = [manager HTTPRequestOperationWithRequest:request success: ^(AFHTTPRequestOperation *operation, id responseObject)
                                  {
                                      NSDictionary *dicResponse = (NSDictionary *)responseObject;
                                      
                                      NSArray *arrResponse =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
                                      
                                      if(arrResponse.count == 0)
                                      {
                                          [self internetNotAvailableOrOtherIssue:internetError];
                                      }
                                      else
                                      {
                                          [self.delegate response:dicResponse ofOperation:operation];
                                      }
                                      
                                  } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                  {
                                      if (error.code == errorCode4 || error.code == errorCode1)
                                      {
                                          [self internetNotAvailableOrOtherIssue:internetError];
                                      }
                                      else
                                      {
                                          [self internetNotAvailableOrOtherIssue:internetError];
                                      }
                                  }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [[NSOperationQueue mainQueue] addOperation:op];
}
- (void)callServiceForUploadMultipleImages:(NSMutableArray *)arrayImages url:(NSString *)strURL WithImageParams:(NSString *)strImgParam alongWithOtherParams:(NSMutableString *)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *imagePostUrl = [NSString stringWithFormat:@"%@%@?%@",common_URL,strURL,dict];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:imagePostUrl parameters:nil constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (UIImage *img in arrayImages)
        {
            NSData *imageData = UIImageJPEGRepresentation(img,0.6);
            [formData appendPartWithFileData:imageData name:strImgParam fileName:[NSString stringWithFormat:@"%@.jpg",strImgParam] mimeType:@"image/jpeg"];
        }
        
    }];
    
    AFHTTPRequestOperation *op = [manager HTTPRequestOperationWithRequest:request success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dicResponse = (NSDictionary *)responseObject;
        
        NSArray *arrResponse =[NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
        
        if(arrResponse.count == 0)
        {
            [self internetNotAvailableOrOtherIssue:internetError];
        }
        else
        {
            [self.delegate response:dicResponse ofOperation:operation];
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                  {
                                      
                                      if (error.code == errorCode4 || error.code == errorCode1)
                                      {
                                          [self internetNotAvailableOrOtherIssue:internetError];
                                      }
                                      else
                                      {
                                          [self internetNotAvailableOrOtherIssue:internetError];
                                      }
                                  }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [[NSOperationQueue mainQueue] addOperation:op];
}
- (void)callPostWebServiceForUploadMultipleImages:(NSMutableArray *)arrayImages url:(NSString *)strURL WithImageParams:(NSString *)strImgParam alongWithOtherParams:(NSMutableDictionary *)dict
{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    NSString *imagePostUrl = [NSString stringWithFormat:@"%@%@",common_URL,strURL];
    
    NSMutableURLRequest *request = [[AFHTTPRequestSerializer serializer] multipartFormRequestWithMethod:@"POST" URLString:imagePostUrl parameters:dict constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        
        for (UIImage *img in arrayImages)
        {
            NSData *imageData = UIImageJPEGRepresentation(img,0.6);
            [formData appendPartWithFileData:imageData name:strImgParam fileName:[NSString stringWithFormat:@"%@.jpg",strImgParam] mimeType:@"image/jpeg"];
        }
    }];
    
    [request setTimeoutInterval:60];
    
    AFHTTPRequestOperation *op = [manager HTTPRequestOperationWithRequest:request success: ^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSDictionary *dicResponse = (NSDictionary *)responseObject;
        
        NSArray *arrResponse = [NSJSONSerialization JSONObjectWithData:(NSData *)dicResponse options:NSJSONReadingAllowFragments error:nil];
        
        if(arrResponse.count == 0)
        {
            [self internetNotAvailableOrOtherIssue:internetError];
        }
        else
        {
            [self.delegate response:dicResponse ofOperation:operation];
        }
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
                                  {
                                      
                                      if (error.code == errorCode4 || error.code == errorCode1)
                                      {
                                          [self internetNotAvailableOrOtherIssue:internetError];
                                      }
                                      else
                                      {
                                          [self internetNotAvailableOrOtherIssue:internetError];
                                      }
                                      
                                  }];
    
    op.responseSerializer = [AFHTTPResponseSerializer serializer];
    [[NSOperationQueue mainQueue] addOperation:op];
}
- (void)internetNotAvailableOrOtherIssue:(NSString *)strText
{
    NSString *message = @"Internet connection is unavailable";
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:strText
                                                        message:message
                                                       delegate:self
                                              cancelButtonTitle:@"Cancel"
                                              otherButtonTitles:@"Settings", nil];
    [alertView show];
}

@end
