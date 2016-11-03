//
//  ChatViewController.m
//  Jambro
//
//  Created by Faraz Haider on 10/31/16.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "ChatViewController.h"
#import "Constants.h"
@interface ChatViewController ()

@end

@implementation ChatViewController
@synthesize friendData;
@synthesize chatArray;
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavigationBarImage];
     [self createBackButton];
     [self setTitleTextAttribute];
    
   
    UIImage* logoImage = [UIImage imageNamed:@"message-icon"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    
    // Do any additional setup after loading the view.
    /**
     *  Load up our fake data for the demo
     */
    //self.demoData = [[ZHCModelData alloc] init];
    
    //self.title = @"Messages";
    // Do any additional setup after loading the view.
}

-(void)setNavigationBarImage{
    //    UIViewController  * viewController = [UIViewController currentViewController];
    //    if ([viewController isKindOfClass:[MyMenuViewController class]]) {
    //        //        [self.navigationController.navigationBar setBackgroundImage:nil
    //        //                                                      forBarMetrics:UIBarMetricsDefault];
    //        [self.navigationController.navigationBar setBackgroundImage:[UIImage new]
    //                                                      forBarMetrics:UIBarMetricsDefault];
    //        self.navigationController.navigationBar.shadowImage = [UIImage new];
    //        self.navigationController.navigationBar.translucent = YES;
    //        self.navigationController.view.backgroundColor = [UIColor clearColor];
    //        self.navigationController.navigationBar.backgroundColor = [UIColor clearColor];
    //
    //    }
    //    else
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top-bar"] forBarMetrics:UIBarMetricsDefault];
}



-(void)createBackButton{
    UIButton *backButton;
    if (APPC_IS_IPAD) {
       backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 52, 52)];
    }
    else{
       backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 26, 26)];
    }
    [backButton setImage:[UIImage imageNamed:@"back-arrow"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    backButton.exclusiveTouch = YES;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backButton];
}

-(void)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)setTitleTextAttribute{
    if(APPC_IS_IPAD){
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back-arrow"]],UITextAttributeTextColor,[UIFont boldSystemFontOfSize:24],UITextAttributeFont,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back-arrow"]],UITextAttributeTextColor,[UIFont systemFontOfSize:17],UITextAttributeFont,nil];
    }
}


- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    if (self.presentBool) {
        self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemStop
                                                                                              target:self
                                                                                              action:@selector(closePressed:)];
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self getChat];
    
    
    
}

- (void)getChat {
    
    [ZHCModelData getChat:@{@"userfbid": @"10207078603832084",
                            @"friendfbid": friendData.facebookid} withURLStr:kWebGetChat onView:self.view response:^(NSMutableDictionary *objUser, NSError *error) {
                                
                                NSLog(@"%@",objUser);
                                self.demoData = [[ZHCModelData alloc] initWithArray:[objUser valueForKey:@"getMessages"]];
                                [self.messageTableView reloadData];
                                
                               // self.demoData = [[ZHCModelData alloc] init];
                            }];
    
}
- (void)sendChat {
    
}
#pragma mark - ZHCMessagesTableViewDataSource

-(NSString *)senderDisplayName
{
    return kZHCDemoAvatarDisplayNameJobs;
}


-(NSString *)senderId
{
    //return kZHCDemoAvatarIdJobs;
    return @"10207078603832084";
}

- (id<ZHCMessageData>)tableView:(ZHCMessagesTableView*)tableView messageDataForCellAtIndexPath:(NSIndexPath *)indexPath
{
    return [self.demoData.messages objectAtIndex:indexPath.row];
}

-(void)tableView:(ZHCMessagesTableView *)tableView didDeleteMessageAtIndexPath:(NSIndexPath *)indexPath
{
    [self.demoData.messages removeObjectAtIndex:indexPath.row];
}


- (nullable id<ZHCMessageBubbleImageDataSource>)tableView:(ZHCMessagesTableView *)tableView messageBubbleImageDataForCellAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  You may return nil here if you do not want bubbles.
     *  In this case, you should set the background color of your TableView view cell's textView.
     *
     *  Otherwise, return your previously created bubble image data objects.
     */
    
    ZHCMessage *message = [self.demoData.messages objectAtIndex:indexPath.row];
    if (message.isMediaMessage) {
        NSLog(@"is mediaMessage");
    }
    
    if ([message.senderId isEqualToString:self.senderId]) {
        return self.demoData.outgoingBubbleImageData;
    }
    
    
    return self.demoData.incomingBubbleImageData;
    
}

