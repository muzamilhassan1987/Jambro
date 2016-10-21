#import "User.h"

#import "UserConcreate.h"

@implementation User

@synthesize message;
@synthesize status;
@synthesize user;

+ (User *)instanceFromDictionary:(NSDictionary *)aDictionary {

    User *instance = [[User alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;

}

- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {

    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }

    self.message = [aDictionary objectForKey:@"message"];
    self.status = [aDictionary objectForKey:@"status"];
    self.user = [UserConcreate instanceFromDictionary:[aDictionary objectForKey:@"user"]];

}

- (NSDictionary *)dictionaryRepresentation {

    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];

    if (self.message) {
        [dictionary setObject:self.message forKey:@"message"];
    }

    if (self.status) {
        [dictionary setObject:self.status forKey:@"status"];
    }

    if (self.user) {
        [dictionary setObject:self.user forKey:@"user"];
    }

    return dictionary;

}


+(AFHTTPRequestOperation *) registerUser:(NSDictionary *)params
                           withURLStr:(NSString *)urlPath
                               onView:(UIView *)loaderOnView
                             response:(void (^)(User *objUser,NSError *error))block {
    
    
    
    NSLog(@"my dic %@",params);
    
    return [[ServiceModel sharedClient] POST:urlPath
                                  parameters:params
                                      onView:loaderOnView
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         
                                         if (responseObject) {
                                             
                                             User* objUser = [User instanceFromDictionary:responseObject];
                                             block (objUser, nil);
                                         }
                                         
                                         
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         block (nil, error);
                                         
                                     }];
}



@end
