//
//  SettingViewController.m
//  Jambro
//
//  Created by Faraz Haider on 15/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "SettingViewController.h"
#import "ServiceModel.h"
#import "UserModel.h"
#import "UserConcreate.h"
#import "AppDelegate.h"
#import "HelpAndSupportViewController.h"
#import "AboutUsViewController.h"
#import "HACLocationManager.h"
#import "User.h"
#import "UtilitiesHelper.h"
#import "Play.h"
#import "Listen.h"
#import "Looking.h"
#import "Selection.h"
#import "NSUserDefaults+RMSaveCustomObject.h"

@interface SettingViewController ()
@property (weak, nonatomic) IBOutlet UILabel *currentLocationLabel;
@property (nonatomic,retain)NSString *searchRadiusValue;
@property (nonatomic,retain) NSString *userLatitude;
@property (nonatomic,retain) NSString *userLongitude;


@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.searchRadiusValue = @"1";
    UIImage* logoImage = [UIImage imageNamed:@"settings-icon"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    
    HACLocationManager *locationManager = [HACLocationManager sharedInstance];
    [locationManager GeocodingQuery];
    
        __weak typeof(self) weakSelf = self;
    locationManager.geocodingBlock = ^(NSArray *placemarks){
        
        CLPlacemark *placemark = (CLPlacemark *)placemarks[0];
        
        NSLog(@"%@",[NSString stringWithFormat:@"%@ %@\n%@ %@\n%@\n%@",
                     placemark.subThoroughfare ? placemark.subThoroughfare : @"",
                     placemark.thoroughfare ? placemark.thoroughfare : @"",
                     placemark.postalCode ? placemark.postalCode : @"",
                     placemark.locality ? placemark.locality : @"",
                     placemark.administrativeArea ? placemark.administrativeArea : @"",
                     placemark.country ? placemark.country : @""]);
        
        weakSelf.currentLocationLabel.text =placemark.locality;
    };
    
    
    
    locationManager.geocodingErrorBlock = ^(NSError *error){
        NSLog(@"%@", error);
    };
    
    
    
    
    
    [locationManager LocationQuery];
    
    __weak typeof(self) weakSelf1 = self;
    
    locationManager.locationUpdatedBlock = ^(CLLocation *location){
        NSLog(@"%@", location);
        weakSelf1.userLatitude = [NSString stringWithFormat:@"%f",location.coordinate.latitude];
        
        weakSelf1.userLongitude = [NSString stringWithFormat:@"%f",location.coordinate.longitude];
        
    };
    
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)searchRadiusKm:(id)sender {
[NSString stringWithFormat:@"%.0f", [(UISlider *)sender value]];
    
    self.searchRadiusValue = [NSString stringWithFormat:@"%.0f", [(UISlider *)sender value]];
    NSLog(@"%@",self.searchRadiusValue);
}

- (IBAction)aboutUsButtonClicked:(id)sender {
    AboutUsViewController * helpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"AboutUsViewController"];
    [self.navigationController pushViewController:helpVC animated:YES];
    
}

- (IBAction)helpButtonClicked:(id)sender {
    HelpAndSupportViewController * helpVC = [self.storyboard instantiateViewControllerWithIdentifier:@"HelpAndSupportViewController"];
    [self.navigationController pushViewController:helpVC animated:YES];
}

- (IBAction)logoutButtonClicked:(id)sender {
    [[ServiceModel sharedClient]POST:@"logOut" parameters:@{@"facebookid": [UserModel sharedInstance].getUserData.facebookid} onView:self.view success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Logout");
        [[UserModel sharedInstance]removeUserData];
        
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate setRootController];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}

- (IBAction)deactivateButtonClicked:(id)sender {
    [[ServiceModel sharedClient]POST:@"deactivateAccount" parameters:@{@"facebookid": [UserModel sharedInstance].getUserData.facebookid} onView:self.view success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Deactivate Account");
        [[UserModel sharedInstance]removeUserData];
        
        AppDelegate *appdelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
        [appdelegate setRootController];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
    }];
}


-(void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:YES];
    
    
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
    
    
    [User updateUser:@{
                       @"facebookid":[UserModel sharedInstance].getUserData.facebookid,
                       @"userDeviceToken":[UserModel sharedInstance].getUserData.deviceToken,
                       @"play":playString,
                       @"listen":listenString,
                       @"lookfor":lookingString,
                       @"bio":[UserModel sharedInstance].getUserData.bio,
                       @"lat":(_userLatitude?_userLatitude:@"0.0"),
                       @"lon":(_userLongitude?_userLongitude:@"0.0"),
                       @"gender":[UserModel sharedInstance].getUserData.gender,
                       @"distance":self.searchRadiusValue,
                       } withURLStr:@"updateProfile" onView:self.view response:^(User *objUser, NSError *error) {
        if (objUser) {
            [[UserModel sharedInstance] saveUserInfo:objUser.user];
        }
        else {
            [UtilitiesHelper showErrorAlert:error];
        }

    }];
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
