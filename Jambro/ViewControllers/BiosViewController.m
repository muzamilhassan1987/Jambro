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
#import "SZTextView.h"
#import "UserModel.h"
#import "ProfileViewController.h"
#import "NSUserDefaults+RMSaveCustomObject.h"

@interface BiosViewController ()
@property (weak, nonatomic) IBOutlet SZTextView *textView;

@end

@implementation BiosViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self hideBackButton];
    
    UIImage* logoImage = [UIImage imageNamed:@"profile-icon"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];

    
    self.textView.placeholder = @"Your bio....";
    self.textView.placeholderTextColor = [UIColor lightGrayColor];
    self.textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
//    self.navigationController.navigationBar.hidden = TRUE;
}


- (IBAction)addBiosButtonClicked:(id)sender {
    
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults rm_setCustomObject:self.textView.text forKey:@"Bios"];
    
    
    
    if ([[UserModel sharedInstance]checkUserData]) {
        [self moveToProfileScreen];
    }
    else{
        [self moveToLoginView];
    }
}

- (IBAction)skipButtonClicked:(id)sender {
    if ([[UserModel sharedInstance]checkUserData]) {
        [self moveToProfileScreen];
    }
    else{
        [self moveToLoginView];
    }
}


-(void)moveToLoginView
{
    LoginViewController * loginVC =[self.storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    [self.navigationController pushViewController:loginVC animated:YES];
}


-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.navigationController setNavigationBarHidden:YES];    // it shows
}


-(void)moveToProfileScreen
{
    UIViewController *exitViewController = nil;
    NSArray *viewControllers = [[self navigationController] viewControllers];
    for( int i=0;i<[viewControllers count];i++){
        id obj=[viewControllers objectAtIndex:i];
        if([obj isKindOfClass:[ProfileViewController class]]){
            exitViewController = obj;
            break;
        }
    }
    if (exitViewController != nil) {
        [[self navigationController] popToViewController:exitViewController animated:YES];
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
