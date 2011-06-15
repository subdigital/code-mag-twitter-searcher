//
//  CDTweet.m
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 6/4/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CDTweet.h"

@implementation CDTweet

@synthesize author, text, profileImageUrl;

+ (CDTweet *)tweetWithDictionary:(NSDictionary *)dict {
    CDTweet *tweet = [[CDTweet alloc] init];
    tweet.author = [dict objectForKey:@"from_user"];
    tweet.text   = [dict objectForKey:@"text"];
    tweet.profileImageUrl = 
        [dict objectForKey:@"profile_image_url"];
    return [tweet autorelease];
}

- (void)dealloc {
    [author release];
    [text release];
    [profileImageUrl release];
    [super dealloc];
}

@end
