//
//  CDTweet.h
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 6/4/11.
//  Copyright 2011 Code Magazine. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface CDTweet : NSObject {
}

@property (nonatomic, copy) NSString *author;
@property (nonatomic, copy) NSString *text;
@property (nonatomic, copy) NSString *profileImageUrl;

+ (CDTweet *)tweetWithDictionary:(NSDictionary *)dict;


@end
