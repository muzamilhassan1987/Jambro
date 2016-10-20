//
//  WKSocialSharing.m
//  Chip
//
//  Created by Waqas Khalid on 02/10/2013.
//  Copyright (c) 2013 Appnotech. All rights reserved.
//

#import "WKSocialSharing.h"
#import "UtilitiesHelper.h"
#import <Social/Social.h>
#import "Constants.h"


static WKSocialSharing *sharingSingleton = nil;
@implementation WKSocialSharing

@synthesize fbAccessToken=_fbAccessToken;


+ (WKSocialSharing*)sharing{
   	@synchronized(self) {
		if (sharingSingleton == nil)
			sharingSingleton = [[WKSocialSharing alloc] init];
	}
	return sharingSingleton;
}

// Checking if the this OS supports Facebook
- (BOOL)checkFacebook{
    
    if([SLComposeViewController isAvailableForServiceType:SLServiceTypeFacebook])
        return YES;
    else{
        
        return NO;
    }
}

# pragma mark - Posting on Facebook

- (void)postToFacebook:(NSString *)message withURL:(NSString *)urlString withImage:(NSString *)imageName withController:(UIViewController *)viewController {
    
    if ([self checkFacebook]) {
        
        SLComposeViewController *composerSheet = [SLComposeViewController composeViewControllerForServiceType:SLServiceTypeFacebook];
        
        [composerSheet setInitialText:message];
        [composerSheet addURL:[NSURL URLWithString:urlString]];
        [composerSheet addImage:[UIImage imageNamed:imageName]];
        [composerSheet setCompletionHandler:^(SLComposeViewControllerResult result) {
            
            switch (result) {
                case SLComposeViewControllerResultDone:
                {
                 
                    break;
                }
                default:
                    break;
            }
        }];

        [viewController presentViewController:composerSheet animated:YES completion:Nil];
    }
}

# pragma mark - Getting Facebook AccessToken

- (void)getFBAccessToken:(void(^)(NSString* accessToken,NSMutableDictionary *dicFbUser, NSError* error))handler{

    accountStore = [[ACAccountStore alloc] init];
    
    ACAccountType *facebookTypeAccount = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
    

    [accountStore requestAccessToAccountsWithType:facebookTypeAccount
                                          options:@{ACFacebookAppIdKey: FACEBOOK_APP_ID_KEY, ACFacebookPermissionsKey: FACEBOOK_APP_PERMISSION,
                                                 ACFacebookAudienceKey: ACFacebookAudienceEveryone}
                                       completion:^(BOOL granted, NSError *error) {
                                           if (granted) {
                                               // If access granted, then get the Facebook account info
                                               NSArray *accounts = [accountStore
                                                                    accountsWithAccountType:facebookTypeAccount];
                                               self.facebookAccount = [accounts lastObject];
                                               
                                               // Get the access token, could be used in other scenarios
                                               ACAccountCredential *fbCredential = [self.facebookAccount credential];
                                              // NSString *accessToken = [fbCredential oauthToken];
                                           
                                               [accountStore requestAccessToAccountsWithType:facebookTypeAccount
                                                                                     options:@{ACFacebookAppIdKey :FACEBOOK_APP_ID_KEY,
                                                                                               ACFacebookPermissionsKey: FACEBOOK_APP_PERMISSION_EXTENDED,
                                                                                               ACFacebookAudienceKey: ACFacebookAudienceEveryone}completion:^(BOOL granted, NSError *error) {
                                                                                                   
                                                                                                   if (granted) {
                                                                                                       NSArray *accounts = [accountStore
                                                                                                                            accountsWithAccountType:facebookTypeAccount];
                                                                                                       self.facebookAccount = [accounts lastObject];
                                                                                                       
                                                                                            
                                                                                                       ACAccountCredential *fbCredential = [self.facebookAccount credential];
                                                                                                       NSString *accessToken = [fbCredential oauthToken];
                                                                                                   
                                                                                      
                                                                                                   [accountStore renewCredentialsForAccount:self.facebookAccount completion:^(ACAccountCredentialRenewResult renewResult, NSError *error) {
                                                                                                       //we don't actually need to inspect renewResult or error.
                                                                                                       if (!error){
                                                                                                           
                                                                                                           self.fbAccessToken = accessToken;
                                                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                               handler(accessToken,[self.facebookAccount valueForKey:@"properties"],nil);
                                                                                                           });
                                                                                                       }
                                                                                                       else
                                                                                                       {
                                                                                                           
                                                                                                           dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                               handler (nil,nil, error);
                                                                                                           });
                                                                                                           
                                                                                                           
                                                                                                       }
                                                                                                   
                                                                                                   }];
                                                                                                       
                                                                                                   }
                                                                                                   else
                                                                                                       
                                                                                                   {
                                                                                                       dispatch_async(dispatch_get_main_queue(), ^{
                                                                                                           handler (nil,nil, error);
                                                                                                       });

                                                                                                   }
                                                                                                   
                                                                                               }];
                                               
                                               
                                               
                                       
                                               
                                           } else {
                                               
                                               dispatch_async(dispatch_get_main_queue(), ^{
                                                   handler (nil,nil, error);
                                               });
                                               
                                               NSLog(@"Error:%@",[error localizedDescription]);
                                           
                                           }
                                       }];
}
//
//# pragma mark - Getting User Info
//
//- (void)getUserInfo{
//    
//    accountStore = [[ACAccountStore alloc] init];
//    
//    ACAccountType *facebookTypeAccount = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierFacebook];
//    
//
//    [accountStore requestAccessToAccountsWithType:facebookTypeAccount
//                                           options:@{ACFacebookAppIdKey: FACEBOOK_APP_ID_KEY, ACFacebookPermissionsKey: FACEBOOK_APP_PERMISSION}
//                                        completion:^(BOOL granted, NSError *error) {
//                                            if(granted){
//                                                NSArray *accounts = [accountStore accountsWithAccountType:facebookTypeAccount];
//                                                self.facebookAccount = [accounts lastObject];
//                                                NSLog(@"Success");
//                                                
//                                            }else{
//                                                // ouch
//                                                NSLog(@"Fail");
//                                                NSLog(@"Error: %@", error);
//                                            }
//                                        }];
//    
//    
//    
//   }


