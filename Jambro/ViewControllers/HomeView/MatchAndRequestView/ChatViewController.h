//
//  ChatViewController.h
//  Jambro
//
//  Created by Faraz Haider on 10/31/16.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "BaseViewController.h"
#import "FriendsConcreate.h"
#import "ZHCMessages.h"
#import "ZHCModelData.h"

@interface ChatViewController : ZHCMessagesViewController {
    FriendsConcreate* friendData;
}
@property(nonatomic,strong)FriendsConcreate* friendData;
@property (strong, nonatomic) ZHCModelData *demoData;
@property (strong, nonatomic) NSMutableArray *chatArray;
@property (assign, nonatomic) BOOL presentBool;
@end