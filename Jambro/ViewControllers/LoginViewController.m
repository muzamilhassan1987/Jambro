//
//  LoginViewController.m
//  Jambro
//
//  Created by Faraz Haider on 18/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "LoginViewController.h"
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "User.h"
#import "UserConcreate.h"
#import "UserModel.h"
#import "Constants.h"
#import "AppDelegate.h"
#import "UtilitiesHelper.h"
#import "Selection.h"
#import "Play.h"
#import "Listen.h"
#import "Looking.h"
#import "NSUserDefaults+RMSaveCustomObject.h"
#import "HACLocationManager.h"

@interface LoginViewController (){
     HACLocationManager *locationManager;
}
@property (weak, nonatomic) IBOutlet UIButton *fbLoginButton;


@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    locationManager = [HACLocationManager sharedInstance];
    locationManager.timeoutUpdating = 6;
    
    NSLog(@"Last saved location: %@",locationManager.getLastSavedLocation);
    
    [self.fbLoginButton
     addTarget:self
     action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view.
}

-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Logged in");
             
             [self getUserInfo];
         }
     }];
}


-(void)getUserInfo
{
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters setValue:@"id,name,email,picture,gender" forKey:@"fields"];
    
    [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:parameters]
     startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection,
                                  id result, NSError *error) {
         
         NSString *myEmail = result[@"email"];
         NSString *myGender = result[@"gender"];
         
         
         if (!error) {
             NSLog(@"fetched user:%@  and Email : %@", result,result[@"email"]);
             
             NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=normal",result[@"id"]]];
             //             NSData  *data = [NSData dataWithContentsOfURL:url];
             
             NSString *deviceToken = [UserModel getUserDeviceToken];
             
             NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
            Selection *selection = [defaults rm_customObjectForKey:@"Selection"];
             
             NSMutableArray * playArray = [NSMutableArray array];
             NSMutableArray * listenArray = [NSMutableArray array];
             NSMutableArray * lookingArray = [NSMutableArray array];
             
             for (Play*pl in selection.play) {
                 if ([pl.selected boolValue]) {
                     [playArray addObject:pl.name];
                 }
             }
             for (Listen*li in selection.listen) {
                 if ([li.selected boolValue]) {
                     [listenArray addObject:li.name];
                 }
             }
             for (Looking*lo in selection.looking) {
                 if ([lo.selected boolValue]) {
                     [lookingArray addObject:lo.name];
                 }
             }

             NSString * playString = [playArray componentsJoinedByString:@","];
             NSString * listenString = [listenArray componentsJoinedByString:@","];
             NSString * lookingString = [lookingArray componentsJoinedByString:@","];
             
             
             
             [User registerUser:@{@"email":(myEmail?myEmail:@"xxx@xxx.com"),
                                  @"facebookid":result[@"id"],
                                  @"userDeviceToken":(deviceToken?deviceToken:@"abc123"),
                                  @"name":result[@"name"],
                                  @"play":playString,
                                  @"listen":listenString,
                                  @"lookfor":lookingString,
                                  @"bio":@"",
                                  @"lat":@"",
                                  @"lon":@"",
                                  @"picture":[NSString stringWithFormat:@"%@",url.absoluteString],
                                  @"gender":(myGender?myGender:@"male"),
                                  @"age":@"",
                                  }

                     withURLStr:kWebRegister onView:self.view response:^(User *objUser, NSError *error) {
                         
                         
                         if (objUser) {
                             [[UserModel sharedInstance] saveUserInfo:objUser.user];
                             AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
                             [appdelegate makeHomeRootView];
                         }
                         else {
                             [UtilitiesHelper showErrorAlert:error];
                         }
                     }];
         }
     }];
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

//-(void)viewWillDisappear:(BOOL)animated
//{
//    [super viewDidDisappear:animated];
//    self.navigationController.navigationBar.hidden = FALSE;
//}
//

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
