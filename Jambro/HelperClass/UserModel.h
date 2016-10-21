//
//  UserModel.h
//  InstApp
//
//  Created by Akber Sayani on 9/30/14.
//  Copyright (c) 2014 Appostrophic. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "UserConcreate.h"

@interface UserModel : NSObject

+ (instancetype)sharedInstance;


- (BOOL)checkUserData;
- (void)removeUserData;
- (UserConcreate *)getUserData;
- (void)saveUserInfo:(UserConcreate *)userinfo;
+ (NSString*)getUserDeviceToken;
+(void)saveDeviceToken:(NSString*)deviceToken;



@end
