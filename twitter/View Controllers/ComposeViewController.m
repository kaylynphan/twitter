//
//  ComposeViewController.m
//  twitter
//
//  Created by Kaylyn Phan on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"
#import "TimelineViewController.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextField *textField;
- (IBAction)didTapClose:(id)sender;
- (IBAction)didTapPost:(id)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapPost:(id)sender {
    [[APIManager shared] postStatusWithText:self.textField.text completion:^(Tweet *tweet, NSError *error) {
        if(error){
                NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else {
            [self dismissViewControllerAnimated:true completion:nil];
            NSLog(@"Compose Tweet Success!");
            [self.delegate didTweet:tweet];
        }
    }];
    
}

- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
