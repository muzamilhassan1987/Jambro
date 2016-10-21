#import <Foundation/Foundation.h>

@interface Looking : NSObject {

    NSString *color;
    NSString *lookingId;
    NSString *name;
    NSString *selected;
    NSString *sound;

}

@property (nonatomic, copy) NSString *color;
@property (nonatomic, copy) NSString *lookingId;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *selected;
@property (nonatomic, copy) NSString *sound;

+ (Looking *)instanceFromDictionary:(NSMutableDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSMutableDictionary *)aDictionary;

- (NSMutableDictionary *)dictionaryRepresentation;

@end
