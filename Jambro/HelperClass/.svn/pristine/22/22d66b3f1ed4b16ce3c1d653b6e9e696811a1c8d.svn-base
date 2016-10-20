//
//  WKSocialSharing.h
//  Chip
//
//  Created by Waqas Khalid on 02/10/2013.
//  Copyright (c) 2013 Appostrophic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Social/Social.h>
#import <Accounts/Accounts.h>

@interface WKSocialSharing : NSObject{

    ACAccount *twitterAccount;
    ACAccountStore *accountStore;

}

@property (nonatomic, retain) ACAccount *facebookAccount;
@property (nonatomic, retain) NSString *fbAccessToken;

+ (WKSocialSharing*)sharing;
- (void)postToFacebook:(NSString *)message withURL:(NSString *)urlString withImage:(NSString *)imageName withController:(UIViewController *)viewController;
//- (void)getUserInfo;
- (void)getFBAccessToken:(void(^)(NSString* accessToken,NSMutableDictionary *dicFbUser ,NSError* error))handler;
- (void)getMyFBDetails:(void(^)(NSDictionary * dicUserFBData, NSError *error))block;
- (void)getMyFBFriendsWithParams:(NSDictionary*)dicParams block:(void(^)(NSDictionary * dicUserFBData, NSError *error))block;
- (void)getMyFBProfilePictureWithId:(NSString *)facebookId block:(void(^)(NSData *responseData, NSError *error))block;

- (void) getInfoTwitter :(void (^)(NSDictionary *TWData, NSError *error))block;
-(void) performRequestViaGraphApi:(NSString *)urlPath
                           onView:(UIView *)loaderOnView
                         response:(void (^)(NSDictionary *dicData,NSError *error))block;
-(void) performRequestViaGraphApi:(NSString *)urlPath
                       parameters:(NSMutableDictionary *)dicParams
                           onView:(UIView *)loaderOnView
                         response:(void (^)(NSDictionary *dicData,NSError *error))block;
-(void) performRequestViaGraphApi:(NSString *)urlPath
                      queryFields:(NSString *)fields
                           onView:(UIView *)loaderOnView
                         response:(void (^)(NSDictionary *dicData,NSError *error))block;
-(void) performRequestViaGraphApiWithParams:(NSString *)urlPath
                                     params:(NSDictionary *)params
                                     onView:(UIView *)loaderOnView
                                   response:(void (^)(NSDictionary *dicData,NSError *error))block;

- (void)requestForTwitterWithUrl :(NSString *)urlStr params:(NSDictionary *)dicParams withRequestMethod:(SLRequestMethod)requestMethod response:(void (^)(NSDictionary *dicData,NSError *error))block;

-(void)likeFacebookFeed:(NSString*)objectId withResponse:(void(^)(NSDictionary * dicUserFBData, NSError *error))block;

//-(void)reTweetPost:(NSString*)objectId withResponse:(void(^)(NSDictionary * dicTweet, NSError *error))block;
@end