-(void) performRequestViaGraphApi:(NSString *)urlPath
                       parameters:(NSMutableDictionary *)dicParams
                           onView:(UIView *)loaderOnView
                         response:(void (^)(NSDictionary *dicData,NSError *error))block {
    
    
    NSURL *url = [NSURL URLWithString:urlPath];
    
    [dicParams setObject:self.fbAccessToken forKey:@"access_token"];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                              requestMethod:SLRequestMethodPOST
                                                        URL:url
                                                 parameters:dicParams];
    merequest.account = self.facebookAccount;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        
        
        if (!error)
        {
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error:nil];
            //NSLog(@"%@", JSON);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block (JSON, nil);
                
            });
        }
        else
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block(nil, error);
                
            });
            
        }
        
    }];
    
    
    
}

-(void) performRequestViaGraphApi:(NSString *)urlPath
                           onView:(UIView *)loaderOnView
                         response:(void (^)(NSDictionary *dicData,NSError *error))block {
    
    
    NSURL *url = [NSURL URLWithString:urlPath];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                              requestMethod:SLRequestMethodGET
                                                        URL:url
                                                 parameters:@{@"access_token":self.fbAccessToken}];
    merequest.account = self.facebookAccount;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        
        
        if (!error)
        {
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error:nil];
           // NSLog(@"%@", JSON);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block (JSON, nil);
                
            });
        }
        else
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block(nil, error);
                
            });
            
        }
        
    }];

    
    
}

-(void) performRequestViaGraphApiWithParams:(NSString *)urlPath
                                     params:(NSDictionary *)params
                                     onView:(UIView *)loaderOnView
                                   response:(void (^)(NSDictionary *dicData,NSError *error))block {
        
    NSURL *url = [NSURL URLWithString:urlPath];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                              requestMethod:SLRequestMethodGET
                                                        URL:url
                                                 parameters:params];
    //merequest.account = self.facebookAccount;
    
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        
        
        if (!error)
        {
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error:nil];
            // NSLog(@"%@", JSON);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block (JSON, nil);
                
            });
        }
        else
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block(nil, error);
                
            });
            
        }
        
    }];
    
    
    
}

