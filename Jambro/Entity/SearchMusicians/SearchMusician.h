#import <Foundation/Foundation.h>
#import "ServiceModel.h"
@interface SearchMusician : NSObject {

    NSString *message;
    NSMutableArray *musician;
    NSNumber *status;

}

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSMutableArray *musician;
@property (nonatomic, copy) NSNumber *status;

+ (SearchMusician *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

+(AFHTTPRequestOperation *) searchMusician:(NSDictionary *)params
                              withURLStr:(NSString *)urlPath
                                  onView:(UIView *)loaderOnView
                                response:(void (^)(SearchMusician *objUser,NSError *error))block;

@end
