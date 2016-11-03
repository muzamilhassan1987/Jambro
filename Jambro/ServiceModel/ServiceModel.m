//
//  ServiceModel.m
//
//  Created by ------ on 10/19/13.
//  Copyright (c) 2013 Appostrophic. All rights reserved.
//

#import "ServiceModel.h"
#import "Constants.h"
#import "UtilitiesHelper.h"


@implementation ServiceModel


+ (instancetype)sharedClient {
    static ServiceModel *_sharedClient = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedClient = [[ServiceModel alloc] initWithBaseURL:[NSURL URLWithString:kWebBaseUrl]];
    });
    
    return _sharedClient;
}


- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure   {
 
    
    
    if ([UtilitiesHelper isReachable]) {
    
    [UtilitiesHelper showLoader:@"Loading.." forView:loaderOnView setMode:MBProgressHUDModeIndeterminate delegate:nil];
    
    AFHTTPRequestOperation *operation =  [self POST:URLString parameters:parameters success:success failure:failure];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       // NSLog(@"response object ====> %@",responseObject);

        if ([[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"status"]]isEqualToString:@"1"]) {
            [UtilitiesHelper hideLoader:loaderOnView];
            success(operation,responseObject);

        }
        else
        {
            NSDictionary *errorDictionary = [NSDictionary dictionaryWithObject:[responseObject valueForKey:@"message"] forKey:NSLocalizedDescriptionKey];
            
            NSError *error =[[NSError alloc]initWithDomain:@"Server Message" code:0 userInfo:errorDictionary];
            
            [UtilitiesHelper hideLoader:loaderOnView];
            failure (operation,error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UtilitiesHelper hideLoader:loaderOnView];

        failure (operation,error);
    }];
    
        return operation;

    }
    else
        return nil;

}


- (AFHTTPRequestOperation *)GET:(NSString *)URLString
                     parameters:(NSDictionary *)parameters
                         onView:(UIView *)loaderOnView
                        success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                        failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure {
    
    if ([UtilitiesHelper isReachable]) {
    
    [UtilitiesHelper showLoader:@"Loading.." forView:loaderOnView setMode:MBProgressHUDModeIndeterminate delegate:nil];
    
    AFHTTPRequestOperation *operation =  [self GET:URLString parameters:parameters success:success failure:failure];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        // NSLog(@"response object ====> %@",responseObject);
        
        if ([[responseObject valueForKey:@"response"]isEqualToString:@"success"]) {
            [UtilitiesHelper hideLoader:loaderOnView];
            success(operation,responseObject);
            
        }
        else
        {
            NSDictionary *errorDictionary = [NSDictionary dictionaryWithObject:[responseObject valueForKey:@"message"] forKey:NSLocalizedDescriptionKey];
            
            NSError *error =[[NSError alloc]initWithDomain:@"Server Message" code:0 userInfo:errorDictionary];
            
            [UtilitiesHelper hideLoader:loaderOnView];
            failure (operation,error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UtilitiesHelper hideLoader:loaderOnView];
        
        failure (operation,error);
    }];
    
    return operation;
    }
    else
        return nil;
    
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                        filename:(NSString*)filename
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure   {
    
    [UtilitiesHelper showLoader:@"Loading.." forView:loaderOnView setMode:MBProgressHUDModeIndeterminate delegate:nil];
    
    AFHTTPRequestOperation *operation =  [self POST:URLString parameters:parameters success:success failure:failure];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
       
        
        if ([responseObject valueForKey:@"Response"])
        {
            
        
        
        if ([[responseObject valueForKey:@"Response"]isEqualToString:@"Success"])
        {
            NSError *error;
            //NSLog(@"response object  reached");
            [UtilitiesHelper hideLoader:loaderOnView];
            if (![filename isEqualToString:@""]) {
                
            
            NSData *jsonData = [NSJSONSerialization dataWithJSONObject:responseObject options:NSJSONWritingPrettyPrinted error:&error];
            NSString *jsonString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
            [UtilitiesHelper writeJsonToFile:jsonString withFileName:filename];
            }
            success(operation,responseObject);
            
        }
        else
        {
          //  NSError *error;
           // NSLog(@"response object not reached");

            [UtilitiesHelper hideLoader:loaderOnView];
            id reponseFile ;
             if (![filename isEqualToString:@""]) {
                 reponseFile = [self usingDocumentForTextfiles:filename];
             }
            if (reponseFile == nil)
            {
                
                
                
                NSError *err = [NSError errorWithDomain:[responseObject valueForKey:@"Response"]
                                                   code:100
                                               userInfo:@{
                                                          NSLocalizedDescriptionKey:[responseObject valueForKey:@"Message"]
                                                          }];
                
                   [UtilitiesHelper showPromptAlertforTitle:@"Message" withMessage:err.localizedDescription forDelegate:nil];
                failure (nil,err);
            }
            else
            {
                failure (operation,reponseFile);
            }

        }
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [UtilitiesHelper hideLoader:loaderOnView];
        id reponseFile = [self usingDocumentForTextfiles:filename];
        
        if (reponseFile == nil)
        {
            [UtilitiesHelper showPromptAlertforTitle:@"Message" withMessage:error.localizedDescription forDelegate:nil];
            failure (operation, error);
        }
        else
        {
            failure (operation,reponseFile);
        }
    }];
    
    return operation;
}

