//
//  SavedSearchesViewController.m
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 6/12/11.
//  Copyright 2011 Code Magazine. All rights reserved.
//

#import "SavedSearchesViewController.h"

@implementation SavedSearchesViewController

@synthesize delegate, savedSearches;

- (void)viewDidLoad {
    [super viewDidLoad];
    id leftButton = [[[UIBarButtonItem alloc] 
                      initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                           target:self
                                           action:@selector(cancel)] 
                     autorelease];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)cancel {
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section {
    return self.savedSearches.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView 
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault 
                                       reuseIdentifier:CellIdentifier] autorelease];
    }
    
    cell.textLabel.text = [self.savedSearches 
                           objectAtIndex:indexPath.row];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.delegate didSelectSearch:[self.savedSearches objectAtIndex:indexPath.row]];
    [self.parentViewController dismissModalViewControllerAnimated:YES];
}

- (void)dealloc {
    delegate = nil;
    [savedSearches release];
    [super dealloc];
}

@end
