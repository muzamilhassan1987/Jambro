//
//  Friend.h
//
//  Created by Faraz Haider on 10/25/16
//  Copyright (c) 2016 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ServiceModel.h"


@interface Friend : NSObject {
    NSString *message;
    NSMutableArray *friends;
    NSNumber *status;
}

@property (nonatomic, copy) NSString *message;
@property (nonatomic, copy) NSMutableArray *friends;
@property (nonatomic, copy) NSNumber *status;

+ (Friend *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

+(AFHTTPRequestOperation *) getFriendList:(NSDictionary *)params
                                withURLStr:(NSString *)urlPath
                                    onView:(UIView *)loaderOnView
                                  response:(void (^)(Friend *objUser,NSError *error))block;

+(AFHTTPRequestOperation *) rejectFriend:(NSDictionary *)params
                               withURLStr:(NSString *)urlPath
                                   onView:(UIView *)loaderOnView
                                 response:(void (^)(Friend *objUser,NSError *error))block;

+(AFHTTPRequestOperation *) acceptFriend:(NSDictionary *)params
                              withURLStr:(NSString *)urlPath
                                  onView:(UIView *)loaderOnView
                                response:(void (^)(Friend *objUser,NSError *error))block;

+(AFHTTPRequestOperation *) removeFriend:(NSDictionary *)params
                              withURLStr:(NSString *)urlPath
                                  onView:(UIView *)loaderOnView
                                response:(void (^)(Friend *objUser,NSError *error))block;
@end
