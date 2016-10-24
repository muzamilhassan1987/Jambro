//
//  UtilitiesHelper.h
//  VotoMessenger
//
//  Created by Muhammad Waqas Khalid on 8/29/13.
//
//

#import <Foundation/Foundation.h>
#import "MBProgressHUD.h"


#ifndef IS_IPHONE_5
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#endif

#ifndef IS_IPAD
#define IS_IPAD    (UI_USER_INTERFACE_IDIOM()==UIUserInterfaceIdiomPad)
#endif

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)


@interface UtilitiesHelper : NSObject
{
    
    

    
}


+ (id)shareUtitlities;
+ (id)getUserDefaultForKey:(NSString*)key;
+ (void)setUserDefaultForKey:(NSString*)key  value:(NSString*)value;
+(void)showCustomLoaderView:(UIView *) customView
                     onView:(UIView *)view;
+(void)showLoader:(NSString *)title
          forView:(UIView *)view  
          setMode:(MBProgressHUDMode)mode
         delegate:(id)vwDelegate;
+(void)hideLoader:(UIView*)forView;
+(void) showErrorAlert:(NSError *) error;
+(void)showPromptAlertforTitle:(NSString *)title withMessage:(NSString *)message forDelegate:(id)deleg;
+(void)showTextInputAlertforTitle:(NSString *)title withMessage:(NSString *)message forDelegate:(id)deleg;
+(BOOL) validateEmail:(NSString *)checkEmail;
+(NSURL *)imageURLMaker :(NSString *)imgUrl;
+(BOOL)isReachable;
+(BOOL) checkForEmptySpaces:(UITextField *)textField;
+(void)writeJsonToFile:(id)responseString withFileName:(NSString*)fileName;
//+(id)writeJsonToFile:(NSString*)fileName;
+(id)readJsonFromFile:(NSString*)fileName;
+(BOOL) validateFullName:(NSString *)checkFullName;
+(BOOL) checkForEmptySpacesInTextView : (UITextView *)textView;
+(BOOL) checkAlphabets:(NSString *)text;
+(BOOL) checkForEmptySpacesInString : (NSString *)rawString;
+(BOOL) checkPassword:(NSString *)text;
+(BOOL) checkPhoneNumber:(NSString *)text;
+(BOOL) checkFaxNumber:(NSString *)text;
+ (id)loadNibNamed:(NSString *)nibName ofClass:(Class)objClass;
+(NSString *) addSuffixToNumber:(NSInteger) number;
+(void)willBeImplementedInBeta;

+(NSDate *) timeDifferenceAccordingToTimeZone:(NSDate *) sourceDate;
+(NSString *) timeFormatForChat:(NSString *)string;
+ (UIImage *)scaleAndRotateImage:(UIImage *)image;

+(void) makeViewRoundedCorners:(UIView *) view
                        raduis:(double) radius
                   borderWidth:(double) border
                   borderColor:(UIColor *) color;
+(NSString *) jsonStringForObject:(id) object;
+(NSString *) cachePathForURL:(NSString *) path;
+(NSArray *) arrayForFilePath:(NSString*) filePath;
+(NSString *) filePathForName:(NSString *) fileName type:(NSString *) type;

+ (UIImage*) maskImage:(UIImage *)image withOverlayMask:(UIImage *) maskImage;

+(NSString *) getStringFromObject:(NSObject *) object;
+(BOOL) isEmpty:(NSString *)string fieldName:(NSString*)fieldName;
+(BOOL)ValidateNumber:(NSString*)myStr fieldName:(NSString*)fieldName;

+(void)showConformationPromptAlertforTitle:(NSString *)title withMessage:(NSString *)message forDelegate:(id)deleg;
+(NSArray *) getAllContacts;
+ (void)setExclusiveTouchToChildrenOf:(NSArray *)subviews;
- (id)loadNibNamed:(NSString *)nibName ofClass:(Class)objClass ;
+(BOOL) matchingString:(NSString *)string withString:(NSString*)anotherString;

+(NSString*)encodeEmojiTextwithText:(NSString*)emojiText;
+(NSString*)decodeEmojiTextwithText:(NSString*)emojiText;

+(UIColor *) colorFromHexString:(NSString *)hexString;
@end

