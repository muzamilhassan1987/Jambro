//
//  BaseViewController.h
//  Revelium
//
//  Created by FarazHaider on 12/02/2014.
//  Copyright (c) 2014 FarazHaider. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

@property (nonatomic, retain)   BaseViewController *parentBaseController;

-(void)createLeftMenuButton;
-(void)createRightMenuButton;
-(void)setTitleViewWithTitle:(NSString*)title;
-(void)createBackButton;

- (void)showLeftMenuPressed:(id)sender;
- (void)showRightMenuPressed:(id)sender;


-(void)showPreviewForImageWithImageName:(NSString*)imageName;
-(void)showPreviewForVideoWithVideoName:(NSString*)videoName;

-(void)showTransparentNavBar;

@end
