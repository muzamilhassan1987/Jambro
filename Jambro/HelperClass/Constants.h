
#import <Foundation/Foundation.h>


#define APPC_IS_IPAD        (UI_USER_INTERFACE_IDIOM()== UIUserInterfaceIdiomPad) ? YES : NO
#define AppCachePath [[NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES) objectAtIndex:0]stringByAppendingPathComponent:@"AppCache"]
#define FACEBOOK_APP_ID_KEY         @"1421033478194582"
#define IS_IPAD (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad)
#define IS_IPHONE (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPhone)
#define IS_IPHONE_4_OR_LESS (IS_IPHONE && SCREEN_MAX_LENGTH < 568.0)
#define IS_IPHONE_5 (IS_IPHONE && SCREEN_MAX_LENGTH == 568.0)
#define IS_IPHONE_6 (IS_IPHONE && SCREEN_MAX_LENGTH == 667.0)
#define IS_IPHONE_6P (IS_IPHONE && SCREEN_MAX_LENGTH == 736.0)
#define IS_OS_5_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 5.0)
#define IS_OS_6_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 6.0)
#define IS_OS_7_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 7.0)
#define IS_OS_8_OR_LATER    ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0)
#define IS_RETINA ([[UIScreen mainScreen] scale] >= 2.0)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define FACEBOOK_APP_PERMISSION     @[@"email",@"user_friends",@"read_stream"]
#define FACEBOOK_APP_PERMISSION_EXTENDED     @[@"email",@"user_friends",@"read_stream",@"publish_actions"]
#define RGB(r,g,b) ([UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha:1])
#define UserDeviceToken                 @"UserDeviceToken"



@interface Constants : NSObject
extern  NSString *const kWebBaseUrl;
extern NSString *const kWebRegister;
@end
