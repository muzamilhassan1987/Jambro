#import <Foundation/Foundation.h>

@interface Selection : NSObject {

    NSMutableArray *listen;
    NSMutableArray *looking;
    NSMutableArray *play;

}

@property (nonatomic, copy) NSMutableArray *listen;
@property (nonatomic, copy) NSMutableArray *looking;
@property (nonatomic, copy) NSMutableArray *play;

+ (Selection *)instanceFromDictionary:(NSMutableDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSMutableDictionary *)aDictionary;

- (NSMutableDictionary *)dictionaryRepresentation;

@end
