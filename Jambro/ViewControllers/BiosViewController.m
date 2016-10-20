//
//  BiosViewController.m
//  Jambro
//
//  Created by Faraz Haider on 18/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "BiosViewController.h"
#import "HomeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"

@interface BiosViewController ()

@end

@implementation BiosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    self.navigationController.navigationBar.hidden = TRUE;
}


- (IBAction)addBiosButtonClicked:(id)sender {
//        [self moveToNextViewController:YES];
    
    LoginViewController * loginVC =[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginVC animated:YES];
}

- (IBAction)skipButtonClicked:(id)sender {
    [self moveToNextViewController:YES];
}


-(void)moveToNextViewController:(BOOL)isFirstTime
{
    if (isFirstTime) {
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate makeHomeRootView];
    }
    else
    {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
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
