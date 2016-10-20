//
//  SelectionCollectionViewCell.h
//  Jambro
//
//  Created by Faraz Haider on 18/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SelectionCollectionViewCell : UICollectionViewCell
@property (nonatomic,weak) IBOutlet UIView * bgView;
@property (nonatomic,weak) IBOutlet UILabel * nameLabel;
@end
