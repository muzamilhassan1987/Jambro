#import "UserConcrete.h"

@implementation UserConcrete

@synthesize created;
@synthesize deviceToken;
@synthesize deviceType;
@synthesize firstName;
@synthesize lastName;
@synthesize modified;
@synthesize pushStatus;
@synthesize userAge;
@synthesize userCity;
@synthesize userDob;
@synthesize userEmail;
@synthesize userFriendId;
@synthesize userGender;
@synthesize userId;
@synthesize userImage;
@synthesize userLat;
@synthesize userLong;
@synthesize userMarijuana;
@synthesize userPassword;

+ (UserConcrete *)instanceFromDictionary:(NSDictionary *)aDictionary {

    UserConcrete *instance = [[UserConcrete alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.created = [aDictionary objectForKey:@"created"];
    self.deviceToken = [aDictionary objectForKey:@"device_token"];
    self.deviceType = [aDictionary objectForKey:@"device_type"];
    self.firstName = [aDictionary objectForKey:@"first_name"];
    self.lastName = [aDictionary objectForKey:@"last_name"];
    self.modified = [aDictionary objectForKey:@"modified"];
    self.pushStatus = [aDictionary objectForKey:@"push_status"];
    self.userAge = [aDictionary objectForKey:@"user_age"];
    self.userCity = [aDictionary objectForKey:@"user_city"];
    self.userDob = [aDictionary objectForKey:@"user_dob"];
    self.userEmail = [aDictionary objectForKey:@"user_email"];
    self.userFriendId = [aDictionary objectForKey:@"user_friend_id"];
    self.userGender = [aDictionary objectForKey:@"user_gender"];
    self.userId = [aDictionary objectForKey:@"user_id"];
    self.userImage = [aDictionary objectForKey:@"user_image"];
    self.userLat = [aDictionary objectForKey:@"user_lat"];
    self.userLong = [aDictionary objectForKey:@"user_long"];
    self.userMarijuana = [aDictionary objectForKey:@"user_marijuana"];
    self.userPassword = [aDictionary objectForKey:@"user_password"];

}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.created) {
        [dictionary setObject:self.created forKey:@"created"];
    }

    if (self.deviceToken) {
        [dictionary setObject:self.deviceToken forKey:@"deviceToken"];
    }

    if (self.deviceType) {
        [dictionary setObject:self.deviceType forKey:@"deviceType"];
    }

    if (self.firstName) {
        [dictionary setObject:self.firstName forKey:@"firstName"];
    }

    if (self.lastName) {
        [dictionary setObject:self.lastName forKey:@"lastName"];
    }

    if (self.modified) {
        [dictionary setObject:self.modified forKey:@"modified"];
    }

    if (self.pushStatus) {
        [dictionary setObject:self.pushStatus forKey:@"pushStatus"];
    }

    if (self.userAge) {
        [dictionary setObject:self.userAge forKey:@"userAge"];
    }

    if (self.userCity) {
        [dictionary setObject:self.userCity forKey:@"userCity"];
    }

    if (self.userDob) {
        [dictionary setObject:self.userDob forKey:@"userDob"];
    }

    if (self.userEmail) {
        [dictionary setObject:self.userEmail forKey:@"userEmail"];
    }

    if (self.userFriendId) {
        [dictionary setObject:self.userFriendId forKey:@"userFriendId"];
    }

    if (self.userGender) {
        [dictionary setObject:self.userGender forKey:@"userGender"];
    }

    if (self.userId) {
        [dictionary setObject:self.userId forKey:@"userId"];
    }

    if (self.userImage) {
        [dictionary setObject:self.userImage forKey:@"userImage"];
    }

    if (self.userLat) {
        [dictionary setObject:self.userLat forKey:@"userLat"];
    }

    if (self.userLong) {
        [dictionary setObject:self.userLong forKey:@"userLong"];
    }

    if (self.userMarijuana) {
        [dictionary setObject:self.userMarijuana forKey:@"userMarijuana"];
    }

    if (self.userPassword) {
        [dictionary setObject:self.userPassword forKey:@"userPassword"];
    }

    return dictionary;

}


@end
