//
//  CDTweetCell.h
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 6/11/11.
//  Copyright 2011 Code Magazine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDTweet.h"

@interface CDTweetCell : UITableViewCell {
    
}

+ (CDTweetCell *)cellForTableView:(UITableView *)tableView;
+ (CGFloat)heightForTweet:(CDTweet *)tweet;

- (void)updateForTweet:(CDTweet *)tweet;

@end
