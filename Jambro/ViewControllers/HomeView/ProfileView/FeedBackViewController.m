//
//  FeedBackViewController.m
//  Jambro
//
//  Created by Faraz Haider on 15/10/2016.
//  Copyright © 2016 Faraz Haider. All rights reserved.
//

#import "FeedBackViewController.h"
#import "ServiceModel.h"
#import "SZTextView.h"

@interface FeedBackViewController ()
@property (weak, nonatomic) IBOutlet SZTextView *textView;

@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.textView.placeholder = @"Write a message.....";
    self.textView.placeholderTextColor = [UIColor lightGrayColor];
    self.textView.font = [UIFont fontWithName:@"HelveticaNeue-Light" size:18.0];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction)feedBackButtonClicked:(id)sender
{
    [[ServiceModel sharedClient]POST:@"sendFeedBack" parameters:@{@"facebookid": @"",@"msg":@""} onView:self.view success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"Feedback shared");
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        
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
