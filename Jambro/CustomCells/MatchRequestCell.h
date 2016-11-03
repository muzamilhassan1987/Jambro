//
//  MatchRequestCell.h
//  Jambro
//
//  Created by Faraz Haider on 10/23/16.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Play.h"
#import "Listen.h"
#import "FriendsConcreate.h"
@interface MatchRequestCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak) IBOutlet UIView * bgView;
@property (nonatomic,weak) IBOutlet UILabel * nameLabel;

-(void)setPlayObjectData:(Play*)data;
-(void)setListenObjectData:(Listen*)data;
-(void)setCollectionData;
@end

@interface MatchRequestCollectionView : UICollectionView

@property (nonatomic, strong) NSIndexPath *indexPath;

@end

static NSString *CollectionViewCellIdentifier = @"CollectionViewCellIdentifier";

@interface MatchRequestCell : UITableViewCell


@property (weak, nonatomic) IBOutlet UILabel *lblPlay;
@property (weak, nonatomic) IBOutlet UILabel *lblListen;

@property (weak, nonatomic) IBOutlet UIButton *btnIgnore;
@property (weak, nonatomic) IBOutlet UIButton *btnAccept;
@property (weak, nonatomic) IBOutlet UIButton *btnChat;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property(nonatomic,weak) IBOutlet MatchRequestCollectionView* collectionViewLeft;
//@property (nonatomic, strong) MatchRequestCollectionView *collectionViewLeft;
//@property (nonatomic, strong) MatchRequestCollectionView *collectionViewRight;
@property (weak, nonatomic) IBOutlet MatchRequestCollectionView *collectionViewRight;

-(void)setCellData:(FriendsConcreate*)data;
- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath;

@end
