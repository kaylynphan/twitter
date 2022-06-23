//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeViewController.h"

@interface TimelineViewController ()

- (IBAction)didTapLogout:(id)sender;

@end

@implementation TimelineViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    
    UIRefreshControl *refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(beginRefresh:) forControlEvents:UIControlEventValueChanged];
    [self.tableView insertSubview:refreshControl atIndex:0];
    
    // Get timeline
    [self getTimeline];
}

- (void)getTimeline {
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"%@", tweets);
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.arrayOfTweets = tweets;
            
            /*
            for (Tweet *tweet in self.arrayOfTweets) {
                NSLog(@"%@", tweet.user.name);
            }
             */
            /*for (NSDictionary *dictionary in tweets) {
                NSString *text = dictionary[@"text"];
                NSLog(@"%@", text);
            }*/
            [self.tableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
}

- (void)beginRefresh:(UIRefreshControl *)refreshControl {
    [self getTimeline];
    [refreshControl endRefreshing];
}

- (void)didTweet:(Tweet *)tweet {
    [self.arrayOfTweets insertObject:tweet atIndex:0];
    [self.tableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.arrayOfTweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    //NSLog(@"cellForRowAtIndexPath is being called");
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    Tweet *tweet = self.arrayOfTweets[indexPath.row];
    //NSLog(@"Name: %@", tweet.user.name);
    
    cell.tweet = tweet;
    cell.nameLabel.text = tweet.user.name;
    cell.handleLabel.text = [NSString stringWithFormat:@"@%@", tweet.user.screenName];
    cell.textLabel.text = tweet.text;
    
    //sample tweet.createdAtString: "Wed Oct 10 20:19:24 +0000 2018"
    
    /*
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    dateFormatter.dateFormat = @"E MMM d HH:mm:ss Z y";
    NSDate *date = [dateFormatter dateFromString:tweet.createdAtString];
    NSString *dateSince = date.shortTimeAgoSinceNow;
    NSLog(@"dateSince: %@", dateSince);
    if (([dateSince containsString:@"d"] ||
         [dateSince containsString:@"w"] ||
         [dateSince containsString:@"M"] ||
         [dateSince containsString:@"y"])) {
        dateFormatter.dateStyle = NSDateFormatterShortStyle;
        dateFormatter.timeStyle = NSDateFormatterNoStyle;
        cell.tweet.createdAtString = [dateFormatter stringFromDate:date];
    } else {
        cell.tweet.createdAtString = dateSince;
    }
     */
    
    cell.dateLabel.text = tweet.createdAtString;
    
    [cell.likeButton setTitle:[NSString stringWithFormat:@"%d", tweet.favoriteCount] forState:UIControlStateNormal];
    [cell.retweetButton setTitle:[NSString stringWithFormat:@"%d", tweet.retweetCount] forState:UIControlStateNormal];
    if (cell.tweet.favorited == YES) {
        [cell.likeButton setImage:[UIImage imageNamed:@"favor-icon-red.png"] forState:UIControlStateNormal];
    } else {
        [cell.likeButton setImage:[UIImage imageNamed:@"favor-icon.png"] forState:UIControlStateNormal];
    }
    
    if (cell.tweet.retweeted == YES) {
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon-green.png"] forState:UIControlStateNormal];
    } else {
        [cell.retweetButton setImage:[UIImage imageNamed:@"retweet-icon.png"] forState:UIControlStateNormal];
    }
    
    //obtain user image
    cell.profileImage.image = nil;
    NSData *imageData = [[NSData alloc] initWithContentsOfURL: [NSURL URLWithString:tweet.user.profilePicture]];
    cell.profileImage.image = [UIImage imageWithData: imageData];
    return cell;
}
/*
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}
 */

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = [segue destinationViewController];
    ComposeViewController *composeController = (ComposeViewController*)navigationController.topViewController;
    composeController.delegate = self;
}

- (IBAction)didTapLogout:(id)sender {
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;

    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    appDelegate.window.rootViewController = loginViewController;
    // clear out access tokens
    [[APIManager shared] logout];
}
@end
