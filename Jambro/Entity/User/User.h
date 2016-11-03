#import <Foundation/Foundation.h>
#import "ServiceModel.h"

@class UserConcreate;

@interface User : NSObject {

    NSString *message;
    NSNumber *status;
    UserConcreate *user;

}

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSNumber *status;
@property (nonatomic, strong) UserConcreate *user;

+ (User *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

+(AFHTTPRequestOperation *) registerUser:(NSDictionary *)params
                           withURLStr:(NSString *)urlPath
                               onView:(UIView *)loaderOnView
                             response:(void (^)(User *objUser,NSError *error))block;

+(AFHTTPRequestOperation *) updateUserProfileImage:(NSDictionary *)params
                              withURLStr:(NSString *)urlPath
                                imageData:(NSData *) image
                                imageParamaterName:(NSString *) imageParam
                                  onView:(UIView *)loaderOnView
                                response:(void (^)(User *objUser,NSError *error))block;

+(AFHTTPRequestOperation *) updateUser:(NSDictionary *)params
                              withURLStr:(NSString *)urlPath
                                  onView:(UIView *)loaderOnView
                                response:(void (^)(User *objUser,NSError *error))block;

@end
