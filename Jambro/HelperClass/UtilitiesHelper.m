
//  UtilitiesHelper.m
//  InstaFlip
//
//  Created by Muhammad Waqas Khalid on 8/29/13.
//
//

#import "UtilitiesHelper.h"
#import "Constants.h"
#import "Reachability.h"
#import "NSDate+MTDates.h"



#define ALERT_FIELD_EMPTY                   @"%@ field can't be left empty!"
#define ALERT_INVLALID_FIELD               @"%@ field is not valid!"

@implementation UtilitiesHelper

+ (id)shareUtitlities
{
    static dispatch_once_t once;
    static UtilitiesHelper *shareUtilities;
    dispatch_once(&once, ^ { shareUtilities = [[self alloc] init];  });
    return shareUtilities;
}

+ (id)getUserDefaultForKey:(NSString*)key
{
    
    return [[NSUserDefaults standardUserDefaults] valueForKey:key];
    
}


+ (void)setUserDefaultForKey:(NSString*)key  value:(NSString*)value
{
   NSUserDefaults *usrDef =    [NSUserDefaults standardUserDefaults];
   [usrDef setObject:value forKey:key];
   [usrDef synchronize];
}


+ (id)returnUserDefaultForKey:(NSString*)key
{
    
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
    
}


+(void)showLoader:(NSString *)title forView:(UIView *)view  setMode:(MBProgressHUDMode)mode delegate:(id)vwDelegate
{
    if(view == nil) return;
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [progressHUD setMode:mode];
    [progressHUD setDimBackground:YES];
    [progressHUD setLabelText:title];
    [progressHUD setMinShowTime:1.0];
    
    
    
}

+(void)showCustomLoaderView:(UIView *) customView
                     onView:(UIView *)view
{
    if(view == nil) return;
    MBProgressHUD *progressHUD = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [progressHUD setCustomView:customView];
    [progressHUD setMode:MBProgressHUDModeCustomView];
    [progressHUD setDimBackground:NO];
    [progressHUD setMinShowTime:1.0];
    
    
    
}

+(void)hideLoader:(UIView *)forView
{
    dispatch_async(dispatch_get_main_queue(), ^{
        [MBProgressHUD hideAllHUDsForView:forView animated:YES];
    });
    
    
}


+(NSString *) addSuffixToNumber:(NSInteger) number
{
    NSString *suffix;
    int ones = number % 10;
    int temp = floor(number/10.0);
    int tens = temp%10;
    
    if (tens ==1) {
        suffix = @"th";
    } else if (ones ==1){
        suffix = @"st";
    } else if (ones ==2){
        suffix = @"nd";
    } else if (ones ==3){
        suffix = @"rd";
    } else {
        suffix = @"th";
    }

    NSString *completeAsString = [NSString stringWithFormat:@"%ld%@",(long)number,suffix];
    return completeAsString;
}




//^\+?\d+(-\d+)*$

+(BOOL) checkForEmptySpaces : (UITextField *)textField  {
 
    
    NSString *rawString = textField.text;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
//        textField.text = textField.placeholder;
//        textField.textColor = [UIColor redColor];
        // Text was empty or only whitespace.
    
        textField.text = @"";
        return NO;
    }
    
    return YES;
    
}

+(BOOL) checkForEmptySpacesInString : (NSString *)rawString  {
    
    
       NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        return NO;
    }
    return YES;
    
}
+(BOOL) checkForEmptySpacesInTextView : (UITextView *)textView  {
    
    
    NSString *rawString = textView.text;
    NSCharacterSet *whitespace = [NSCharacterSet whitespaceAndNewlineCharacterSet];
    NSString *trimmed = [rawString stringByTrimmingCharactersInSet:whitespace];
    if ([trimmed length] == 0) {
        // Text was empty or only whitespace.
        
        textView.text = @"";
        return NO;
    }
    
    return YES;
    
}


+(void)showTextInputAlertforTitle:(NSString *)title withMessage:(NSString *)message forDelegate:(id)deleg
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:deleg cancelButtonTitle:@"OK" otherButtonTitles:nil];
    alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alertView show];
}

+(void)showPromptAlertforTitle:(NSString *)title withMessage:(NSString *)message forDelegate:(id)deleg
{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:deleg cancelButtonTitle:@"OK"otherButtonTitles:nil];
    
    [alertView show];
}


