//
//  ZHUseFDModel.m
//  testAutoCalculateCellHeight
//
//  Created by aimoke on 16/8/3.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHUseFDModel.h"

@implementation ZHUseFDModel
-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if (self) {
        _identifier = [self uniqueIdentifier];
        _title = dictionary[@"title"];
        _content = dictionary[@"msg"];
        _username = dictionary[@"username"];
        _time = dictionary[@"date"];
        _imageName = dictionary[@"imageName"];
        _receiverID = dictionary[@"receiverid"];
        _senderID = dictionary[@"senderid"];
        
//        _title = @"weere";
//        _username = @"weere";
//        _time = @"weere";
//        _imageName = @"weere";
//        
//        _title = dictionary[@"title"];
//        _content = dictionary[@"msg"];
//        _username = dictionary[@"username"];
//        _time = dictionary[@"date"];
//        _imageName = dictionary[@"imageName"];
    }
    return self;
}


- (NSString *)uniqueIdentifier
{
    static NSInteger counter = 0;
    return [NSString stringWithFormat:@"unique-id-%@", @(counter++)];
}


@end
