//
//  ComposeViewController.m
//  twitter
//
//  Created by Kaylyn Phan on 6/22/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textField;
- (IBAction)didTapClose:(id)sender;
- (IBAction)didTapTweet:(id)sender;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapTweet:(id)sender {
    [[APIManager shared] postStatusWithText:self.textField.text completion:^(Tweet *, NSError *) {
        [self dismissViewControllerAnimated:true completion:nil];
    }];
    
    /*
    [[APIManager shared] postStatusWithText text:this.textField.text ^(Tweet *, NSError *) {
        [self dismissViewControllerAnimated:true completion:nil];
    }];
     */
}

- (IBAction)didTapClose:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}
@end
