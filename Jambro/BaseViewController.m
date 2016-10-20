//
//  BaseViewController.m
//  Revelium
//
//  Created by FarazHaider on 12/02/2014.
//  Copyright (c) 2014 FarazHaider. All rights reserved.
//

#import "BaseViewController.h"
#import "UtilitiesHelper.h"
#import "Constants.h"
#import "HomeViewController.h"
#import "UserModel.h"
#import <MediaPlayer/MediaPlayer.h>
#import "MWPhoto.h"
#import "UIViewController+Utils_h.h"
#import "MWPhotoBrowser.h"



@interface BaseViewController ()<MWPhotoBrowserDelegate>
{
    BOOL isExclusiveTouchMethodCall;
}
@property(nonatomic,retain)UIButton *leftMenuButton;
@property (nonatomic,strong) NSMutableArray *photoCollection;
@property (nonatomic,strong) MPMoviePlayerViewController *objMoviePlayerViewController;

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    //[self setNavigationBarImage];
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self setNavigationBarImage];
    if([[self.navigationController viewControllers] count]>1){
        [self createBackButton];
    }
    // else{
    // }
    
    [self setTitleTextAttribute];
    
}




-(void) viewDidAppear:(BOOL)animated
{
    if (!isExclusiveTouchMethodCall) {
        isExclusiveTouchMethodCall = YES;
        [self exclusiveTouchOn];
    }
}

-(void) exclusiveTouchOn
{
    [UtilitiesHelper setExclusiveTouchToChildrenOf:self.view.subviews];
    self.navigationItem.rightBarButtonItem.customView.exclusiveTouch = YES;
    self.navigationItem.leftBarButtonItem.customView.exclusiveTouch = YES;
}

-(void) viewWillAppear:(BOOL)animated
{
    [self setNavigationBarImage];
    
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)setTitleViewWithTitle:(NSString*)title{
    UILabel* titleLbl;
    int fontSize = 17;
    if (APPC_IS_IPAD) {
        fontSize = 24;
    }
    
    CGSize labelSize = [title sizeWithFont:[UIFont systemFontOfSize:fontSize]
                         constrainedToSize:CGSizeMake(210, 30)
                             lineBreakMode:NSLineBreakByCharWrapping];
    
    if(APPC_IS_IPAD){
        titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(14, 0, 300,150)];
    }
    else{
        
        titleLbl=[[UILabel alloc]initWithFrame:CGRectMake(14, 7, labelSize.width,30)];
    }
    
    [titleLbl setText:title];
    [titleLbl setTextColor:[UIColor whiteColor]];
    [titleLbl setTextAlignment:NSTextAlignmentCenter];
    [titleLbl setBackgroundColor:[UIColor clearColor]];
    titleLbl.lineBreakMode = NSLineBreakByCharWrapping;
    [titleLbl setFont:[UIFont systemFontOfSize:fontSize]];
    self.navigationItem.titleView = titleLbl;
}

-(void)setTitleTextAttribute{
    if(APPC_IS_IPAD){
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]],UITextAttributeTextColor,[UIFont boldSystemFontOfSize:24],UITextAttributeFont,nil];
    }
    else{
        self.navigationController.navigationBar.titleTextAttributes = [NSDictionary dictionaryWithObjectsAndKeys:[UIColor colorWithPatternImage:[UIImage imageNamed:@"back.png"]],UITextAttributeTextColor,[UIFont systemFontOfSize:17],UITextAttributeFont,nil];
    }
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
    
    UIButton* backButton;
    if (APPC_IS_IPAD) {
        backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 52, 52)];
    }
    else{
        backButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 26, 26)];
    }
    [backButton setImage:[UIImage imageNamed:@"back"] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backButtonClicked:) forControlEvents:UIControlEventTouchUpInside];
    backButton.exclusiveTouch = YES;
    self.navigationItem.leftBarButtonItem=[[UIBarButtonItem alloc]initWithCustomView:backButton];
}

-(void)backButtonClicked:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark Left Right Menu

-(void)createLeftMenuButton{
    
    if (APPC_IS_IPAD) {
        self.leftMenuButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    }
    else{
        self.leftMenuButton=[[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    }
    
    [self.leftMenuButton setImage:[UIImage imageNamed:@"btnMenu"] forState:UIControlStateNormal];
    [self.leftMenuButton addTarget:self action:@selector(showLeftMenuPressed:) forControlEvents:UIControlEventTouchUpInside];
    self.leftMenuButton.exclusiveTouch = YES;
    UIBarButtonItem *leftMenuBar = [[UIBarButtonItem alloc]initWithCustomView:self.leftMenuButton];
    
    self.navigationItem.leftBarButtonItems =[NSArray arrayWithObjects:leftMenuBar, nil];
}

-(void)hideLeftMenuButton
{
    self.leftMenuButton.hidden =YES;
}

-(void)showLeftMenuButton
{
    self.leftMenuButton.hidden =NO;
}

- (void)showLeftMenuPressed:(id)sender {
    
}


-(void)showPreviewForImageWithImageName:(NSString*)imageName
{
    self.photoCollection = [NSMutableArray array];
    
    [self.photoCollection addObject:[MWPhoto photoWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", imageName]]]];
    
    MWPhotoBrowser *browser = [[MWPhotoBrowser alloc] initWithDelegate:self];
    browser.displayActionButton = NO;
    browser.displayNavArrows = NO;
    browser.displaySelectionButtons = NO;
    browser.zoomPhotosToFill = YES;
    browser.alwaysShowControls = NO;
    browser.enableGrid = YES;
    browser.startOnGrid = NO;
    
    [self.navigationController pushViewController:browser animated:YES];
}


#pragma mark - MWPhotoBrowser Delegate

- (NSUInteger)numberOfPhotosInPhotoBrowser:(MWPhotoBrowser *)photoBrowser {
    return self.photoCollection.count;
}

- (id <MWPhoto>)photoBrowser:(MWPhotoBrowser *)photoBrowser photoAtIndex:(NSUInteger)index {
    
    if (index < self.photoCollection.count)
        return [self.photoCollection objectAtIndex:index];
    
    return nil;
}



-(void)showPreviewForVideoWithVideoName:(NSString*)videoName
{
    self.objMoviePlayerViewController = [[MPMoviePlayerViewController alloc] initWithContentURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@", videoName]]];
    
    self.objMoviePlayerViewController.moviePlayer.scalingMode = MPMovieScalingModeAspectFit;
    
    [self presentMoviePlayerViewControllerAnimated:self.objMoviePlayerViewController];
}


@end