-(id)usingDocumentForTextfiles:(NSString*)filename
{
    NSError *error;
    NSString *objEntityCourse=[UtilitiesHelper readJsonFromFile:filename];
    NSData* aData = [objEntityCourse dataUsingEncoding:NSUTF8StringEncoding];;
    
    if (aData != nil) {
        
        id reponseFile = [NSJSONSerialization
                          JSONObjectWithData:aData//1
                          options:NSJSONReadingMutableContainers
                          error:&error];
        
        return reponseFile;

    }
    else
    {
        
        
        return nil;
        
    }
   

}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                     cachePolicy:(NSString*)fileCache
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure   {
 
   
   
    [UtilitiesHelper showLoader:@"Loading.." forView:loaderOnView setMode:MBProgressHUDModeIndeterminate delegate:nil];
    
    NSMutableURLRequest *request = [self.requestSerializer requestWithMethod:@"POST" URLString:[[NSURL URLWithString:URLString relativeToURL:self.baseURL] absoluteString] parameters:parameters];

    AFHTTPRequestOperation *operation = [self HTTPRequestOperationWithRequest:request success:success failure:failure];
    
    [operation setUserInfo:@{@"cacheResponse":fileCache}];
    [self.operationQueue addOperation:operation];
    
    

    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        if ([[responseObject valueForKey:@"response"]isEqualToString:@"success"]) {
            [UtilitiesHelper hideLoader:loaderOnView];
            
            if(operation.userInfo && [[operation.userInfo objectForKey:@"cacheResponse"] isEqualToString:@"YES"])
            {
                NSString *requestBody=[[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
                NSString *requestUrl=operation.request.URL.absoluteString;
                NSString *fileName=[requestUrl stringByAppendingString:requestBody];
                fileName=[fileName stringByReplacingOccurrencesOfString:@"/"
                                                             withString:@"-"];
                NSString *savedFilePath=[AppCachePath stringByAppendingFormat:@"/%@",fileName];
                
                if(![[NSFileManager defaultManager] fileExistsAtPath:AppCachePath])
                
                    [[NSFileManager defaultManager]createDirectoryAtPath:AppCachePath withIntermediateDirectories:YES attributes:nil error:nil];
                
                [responseObject writeToFile:savedFilePath
                                   atomically:YES];
                
            }
            
            [UtilitiesHelper hideLoader:loaderOnView];
            success(operation,responseObject);
            
        }
        else
        {
            //[UtilitiesHelper showPromptAlertforTitle:@"Message" withMessage:responseObject forDelegate:nil];
            
            
            [UtilitiesHelper hideLoader:loaderOnView];
            
            
            NSError *err = [NSError errorWithDomain:[responseObject valueForKey:@"Response"]
                                               code:100
                                           userInfo:@{
                                                      NSLocalizedDescriptionKey:[responseObject valueForKey:@"Message"]
                                                      }];
            
            
            [UtilitiesHelper showPromptAlertforTitle:@"Message" withMessage:err.localizedDescription forDelegate:nil];
            
            failure (nil,err);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        

        
       // NSLog(@"RequestBody:%@",[[NSString alloc]initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding]);
      //  NSLog(@"failure error no : %@", operation.error);
        NSString *requestBody=[[NSString alloc] initWithData:operation.request.HTTPBody encoding:NSUTF8StringEncoding];
        NSString *requestUrl=operation.request.URL.absoluteString;
        NSString *fileName=[requestUrl stringByAppendingString:requestBody];
        fileName=[fileName stringByReplacingOccurrencesOfString:@"/"
                                                     withString:@"-"];
        NSString *savedFilePath=[AppCachePath stringByAppendingFormat:@"/%@",fileName];
        
        if([[NSFileManager defaultManager] fileExistsAtPath:savedFilePath])
        {
            NSDictionary *dictionary=[[NSDictionary alloc]initWithContentsOfFile:savedFilePath];
            [UtilitiesHelper hideLoader:loaderOnView];
            success(operation,dictionary);
        }
        else
        {
  

            [UtilitiesHelper hideLoader:loaderOnView];
            
            [UtilitiesHelper showPromptAlertforTitle:@"Message" withMessage:error.localizedDescription forDelegate:nil];

            failure(operation,error);
            
            
        }
}];
    
    return operation;

}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       imageData:(NSData *) image
              imageParamaterName:(NSString *) imageParam
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure   {
    
    
    if ([UtilitiesHelper isReachable]) {
    
    [UtilitiesHelper showLoader:@"Loading.." forView:loaderOnView setMode:MBProgressHUDModeIndeterminate delegate:nil];
    
    AFHTTPRequestOperation *operation =  [self POST:URLString
                                         parameters:parameters
                          constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                              
                              if (image.bytes) {
                                  
                                  [formData appendPartWithFileData:image
                                                              name:imageParam
                                                          fileName:@"image.jpg"
                                                          mimeType:@"image/jpeg"];
                              }
                              
                              
                          } success:success failure:failure];
    
    [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        
        if ([[NSString stringWithFormat:@"%@",[responseObject valueForKey:@"status"]]isEqualToString:@"1"]) {
            [UtilitiesHelper hideLoader:loaderOnView];
            success(operation,responseObject);
            
        }
        else
        {
            NSDictionary *errorDictionary = [NSDictionary dictionaryWithObject:[responseObject valueForKey:@"message"] forKey:NSLocalizedDescriptionKey];
            
            NSError *error =[[NSError alloc] initWithDomain:@"Server Message" code:0 userInfo:errorDictionary];
            
            [UtilitiesHelper hideLoader:loaderOnView];
            failure (operation,error);
        }
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
        [UtilitiesHelper hideLoader:loaderOnView];
        
        failure (operation,error);
    }];
        
        return operation;

    }
    else
        return nil;
    
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       videoData:(NSData *) video
              videoParamaterName:(NSString *) videoParam
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure   {
    
    
    if ([UtilitiesHelper isReachable]) {
        
        [UtilitiesHelper showLoader:@"Loading.." forView:loaderOnView setMode:MBProgressHUDModeIndeterminate delegate:nil];
        
        AFHTTPRequestOperation *operation =  [self POST:URLString
                                             parameters:parameters
                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                  
                                  if (video.bytes) {
                                      
                                      [formData appendPartWithFileData:video
                                                                  name:videoParam
                                                              fileName:@"video.mp4"
                                                              mimeType:@"video/mp4"];
                                  }
                                  
                              } success:success failure:failure];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([[responseObject valueForKey:@"Response"] isEqualToString:@"Success"]) {
                
                [UtilitiesHelper hideLoader:loaderOnView];
                success(operation,responseObject);
                
            }
            else {
                
                NSDictionary *errorDictionary = [NSDictionary dictionaryWithObject:[responseObject valueForKey:@"Message"] forKey:NSLocalizedDescriptionKey];
                
                NSError *error =[[NSError alloc] initWithDomain:@"Server Message" code:0 userInfo:errorDictionary];
                
                [UtilitiesHelper hideLoader:loaderOnView];
                failure (operation,error);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [UtilitiesHelper hideLoader:loaderOnView];
            
            failure (operation,error);
        }];
        
        return operation;
        
    }
    else
        return nil;
}

- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       videoData:(NSData *) video
              videoParamaterName:(NSString *) videoParam
                       imageData:(NSData *) image
              imageParamaterName:(NSString *)imageParam
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure
{
    if ([UtilitiesHelper isReachable]) {
        
        [UtilitiesHelper showLoader:@"Loading.." forView:loaderOnView setMode:MBProgressHUDModeIndeterminate delegate:nil];
        
        AFHTTPRequestOperation *operation =  [self POST:URLString
                                             parameters:parameters
                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                  
                                  if (video.bytes) {
                                      
                                      [formData appendPartWithFileData:video
                                                                  name:videoParam
                                                              fileName:@"video.mp4"
                                                              mimeType:@"video/mp4"];
                                  }
                                  
                                  if (image.bytes) {
                                      
                                      [formData appendPartWithFileData:image
                                                                  name:imageParam
                                                              fileName:@"image.jpg"
                                                              mimeType:@"image/jpeg"];
                                  }
                                  
                              } success:success failure:failure];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([[responseObject valueForKey:@"Response"] isEqualToString:@"Success"]) {
                
                [UtilitiesHelper hideLoader:loaderOnView];
                success(operation,responseObject);
                
            }
            else {
                
                NSDictionary *errorDictionary = [NSDictionary dictionaryWithObject:[responseObject valueForKey:@"Message"] forKey:NSLocalizedDescriptionKey];
                
                NSError *error =[[NSError alloc] initWithDomain:@"Server Message" code:0 userInfo:errorDictionary];
                
                [UtilitiesHelper hideLoader:loaderOnView];
                failure (operation,error);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [UtilitiesHelper hideLoader:loaderOnView];
            
            failure (operation,error);
        }];
        
        return operation;
        
    }
    else
        return nil;
}



