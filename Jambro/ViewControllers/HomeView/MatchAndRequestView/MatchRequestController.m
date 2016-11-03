//
//  MatchRequestController.m
//  Jambro
//
//  Created by Faraz Haider on 10/23/16.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "MatchRequestController.h"
#import "MatchRequestCell.h"
#import "NSUserDefaults+RMSaveCustomObject.h"
#import "ServiceModel.h"
#import "Friend.h"
#import "Constants.h"
#import "HomeViewController.h"
#import "SelectionCollectionViewCell.h"
#import "Constants.h"
#import "UIImageView+AFNetworking.h"
#import "Selection.h"
#import "NSUserDefaults+RMSaveCustomObject.h"
#import "Play.h"
#import "Listen.h"
#import "UtilitiesHelper.h"
#import "ServiceModel.h"
#import "UserModel.h"
#import "UserConcreate.h"
#import "FeedBackViewController.h"
#import "ProfileViewController.h"
#import "FriendsConcreate.h"
#import "ChatViewController.h"
#import <objc/runtime.h>
#import "ALActionBlocks.h"
static void *chatKey;
@interface MatchRequestController ()

@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSMutableDictionary *contentOffsetDictionary;
@property (nonatomic, strong) NSMutableArray *friendsArray;

@property (nonatomic, strong) NSMutableArray *orignalMatchesArray;
@property (nonatomic, strong) NSMutableArray *orignalRequestArray;
@end

@implementation MatchRequestController

