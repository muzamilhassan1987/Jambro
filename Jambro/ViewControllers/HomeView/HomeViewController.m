//
//  HomeViewController.m
//  Jambro
//
//  Created by Faraz Haider on 14/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "HomeViewController.h"
#import "SelectionCollectionViewCell.h"
#import "SearchMusician.h"
#import "MusicianConcreate.h"
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

@interface HomeViewController ()
{
    CGRect playCollectionViewFrame;
    CGRect listenCollectionViewFrame;
    NSArray * playArray;
    NSArray * listenArray;
    Selection *selection;
    NSMutableArray * musicianArray;
}
@property (weak, nonatomic) IBOutlet UIImageView *userProfileImageView;
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *userDistanceLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *playCollectionView;
@property (weak, nonatomic) IBOutlet UICollectionView *listenCollectionView;

@end

@implementation HomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    [self setTitleViewWithTitle:@"Jambro"];
   
    UIImage* logoImage = [UIImage imageNamed:@"top-logo"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    [self createLeftBarButton];
    [self createRightBarButton];
    
    /*UIBarButtonItem * matchesItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"matches-icon"]]];
    [matchesItem.target performSelector:@selector(matchesIconClicked:)];
    self.navigationItem.rightBarButtonItem = matchesItem;

    UIBarButtonItem * profileItem = [[UIBarButtonItem alloc] initWithCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"profile-icon"]]];
    self.navigationItem.leftBarButtonItem = profileItem;*/

    
    
    playArray = [NSArray array];
    listenArray = [NSArray array];
    musicianArray = [NSMutableArray array];
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    selection = [defaults rm_customObjectForKey:@"Selection"];
    
    [SearchMusician searchMusician:@{@"facebookid": @"987654321000111111"} withURLStr:kWebSearchMusian  onView:self.view response:^(SearchMusician *objUser, NSError *error) {
        if (!error) {
            musicianArray = (NSMutableArray*)objUser.musician;
            musicianArray = [self createMutableArray1:musicianArray];
            
            [self setDataForMusician];
            
        }
        else
        {
            NSLog(@"%@",error);
        }
    }];
    
    // Do any additional setup after loading the view.
}



-(void)createLeftBarButton
{
    UIButton* profileButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 46, 31)];
    [profileButton setImage:[UIImage imageNamed:@"profile-icon"] forState:UIControlStateNormal];
    [profileButton addTarget:self action:@selector(profileButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    profileButton.exclusiveTouch = YES;
    
    UIBarButtonItem *profileItem = [[UIBarButtonItem alloc]initWithCustomView:profileButton];
    
    self.navigationItem.leftBarButtonItems =[NSArray arrayWithObjects:profileItem, nil];
}



-(void)createRightBarButton
{
    UIButton* matchesButton = [[UIButton alloc]initWithFrame:CGRectMake(10, 0, 64, 84)];
    [matchesButton setImage:[UIImage imageNamed:@"matches-icon"] forState:UIControlStateNormal];
    [matchesButton addTarget:self action:@selector(matchesButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    matchesButton.exclusiveTouch = YES;
    
    UIBarButtonItem *matchesItem = [[UIBarButtonItem alloc]initWithCustomView:matchesButton];
    
    self.navigationItem.rightBarButtonItems =[NSArray arrayWithObjects:matchesItem, nil];
}



-(void)matchesButtonClicked:(id)sender
{
    NSLog(@"Matches");
}

-(void)profileButtonClicked:(id)sender
{
    NSLog(@"Profile");
    
    ProfileViewController * feedbackVC = [self.storyboard instantiateViewControllerWithIdentifier:@"ProfileViewController"];
    [self.navigationController pushViewController:feedbackVC animated:YES];
    
}



-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    if (CGRectEqualToRect(CGRectZero, playCollectionViewFrame)) {
        playCollectionViewFrame = self.playCollectionView.frame;
    }
    
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
    
    
}


- (NSInteger)collectionView:(UICollectionView *)view numberOfItemsInSection:(NSInteger)section {
    if (view == _playCollectionView) {
        return playArray.count;
    }
    else
    {
        return listenArray.count;
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
      
     
      for (Play *playObject in selection.play) {
          if ([playObject.name isEqualToString:playArray[indexPath.row]]) {
              UIColor * color = [UtilitiesHelper colorFromHexString:playObject.color];
              playCV.bgView.backgroundColor = color;
              playCV.bgView.alpha = 0.8;
          }
      }
      

      playCV.nameLabel.text = playArray[indexPath.row];
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
        
        
        for (Listen *listenObject in selection.listen) {
            if ([listenObject.name isEqualToString:listenArray[indexPath.row]]) {
                UIColor * color = [UtilitiesHelper colorFromHexString:listenObject.color];
                listenCV.bgView.backgroundColor = color;
                listenCV.bgView.alpha = 0.8;
            }
        }
        
        
        listenCV.nameLabel.text = listenArray[indexPath.row];
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


- (IBAction)likeButtonClicked:(id)sender {
    
//    NSLog(@"facebook id %@", musicianConcreate.facebookid);
//    NSLog(@"my id %@",[UserModel sharedInstance].getUserData.facebookid);
    MusicianConcreate * musician = musicianArray[0];
    
    
    [[ServiceModel sharedClient]POST:@"requestFriend" parameters:@{@"userfbid":[UserModel sharedInstance].getUserData.facebookid,@"friendfbid":musician.facebookid} onView:self.view success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [musicianArray removeObjectAtIndex:0];
        [self setDataForMusician];
        
        NSLog(@"%@",responseObject);
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}

- (IBAction)dislikeButtonClicked:(id)sender {
    [[ServiceModel sharedClient]POST:@"dislikePerson" parameters:@{@"userfbid":@"",@"friendfbid":@""} onView:self.view success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        [musicianArray removeObjectAtIndex:0];
        [self setDataForMusician];
        
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
}


-(void)setDataForMusician
{
    if (musicianArray.count>0) {
    MusicianConcreate * musician = musicianArray[0];
    
    _userNameLabel.text = musician.name;
    _userDistanceLabel.text =[NSString stringWithFormat:@"%.2f Km",[ musician.caldistance doubleValue]] ;
        _userProfileImageView.layer.cornerRadius = _userProfileImageView.frame.size.width / 2;
        _userProfileImageView.clipsToBounds = YES;

        _userProfileImageView.layer.borderWidth = 3.0f;
        _userProfileImageView.layer.borderColor = [UIColor redColor].CGColor;
        
    [_userProfileImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",musician.picture]] placeholderImage:[UIImage imageNamed:@""]];
    
    playArray = [musician.play componentsSeparatedByString:@","];
    listenArray = [musician.listen componentsSeparatedByString:@","];
    
    
    [_playCollectionView reloadData];
    [_listenCollectionView reloadData];
    }
    else
    {
        NSLog(@"Show Error");
    }
}

- (NSMutableArray *)createMutableArray1:(NSArray *)array
{
    return [NSMutableArray arrayWithArray:array];
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
