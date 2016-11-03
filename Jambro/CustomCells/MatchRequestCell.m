//
//  MatchRequestCell.m
//  Jambro
//
//  Created by Faraz Haider on 10/23/16.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "MatchRequestCell.h"
#import "UtilitiesHelper.h"
#import "UIImageView+AFNetworking.h"
@implementation MatchRequestCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    
}

-(void)setPlayObjectData:(Play*)data {
    
    self.nameLabel.text = data.name;
    _bgView.backgroundColor = [UtilitiesHelper colorFromHexString:data.color];
    [self setCollectionData];
}
-(void)setListenObjectData:(Listen*)data {
    self.nameLabel.text = data.name;
    _bgView.backgroundColor = [UtilitiesHelper colorFromHexString:data.color];
    
    [self setCollectionData];
}
-(void)setCollectionData {
    
    _nameLabel.textColor = [UIColor whiteColor];
    _bgView.alpha = 1.0;
    _bgView.layer.cornerRadius = self.bounds.size.width/2;
    _bgView.layer.borderWidth = 1.0f;
    _bgView.layer.borderColor = [UIColor blackColor].CGColor;
    _bgView.layer.masksToBounds = YES;
    _bgView.clipsToBounds = YES;
    
    
}
@end


@implementation MatchRequestCollectionView

@end

@implementation MatchRequestCell


-(void)setCellData:(FriendsConcreate*)data {
    
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    _titleLabel.text = data.name;
    [_profileImageView setImageWithURL:[NSURL URLWithString:data.picture] placeholderImage: [UIImage imageNamed:@"Placeholder"]];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
   // self.collectionViewLeft.frame = self.contentView.bounds;
   // self.collectionViewRight.frame = self.contentView.bounds;
}

- (void)setCollectionViewDataSourceDelegate:(id<UICollectionViewDataSource, UICollectionViewDelegate>)dataSourceDelegate indexPath:(NSIndexPath *)indexPath
{
    
    self.collectionViewLeft.dataSource = dataSourceDelegate;
    self.collectionViewLeft.delegate = dataSourceDelegate;
    self.collectionViewLeft.indexPath = indexPath;
    [self.collectionViewLeft setContentOffset:self.collectionViewLeft.contentOffset animated:NO];
    [self.collectionViewLeft reloadData];
    
    
    self.collectionViewRight.dataSource = dataSourceDelegate;
    self.collectionViewRight.delegate = dataSourceDelegate;
    self.collectionViewRight.indexPath = indexPath;
    [self.collectionViewRight setContentOffset:self.collectionViewRight.contentOffset animated:NO];
    [self.collectionViewRight reloadData];
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