-(void)loadView
{
    [super loadView];
    
    const NSInteger numberOfTableViewRows = 10;
    const NSInteger numberOfCollectionViewCells = 25;
    
    NSMutableArray *mutableArray = [NSMutableArray arrayWithCapacity:numberOfTableViewRows];
    
    for (NSInteger tableViewRow = 0; tableViewRow < numberOfTableViewRows; tableViewRow++)
    {
        NSMutableArray *colorArray = [NSMutableArray arrayWithCapacity:numberOfCollectionViewCells];
        
        for (NSInteger collectionViewItem = 0; collectionViewItem < numberOfCollectionViewCells; collectionViewItem++)
        {
            
            CGFloat red = arc4random() % 255;
            CGFloat green = arc4random() % 255;
            CGFloat blue = arc4random() % 255;
            UIColor *color = [UIColor colorWithRed:red/255.0 green:green/255.0 blue:blue/255.0 alpha:1.0f];
            
            [colorArray addObject:color];
        }
        
        [mutableArray addObject:colorArray];
    }
    
    self.colorArray = [NSArray arrayWithArray:mutableArray];
    
    self.contentOffsetDictionary = [NSMutableDictionary dictionary];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage* logoImage = [UIImage imageNamed:@"matches-icon"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    
    
    if ([[UserModel sharedInstance] checkUserData]){
        if ([UtilitiesHelper getUserDefaultForKey:@"Selection"]) {
            
            NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            selection = [defaults rm_customObjectForKey:@"Selection"];
        }
    }
    else{
        [self setSelectionData];
    }
    
    isMatchedLoad = NO;
    isRequestLoad = NO;
    NSLog(@"%@",selection.play);
    
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    selectedMenu = 1;
    [viewRequest setBackgroundColor:[UIColor whiteColor]];
    [self fetchRecord:selectedMenu];
    
}

- (IBAction)selectMenu:(UIButton *)sender {
    
    [viewRequest setBackgroundColor:[UIColor whiteColor]];
    [viewMatches setBackgroundColor:[UIColor whiteColor]];
    
    selectedMenu = sender.tag;
    if(sender.tag == 1) {
        [viewMatches setBackgroundColor:[UIColor colorWithRed:(22/255.f) green:(158/255.f) blue:(77/255.f) alpha:255.f]];
        if(isMatchedLoad == YES) {
            if(_friendsArray) {
                [_friendsArray removeAllObjects];
                _friendsArray = nil;
            }
            _friendsArray = _orignalMatchesArray.mutableCopy;
            [_tblListing reloadData];
        }
        else {
            [self fetchRecord:1];
        }
    }
    else {
        [viewRequest setBackgroundColor:[UIColor colorWithRed:(22/255.f) green:(158/255.f) blue:(77/255.f) alpha:255.f]];
        if(isRequestLoad == YES) {
            if(_friendsArray) {
                [_friendsArray removeAllObjects];
                _friendsArray = nil;
            }
            _friendsArray = _orignalRequestArray.mutableCopy;
            [_tblListing reloadData];
            
        }
        else {
            [self fetchRecord:2];
        }
    }
    
}



- (NSMutableArray *)createMutableArray1:(NSArray *)array
{
    return [NSMutableArray arrayWithArray:array];
}
-(void)fetchRecord:(NSInteger)type
{
    if(_friendsArray) {
        [_friendsArray removeAllObjects];
        _friendsArray = nil;
    }
    _friendsArray = [NSMutableArray array];
    

    
    NSString* url = @"";
    if(type == 1) {
        url = kWebFriendList;
        if(_orignalMatchesArray) {
            [_orignalMatchesArray removeAllObjects];
            _orignalMatchesArray = nil;
            _orignalMatchesArray = [NSMutableArray array];
            isMatchedLoad = NO;
        }
    }
    else {
        url = kWebPendingRequest;
        if(_orignalRequestArray) {
            [_orignalRequestArray removeAllObjects];
            _orignalRequestArray = nil;
            _orignalRequestArray = [NSMutableArray array];
            isRequestLoad = NO;
        }
    }

    
    [Friend getFriendList:@{@"facebookid": @"10207078603832084"} withURLStr:url  onView:self.view response:^(Friend *objUser, NSError *error) {
        if (!error) {
            if (objUser) {
                _friendsArray = (NSMutableArray*)objUser.friends;
                _friendsArray = [self createMutableArray1:_friendsArray];
                
                //FriendsConcreate* obj = [_friendsArray objectAtIndex:0];
                if(type == 1) {
                    _orignalMatchesArray = _friendsArray.mutableCopy;
                    isMatchedLoad = true;
                }
                else {
                    _orignalRequestArray = _friendsArray.mutableCopy;
                    isRequestLoad = true;
                }
                
                //NSLog(@"%@",obj.name);
                [_tblListing reloadData];
                
            }
            else
            {
                //self.noDataView.hidden = NO;
            }
        }
        else
        {
            //self.noDataView.hidden = NO;
            
            [UtilitiesHelper showErrorAlert:error];
            NSLog(@"%@",error);
        }
    }];
    
    
}


#pragma mark - UITableViewDataSource Methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"%lu",(unsigned long)self.friendsArray.count);
    return self.friendsArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MatchRequestCell";
    
    MatchRequestCell *cell = (MatchRequestCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if(indexPath.row % 2 == 0) {
        cell.backgroundColor = [UIColor colorWithRed:247.0/255.0 green:247.0/255.0 blue:247.0/255.0 alpha:1.0];
    }
    else{
        cell.backgroundColor = [UIColor whiteColor];
        
    }
    cell.lblPlay.backgroundColor = cell.backgroundColor;
    cell.lblListen.backgroundColor = cell.backgroundColor;
    
    [cell.btnAccept addTarget:self action:@selector(acceptMatch:) forControlEvents:UIControlEventTouchUpInside];
    [cell.btnIgnore addTarget:self action:@selector(rejectMatch:) forControlEvents:UIControlEventTouchUpInside];

    objc_setAssociatedObject(cell.btnChat, &chatKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.btnIgnore, &chatKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    objc_setAssociatedObject(cell.btnAccept, &chatKey, indexPath, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    

    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(MatchRequestCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(selectedMenu == 1) {
        cell.btnChat.hidden = false;
        cell.btnAccept.hidden = true;
        cell.btnIgnore.hidden = true;
    }
    else {
        cell.btnChat.hidden = true;
        cell.btnAccept.hidden = false;
        cell.btnIgnore.hidden = false;
    }
    FriendsConcreate* obj = self.friendsArray[indexPath.row];
    [cell setCellData:obj];
    [cell setCollectionViewDataSourceDelegate:self indexPath:indexPath];
    NSInteger indexLeft = cell.collectionViewLeft.indexPath.row;
    NSInteger indexRight = cell.collectionViewRight.indexPath.row;
    
    CGFloat horizontalOffsetLeft = [self.contentOffsetDictionary[[@(indexLeft) stringValue]] floatValue];
    [cell.collectionViewLeft setContentOffset:CGPointMake(horizontalOffsetLeft, 0)];
    
    CGFloat horizontalOffsetRight = [self.contentOffsetDictionary[[@(indexRight) stringValue]] floatValue];
    [cell.collectionViewRight setContentOffset:CGPointMake(horizontalOffsetRight, 0)];
}
- (NSArray *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewRowAction *modifyAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault title:@"Delete" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
        
        [self removeFriend:indexPath];
    }];
    modifyAction.backgroundColor = [UIColor redColor];
    return @[modifyAction];
}
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
}
#pragma mark - UITableViewDelegate Methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 206;
}