- (AFHTTPRequestOperation *)POST:(NSString *)URLString
                      parameters:(NSDictionary *)parameters
                       audioData:(NSData *) audio
              audioParamaterName:(NSString *) audioParam
                          onView:(UIView *)loaderOnView
                         success:(void (^)(AFHTTPRequestOperation *operation, id responseObject))success
                         failure:(void (^)(AFHTTPRequestOperation *operation, NSError *error))failure   {
    
    
    if ([UtilitiesHelper isReachable]) {
        
        [UtilitiesHelper showLoader:@"Loading.." forView:loaderOnView setMode:MBProgressHUDModeIndeterminate delegate:nil];
        
        AFHTTPRequestOperation *operation =  [self POST:URLString
                                             parameters:parameters
                              constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
                                  
                                  if (audio.bytes) {
                                      
                                      [formData appendPartWithFileData:audio
                                                                  name:audioParam
                                                              fileName:@"audio.mp3"
                                                              mimeType:@"audio/mpeg"];
                                  }
                              } success:success failure:failure];
        
        [operation setCompletionBlockWithSuccess:^(AFHTTPRequestOperation *operation, id responseObject) {
            
            if ([[responseObject valueForKey:@"Response"] isEqualToString:@"Success"]) {
                
                [UtilitiesHelper hideLoader:loaderOnView];
                success(operation,responseObject);
                
            }
            else {
                
                NSDictionary *errorDictionary = [NSDictionary dictionaryWithObject:[responseObject valueForKey:@"Message"] forKey:NSLocalizedDescriptionKey];
                
                NSError *error =[[NSError alloc] initWithDomain:@"Server Message" code:0 userInfo:errorDictionary];
                
                [UtilitiesHelper hideLoader:loaderOnView];
                failure (operation,error);
            }
            
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            
            [UtilitiesHelper hideLoader:loaderOnView];
            
            failure (operation,error);
        }];
        
        return operation;
        
    }
    else
        return nil;
}
  

@end
