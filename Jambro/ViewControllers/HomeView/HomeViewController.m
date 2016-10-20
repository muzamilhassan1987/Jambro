//
//  HomeViewController.m
//  Jambro
//
//  Created by Faraz Haider on 14/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "HomeViewController.h"

@interface HomeViewController ()
{
    CGRect playCollectionViewFrame;
    CGRect listenCollectionViewFrame;
}
@property (weak, nonatomic) IBOutlet UICollectionView *playCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *listenCollectionView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (CGRectEqualToRect(CGRectZero, playCollectionViewFrame)) {
        playCollectionViewFrame = self.playCollectionView.frame;
    }
    
    if (CGRectEqualToRect(CGRectZero, listenCollectionViewFrame)) {
        listenCollectionViewFrame = self.listenCollectionView.frame;
    }
}


-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
    UICollectionViewFlowLayout *playFlowLayout = (id)self.playCollectionView.collectionViewLayout;
    CGFloat playScreenWidth = playCollectionViewFrame.size.width;
    float playCellWidth = playScreenWidth / 4.0 - 10; //Replace the divisor with the column count requirement. Make sure to have it in float.
    CGSize playSize = CGSizeMake(playCellWidth, playCellWidth);
    playFlowLayout.itemSize = playSize;
    [playFlowLayout invalidateLayout];
    
    
    UICollectionViewFlowLayout *listenFlowLayout = (id)self.listenCollectionView.collectionViewLayout;
    CGFloat listenScreenWidth = listenCollectionViewFrame.size.width;
    float listenCellWidth = listenScreenWidth / 4.0 - 10; //Replace the divisor with the column count requirement. Make sure to have it in float.
    CGSize listenSize = CGSizeMake(listenCellWidth, listenCellWidth);
    listenFlowLayout.itemSize = listenSize;
    [listenFlowLayout invalidateLayout];
    
    
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
