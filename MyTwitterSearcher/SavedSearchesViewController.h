//
//  SavedSearchesViewController.h
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 6/12/11.
//  Copyright 2011 Code Magazine. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol SavedSearchDelegate <NSObject>

- (void)didSelectSearch:(NSString *)searchTerm;

@end

@interface SavedSearchesViewController : UITableViewController {
    
}

@property (nonatomic, assign) id<SavedSearchDelegate> delegate;
@property (nonatomic, retain) NSArray *savedSearches;

@end

