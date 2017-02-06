//
//  WebService.h
//  WebServiceCall
//
//  Created by Marwadi  on 03/08/15.
//  Copyright (c) 2015 Abbacus. All rights reserved.
//

#define getProductList @"getProductList"
#import <Foundation/Foundation.h>
#import "AFNetworking.h"


@protocol WebServiceCallDelegate <NSObject>
- (void)response:(NSDictionary *)dicResponse ofOperation:(AFHTTPRequestOperation *)operation;
@optional
- (void)responseFail:(NSError *)error;
- (void)responseFilter:(NSDictionary *)dicResponse ofOperation:(AFHTTPRequestOperation *)operation;
- (void)responseTwo:(NSDictionary *)dicResponse ofOperation:(AFHTTPRequestOperation *)operation;
@end

@interface WebService : NSObject
{
    id<WebServiceCallDelegate>delegate;
    
    AFHTTPRequestOperationManager *managerCall;
}

@property (strong, nonatomic)id<WebServiceCallDelegate>delegate;

-(void)trackDNSfailedOrIPConnetionIssue:(NSString *)string andAPIName:(NSString *)strAPIName;

- (void)callGetWebService:(NSString *)strFunction withParams:(NSMutableDictionary *)dic;
- (void)callGETWebService:(NSString *)strURL withParams:(NSMutableDictionary *)dic;
- (void)callCITYWebService:(NSString *)strURL withParams:(NSMutableDictionary *)dic;
- (void)callPostWebServicWithImagedata:(NSString *)strURL uploadImage:(NSData *)imageData WithImageParams:(NSString *)strImgParam alongWithOtherParams:(NSMutableDictionary *)dict;
- (void)callPostWebServic:(NSString *)strURL uploadImage:(UIImage *)image WithImageParams:(NSString *)strImgParam alongWithOtherParams:(NSMutableDictionary *)dict;
- (void)callPostWebServiceForUploadMultipleImages:(NSMutableArray *)arrayImages url:(NSString *)strURL WithImageParams:(NSString *)strImgParam alongWithOtherParams:(NSMutableDictionary *)dict;
- (void)callGETWebService1:(NSString *)strURL withParams:(NSMutableDictionary *)dic;

//If Necessory
- (void)callGETWebService2:(NSString *)strURL withParams:(NSMutableDictionary *)dic;
- (void)callGETWebServiceForFilter:(NSString *)strURL withParams:(NSMutableDictionary *)dic;
- (void)callServiceForUploadMultipleImages:(NSMutableArray *)arrayImages url:(NSString *)strURL WithImageParams:(NSString *)strImgParam alongWithOtherParams:(NSMutableString *)dict;
@end
