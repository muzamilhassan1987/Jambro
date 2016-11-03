//
//  MatchRequestController.h
//  Jambro
//
//  Created by Faraz Haider on 10/23/16.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "BaseViewController.h"
#import "Selection.h"
#import "AcceptFriendView.h"
@interface MatchRequestController : BaseViewController<UICollectionViewDataSource, UICollectionViewDelegate>
{
    
    __weak IBOutlet UIView *viewRequest;
    __weak IBOutlet UIButton *btnRequest;
    __weak IBOutlet UIButton *btnMatches;
    __weak IBOutlet UIView *viewMatches;
    BOOL isMatchedLoad;
    BOOL isRequestLoad;
    NSInteger selectedMenu;
    Selection *selection;
    AcceptFriendView *acceptFriendView;
    //NSMutableArray * friendsArray;
}


@property (weak, nonatomic) IBOutlet UITableView *tblListing;

@end
