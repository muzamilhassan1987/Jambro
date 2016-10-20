#import <Foundation/Foundation.h>

@interface Play : NSObject {

    NSString *color;
    NSString *name;
    NSString *playId;
    NSString *selected;
    NSString *sound;

}

@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *playId;
@property (nonatomic, copy) NSString *selected;
@property (nonatomic, copy) NSString *sound;

+ (Play *)instanceFromDictionary:(NSMutableDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSMutableDictionary *)aDictionary;

- (NSMutableDictionary *)dictionaryRepresentation;

@end
