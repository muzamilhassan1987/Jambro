//
//  HomeViewController.m
//  Jambro
//
//  Created by Faraz Haider on 14/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "HomeViewController.h"
#import "SelectionCollectionViewCell.h"
#import "HACLocationManager.h"

@interface HomeViewController ()
{
    CGRect playCollectionViewFrame;
    CGRect listenCollectionViewFrame;
    HACLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UICollectionView *playCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *listenCollectionView;
@property (strong, nonatomic) NSArray * section_0;
@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [HACLocationManager sharedInstance];
    locationManager.timeoutUpdating = 6;
    
    NSLog(@"Last saved location: %@",locationManager.getLastSavedLocation);
    
    __weak typeof(self) weakSelf = self;
    
    [locationManager LocationQuery];
    
    locationManager.locationUpdatedBlock = ^(CLLocation *location){
        
        
        weakSelf.section_0 = @[[NSString stringWithFormat:@"Lat: %f - Lng: %f", location.coordinate.latitude, location.coordinate.longitude]];
    };

    
    
    // Do any additional setup after loading the view.
}

-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (CGRectEqualToRect(CGRectZero, playCollectionViewFrame)) {
        playCollectionViewFrame = self.playCollectionView.frame;
    }
    
//    if (CGRectEqualToRect(CGRectZero, listenCollectionViewFrame)) {
//        listenCollectionViewFrame = self.listenCollectionView.frame;
//    }
}
/////

-(void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    
    UICollectionViewFlowLayout *playFlowLayout = (id)self.playCollectionView.collectionViewLayout;
    CGFloat playScreenWidth = playCollectionViewFrame.size.width;
    float playCellWidth = playScreenWidth / 4.0 - 10; //Replace the divisor with the column count requirement. Make sure to have it in float.
    CGSize playSize = CGSizeMake(playCellWidth, playCellWidth);
    playFlowLayout.itemSize = playSize;
    [playFlowLayout invalidateLayout];
    
    
//    UICollectionViewFlowLayout *listenFlowLayout = (id)self.listenCollectionView.collectionViewLayout;
//    CGFloat listenScreenWidth = listenCollectionViewFrame.size.width;
//    float listenCellWidth = listenScreenWidth / 4.0 - 10; //Replace the divisor with the column count requirement. Make sure to have it in float.
//    CGSize listenSize = CGSizeMake(listenCellWidth, listenCellWidth);
//    listenFlowLayout.itemSize = listenSize;
//    [listenFlowLayout invalidateLayout];
    
    
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    if (view == _playCollectionView) {
        return 5;
    }
    else
    {
        return 3;
    }
    
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  if (collectionView == self.playCollectionView) {
        SelectionCollectionViewCell *playCV= (SelectionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectionCell" forIndexPath:indexPath];
      playCV.bgView.backgroundColor = [UIColor clearColor];
      playCV.bgView.alpha = 1.0;
      playCV.bgView.layer.cornerRadius = playCV.bounds.size.width/2;
      playCV.bgView.layer.borderWidth = 1.0f;
      playCV.bgView.layer.borderColor = [UIColor blackColor].CGColor;
      playCV.bgView.layer.masksToBounds = YES;
      playCV.bgView.clipsToBounds = YES;
      
//      if ([playObject.selected boolValue]) {
//          UIColor * color = [self colorFromHexString:playObject.color];
//          playCV.bgView.backgroundColor = color;
//          playCV.bgView.alpha = 0.8;
//      }
      
      playCV.nameLabel.text = @"play";
      playCV.nameLabel.textColor = [UIColor blackColor];
      
      return playCV;
  }
    else
    {
        SelectionCollectionViewCell *listenCV= (SelectionCollectionViewCell*)[collectionView dequeueReusableCellWithReuseIdentifier:@"SelectionCell" forIndexPath:indexPath];
        listenCV.bgView.backgroundColor = [UIColor clearColor];
        listenCV.bgView.alpha = 1.0;
        listenCV.bgView.layer.cornerRadius = listenCV.bounds.size.width/2;
        listenCV.bgView.layer.borderWidth = 1.0f;
        listenCV.bgView.layer.borderColor = [UIColor blackColor].CGColor;
        listenCV.bgView.layer.masksToBounds = YES;
        listenCV.bgView.clipsToBounds = YES;
        
        //      if ([playObject.selected boolValue]) {
        //          UIColor * color = [self colorFromHexString:playObject.color];
        //          playCV.bgView.backgroundColor = color;
        //          playCV.bgView.alpha = 0.8;
        //      }
        
        listenCV.nameLabel.text = @"listen";
        listenCV.nameLabel.textColor = [UIColor blackColor];
        return listenCV;
    }
    
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat screenWidth =playCollectionViewFrame.size.width;
    float cellWidth = screenWidth / 4.0 - 10; //Replace the divisor with the column count requirement. Make sure to have it in float.
    CGSize size = CGSizeMake(cellWidth, cellWidth);
    
    return size;
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