+(void)showConformationPromptAlertforTitle:(NSString *)title withMessage:(NSString *)message forDelegate:(id)deleg
{
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title message:message delegate:deleg cancelButtonTitle:@"YES" otherButtonTitles:@"NO",nil];
    
    [alertView show];
    
    
}



+(void) showErrorAlert:(NSError *) error {
    
    [UtilitiesHelper showPromptAlertforTitle:@"Error"
                                 withMessage:[error localizedDescription]
                                 forDelegate:nil];
}

+(void)willBeImplementedInBeta
{
    
    
    [self showPromptAlertforTitle:@"Message" withMessage:@"This feature will be implemented in BETA version" forDelegate:nil];
    
}


+(BOOL) validateEmail:(NSString *)checkEmail
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z\\._%+-]+@([A-Za-z0-9-]+\\.)+[A-Za-z]{2,4}";
    NSString *laxString = @".+@([A-Za-z0-9]+\\.)+[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    BOOL result = [emailTest evaluateWithObject:checkEmail];
    
    if(!result){
//        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Email Field"] message:[NSString stringWithFormat:ALERT_INVLALID_FIELD,@"Email"] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
//        [alert show];
    }
    return result;
}

+(BOOL) validateFullName:(NSString *)checkFullName
{
    NSString *regex = @"[a-zA-Z]{2,}+(\\s{1}[a-zA-Z]{2,}+)+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:checkFullName];
}
+(BOOL) checkAlphabets:(NSString *)text
{
    NSString *regex = @"[a-zA-Z][a-zA-Z ]+";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}
+(BOOL) checkFaxNumber:(NSString *)text
{
    NSString *regex = @"^[0-9\\-\\+]{6,12}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}

///[\+? *[1-9]+]?[0-9 ]+/

+(BOOL) checkPhoneNumber:(NSString *)text
{
    NSString *regex = @"^[0-9\\-\\+]{9,15}$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}
+(BOOL) checkPassword:(NSString *)text
{
    NSString *regex = @"^\\w*(?=\\w*\\d)(?=\\w*[a-z])(?=\\w*[A-Z])\\w*$";
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    return [predicate evaluateWithObject:text];
}


+(NSURL *)imageURLMaker :(NSString *)imgUrl
{
//    return [NSURL URLWithString:[NSString stringWithFormat:@"%@%@", kWebServiceBaseURL, imgUrl]];
    return nil;
}



+(BOOL)isReachable{

        Reachability *networkReachability = [Reachability reachabilityForInternetConnection];
        NetworkStatus networkStatus = [networkReachability currentReachabilityStatus];
        if (networkStatus == NotReachable) {
            
             [UtilitiesHelper showPromptAlertforTitle:@"Message"
                                          withMessage:@"Please check your network connection and try again."
                                          forDelegate:nil];
            return NO;
            
        } else {
            
            return YES;
        }
    
}


+ (id)loadNibNamed:(NSString *)nibName ofClass:(Class)objClass {
    
    if (nibName && objClass) {
        
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName owner:nil options:nil];
        
        for (id currentObject in objects ){
            if ([currentObject isKindOfClass:objClass])
                return currentObject;
        }
    }
    
    return nil;
}

+(void)writeJsonToFile:(id)responseString withFileName:(NSString*)fileName
{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filePath = [NSString stringWithFormat:@"%@/%@", documentsDirectory, fileName];
    NSLog(@"filePath %@", filePath);

    if (![[NSFileManager defaultManager] fileExistsAtPath:filePath]) { // if file is not exist, create it.
         NSError *error;
        [responseString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
        
    }
    else
    {
        NSError *error;
        [[NSFileManager defaultManager] removeItemAtPath: filePath error: &error];

        [responseString writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error:&error];
    }
    
}
+(id)readJsonFromFile:(NSString*)fileName
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    NSString *myPathDocs =  [documentsDirectory stringByAppendingPathComponent:fileName];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:myPathDocs])
    {
//        NSString *myPathInfo = [[NSBundle mainBundle] pathForResource:@"myfile" ofType:@"txt"];
//        NSFileManager *fileManager = [NSFileManager defaultManager];
//        [fileManager copyItemAtPath:myPathInfo toPath:myPathDocs error:NULL];
        return NULL;
    }
    
    //Load from File
    NSString *myString = [[NSString alloc] initWithContentsOfFile:myPathDocs encoding:NSUTF8StringEncoding error:NULL];
    NSLog(@"string ===> %@",myString);
    return myString;
}



