//
//  Friend.m
//
//  Created by Faraz Haider on 10/25/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import "Friend.h"
#import "FriendsConcreate.h"
@implementation Friend

@synthesize message;
@synthesize friends;
@synthesize status;

+ (Friend *)instanceFromDictionary:(NSDictionary *)aDictionary {
    
    Friend *instance = [[Friend alloc] init];
    [instance setAttributesFromDictionary:aDictionary];
    return instance;
    
}
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary {
    
    if (![aDictionary isKindOfClass:[NSDictionary class]]) {
        return;
    }
    
    self.message = [aDictionary objectForKey:@"message"];
    
    NSString* key = @"";
    if (aDictionary[@"pendingRequest"]) {
        key = @"pendingRequest";
    }
    else if (aDictionary[@"friends"]) {
        key = @"friends";
    }
    
    
    NSArray *receivedMusician = [aDictionary objectForKey:key];
    if ([receivedMusician isKindOfClass:[NSArray class]]) {
        
        NSMutableArray *populatedMusician = [NSMutableArray arrayWithCapacity:[receivedMusician count]];
        for (NSDictionary *item in receivedMusician) {
            if ([item isKindOfClass:[NSDictionary class]]) {
                [populatedMusician addObject:[FriendsConcreate instanceFromDictionary:item]];
            }
        }
        
        self.friends = populatedMusician;
        
    }
    self.status = [aDictionary objectForKey:@"status"];
    
}
- (NSDictionary *)dictionaryRepresentation {
    
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    
    if (self.message) {
        [dictionary setObject:self.message forKey:@"message"];
    }
    
    if (self.friends) {
        [dictionary setObject:self.friends forKey:@"friends"];
    }
    
    if (self.status) {
        [dictionary setObject:self.status forKey:@"status"];
    }
    
    return dictionary;
    
}

+(AFHTTPRequestOperation *) getFriendList:(NSDictionary *)params
                                withURLStr:(NSString *)urlPath
                                    onView:(UIView *)loaderOnView
                                  response:(void (^)(Friend *objUser,NSError *error))block
{
    return [[ServiceModel sharedClient] POST:urlPath
                                  parameters:params
                                      onView:loaderOnView
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         
                                         if (responseObject) {
                                             
                                             Friend* objUser = [Friend instanceFromDictionary:responseObject];
                                             block (objUser, nil);
                                         }
                                         
                                         
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         block (nil, error);
                                         
                                     }];
}


+(AFHTTPRequestOperation *) rejectFriend:(NSDictionary *)params
                              withURLStr:(NSString *)urlPath
                                  onView:(UIView *)loaderOnView
                                response:(void (^)(Friend *objUser,NSError *error))block {
    
    return [[ServiceModel sharedClient] POST:urlPath
                                  parameters:params
                                      onView:loaderOnView
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         
                                         if (responseObject) {
                                             
                                           //  Friend* objUser = [Friend instanceFromDictionary:responseObject];
                                             //block (objUser, nil);
                                              block (responseObject, nil);
                                         }
                                         
                                         
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         block (nil, error);
                                         
                                     }];
}

+(AFHTTPRequestOperation *) acceptFriend:(NSDictionary *)params
                              withURLStr:(NSString *)urlPath
                                  onView:(UIView *)loaderOnView
                                response:(void (^)(Friend *objUser,NSError *error))block {
    
    return [[ServiceModel sharedClient] POST:urlPath
                                  parameters:params
                                      onView:loaderOnView
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         
                                         if (responseObject) {
                                             
                                             
                                             Friend* objUser = [Friend instanceFromDictionary:responseObject];
                                             block (objUser, nil);
                                         }
                                         
                                         
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         block (nil, error);
                                         
                                     }];
    
}
+(AFHTTPRequestOperation *) removeFriend:(NSDictionary *)params
                              withURLStr:(NSString *)urlPath
                                  onView:(UIView *)loaderOnView
                                response:(void (^)(Friend *objUser,NSError *error))block {
    
    return [[ServiceModel sharedClient] POST:urlPath
                                  parameters:params
                                      onView:loaderOnView
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         
                                         if (responseObject) {
                                             
                                             //Friend* objUser = [Friend instanceFromDictionary:responseObject];
                                             block (responseObject, nil);
                                         }
                                         
                                         
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         block (nil, error);
                                         
                                     }];
}
@end
