//
//  RootViewController.m
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 5/23/11.
//  Copyright 2011 Code Magazine. All rights reserved.
//

#import "RootViewController.h"

//at the top of the file
#import "CDTweet.h"
#import "CDTweetCell.h"
#import "SavedSearchesViewController.h"


@implementation RootViewController

@synthesize searchBar;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Search Twitter";
    
    _twitterSearcher = [[CDTwitterSearcher alloc] init];
    _twitterSearcher.delegate = self;
    
    _imageCache = [[CDTableViewImageCache alloc] initWithTableView:self.tableView];
    _imageCache.defaultImage = [UIImage imageNamed:@"defaultAvatar.png"];
}

- (void)searcherDidCompleteWithResults:(NSArray *)results {
    [_tweets release];
    _tweets = [results retain];
    [self.tableView reloadData];
    
    id saveButton = [[[UIBarButtonItem alloc] 
                      initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                      target:self
                      action:@selector(saveSearch)] 
                     autorelease];
    self.navigationItem.rightBarButtonItem = saveButton;
}

- (void)saveSearch {
    NSString *searchTerm = self.searchBar.text;
    // check for existing saved searches array, comes back as a standard NSArray, so we have to 
    // create an intermediary array & then add it to our mutable instance
    NSArray *existingItems = [[NSUserDefaults standardUserDefaults] objectForKey:@"saved_searches"];
    NSMutableArray *savedSearches = [NSMutableArray array];
    if (existingItems) {
        [savedSearches addObjectsFromArray:existingItems];
    }
    
    //don't save the same search term twice
    if (![savedSearches containsObject:searchTerm]) {
        [savedSearches addObject:searchTerm];   
        [[NSUserDefaults standardUserDefaults] setObject:savedSearches forKey:@"saved_searches"];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }
    
    [[[[UIAlertView alloc] initWithTitle:@"Search saved"
                                 message:@"Your search was saved"
                                delegate:nil
                       cancelButtonTitle:@"OK"
                       otherButtonTitles:nil] autorelease] show];
}

- (void)searchBarBookmarkButtonClicked:(UISearchBar *)searchBar {
    id savedSearches = [[NSUserDefaults standardUserDefaults] 
                        objectForKey:@"saved_searches"];
    SavedSearchesViewController *ssvc = [[SavedSearchesViewController alloc] 
                                         initWithStyle:UITableViewStylePlain];
    ssvc.title = @"Choose a Saved Search";
    ssvc.delegate = self;
    ssvc.savedSearches = savedSearches;
    
    UINavigationController *navController = [[UINavigationController alloc] 
                                             initWithRootViewController:ssvc];
    
    [self presentModalViewController:navController animated:YES];
    
    [ssvc release];
    [navController release];
}

- (void)didSelectSearch:(NSString *)searchTerm {
    self.searchBar.text = searchTerm;
    [_twitterSearcher searchTwitter:searchTerm];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView 
 numberOfRowsInSection:(NSInteger)section {
    return [_tweets count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDTweetCell *cell = [CDTweetCell cellForTableView:tableView];
    CDTweet *tweet = [_tweets objectAtIndex:indexPath.row];
    [cell updateForTweet:tweet];
    
    cell.imageView.image = [_imageCache imageForIndexPath:indexPath imageUrl:[NSURL URLWithString:tweet.profileImageUrl]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView 
     didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

}

- (CGFloat)tableView:(UITableView *)tableView 
  heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    CDTweet *tweet = [_tweets objectAtIndex:indexPath.row];
    return [CDTweetCell heightForTweet:tweet];
}

#pragma mark -
#pragma mark UISearchBarDelegate methods

- (void)searchBarSearchButtonClicked:(UISearchBar *)aSearchBar {
    NSString *searchTerm = aSearchBar.text;
    //dismiss the keyboard
    [aSearchBar resignFirstResponder];
    [_twitterSearcher searchTwitter:searchTerm];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)aSearchBar {
    [aSearchBar resignFirstResponder];
}

- (void)viewDidUnload {
    [super viewDidUnload];

    self.searchBar = nil;
    
    [_twitterSearcher release];
    _twitterSearcher = nil;
    
    [_imageCache release];
    _imageCache = nil;
    
    [_tweets release];
    _tweets = nil;
}

- (void)dealloc {
    [searchBar release];
    [_tweets release];
    [_twitterSearcher release];
    [_imageCache release];
    [super dealloc];
}

@end