- (nullable id<ZHCMessageAvatarImageDataSource>)tableView:(ZHCMessagesTableView *)tableView avatarImageDataForCellAtIndexPath:(NSIndexPath *)indexPath
{
    
    /**
     *  Return your previously created avatar image data objects.
     *
     *  Note: these the avatars will be sized according to these values:
     *
     *  Override the defaults in `viewDidLoad`
     */
    
    ZHCMessage *message = [self.demoData.messages objectAtIndex:indexPath.row];
    return [self.demoData.avatars objectForKey:message.senderId];
}


-(NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  This logic should be consistent with what you return from `heightForCellTopLabelAtIndexPath:`
     *  The other label text delegate methods should follow a similar pattern.
     *
     *  Show a timestamp for every 3rd message
     */
//    if (indexPath.row %3 == 0) {
//        ZHCMessage *message = [self.demoData.messages objectAtIndex:indexPath.row];
//        return [[ZHCMessagesTimestampFormatter sharedFormatter]attributedTimestampForDate:message.date];
//    }
    return nil;
}


-(NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    ZHCMessage *message = [self.demoData.messages objectAtIndex:indexPath.row];
    /**
     *  iOS7-style sender name labels
     */
    if ([message.senderId isEqualToString:self.senderId]) {
        return nil;
    }
    
    if ((indexPath.row - 1) > 0) {
        ZHCMessage *preMessage = [self.demoData.messages objectAtIndex:(indexPath.row - 1)];
        if ([preMessage.senderId isEqualToString:message.senderId]) {
            return nil;
        }
    }
    
    /**
     *  Don't specify attributes to use the defaults.
     */
    return [[NSAttributedString alloc] initWithString:message.senderDisplayName];
    
}


- (NSAttributedString *)tableView:(ZHCMessagesTableView *)tableView attributedTextForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}


#pragma mark - Adjusting cell label heights
-(CGFloat)tableView:(ZHCMessagesTableView *)tableView heightForCellTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  Each label in a cell has a `height` delegate method that corresponds to its text dataSource method
     */
    
    /**
     *  This logic should be consistent with what you return from `attributedTextForCellTopLabelAtIndexPath:`
     *  The other label height delegate methods should follow similarly
     *
     *  Show a timestamp for every 3rd message
     */
    CGFloat labelHeight = 0.0f;
//    if (indexPath.item % 3 == 0) {
//        labelHeight = kZHCMessagesTableViewCellLabelHeightDefault;
//    }
    return labelHeight;
    
}


-(CGFloat)tableView:(ZHCMessagesTableView *)tableView  heightForMessageBubbleTopLabelAtIndexPath:(NSIndexPath *)indexPath
{
    /**
     *  iOS7-style sender name labels
     */
    CGFloat labelHeight = kZHCMessagesTableViewCellLabelHeightDefault;
    ZHCMessage *currentMessage = [self.demoData.messages objectAtIndex:indexPath.item];
    if ([[currentMessage senderId] isEqualToString:self.senderId]) {
        labelHeight = 0.0f;
    }
    
    if (indexPath.item - 1 > 0) {
        ZHCMessage *previousMessage = [self.demoData.messages objectAtIndex:indexPath.item - 1];
        if ([[previousMessage senderId] isEqualToString:[currentMessage senderId]]) {
            labelHeight = 0.0f;
        }
    }
    
    return 0;
    
}


-(CGFloat)tableView:(ZHCMessagesTableView *)tableView  heightForCellBottomLabelAtIndexPath:(NSIndexPath *)indexPath
{
    
    CGFloat labelHeight = 0.0f;
    return labelHeight;
}

#pragma mark - ZHCMessagesTableViewDelegate
-(void)tableView:(ZHCMessagesTableView *)tableView didTapAvatarImageView:(UIImageView *)avatarImageView atIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didTapAvatarImageView:avatarImageView atIndexPath:indexPath];
}


-(void)tableView:(ZHCMessagesTableView *)tableView didTapMessageBubbleAtIndexPath:(NSIndexPath *)indexPath
{
    [super tableView:tableView didTapMessageBubbleAtIndexPath:indexPath];
}


-(void)tableView:(ZHCMessagesTableView *)tableView didTapCellAtIndexPath:(NSIndexPath *)indexPath touchLocation:(CGPoint)touchLocation
{
    [super tableView:tableView didTapCellAtIndexPath:indexPath touchLocation:touchLocation];
}


-(void)tableView:(ZHCMessagesTableView *)tableView performAction:(SEL)action forcellAtIndexPath:(NSIndexPath *)indexPath withSender:(id)sender
{
    [super tableView:tableView performAction:action forcellAtIndexPath:indexPath withSender:sender];
    
    NSLog(@"performAction:%ld",(long)indexPath.row);
}


