//
//  RootViewController.h
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 5/23/11.
//  Copyright 2011 Code Magazine. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CDTwitterSearcher.h"
#import "SavedSearchesViewController.h"
#import "CDTableViewImageCache.h"

@interface RootViewController : UITableViewController
    <UISearchBarDelegate, CDTwitterSearcherDelegate, SavedSearchDelegate> {
        CDTwitterSearcher *_twitterSearcher;
        NSArray *_tweets;
        CDTableViewImageCache *_imageCache;
}

@property (nonatomic, retain) IBOutlet UISearchBar *searchBar;

@end
