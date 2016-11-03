//
//  ZHCModelData.m
//  ZHChat
//
//  Created by aimoke on 16/8/10.
//  Copyright © 2016年 zhuo. All rights reserved.
//

#import "ZHCModelData.h"
#import "ZHUseFDModel.h"
#import "ZHCMessagesCommonParameter.h"
#import "ZHCPhotoMediaItem.h"
#import "ZHCLocationMediaItem.h"
#import "ZHCVideoMediaItem.h"
#import "ZHCAudioMediaItem.h"



@implementation ZHCModelData

-(instancetype)initWithArray:(NSMutableArray*)array {
    
    self = [super init];
    if (self) {
        self.messages = [NSMutableArray new];
        [self loadMessages:array];
        
        //       [self addPhotoMediaMessage];
        //        [self addVideoMediaMessage];
        //        [self addAudioMediaMessage];
    }
    return self;
}
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.messages = [NSMutableArray new];
        //[self loadMessages];
        
 //       [self addPhotoMediaMessage];
//        [self addVideoMediaMessage];
//        [self addAudioMediaMessage];
    }
    return self;
}

-(void)loadMessages:(NSMutableArray*)array
{
    /**
     *  Create avatar images once.
     *
     *  Be sure to create your avatars one time and reuse them for good performance.
     *
     *  If you are not using avatars, ignore this.
     */
//    ZHCMessagesAvatarImageFactory *avatarFactory = [[ZHCMessagesAvatarImageFactory alloc] initWithDiameter:kZHCMessagesTableViewCellAvatarSizeDefault];
//    ZHCMessagesAvatarImage *cookImage = [avatarFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_cook"]];
//    
//    ZHCMessagesAvatarImage *jobsImage = [avatarFactory avatarImageWithImage:[UIImage imageNamed:@"demo_avatar_jobs"]];
//    
//    self.avatars = @{kZHCDemoAvatarIdCook : cookImage,
//                      kZHCDemoAvatarIdJobs : jobsImage};
//    
//    
//    self.users = @{ kZHCDemoAvatarIdJobs : kZHCDemoAvatarDisplayNameJobs,
//                    kZHCDemoAvatarIdCook : kZHCDemoAvatarDisplayNameCook};
    
    /**
     *  Create message bubble images objects.
     *
     *  Be sure to create your bubble images one time and reuse them for good performance.
     *
     */
    ZHCMessagesBubbleImageFactory *bubbleFactory = [[ZHCMessagesBubbleImageFactory alloc] init];
    
    self.outgoingBubbleImageData = [bubbleFactory outgoingMessagesBubbleImageWithColor:[UIColor zhc_messagesBubbleLightGrayColor]];
    self.incomingBubbleImageData = [bubbleFactory incomingMessagesBubbleImageWithColor:[UIColor zhc_messagesBubbleLightRedColor]];


    
//    NSString *filePath = [[NSBundle mainBundle]pathForResource:@"data" ofType:@"json"];
//    NSData *data = [[NSData alloc]initWithContentsOfFile:filePath];
//    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
//    NSArray *array = [dic objectForKey:@"feed"];
    NSMutableArray *muArray = [NSMutableArray array];
    for (NSDictionary *dic in array) {
        ZHUseFDModel *model = [[ZHUseFDModel alloc]initWithDictionary:dic];
        [muArray addObject:model];
    }
    
    for (NSUInteger i=0;i<muArray.count;i++) {
        ZHUseFDModel *model = [muArray objectAtIndex:i];
        NSString *avatarId = nil;
        NSString *displayName = nil;
        
//        if (i%3== 0) {
//            
//        }else{
//            avatarId = kZHCDemoAvatarIdJobs;
//            displayName = kZHCDemoAvatarDisplayNameJobs;
//            displayName = @"";
//        }
        
        avatarId = model.senderID;
        displayName = kZHCDemoAvatarDisplayNameCook;
        displayName = @"";
        ZHCMessage *message = [[ZHCMessage alloc]initWithSenderId:avatarId senderDisplayName:displayName date:[NSDate date] text:model.content];
        [self.messages addObject:message];
    }
    

}