+(NSDate *) timeDifferenceAccordingToTimeZone:(NSDate *) sourceDate {
    
    NSTimeZone* destinationTimeZone = [NSTimeZone systemTimeZone];
    float timeZoneOffset = [destinationTimeZone secondsFromGMT];
    
    //timeZoneOffset = timeZoneOffset - (3600*(-8));
    
    return [sourceDate dateByAddingTimeInterval:timeZoneOffset];
}

+(NSString *) timeFormatForChat:(NSString *)string
{
    NSDate *date;
    NSDateFormatter *formattor = [NSDate mt_sharedFormatter];
    [formattor setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [formattor setTimeZone:[NSTimeZone systemTimeZone]];
    date = [formattor dateFromString:string];
    NSDateFormatter *formater3 = [NSDate mt_sharedFormatter];
    [formater3 setDateFormat:@"hh:mm"];
    NSString *strTime = [formater3 stringFromDate:date];
    return strTime;
}

+ (UIImage *)scaleAndRotateImage:(UIImage *)image {
    int kMaxResolution = 2000;
    
    CGImageRef imgRef = image.CGImage;
    
    CGFloat width = CGImageGetWidth(imgRef);
    CGFloat height = CGImageGetHeight(imgRef);
    
    
    CGAffineTransform transform = CGAffineTransformIdentity;
    CGRect bounds = CGRectMake(0, 0, width, height);
    if (width > kMaxResolution || height > kMaxResolution) {
        CGFloat ratio = width/height;
        if (ratio > 1) {
            bounds.size.width = kMaxResolution;
            bounds.size.height = roundf(bounds.size.width / ratio);
        }
        else {
            bounds.size.height = kMaxResolution;
            bounds.size.width = roundf(bounds.size.height * ratio);
        }
    }
    
    CGFloat scaleRatio = bounds.size.width / width;
    CGSize imageSize = CGSizeMake(CGImageGetWidth(imgRef), CGImageGetHeight(imgRef));
    CGFloat boundHeight;
    UIImageOrientation orient = image.imageOrientation;
    switch(orient) {
            
        case UIImageOrientationUp: //EXIF = 1
            transform = CGAffineTransformIdentity;
            break;
            
        case UIImageOrientationUpMirrored: //EXIF = 2
            transform = CGAffineTransformMakeTranslation(imageSize.width, 0.0);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            break;
            
        case UIImageOrientationDown: //EXIF = 3
            transform = CGAffineTransformMakeTranslation(imageSize.width, imageSize.height);
            transform = CGAffineTransformRotate(transform, M_PI);
            break;
            
        case UIImageOrientationDownMirrored: //EXIF = 4
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.height);
            transform = CGAffineTransformScale(transform, 1.0, -1.0);
            break;
            
        case UIImageOrientationLeftMirrored: //EXIF = 5
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, imageSize.width);
            transform = CGAffineTransformScale(transform, -1.0, 1.0);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationLeft: //EXIF = 6
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(0.0, imageSize.width);
            transform = CGAffineTransformRotate(transform, 3.0 * M_PI / 2.0);
            break;
            
        case UIImageOrientationRightMirrored: //EXIF = 7
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeScale(-1.0, 1.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        case UIImageOrientationRight: //EXIF = 8
            boundHeight = bounds.size.height;
            bounds.size.height = bounds.size.width;
            bounds.size.width = boundHeight;
            transform = CGAffineTransformMakeTranslation(imageSize.height, 0.0);
            transform = CGAffineTransformRotate(transform, M_PI / 2.0);
            break;
            
        default:
            [NSException raise:NSInternalInconsistencyException format:@"Invalid image orientation"];
            
    }
    
    UIGraphicsBeginImageContext(bounds.size);
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    if (orient == UIImageOrientationRight || orient == UIImageOrientationLeft) {
        CGContextScaleCTM(context, -scaleRatio, scaleRatio);
        CGContextTranslateCTM(context, -height, 0);
    }
    else {
        CGContextScaleCTM(context, scaleRatio, -scaleRatio);
        CGContextTranslateCTM(context, 0, -height);
    }
    
    CGContextConcatCTM(context, transform);
    
    CGContextDrawImage(UIGraphicsGetCurrentContext(), CGRectMake(0, 0, width, height), imgRef);
    UIImage *imageCopy = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return imageCopy;
}


