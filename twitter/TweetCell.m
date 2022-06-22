//
//  TweetCell.m
//  twitter
//
//  Created by Kaylyn Phan on 6/21/22.
//  Copyright © 2022 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (IBAction)didTapReply:(id)sender {
}

- (IBAction)didTapRetweet:(id)sender {
}

- (IBAction)didTapFavorite:(id)sender {
    //self.tweet.favorited = YES;
    //self.tweet.favoriteCount += 1;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)refreshData {
    
}

@end
