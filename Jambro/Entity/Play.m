#import "Play.h"

@implementation Play

@synthesize color;
@synthesize name;
@synthesize playId;
@synthesize selected;
@synthesize sound;

+ (Play *)instanceFromDictionary:(NSMutableDictionary *)aDictionary {

    Play *instance = [[Play alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSMutableDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSMutableDictionary class]]) {
        return;
    }

    self.color = [aDictionary objectForKey:@"color"];
    self.name = [aDictionary objectForKey:@"name"];
    self.playId = [aDictionary objectForKey:@"id"];
    self.selected = [aDictionary objectForKey:@"selected"];
    self.sound = [aDictionary objectForKey:@"sound"];

}

- (NSMutableDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.color) {
        [dictionary setObject:self.color forKey:@"color"];
    }

    if (self.name) {
        [dictionary setObject:self.name forKey:@"name"];
    }

    if (self.playId) {
        [dictionary setObject:self.playId forKey:@"playId"];
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
