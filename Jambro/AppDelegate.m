//
//  AppDelegate.m
//  Jambro
//
//  Created by Faraz Haider on 14/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "AppDelegate.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import "UserModel.h"
#import "HACLocationManager.h"
#import "MPNotificationView.h"
#import "ChatViewController.h"
//cccc

@interface AppDelegate ()

@end

@implementation AppDelegate


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


-(void)setRootController{
    
    
    UIStoryboard* storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];

    
    if (![[UserModel sharedInstance] checkUserData])
    {
        UINavigationController* navController=[storyboard instantiateViewControllerWithIdentifier:@"SelectionNavigation"];
        self.window.rootViewController=navController;
        
    }
    else{
        UINavigationController* navController=[storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"];
        self.window.rootViewController=navController;
    }
}


-(void)makeHomeRootView
{
    UIStoryboard* storyboard=[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    
    UINavigationController* navController=[storyboard instantiateViewControllerWithIdentifier:@"HomeNavigation"];
    self.window.rootViewController=navController;
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    [FBSDKAppEvents activateApp];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [[FBSDKApplicationDelegate sharedInstance] application:application
                             didFinishLaunchingWithOptions:launchOptions];
    
//    for (NSString* family in [UIFont familyNames])
//    {
//        NSLog(@"%@", family);
//        
//        for (NSString* name in [UIFont fontNamesForFamilyName: family])
//        {
//            NSLog(@"  %@", name);
//        }
//    }
    

    [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:(UIUserNotificationTypeSound | UIUserNotificationTypeAlert | UIUserNotificationTypeBadge) categories:nil]];
    
    [application registerForRemoteNotifications];
    
    [[HACLocationManager sharedInstance]requestAuthorizationLocation];
    
    return YES;
}




-(void)application:(UIApplication *)application didRegisterForRemoteNotificationsWithDeviceToken:(NSData *)deviceToken
{
    NSString *strDeviceToken = [[[[[deviceToken description]stringByReplacingOccurrencesOfString: @"<" withString: @""] stringByReplacingOccurrencesOfString: @">" withString: @""]stringByReplacingOccurrencesOfString:@" " withString: @""]copy];
    NSLog(@"Push %@",strDeviceToken);
    
    [UserModel saveDeviceToken:strDeviceToken];
}

- (void)application:(UIApplication*)application didFailToRegisterForRemoteNotificationsWithError:(NSError*)error
{
    NSLog(@"Failed to get token, error: %@", error);
    [UserModel saveDeviceToken:@"111"];
}

- (void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings
{
    //register to receive notifications
    [application registerForRemoteNotifications];
}



- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo {
    
    NSLog(@" this is me %@",userInfo);
    
    NSString *messageType = [userInfo valueForKey:@"type"];
    
    
    UIApplicationState state = [application applicationState];
    if (state == UIApplicationStateActive) {
        
        if ([((UINavigationController*)self.window.rootViewController).visibleViewController isKindOfClass:[ChatViewController class]]) {
            return;
        }
        
        NSString *message = [[userInfo valueForKey:@"aps"] valueForKey:@"alert"];
        
        
        [MPNotificationView notifyWithText:@"Jambro" detail:message image:[UIImage imageNamed:@"AppIcon"] duration:0.7 type:@"" andTouchBlock:^(MPNotificationView *view) {
            
        }];
        
        

        
    }
    NSLog(@"Im in this %@",((UINavigationController*)self.window.rootViewController).visibleViewController);
    
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
