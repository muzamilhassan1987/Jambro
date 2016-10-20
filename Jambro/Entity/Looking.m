#import "Looking.h"

@implementation Looking

@synthesize color;
@synthesize lookingId;
@synthesize name;
@synthesize selected;
@synthesize sound;

+ (Looking *)instanceFromDictionary:(NSMutableDictionary *)aDictionary {

    Looking *instance = [[Looking alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSMutableDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSMutableDictionary class]]) {
        return;
    }

    self.color = [aDictionary objectForKey:@"color"];
    self.lookingId = [aDictionary objectForKey:@"id"];
    self.name = [aDictionary objectForKey:@"name"];
    self.selected = [aDictionary objectForKey:@"selected"];
    self.sound = [aDictionary objectForKey:@"sound"];

}

- (NSMutableDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.color) {
        [dictionary setObject:self.color forKey:@"color"];
    }

    if (self.lookingId) {
        [dictionary setObject:self.lookingId forKey:@"lookingId"];
    }

    if (self.name) {
        [dictionary setObject:self.name forKey:@"name"];
    }

    if (self.selected) {
        [dictionary setObject:self.selected forKey:@"selected"];
    }

    if (self.sound) {
        [dictionary setObject:self.sound forKey:@"sound"];
    }

    return dictionary;

}


@end