-(void) performRequestViaGraphApi:(NSString *)urlPath
                      queryFields:(NSString *)fields
                           onView:(UIView *)loaderOnView
                         response:(void (^)(NSDictionary *dicData,NSError *error))block {
    
    
    NSURL *url = [NSURL URLWithString:urlPath];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                              requestMethod:SLRequestMethodGET
                                                        URL:url
                                                 parameters:@{@"access_token":self.fbAccessToken,
                                                              @"fields":fields}];
    merequest.account = self.facebookAccount;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        
        
        if (!error)
        {
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error:nil];
            //NSLog(@"%@", JSON);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block (JSON, nil);
                
            });
        }
        else
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block(nil, error);
                
            });
            
        }
        
    }];
    
    
    
}

- (void)getMyFBDetails:(void(^)(NSDictionary * dicUserFBData, NSError *error))block{
    
    NSURL *meurl = [NSURL URLWithString:@"https://graph.facebook.com/me"];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                              requestMethod:SLRequestMethodGET
                                                        URL:meurl
                                                 parameters:@{@"access_token":self.fbAccessToken}];
    
    merequest.account = self.facebookAccount;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        

        
        if (!error)
        {
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error:nil];
            //NSLog(@"%@", JSON);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block (JSON, nil);

            });
        }
        else
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block(nil, error);
                
            });
            
        }
        
    }];
    
}


- (void)getMyFBProfilePictureWithId:(NSString *)facebookId block:(void(^)(NSData *responseData, NSError *error))block
{
    NSURL *meurl = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture",facebookId]];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                              requestMethod:SLRequestMethodGET
                                                        URL:meurl
                                                 parameters:@{@"access_token":self.fbAccessToken,
                                                              @"type":@"large"}];
    
    merequest.account = self.facebookAccount;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        
        
        if (responseData)
        {
//            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error:nil];
            //NSLog(@"%@", JSON);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block (responseData, nil);
                
            });
        }
        else
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block(nil, error);
                
            });
            
        }
        
    }];
}


#pragma mark -
#pragma mark - Twitter Info

- (void) getInfoTwitter :(void (^)(NSDictionary *TWData, NSError *error))block
{
    // Request access to the Twitter accounts
    accountStore = [[ACAccountStore alloc] init];
    ACAccountType *accountType = [accountStore accountTypeWithAccountTypeIdentifier:ACAccountTypeIdentifierTwitter];
    
    
    [accountStore requestAccessToAccountsWithType:accountType options:nil completion:^(BOOL granted, NSError *error){
        if (granted) {
            NSArray *accounts = [accountStore accountsWithAccountType:accountType];
            // Check if the users has setup at least one Twitter account
            if (accounts.count > 0)
            {
                twitterAccount = [accounts lastObject];
                
              //  NSString *userId = [[twitterAccount valueForKey:@"properties"] valueForKey:@"user_id"];
                
                SLRequest *twitterInfoRequest = [SLRequest requestForServiceType:SLServiceTypeTwitter requestMethod:SLRequestMethodGET URL:[NSURL URLWithString:@"https://api.twitter.com/1.1/users/show.json"] parameters:[NSDictionary dictionaryWithObject:twitterAccount.username forKey:@"screen_name"]];
                [twitterInfoRequest setAccount:twitterAccount];
                // Making the request
                [twitterInfoRequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                    dispatch_async(dispatch_get_main_queue(), ^{

                        if ([urlResponse statusCode] == 429) {
                            NSLog(@"Rate limit reached");
                            return;
                        }
                        // Check if there was an error
                        if (error) {
                            
                            NSDictionary *errorDictionary = [NSDictionary dictionaryWithObject:error.localizedDescription forKey:NSLocalizedDescriptionKey];
                            
                            NSError *error =[[NSError alloc]initWithDomain:@"Message" code:0 userInfo:errorDictionary];
                            block(nil,error);
                        }
                        // Check if there is some response data
                        if (responseData) {
                            NSError *errorJson = nil;
                            NSDictionary *TWData = [NSJSONSerialization JSONObjectWithData:responseData options:NSJSONReadingMutableLeaves error:&errorJson];
                            // Filter the preferred data
                            
                            if (TWData == nil) {

                                if (errorJson) {
                                    
                                    block(nil,errorJson);
                                    
                                }
                               
                                    
                                
                            }
                            
//                            NSString *screen_name = [(NSDictionary *)TWData objectForKey:@"screen_name"];
//                            NSString *name = [(NSDictionary *)TWData objectForKey:@"name"];
//                            int followers = [[(NSDictionary *)TWData objectForKey:@"followers_count"] integerValue];
//                            int following = [[(NSDictionary *)TWData objectForKey:@"friends_count"] integerValue];
//                            int tweets = [[(NSDictionary *)TWData objectForKey:@"statuses_count"] integerValue];
//                            NSString *profileImageStringURL = [(NSDictionary *)TWData objectForKey:@"profile_image_url_https"];
//                            NSString *bannerImageStringURL =[(NSDictionary *)TWData objectForKey:@"profile_banner_url"];
                            // Update the interface with the loaded data
                            
                            
                                
                                block(TWData,nil);
                                
                          
//                            NSString *lastTweet = [[(NSDictionary *)TWData objectForKey:@"status"] objectForKey:@"text"];
//                            // Get the profile image in the original resolution
//                            profileImageStringURL = [profileImageStringURL stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
//                            // Get the banner image, if the user has one
//                            if (bannerImageStringURL) {
//                                NSString *bannerURLString = [NSString stringWithFormat:@"%@/mobile_retina", bannerImageStringURL];
//                            } else {
//                                // bannerImageView.backgroundColor = [UIColor underPageBackgroundColor];
//                            }
                        }
                    });
                }];

                // Creating a request to get the info about a user on Twitter
            }
            else
            {
               
                    NSDictionary *errorDictionary = [NSDictionary dictionaryWithObject:@"Account not found. Please login twitter from SETTINGS" forKey:NSLocalizedDescriptionKey];

                    NSError *error =[[NSError alloc]initWithDomain:@"Message" code:0 userInfo:errorDictionary];
                    block(nil,error);
                    NSLog(@"No access granted");
  
            }
        } else {

                NSError *error1 = [NSError new];
                block(nil,error1);
                NSLog(@"No access granted");

        }
    }];
}

