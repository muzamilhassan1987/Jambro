#import "SearchMusician.h"

#import "MusicianConcreate.h"

@implementation SearchMusician

@synthesize message;
@synthesize musician;
@synthesize status;

+ (SearchMusician *)instanceFromDictionary:(NSDictionary *)aDictionary {

    SearchMusician *instance = [[SearchMusician alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.message = [aDictionary objectForKey:@"message"];

    NSArray *receivedMusician = [aDictionary objectForKey:@"musician"];
    if ([receivedMusician isKindOfClass:[NSArray class]]) {

        NSMutableArray *populatedMusician = [NSMutableArray arrayWithCapacity:[receivedMusician count]];
        for (NSDictionary *item in receivedMusician) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedMusician addObject:[MusicianConcreate instanceFromDictionary:item]];
            }
        }

        self.musician = populatedMusician;

    }
    self.status = [aDictionary objectForKey:@"status"];

}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.message) {
        [dictionary setObject:self.message forKey:@"message"];
    }

    if (self.musician) {
        [dictionary setObject:self.musician forKey:@"musician"];
    }

    if (self.status) {
        [dictionary setObject:self.status forKey:@"status"];
    }

    return dictionary;

}



+(AFHTTPRequestOperation *) searchMusician:(NSDictionary *)params
                                withURLStr:(NSString *)urlPath
                                    onView:(UIView *)loaderOnView
                                  response:(void (^)(SearchMusician *objUser,NSError *error))block
{
    return [[ServiceModel sharedClient] POST:urlPath
                                  parameters:params
                                      onView:loaderOnView
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         
                                         if (responseObject) {
                                             
                                             SearchMusician* objUser = [SearchMusician instanceFromDictionary:responseObject];
                                             block (objUser, nil);
                                         }
                                         
                                         
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         block (nil, error);
                                         
                                     }];
}

@end
