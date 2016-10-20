//
//  SplashViewController.m
//  Jambro
//
//  Created by Faraz Haider on 14/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "SplashViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "AppDelegate.h"

@interface SplashViewController ()
@end

@implementation SplashViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"splash" ofType:@"mp4"];
    NSURL *url = [NSURL fileURLWithPath:path];
    
    AVPlayer *av = [[AVPlayer alloc] initWithURL:url];
    
    av.actionAtItemEnd = AVPlayerActionAtItemEndNone;
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(playerItemDidReachEnd:)
                                                 name:AVPlayerItemDidPlayToEndTimeNotification
                                               object:[av currentItem]];
    
    AVPlayerLayer *layer = [AVPlayerLayer playerLayerWithPlayer:av];
    
    [layer setFrame:self.view.frame];
    
    [self.view.layer addSublayer:layer];
    
    [av play];

    
}


- (void)playerItemDidReachEnd:(NSNotification *)notification {
//    AVPlayerItem *p = [notification object];
//    [p seekToTime:kCMTimeZero];
    
    [self setRootController];
}

-(void)setRootController{
    
    AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    [appdelegate setRootController];
    
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