+(void) makeViewRoundedCorners:(UIView *) view
                        raduis:(double) radius
                   borderWidth:(double) border
                   borderColor:(UIColor *) color {
    
    [view.layer setCornerRadius:radius];
    [view.layer setBorderWidth:border];
    [view.layer setBorderColor:color.CGColor];
    [view setClipsToBounds:YES];
}

+ (UIImage *) iconForAvailabilityStatus:(NSString *) status
{
    UIImage *icon;
    status = [status lowercaseString];
    
    if ([status isEqualToString:@"online"]) {
        icon = [UIImage imageNamed:@"imgOnline"];
    }
    else {
        icon = [UIImage imageNamed:@"imgOffline"];
    }

    return icon;
}

+(NSString *) jsonStringForObject:(id) object {
    
    NSError *error = nil;
    NSData * JSONData = [NSJSONSerialization dataWithJSONObject:object
                                                        options:kNilOptions
                                                          error:&error];
    NSLog(@"error: %@", error);
    NSString *string = [[NSString alloc] initWithData:JSONData encoding:NSUTF8StringEncoding];
    return string;
}

+(NSString *) cachePathForURL:(NSString *) path {
    
    return [AppCachePath stringByAppendingPathComponent:[@"_" stringByAppendingString:[path stringByReplacingOccurrencesOfString:@"/" withString:@"_"]]];
}

+(NSString *) filePathForName:(NSString *) fileName type:(NSString *) type {
    NSString *filePath = [[NSBundle mainBundle] pathForResource:fileName ofType:type];
    return filePath;
}

+(NSArray *) arrayForFilePath:(NSString*) filePath {
    return [NSArray arrayWithContentsOfFile:filePath];
}

+ (UIImage*) maskImage:(UIImage *)image withOverlayMask:(UIImage *) maskImage
{
    CGImageRef maskImageRef = [maskImage CGImage];
    
    CGFloat scaleFactor = maskImage.scale;
    
    /* create a bitmap graphics context the size of the image */
    
//    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL, maskImage.size.width, maskImage.size.height, 8, 0, colorSpace, (CGBitmapInfo)kCGImageAlphaPremultipliedLast);

    CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();

    CGContextRef mainViewContentContext = CGBitmapContextCreate (NULL,
                                                                 maskImage.size.width * scaleFactor,
                                                                 maskImage.size.height * scaleFactor,
                                                                 8,
                                                                 maskImage.size.width * scaleFactor * 4,
                                                                 colorSpace,
                                                                 (CGBitmapInfo)kCGImageAlphaPremultipliedLast);
    
    CGContextScaleCTM(mainViewContentContext, scaleFactor, scaleFactor);
    
    if (mainViewContentContext==NULL)
        return NULL;
    
    CGFloat ratio = 0;
    
    ratio = maskImage.size.width/ image.size.width;
    
    if(ratio * image.size.height < maskImage.size.height) {
        ratio = maskImage.size.height/ image.size.height;
    }
    
    CGRect rect1  = {{0, 0}, {maskImage.size.width, maskImage.size.height}};

    CGRect rect2  = {{-((image.size.width*ratio)-maskImage.size.width)/2 , -((image.size.height*ratio)-maskImage.size.height)/2}, {image.size.width*ratio, image.size.height*ratio}};

//    CGRect rect2  = {{-((image.size.width*ratio)-maskImage.size.width)/2 , -((image.size.height*ratio)-maskImage.size.height)/2}, {image.size.width*maskImage.scale, image.size.height*maskImage.scale}};

    CGContextClipToMask(mainViewContentContext, rect1, maskImageRef);
    CGContextDrawImage(mainViewContentContext, rect2, image.CGImage);
    
    
    // Create CGImageRef of the main view bitmap content, and then
    // release that bitmap context
    CGImageRef newImage = CGBitmapContextCreateImage(mainViewContentContext);
    CGContextRelease(mainViewContentContext);

//    UIImage *theImage = [UIImage imageWithCGImage:newImage];
    
    UIImage *theImage = [UIImage imageWithCGImage:newImage scale:scaleFactor orientation:maskImage.imageOrientation];
    
    CGImageRelease(newImage);
    
    // return the image
    return theImage;
}

