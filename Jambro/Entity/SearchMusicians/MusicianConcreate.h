#import <Foundation/Foundation.h>

@interface MusicianConcreate : NSObject {

    NSString *age;
    NSNumber *caldistance;
    NSString *distance;
    NSString *email;
    NSString *facebookid;
    NSString *gender;
    NSString *lat;
    NSString *listen;
    NSString *longt;
    NSString *lookfor;
    NSString *name;
    NSString *picture;
    NSString *play;

}

@property (nonatomic, copy) NSString *age;
@property (nonatomic, copy) NSNumber *caldistance;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *facebookid;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *listen;
@property (nonatomic, copy) NSString *longt;
@property (nonatomic, copy) NSString *lookfor;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *play;

+ (MusicianConcreate *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
