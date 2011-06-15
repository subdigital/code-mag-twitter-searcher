//
//  CDTwitterSearcher.h
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 6/1/11.
//  Copyright 2011 Code Magazine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

//define our protocol
@protocol CDTwitterSearcherDelegate <NSObject>
@required
- (void)searcherDidCompleteWithResults:(NSArray *)results;
@end

@interface CDTwitterSearcher : NSObject<ASIHTTPRequestDelegate> {
    
}

@property (nonatomic, assign) id<CDTwitterSearcherDelegate> delegate;

- (void)searchTwitter:(NSString *)searchTerm;

@end