#pragma mark - UICollectionViewDataSource Methods

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    FriendsConcreate* obj = self.friendsArray[[(MatchRequestCollectionView *)collectionView indexPath].row];
    NSLog(@"%@",obj.arrPlay);
    
    //NSArray *collectionViewArray = self.friendsArray[[(MatchRequestCollectionView *)collectionView indexPath].row];
    if (collectionView.tag == 1) {
        return obj.arrPlay.count;
    }
    else{
        return obj.arrListen.count;
    }
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    MatchRequestCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CollectionViewCellIdentifier forIndexPath:indexPath];
    
//    NSArray *collectionViewArray = self.colorArray[[(MatchRequestCollectionView *)collectionView indexPath].row];
    
//     NSArray *collectionViewArray = self.friendsArray[[(MatchRequestCollectionView *)collectionView indexPath].row];
    
    FriendsConcreate* obj = self.friendsArray[[(MatchRequestCollectionView *)collectionView indexPath].row];

    
//    NSLog(@"%@",obj.arrPlay);
//    NSLog(@"%@",collectionViewArray);
//    NSLog(@"%@",cell);
//    NSLog(@"%@",collectionView);
//    NSLog(@"%ld",(long)collectionView.tag);
//    NSLog(@"%@",cell.subviews);
//    NSLog(@"%@",cell.bgView);
//    cell.backgroundColor = collectionViewArray[indexPath.item];
    if (collectionView.tag == 1) {
        
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==%@",obj.arrPlay[indexPath.item]];
        NSArray *results = [selection.play filteredArrayUsingPredicate:predicate];
        if (results.count > 0) {
            Play* objPlay = [results objectAtIndex:0];
            [cell setPlayObjectData:objPlay];
        }
        
    }
    else{
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"name==%@",obj.arrListen[indexPath.item]];
        NSArray *results = [selection.listen filteredArrayUsingPredicate:predicate];
        if (results.count > 0) {
            Listen* objListen = [results objectAtIndex:0];
            [cell setListenObjectData:objListen];
        }
        
    }
    
//    cell.nameLabel.text = obj.arrPlay[indexPath.item];
    [cell setCollectionData];
//    cell.bgView.backgroundColor = [UIColor clearColor];
//    cell.bgView.alpha = 1.0;
//    cell.bgView.layer.cornerRadius = cell.bounds.size.width/2;
//    cell.bgView.layer.borderWidth = 1.0f;
//    cell.bgView.layer.borderColor = [UIColor blackColor].CGColor;
//    cell.bgView.layer.masksToBounds = YES;
//    cell.bgView.clipsToBounds = YES;
    
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    NSLog(@"%ld",(long)collectionView.tag);
    NSLog(@"%@",indexPath);
    NSLog(@"%@",NSStringFromCGRect(collectionView.frame));

}

#pragma mark - UIScrollViewDelegate Methods

-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    if (![scrollView isKindOfClass:[UICollectionView class]]) return;
    
    CGFloat horizontalOffset = scrollView.contentOffset.x;
    
    MatchRequestCollectionView *collectionView = (MatchRequestCollectionView *)scrollView;
    NSInteger index = collectionView.indexPath.row;
    self.contentOffsetDictionary[[@(index) stringValue]] = @(horizontalOffset);
}