+(NSString *) getStringFromObject:(NSObject *) object
{
    if ([object isKindOfClass:[NSNull class]]) {
        return @"";
    }
    return (NSString *)object;
}


+(BOOL) isEmpty:(NSString *)string fieldName:(NSString*)fieldName
{
    if(string == nil || [string isKindOfClass:[NSNull class]] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ Field",fieldName] message:[NSString stringWithFormat:ALERT_FIELD_EMPTY,fieldName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return TRUE;
    }
    else{
        return FALSE;
    }
    
}


+(BOOL) matchingString:(NSString *)string withString:(NSString*)anotherString
{
    if (![string isEqualToString:anotherString]) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"Error"] message:@"Passwords do not match" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        return FALSE;
    }
    else{
        return TRUE;
    }
    
}



+(BOOL)ValidateNumber:(NSString*)myStr fieldName:(NSString*)fieldName{
    
    NSString *strMatchstring=@"\\b([0-9%_.+\\-]+)\\b";
    NSPredicate *textpredicate=[NSPredicate predicateWithFormat:@"SELF MATCHES %@", strMatchstring];
    BOOL result = [textpredicate evaluateWithObject:myStr];
    if(!result){
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@ Field",fieldName] message:[NSString stringWithFormat:ALERT_INVLALID_FIELD,fieldName] delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
    }
    return result;
}


+ (void)setExclusiveTouchToChildrenOf:(NSArray *)subviews
{
    for (UIView *v in subviews) {
        [self setExclusiveTouchToChildrenOf:v.subviews];
        if ([v isKindOfClass:[UIButton class]]) {
            UIButton *btn = (UIButton *)v;
            [btn setExclusiveTouch:YES];
        }
        else if ([v isKindOfClass:[UICollectionViewCell class]]) {
            [v setExclusiveTouch:YES];
        }
        else {
            [v setExclusiveTouch:YES];
        }
        
    }
}


- (id)loadNibNamed:(NSString *)nibName ofClass:(Class)objClass {
    if (nibName && objClass) {
        NSArray *objects = [[NSBundle mainBundle] loadNibNamed:nibName
                                                         owner:nil
                                                       options:nil];
        for (id currentObject in objects ){
            if ([currentObject isKindOfClass:objClass])
                return currentObject;
        }
    }
    
    return nil;
}



+(NSString*)encodeEmojiTextwithText:(NSString*)emojiText
{
    NSString *uniText = [NSString stringWithUTF8String:[emojiText UTF8String]];
    NSData *msgData = [uniText dataUsingEncoding:NSNonLossyASCIIStringEncoding];
    NSString *encodedText = [[NSString alloc] initWithData:msgData encoding:NSUTF8StringEncoding];
    return encodedText;

}

+(NSString*)decodeEmojiTextwithText:(NSString*)emojiText
{
    const char *jsonString = [emojiText UTF8String];
    NSData *jsonData = [NSData dataWithBytes:jsonString length:strlen(jsonString)];
    NSString *decodedText = [[NSString alloc] initWithData:jsonData encoding:NSNonLossyASCIIStringEncoding];
    return decodedText;
}


+(UIColor *) colorFromHexString:(NSString *)hexString {
    NSString *cleanString = [hexString stringByReplacingOccurrencesOfString:@"#" withString:@""];
    if([cleanString length] == 3) {
        cleanString = [NSString stringWithFormat:@"%@%@%@%@%@%@",
                       [cleanString substringWithRange:NSMakeRange(0, 1)],[cleanString substringWithRange:NSMakeRange(0, 1)],
                       [cleanString substringWithRange:NSMakeRange(1, 1)],[cleanString substringWithRange:NSMakeRange(1, 1)],
                       [cleanString substringWithRange:NSMakeRange(2, 1)],[cleanString substringWithRange:NSMakeRange(2, 1)]];
    }
    if([cleanString length] == 6) {
        cleanString = [cleanString stringByAppendingString:@"ff"];
    }
    
    unsigned int baseValue;
    [[NSScanner scannerWithString:cleanString] scanHexInt:&baseValue];
    
    float red = ((baseValue >> 24) & 0xFF)/255.0f;
    float green = ((baseValue >> 16) & 0xFF)/255.0f;
    float blue = ((baseValue >> 8) & 0xFF)/255.0f;
    float alpha = ((baseValue >> 0) & 0xFF)/255.0f;
    
    return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end

