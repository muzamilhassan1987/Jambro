//
//  AcceptFriendView.h
//  Jambro
//
//  Created by Faraz Haider on 11/2/16.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FriendsConcreate.h"
@interface AcceptFriendView : UIView
@property (weak, nonatomic) IBOutlet UIButton *btnExploring;
@property (weak, nonatomic) IBOutlet UIButton *btnSendMsg;
@property (weak, nonatomic) IBOutlet UIButton *btnTellFriend;
@property (weak, nonatomic) IBOutlet UIImageView *imgUser;
@property (weak, nonatomic) IBOutlet UIImageView *imgFriend;
-(void)setData:(FriendsConcreate*)obj;
@end
