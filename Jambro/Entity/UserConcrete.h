#import <Foundation/Foundation.h>

@interface UserConcrete : NSObject {

    NSString *created;
    NSString *deviceToken;
    NSString *deviceType;
    NSString *firstName;
    NSString *lastName;
    NSString *modified;
    NSString *pushStatus;
    NSString *userAge;
    NSString *userCity;
    NSString *userDob;
    NSString *userEmail;
    NSString *userFriendId;
    NSString *userGender;
    NSString *userId;
    NSString *userImage;
    NSString *userLat;
    NSString *userLong;
    NSString *userMarijuana;
    NSString *userPassword;

}

@property (nonatomic, copy) NSString *created;
@property (nonatomic, copy) NSString *deviceToken;
@property (nonatomic, copy) NSString *deviceType;
@property (nonatomic, copy) NSString *firstName;
@property (nonatomic, copy) NSString *lastName;
@property (nonatomic, copy) NSString *modified;
@property (nonatomic, copy) NSString *pushStatus;
@property (nonatomic, copy) NSString *userAge;
@property (nonatomic, copy) NSString *userCity;
@property (nonatomic, copy) NSString *userDob;
@property (nonatomic, copy) NSString *userEmail;
@property (nonatomic, copy) NSString *userFriendId;
@property (nonatomic, copy) NSString *userGender;
@property (nonatomic, copy) NSString *userId;
@property (nonatomic, copy) NSString *userImage;
@property (nonatomic, copy) NSString *userLat;
@property (nonatomic, copy) NSString *userLong;
@property (nonatomic, copy) NSString *userMarijuana;
@property (nonatomic, copy) NSString *userPassword;

+ (UserConcrete *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
