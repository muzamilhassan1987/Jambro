#import <Foundation/Foundation.h>

@interface Listen : NSObject {

    NSString *color;
    NSString *listenId;
    NSString *name;
    NSString *selected;
    NSString *sound;

}

@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *listenId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *selected;
@property (nonatomic, copy) NSString *sound;

+ (Listen *)instanceFromDictionary:(NSMutableDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSMutableDictionary *)aDictionary;

- (NSMutableDictionary *)dictionaryRepresentation;

@end
