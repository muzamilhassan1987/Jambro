#import "Selection.h"

#import "Listen.h"
#import "Looking.h"
#import "Play.h"

@implementation Selection

@synthesize listen;
@synthesize looking;
@synthesize play;

+ (Selection *)instanceFromDictionary:(NSMutableDictionary *)aDictionary {

    Selection *instance = [[Selection alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSMutableDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSMutableDictionary class]]) {
        return;
    }


    NSMutableArray *receivedListen = [aDictionary objectForKey:@"listen"];
    if ([receivedListen isKindOfClass:[NSMutableArray class]]) {

        NSMutableArray *populatedListen = [NSMutableArray arrayWithCapacity:[receivedListen count]];
        for (NSMutableDictionary *item in receivedListen) {
            if ([item isKindOfClass:[NSMutableDictionary class]]) {
                [populatedListen addObject:[Listen instanceFromDictionary:item]];
            }
        }

        self.listen = populatedListen;

    }

    NSMutableArray *receivedLooking = [aDictionary objectForKey:@"looking"];
    if ([receivedLooking isKindOfClass:[NSMutableArray class]]) {

        NSMutableArray *populatedLooking = [NSMutableArray arrayWithCapacity:[receivedLooking count]];
        for (NSMutableDictionary *item in receivedLooking) {
            if ([item isKindOfClass:[NSMutableDictionary class]]) {
                [populatedLooking addObject:[Looking instanceFromDictionary:item]];
            }
        }

        self.looking = populatedLooking;

    }

    NSMutableArray *receivedPlay = [aDictionary objectForKey:@"play"];
    if ([receivedPlay isKindOfClass:[NSMutableArray class]]) {

        NSMutableArray *populatedPlay = [NSMutableArray arrayWithCapacity:[receivedPlay count]];
        for (NSMutableDictionary *item in receivedPlay) {
            if ([item isKindOfClass:[NSMutableDictionary class]]) {
                [populatedPlay addObject:[Play instanceFromDictionary:item]];
            }
        }

        self.play = populatedPlay;

    }

}

- (NSMutableDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.listen) {
        [dictionary setObject:self.listen forKey:@"listen"];
    }

    if (self.looking) {
        [dictionary setObject:self.looking forKey:@"looking"];
    }

    if (self.play) {
        [dictionary setObject:self.play forKey:@"play"];
    }

    return dictionary;

}


@end
