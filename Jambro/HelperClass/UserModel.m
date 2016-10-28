//
//  UserModel.m
//  InstApp
//
//  Created by Akber Sayani on 9/30/14.
//  Copyright (c) 2014 Appostrophic. All rights reserved.
//

#import "UserModel.h"
#import "Constants.h"
#import "NSUserDefaults+RMSaveCustomObject.h"

@implementation UserModel

+ (instancetype)sharedInstance {
    
    static UserModel *_sharedClient = nil;
    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        _sharedClient = [[UserModel alloc] init];
    });
    
    return _sharedClient;
}

- (BOOL)checkUserData
{
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    if ([userdefault objectForKey:@"userinfo"])
        return YES;
    else
        return NO;
}

- (void)removeUserData
{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault removeObjectForKey:@"userinfo"];
    [userdefault synchronize];
}

- (UserConcreate *)getUserData
{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    UserConcreate* user = [defaults rm_customObjectForKey:@"userinfo"];
    return user;
}

- (void)saveUserInfo:(UserConcreate *)userinfo{
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults rm_setCustomObject:userinfo forKey:@"userinfo"];
}

+(void)saveDeviceToken:(NSString*)deviceToken{
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    [userdefault setObject:deviceToken forKey:UserDeviceToken];
    [userdefault synchronize];
}

+ (NSString*)getUserDeviceToken{
    
    NSUserDefaults *userdefault = [NSUserDefaults standardUserDefaults];
    return [userdefault valueForKey:UserDeviceToken];
}





@end