-(void)addPhotoMediaMessage
{
    ZHCPhotoMediaItem *photoItem = [[ZHCPhotoMediaItem alloc]initWithImage:[UIImage imageNamed:@"goldengate"]];
    photoItem.appliesMediaViewMaskAsOutgoing = NO;
//    ZHCMessage *photoMessage = [ZHCMessage messageWithSenderId:kZHCDemoAvatarIdCook displayName:kZHCDemoAvatarDisplayNameCook media:photoItem];
//    [self.messages addObject:photoMessage];
}

- (void)addLocationMediaMessageCompletion:(ZHCLocationMediaItemCompletionBlock)completion
{
    CLLocation *ferryBuildingInSF = [[CLLocation alloc] initWithLatitude:22.610599 longitude:114.030238];
    
    ZHCLocationMediaItem *locationItem = [[ZHCLocationMediaItem alloc] init];
    [locationItem setLocation:ferryBuildingInSF withCompletionHandler:completion];
    locationItem.appliesMediaViewMaskAsOutgoing = YES;
    
//    ZHCMessage *locationMessage = [ZHCMessage messageWithSenderId:kZHCDemoAvatarIdJobs
//                                                      displayName:kZHCDemoAvatarDisplayNameJobs
//                                                            media:locationItem];
//    [self.messages addObject:locationMessage];
}

- (void)addVideoMediaMessage
{
    // don't have a real video, just pretending
    NSURL *videoURL = [NSURL URLWithString:@"file://"];
    
    ZHCVideoMediaItem *videoItem = [[ZHCVideoMediaItem alloc] initWithFileURL:videoURL isReadyToPlay:YES];
    videoItem.appliesMediaViewMaskAsOutgoing = YES;
//    ZHCMessage *videoMessage = [ZHCMessage messageWithSenderId:kZHCDemoAvatarIdJobs
//                                                   displayName:kZHCDemoAvatarDisplayNameJobs
//                                                         media:videoItem];
//    [self.messages addObject:videoMessage];
}

- (void)addAudioMediaMessage
{
    NSString * sample = [[NSBundle mainBundle] pathForResource:@"zhc_messages_sample" ofType:@"m4a"];
    
    NSData * audioData = [NSData dataWithContentsOfFile:sample];
    ZHCAudioMediaItem *audioItem = [[ZHCAudioMediaItem alloc] initWithData:audioData];
    audioItem.appliesMediaViewMaskAsOutgoing = NO;
//    ZHCMessage *audioMessage = [ZHCMessage messageWithSenderId:kZHCDemoAvatarIdCook
//                                                   displayName:kZHCDemoAvatarDisplayNameCook
//                                                         media:audioItem];
//    [self.messages addObject:audioMessage];
}

+(AFHTTPRequestOperation *) getChat:(NSDictionary *)params
                               withURLStr:(NSString *)urlPath
                                   onView:(UIView *)loaderOnView
                                 response:(void (^)(NSMutableDictionary *objUser,NSError *error))block
{
    return [[ServiceModel sharedClient] POST:urlPath
                                  parameters:params
                                      onView:loaderOnView
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         
                                         if (responseObject) {
//                                             
//                                             ZHCModelData* o = [ZHCModelData in]
//                                             ZHCModelData* objUser = [ZHCModelData instanceFromDictionary:responseObject];
                                             block (responseObject, nil);
                                         }
                                         
                                         
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         block (nil, error);
                                         
                                     }];
}

+(AFHTTPRequestOperation *) sendChat:(NSDictionary *)params
                          withURLStr:(NSString *)urlPath
                              onView:(UIView *)loaderOnView
                            response:(void (^)(NSMutableDictionary *objUser,NSError *error))block {
    
    return [[ServiceModel sharedClient] POST:urlPath
                                  parameters:params
                                      onView:loaderOnView
                                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                                         
                                         if (responseObject) {
                                             //
                                             //                                             ZHCModelData* o = [ZHCModelData in]
                                             //                                             ZHCModelData* objUser = [ZHCModelData instanceFromDictionary:responseObject];
                                             block (responseObject, nil);
                                         }
                                         
                                         
                                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                                         
                                         block (nil, error);
                                         
                                     }];

}

@end