- (BOOL)userHasAccessToTwitter
{
    return [SLComposeViewController
            isAvailableForServiceType:SLServiceTypeTwitter];
}


- (void)requestForTwitterWithUrl :(NSString *)urlStr params:(NSDictionary *)dicParams
                withRequestMethod:(SLRequestMethod)requestMethod
                         response:(void (^)(NSDictionary *dicData,NSError *error))block
{

    if ([self userHasAccessToTwitter]) {
        
        ACAccountType *twitterAccountType =
        [accountStore accountTypeWithAccountTypeIdentifier:
         ACAccountTypeIdentifierTwitter];
        
        [accountStore
         requestAccessToAccountsWithType:twitterAccountType
         options:NULL
         completion:^(BOOL granted, NSError *error) {
             if (granted) {

                 NSArray *twitterAccounts =
                 [accountStore accountsWithAccountType:twitterAccountType];
                 NSURL *url = [NSURL URLWithString:urlStr];
                 
                 SLRequest *request =
                 [SLRequest requestForServiceType:SLServiceTypeTwitter
                                    requestMethod:requestMethod
                                              URL:url
                                       parameters:dicParams];
                 
                 [request setAccount:[twitterAccounts lastObject]];
                 
                 [request performRequestWithHandler:
                  ^(NSData *responseData,
                    NSHTTPURLResponse *urlResponse,
                    NSError *error) {
                      
                      if (responseData) {
                          if (urlResponse.statusCode >= 200 &&
                              urlResponse.statusCode < 300) {
                              
                              NSError *jsonError;
                              NSDictionary *timelineData =
                              [NSJSONSerialization
                               JSONObjectWithData:responseData
                               options:NSJSONReadingAllowFragments error:&jsonError];
                              if (timelineData) {
                                  //NSLog(@"Twitter Response: %@\n", timelineData);
                                  
                                  block(timelineData,nil);
                                  
                              }
                              else {

                                  block(timelineData,jsonError);
                                  NSLog(@"Twitter JSON Error: %@", [jsonError localizedDescription]);

                              }
                          }
                          else {

                              NSLog(@"The response status code is %d",
                                    urlResponse.statusCode);
                              
                              NSError *err = [NSError errorWithDomain:@"Twitter"
                                                                 code:urlResponse.statusCode
                                                             userInfo:@{
                                                                        NSLocalizedDescriptionKey:@"Cannot retweet or send similar tweets. Please try again later"
                                                                        }];

                              block(nil,err);
                              
                          }
                      }
                      else
                      {
                          
                          block(nil, error);
                          
                      }
                  }];
             }
             else {

                 
                 block(nil,error);

                 NSLog(@"%@", [error localizedDescription]);
             }
         }];
    }
    else
    {
        
        NSDictionary *dicError = [NSDictionary dictionaryWithObject:@"Please Setup your Twitter account in SETTINGS" forKey:NSLocalizedDescriptionKey];
     
        NSError *error = [[NSError alloc]initWithDomain:@"Message" code:0 userInfo:dicError];
        
        block(nil,error);
        
        
    }
}