#pragma mark － TableView datasource
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.demoData.messages.count;
}

-(UITableViewCell *)tableView:(ZHCMessagesTableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZHCMessagesTableViewCell *cell = (ZHCMessagesTableViewCell *)[super tableView:tableView cellForRowAtIndexPath:indexPath];
//    cell.contentView.backgroundColor = [UIColor clearColor];
    [self configureCell:cell atIndexPath:indexPath];
    return cell;
}



#pragma mark Configure Cell Data
- (void)configureCell:(ZHCMessagesTableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    ZHCMessage *message = [self.demoData.messages objectAtIndex:indexPath.row];
    if (!message.isMediaMessage) {
        if ([message.senderId isEqualToString:self.senderId]) {
            cell.textView.textColor = [UIColor blackColor];
        }else{
            cell.textView.textColor = [UIColor whiteColor];
        }
        cell.textView.linkTextAttributes = @{ NSForegroundColorAttributeName : cell.textView.textColor,
                                              NSUnderlineStyleAttributeName : @(NSUnderlineStyleSingle | NSUnderlinePatternSolid) };
    }
    
}


#pragma mark - Messages view controller

- (void)didPressSendButton:(UIButton *)button
           withMessageText:(NSString *)text
                  senderId:(NSString *)senderId
         senderDisplayName:(NSString *)senderDisplayName
                      date:(NSDate *)date
{
    /**
     *  Sending a message. Your implementation of this method should do *at least* the following:
     *
     *  1. Play sound (optional)
     *  2. Add new id<ZHCMessageData> object to your data source
     *  3. Call `finishSendingMessage`
     */
    
    
    [ZHCModelData sendChat:@{@"userfbid": @"10207078603832084",
                            @"friendfbid": friendData.facebookid,
                             @"msg": text} withURLStr:kWebSendChat onView:self.view response:^(NSMutableDictionary *objUser, NSError *error) {
                                

                                 ZHCMessage *message = [[ZHCMessage alloc] initWithSenderId:senderId
                                                                          senderDisplayName:senderDisplayName
                                                                                       date:date
                                                                                       text:text];
                                 
                                 [self.demoData.messages addObject:message];
                                 
                                 [self finishSendingMessageAnimated:YES];
                                 
                                 
                            }];
    
}


#pragma mark - ZHCMessagesInputToolbarDelegate
-(void)messagesInputToolbar:(ZHCMessagesInputToolbar *)toolbar sendVoice:(NSString *)voiceFilePath seconds:(NSTimeInterval)senconds
{
    NSData * audioData = [NSData dataWithContentsOfFile:voiceFilePath];
    ZHCAudioMediaItem *audioItem = [[ZHCAudioMediaItem alloc] initWithData:audioData];
    
    ZHCMessage *audioMessage = [ZHCMessage messageWithSenderId:self.senderId
                                                   displayName:self.senderDisplayName
                                                         media:audioItem];
    [self.demoData.messages addObject:audioMessage];
    
    [self finishSendingMessageAnimated:YES];
    
}

#pragma mark - ZHCMessagesMoreViewDelegate

-(void)messagesMoreView:(ZHCMessagesMoreView *)moreView selectedMoreViewItemWithIndex:(NSInteger)index
{
    
    switch (index) {
        case 0:{//Camera
            [self.demoData addVideoMediaMessage];
            [self.messageTableView reloadData];
            [self finishSendingMessage];
        }
            break;
            
        case 1:{//Photos
            [self.demoData addPhotoMediaMessage];
            [self.messageTableView reloadData];
            [self finishSendingMessage];
        }
            break;
            
        case 2:{//Location
            typeof(self) __weak weakSelf = self;
            __weak ZHCMessagesTableView *weakView = self.messageTableView;
            [self.demoData addLocationMediaMessageCompletion:^{
                [weakView reloadData];
                [weakSelf finishSendingMessage];
                
            }];
        }
            
            break;
            
        default:
            break;
    }
}



#pragma mark - ZHCMessagesMoreViewDataSource
-(NSArray *)messagesMoreViewTitles:(ZHCMessagesMoreView *)moreView
{
    return @[@"Camera",@"Photos",@"Location"];
}

-(NSArray *)messagesMoreViewImgNames:(ZHCMessagesMoreView *)moreView
{
    return @[@"chat_bar_icons_camera",@"chat_bar_icons_location",@"chat_bar_icons_pic"];
}


#pragma mark - PrivateMethods
-(void)closePressed:(id)sender
{
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
