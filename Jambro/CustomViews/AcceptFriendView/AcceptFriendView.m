//
//  AcceptFriendView.m
//  Jambro
//
//  Created by Faraz Haider on 11/2/16.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "AcceptFriendView.h"

#import "UIImageView+AFNetworking.h"
@implementation AcceptFriendView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)setData:(FriendsConcreate*)obj {
    
    _imgUser.layer.cornerRadius = self.imgUser.frame.size.width / 2;
    _imgUser.clipsToBounds = YES;
    
    _imgFriend.layer.cornerRadius = self.imgUser.frame.size.width / 2;
    _imgFriend.clipsToBounds = YES;
    
    NSLog(@"%@",obj.picture);
    NSString * encodedString = [obj.picture stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLFragmentAllowedCharacterSet]];
    NSLog(@"%@",encodedString);
    
    [_imgFriend setImageWithURL:[NSURL URLWithString:encodedString]];
    
}

@end