-(void)setSelectionData
{
    NSMutableDictionary * selectionDictionary = [NSMutableDictionary dictionary];
    NSMutableArray * lookingArray = [NSMutableArray array];
    NSMutableArray * listenArray = [NSMutableArray array];
    NSMutableArray * playArray = [NSMutableArray array];
    
    
    NSArray * nameArray = @[@"Guitar",
                            @"Drums",
                            @"Bass",
                            @"Keyboard",
                            @"Vocals",
                            @"Flute",
                            @"Percussion",
                            @"Piano",
                            @"Violin",
                            @"Saxophone",
                            @"Tabla",
                            @"Harmonium",
                            @"Harmonica",
                            @"Strings",
                            @"Eastern",
                            @"Other",
                            @"Rock",
                            @"Pop",
                            @"Blues",
                            @"Jazz",
                            @"Funk",
                            @"Folk",
                            @"R&B",
                            @"Hip-hop",
                            @"Classical",
                            @"Latin",
                            @"World",
                            @"Reggae",
                            @"Country",
                            @"Metal",
                            @"Eastern",
                            @"Other"];
    
    
    NSArray * colorArray = @[@"#39BD95",
                             @"#9D5789",
                             @"#AA9F8F",
                             @"#854030",
                             @"#505068",
                             @"#5EB3DD",
                             @"#E56846",
                             @"#6B8BA5",
                             @"#ABC14D",
                             @"#DD8597",
                             @"#65704D",
                             @"#D462B9",
                             @"#204496",
                             @"#8D90B2",
                             @"#1F8989",
                             @"#FF9999",
                             @"#4B6479",
                             @"#EB73F4",
                             @"#1FBBFF",
                             @"#9C8C5A",
                             @"#00A000",
                             @"#8629FF",
                             @"#CA1C2D",
                             @"#9166AC",
                             @"#B283A9",
                             @"#F4AA06",
                             @"#1EC18E",
                             @"#FF7900",
                             @"#CE4427",
                             @"#000000",
                             @"#74899C",
                             @"#AFAFAF"];
    
    NSArray * soundArray = @[@"guitar.wav",
                             @"drums.wav",
                             @"bass.wav",
                             @"keyboard.wav",
                             @"vocals.wav",
                             @"flute.wav",
                             @"percussion.wav",
                             @"piano.wav",
                             @"violin.wav",
                             @"saxophone.wav",
                             @"tabla.wav",
                             @"hamonium.wav",
                             @"harmonica.wav",
                             @"strings.wav",
                             @"eastern.mp3",
                             @"click.wav"];
    
    for (int i =0 ; i <= 15; i ++)
    {
        NSMutableDictionary *playDic = [[NSMutableDictionary alloc]init];
        [playDic setObject:colorArray[i] forKey:@"color"];
        [playDic setObject:soundArray[i] forKey:@"sound"];
        [playDic setObject:@"0" forKey:@"selected"];
        [playDic setObject:nameArray[i] forKey:@"name"];
        [playDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"id"];
        [playArray addObject:playDic];
    }
    
    for (int i =0 ; i <= 15; i ++)
    {
        NSMutableDictionary *lookingDic = [[NSMutableDictionary alloc]init];
        [lookingDic setObject:colorArray[i] forKey:@"color"];
        [lookingDic setObject:soundArray[i] forKey:@"sound"];
        [lookingDic setObject:@"0" forKey:@"selected"];
        [lookingDic setObject:nameArray[i] forKey:@"name"];
        [lookingDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"id"];
        [lookingArray addObject:lookingDic];
    }
    
    for (int i =16 ; i <= 31; i ++)
    {
        NSMutableDictionary *listenDic = [[NSMutableDictionary alloc]init];
        [listenDic setObject:colorArray[i] forKey:@"color"];
        [listenDic setObject:@"click.wav" forKey:@"sound"];
        [listenDic setObject:@"0" forKey:@"selected"];
        [listenDic setObject:nameArray[i] forKey:@"name"];
        [listenDic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"id"];
        [listenArray addObject:listenDic];
    }
    
    [selectionDictionary setObject:playArray forKey:@"play"];
    [selectionDictionary setObject:lookingArray forKey:@"looking"];
    [selectionDictionary setObject:listenArray forKey:@"listen"];
    
    selection =[Selection instanceFromDictionary:selectionDictionary];
}


