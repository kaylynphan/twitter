//
//  DetailsViewController.m
//  twitter
//
//  Created by Kaylyn Phan on 6/24/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "DetailsViewController.h"

@interface DetailsViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *profileImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *textLabel;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *retweetsLabel;
@property (weak, nonatomic) IBOutlet UILabel *likesLabel;
- (IBAction)didTapRetweet:(id)sender;
- (IBAction)didTapLike:(id)sender;

@end

@implementation DetailsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.nameLabel.text = self.tweet.user.name;
    self.handleLabel.text = [NSString stringWithFormat:@"@%@", self.tweet.user.screenName];
    self.textLabel.text = self.tweet.text;
    self.dateLabel.text = self.tweet.createdAtString;
    self.retweetsLabel.text = [NSString stringWithFormat:@"%d Retweets", self.tweet.retweetCount];
    self.likesLabel.text = [NSString stringWithFormat:@"%d Likes", self.tweet.favoriteCount];;
    
    
    // handle user image
    self.profileImage.image = nil;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:self.tweet.user.profilePicture]];
    self.profileImage.image = [UIImage imageWithData: imageData];
    self.profileImage.layer.cornerRadius = CGRectGetHeight(self.profileImage.frame) / 4;
    self.profileImage.clipsToBounds = YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)didTapLike:(id)sender {
}

- (IBAction)didTapRetweet:(id)sender {
}

@end
