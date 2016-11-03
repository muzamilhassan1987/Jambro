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
#import "UserModel.h"
#import "UserConcreate.h"
#import "UIImageView+AFNetworking.h"
#import "SettingViewController.h"
#import "JSImagePickerViewController.h"
#import "ServiceModel.h"
#import "User.h"
#import "UtilitiesHelper.h"

@interface ProfileViewController ()<JSImagePickerViewControllerDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *imageViewProfilePhoto;

@end

@implementation ProfileViewController
//
- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage* logoImage = [UIImage imageNamed:@"profile-icon"];
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:logoImage];
    
    [self.imageViewProfilePhoto setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[UserModel sharedInstance]getUserData].picture]]placeholderImage:[UIImage imageNamed:@"Placeholder"]];
    [self circleImage];
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
    SettingViewController * settingVC = [self.storyboard instantiateViewControllerWithIdentifier:@"SettingViewController"];
    [self.navigationController pushViewController:settingVC animated:YES];
}

- (IBAction)inviteButtonClicked:(id)sender {
}

- (IBAction)feedbackButtonClicked:(id)sender {
    FeedBackViewController * feedbackVC = [self.storyboard instantiateViewControllerWithIdentifier:@"FeedBackViewController"];
    [self.navigationController pushViewController:feedbackVC animated:YES];
}

- (IBAction)changePhotoButtonClicked:(id)sender {
    JSImagePickerViewController *imagePicker = [[JSImagePickerViewController alloc] init];
    imagePicker.delegate = self;
    [imagePicker showImagePickerInController:self animated:YES];
}


#pragma mark - JSImagePikcerViewControllerDelegate

- (void)imagePicker:(JSImagePickerViewController *)imagePicker didSelectImage:(UIImage *)image {
    self.imageViewProfilePhoto.image = image;
    
    NSData *imgData = UIImageJPEGRepresentation(image, 0.7);

    [User updateUserProfileImage:@{@"facebookid": [UserModel sharedInstance].getUserData.facebookid} withURLStr:@"updateProfileImage" imageData:imgData imageParamaterName:@"picture" onView:self.view response:^(User *objUser, NSError *error) {
        
        if (objUser) {
            [[UserModel sharedInstance] saveUserInfo:objUser.user];
        }
        else {
            [UtilitiesHelper showErrorAlert:error];
        }
    }];
    
    
    [self circleImage];
}

-(void)circleImage
{
    self.imageViewProfilePhoto.layer.cornerRadius = self.imageViewProfilePhoto.frame.size.width / 2;
    self.imageViewProfilePhoto.clipsToBounds = YES;
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO];   //it hides
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
