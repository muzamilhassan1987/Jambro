//
//  FriendsConcreate.h
//  Jambro
//
//  Created by Faraz Haider on 10/31/16.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FriendsConcreate : NSObject {
    
    NSString *facebookid;
    NSString *name;
    NSString *lookfor;
    NSString *longt;
    NSNumber *age;
    NSString *play;
    NSString *listen;
    NSString *picture;
    NSString *bio;
    NSString *lat;
    NSString *distance;
    NSString *email;
    NSString *gender;
    NSNumber *chatCount;
    NSArray *arrPlay;
    NSArray *arrListen;
    
}

@property (nonatomic, copy) NSString *facebookid;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *lookfor;
@property (nonatomic, copy) NSString *longt;
@property (nonatomic, copy) NSNumber *age;
@property (nonatomic, copy) NSString *play;
@property (nonatomic, copy) NSString *listen;
@property (nonatomic, copy) NSString *picture;
@property (nonatomic, copy) NSString *bio;
@property (nonatomic, copy) NSString *lat;
@property (nonatomic, copy) NSString *distance;
@property (nonatomic, copy) NSString *email;
@property (nonatomic, copy) NSString *gender;
@property (nonatomic, copy) NSNumber *chatCount;
@property (nonatomic, copy) NSArray *arrPlay;
@property (nonatomic, copy) NSArray *arrListen;

+ (FriendsConcreate *)instanceFromDictionary:(NSDictionary *)aDictionary;
- (void)setAttributesFromDictionary:(NSDictionary *)aDictionary;

- (NSDictionary *)dictionaryRepresentation;

@end
