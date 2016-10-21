#import <Foundation/Foundation.h>

@interface UserConcreate : NSObject {

    NSNumber *age;
    NSString *bio;
    NSString *deviceToken;
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

@property (nonatomic, copy) NSNumber *age;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *deviceToken;
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

+ (UserConcreate *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
