#import "UserConcreate.h"

@implementation UserConcreate

@synthesize age;
@synthesize bio;
@synthesize deviceToken;
@synthesize distance;
@synthesize email;
@synthesize facebookid;
@synthesize gender;
@synthesize lat;
@synthesize listen;
@synthesize longt;
@synthesize lookfor;
@synthesize name;
@synthesize picture;
@synthesize play;

+ (UserConcreate *)instanceFromDictionary:(NSDictionary *)aDictionary {

    UserConcreate *instance = [[UserConcreate alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.age = [aDictionary objectForKey:@"age"];
    self.bio = [aDictionary objectForKey:@"bio"];
    self.deviceToken = [aDictionary objectForKey:@"device_token"];
    self.distance = [aDictionary objectForKey:@"distance"];
    self.email = [aDictionary objectForKey:@"email"];
    self.facebookid = [aDictionary objectForKey:@"facebookid"];
    self.gender = [aDictionary objectForKey:@"gender"];
    self.lat = [aDictionary objectForKey:@"lat"];
    self.listen = [aDictionary objectForKey:@"listen"];
    self.longt = [aDictionary objectForKey:@"longt"];
    self.lookfor = [aDictionary objectForKey:@"lookfor"];
    self.name = [aDictionary objectForKey:@"name"];
    self.picture = [aDictionary objectForKey:@"picture"];
    self.play = [aDictionary objectForKey:@"play"];

}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.age) {
        [dictionary setObject:self.age forKey:@"age"];
    }

    if (self.bio) {
        [dictionary setObject:self.bio forKey:@"bio"];
    }

    if (self.deviceToken) {
        [dictionary setObject:self.deviceToken forKey:@"deviceToken"];
    }

    if (self.distance) {
        [dictionary setObject:self.distance forKey:@"distance"];
    }

    if (self.email) {
        [dictionary setObject:self.email forKey:@"email"];
    }

    if (self.facebookid) {
        [dictionary setObject:self.facebookid forKey:@"facebookid"];
    }

    if (self.gender) {
        [dictionary setObject:self.gender forKey:@"gender"];
    }

    if (self.lat) {
        [dictionary setObject:self.lat forKey:@"lat"];
    }

    if (self.listen) {
        [dictionary setObject:self.listen forKey:@"listen"];
    }

    if (self.longt) {
        [dictionary setObject:self.longt forKey:@"longt"];
    }

    if (self.lookfor) {
        [dictionary setObject:self.lookfor forKey:@"lookfor"];
    }

    if (self.name) {
        [dictionary setObject:self.name forKey:@"name"];
    }

    if (self.picture) {
        [dictionary setObject:self.picture forKey:@"picture"];
    }

    if (self.play) {
        [dictionary setObject:self.play forKey:@"play"];
    }

    return dictionary;

}


@end