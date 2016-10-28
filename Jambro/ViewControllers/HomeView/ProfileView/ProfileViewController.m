//
//  ProfileViewController.m
//  Jambro
//
//  Created by Faraz Haider on 15/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "ProfileViewController.h"
#import "FeedBackViewController.h"
#import "SelectionViewController.h"

@interface ProfileViewController ()

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)editProfileButtonClicked:(id)sender {
    SelectionViewController * selectionVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SelectionViewController"];
    [self.navigationController pushViewController:selectionVC animated:YES];
}

- (IBAction)settingButtonClicked:(id)sender {
}

- (IBAction)inviteButtonClicked:(id)sender {
}

- (IBAction)feedbackButtonClicked:(id)sender {
    FeedBackViewController * feedbackVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedBackViewController"];
    [self.navigationController pushViewController:feedbackVC animated:YES];
}

- (IBAction)changePhotoButtonClicked:(id)sender {
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