- (void)getMyFBFriendsWithParams:(NSDictionary*)dicParams block:(void(^)(NSDictionary * dicUserFBData, NSError *error))block{

    NSURL *meurl = [NSURL URLWithString:kFbFriends];
    
    SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                              requestMethod:SLRequestMethodGET
                                                        URL:meurl
                                                 parameters:dicParams];
    
    //@{@"access_token":self.fbAccessToken}
    
    merequest.account = self.facebookAccount;
    
    [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
        
        
        
        if (!error)
        {
            NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error:nil];
           // NSLog(@"%@", JSON);
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block (JSON, nil);
                
            });
        }
        else
        {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                
                block(nil, error);
                
            });
            
        }
        
    }];

}

-(void)likeFacebookFeed:(NSString*)objectId withResponse:(void(^)(NSDictionary * dicUserFBData, NSError *error))block{
    

    [self getFBAccessToken:^(NSString *accessToken, NSMutableDictionary *dicFbUser, NSError *error){
    
        if (!error) {
    
            NSString *url = [NSString stringWithFormat:@"https://graph.facebook.com/%@/likes", objectId];
            NSURL *meurl = [NSURL URLWithString:url];
            
            //NSLog(@"%@",url);
            SLRequest *merequest = [SLRequest requestForServiceType:SLServiceTypeFacebook
                                                      requestMethod:SLRequestMethodPOST
                                                                URL:meurl
                                                         parameters:@{@"access_token":accessToken}];
            
            merequest.account = self.facebookAccount;
            
            [merequest performRequestWithHandler:^(NSData *responseData, NSHTTPURLResponse *urlResponse, NSError *error) {
                
                
                
                if (!error)
                {
                    NSError *error2 = nil;
                    NSDictionary *JSON = [NSJSONSerialization JSONObjectWithData:responseData options: NSJSONReadingMutableContainers error:&error2];
                    if (error2 != nil) {
                        
                        NSString *responseString = [[NSString alloc] initWithData:responseData encoding:NSUTF8StringEncoding];
                        JSON = @{@"response": responseString};
                        
                    }
                   // NSLog(@"%@", JSON);
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        block (JSON, nil);
                        
                    });
                }
                else
                {
                    
                    dispatch_async(dispatch_get_main_queue(), ^{
                        
                        block(nil, error);
                        
                    });
                    
                }
                
            }];

            
        }else{
            
           if([error code]== ACErrorAccountNotFound)
               
                [UtilitiesHelper showPromptAlertforTitle:@"Message" withMessage:@"Account not found. Please setup your account in settings app." forDelegate:nil];
            
            else
                [UtilitiesHelper showPromptAlertforTitle:@"Message" withMessage:@"Account access denied." forDelegate:nil];
            
            
        }
    
    
    
   }];
    
   

    
    
}


//-(void)reTweetPost:(NSString *)objectId withResponse:(void (^)(NSDictionary * dicTweet, NSError *error))block {
//    
//    [self requestForTwitterWithUrl:[NSString stringWithFormat:@"%@%@.json",kTwitterRetweet,objectId] params:nil
//                          response:^(NSDictionary *dicData, NSError *error) {
//        
//                             
//                              if (!error) {
//                                  
//                                  
//                                  block(dicData,nil);
//                                  
//                              }
//                              else {
//                                  
//                                  
//                                  block(nil,error);
//                                  
//                              }
//                              
//                              
//                              
//                          }];
//    
//    
//    
//    
//}


@end
