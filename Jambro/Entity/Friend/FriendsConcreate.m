//
//  FriendsConcreate.m
//  Jambro
//
//  Created by Faraz Haider on 10/31/16.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FriendsConcreate.h"

@implementation FriendsConcreate

NSString *const kFriendFacebookid = @"facebookid";
NSString *const kFriendName = @"name";
NSString *const kFriendLookfor = @"lookfor";
NSString *const kFriendLongt = @"longt";
NSString *const kFriendAge = @"age";
NSString *const kFriendPlay = @"play";
NSString *const kFriendListen = @"listen";
NSString *const kFriendPicture = @"picture";
NSString *const kFriendBio = @"bio";
NSString *const kFriendLat = @"lat";
NSString *const kFriendDistance = @"distance";
NSString *const kFriendEmail = @"email";
NSString *const kFriendGender = @"gender";
NSString *const kFriendChatCount = @"chat_count";


@synthesize facebookid;
@synthesize name;
@synthesize lookfor;
@synthesize longt;
@synthesize age;
@synthesize play;
@synthesize listen;
@synthesize picture;
@synthesize bio;
@synthesize lat;
@synthesize distance;
@synthesize email;
@synthesize gender;
@synthesize chatCount;
@synthesize arrPlay;
@synthesize arrListen;

+ (FriendsConcreate *)instanceFromDictionary:(NSDictionary *)aDictionary {
    
    FriendsConcreate *instance = [[FriendsConcreate alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
    
}
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    if (aDictionary[@"facebookid"]) {
        self.facebookid = [aDictionary objectForKey:kFriendFacebookid];
    }
    else {
        self.facebookid = [aDictionary objectForKey:@"id"];
    }
//    self.facebookid = [aDictionary objectForKey:kFriendFacebookid];
    self.name = [aDictionary objectForKey:kFriendName];
    self.lookfor = [aDictionary objectForKey:kFriendLookfor];
    self.longt = [aDictionary objectForKey:kFriendLongt];
    self.age = [aDictionary objectForKey:kFriendAge];
    self.play = [aDictionary objectForKey:kFriendPlay];
    self.listen = [aDictionary objectForKey:kFriendListen];
    self.picture = [aDictionary objectForKey:kFriendPicture];
    self.bio = [aDictionary objectForKey:kFriendBio];
    self.lat = [aDictionary objectForKey:kFriendLat];
    self.distance = [aDictionary objectForKey:kFriendDistance];
    self.email = [aDictionary objectForKey:kFriendEmail];
    self.gender = [aDictionary objectForKey:kFriendGender];
    self.chatCount = [aDictionary objectForKey:kFriendChatCount];
    
    arrPlay = [self.play componentsSeparatedByString:@","];
    arrListen = [self.listen componentsSeparatedByString:@","];
    
    
}

- (NSDictionary *)dictionaryRepresentation {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.facebookid) {
        [dictionary setObject:self.facebookid forKey:kFriendFacebookid];
    }
    
    if (self.name) {
        [dictionary setObject:self.name forKey:kFriendName];
    }
    
    if (self.lookfor) {
        [dictionary setObject:self.lookfor forKey:kFriendLookfor];
    }
    if (self.longt) {
        [dictionary setObject:self.longt forKey:kFriendLongt];
    }
    
    if (self.age) {
        [dictionary setObject:self.age forKey:kFriendAge];
    }
    
    if (self.play) {
        [dictionary setObject:self.play forKey:kFriendPlay];
    }
    
    if (self.listen) {
        [dictionary setObject:self.listen forKey:kFriendListen];
    }
    
    if (self.picture) {
        [dictionary setObject:self.picture forKey:kFriendPicture];
    }
    if (self.bio) {
        [dictionary setObject:self.bio forKey:kFriendBio];
    }
    
    if (self.lat) {
        [dictionary setObject:self.lat forKey:kFriendLat];
    }
    if (self.distance) {
        [dictionary setObject:self.distance forKey:kFriendDistance];
    }
    if (self.email) {
        [dictionary setObject:self.email forKey:kFriendEmail];
    }
    
    if (self.gender) {
        [dictionary setObject:self.gender forKey:kFriendGender];
    }
    
    if (self.chatCount) {
        [dictionary setObject:self.chatCount forKey:kFriendChatCount];
    }
    
    return dictionary;
    
}
@end
