//
//  ServiceModel.h
//
//  Created by ------ on 10/19/13.
//  Copyright (c) 2013 Appostrophic. All rights reserved.
//

#import "AFHTTPRequestOperationManager.h"

@interface ServiceModel : AFHTTPRequestOperationManager
{
    
    
}

@property (nonatomic, assign) BOOL  isSessionValid;

+ (instancetype)sharedClient;


- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                     cachePolicy:(NSString*)fileCache
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                        filename:(NSString*)filename
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       imageData:(NSData *) image
              imageParamaterName:(NSString *) imageParam
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       videoData:(NSData *) video
              videoParamaterName:(NSString *) videoParam
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       videoData:(NSData *) video
              videoParamaterName:(NSString *) videoParam
                       imageData:(NSData *) image
              imageParamaterName:(NSString *)imageParam
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       audioData:(NSData *) audio
              audioParamaterName:(NSString *) audioParam
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure;
@end