-(void)removeFriend:(NSIndexPath*)indexPath {
 
    
    FriendsConcreate* obj = self.friendsArray[indexPath.row];
    NSLog(@"%@",obj.facebookid);
    
    [Friend removeFriend:@{@"userfbid": @"10207078603832084",
                           @"friendfbid": obj.facebookid} withURLStr:kWebRemoveFriend  onView:self.view response:^(Friend *objUser, NSError *error) {
        if (!error) {
            if (objUser) {
                
                [self.friendsArray removeObjectAtIndex:indexPath.row];
                [_tblListing reloadData];
                
            }
            else
            {
            }
        }
        else
        {
            
            [UtilitiesHelper showErrorAlert:error];
            NSLog(@"%@",error);
        }
    }];

    
}

-(void)rejectMatch:(UIButton*)button {
    
    NSIndexPath* indexPath = objc_getAssociatedObject(button, &chatKey);
    NSLog(@"%ld",(long)indexPath.row);
    
    FriendsConcreate* obj = self.friendsArray[indexPath.row];
    NSLog(@"%@",obj.facebookid);
    [Friend rejectFriend:@{@"userfbid": @"10207078603832084",
                           @"friendfbid": obj.facebookid} withURLStr:kWebRejectFriend  onView:self.view response:^(Friend *objUser, NSError *error) {
                               if (!error) {
                                   
                                   
                                   [self.friendsArray removeObjectAtIndex:indexPath.row];
                                   [_tblListing reloadData];
                               }
                               else
                               {
                                   
                                   [UtilitiesHelper showErrorAlert:error];
                                   NSLog(@"%@",error);
                               }
                           }];
}

-(void)acceptMatch:(UIButton*)button {
    
    NSIndexPath* indexPath = objc_getAssociatedObject(button, &chatKey);
    NSLog(@"%ld",(long)indexPath.row);
    
    FriendsConcreate* obj = self.friendsArray[indexPath.row];
    NSLog(@"%@",obj.facebookid);
    [Friend acceptFriend:@{@"userfbid": @"10207078603832084",
                           @"friendfbid": obj.facebookid} withURLStr:kWebAcceptFriend  onView:self.view response:^(Friend *objUser, NSError *error) {
        if (!error) {
            if (objUser) {
                if([objUser.status intValue] == 1) {
                    
                    [self showPopUp:obj];
                }
                else {
                    [UtilitiesHelper showPromptAlertforTitle:@"Error" withMessage:objUser.message forDelegate:nil];
                }
                
                
            }
            else
            {
                //self.noDataView.hidden = NO;
            }
        }
        else
        {
            //self.noDataView.hidden = NO;
            
            [UtilitiesHelper showErrorAlert:error];
            NSLog(@"%@",error);
        }
    }];
    
    
    
}
-(void)showPopUp:(FriendsConcreate*)obj {
    
    [viewMatches setBackgroundColor:[UIColor colorWithRed:(22/255.f) green:(158/255.f) blue:(77/255.f) alpha:255.f]];
    [viewRequest setBackgroundColor:[UIColor whiteColor]];
    isMatchedLoad = false;
    
    
    acceptFriendView = [[[NSBundle mainBundle] loadNibNamed:@"AcceptFriendView" owner:self options:nil] objectAtIndex:0];
    acceptFriendView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    
    [acceptFriendView setData:obj];
    [self.view addSubview:acceptFriendView];
    
    
    [acceptFriendView.btnSendMsg handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
   
        NSLog(@"button pressed");
    }];
    [acceptFriendView.btnExploring handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        
        NSLog(@"button pressed");
    }];
    [acceptFriendView.btnTellFriend handleControlEvents:UIControlEventTouchUpInside withBlock:^(id weakControl) {
        
        NSLog(@"button pressed");
    }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"chat"])
    {
        
        NSIndexPath* indexPath = objc_getAssociatedObject(sender, &chatKey);
        NSLog(@"%ld",(long)indexPath.row);
        FriendsConcreate* data = [self.friendsArray objectAtIndex:indexPath.row];
        NSLog(@"%@",data.name);
        ChatViewController *vc = (ChatViewController *)[segue destinationViewController];
        vc.friendData = data;
    }
    
    
}
@end
