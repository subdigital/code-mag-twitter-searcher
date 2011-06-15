//
//  CDTableViewImageCache.m
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 6/12/11.
//  Copyright 2011 ChaiONE. All rights reserved.
//

#import "CDTableViewImageCache.h"


@implementation CDTableViewImageCache

@synthesize tableView, defaultImage;

- (id)initWithTableView:(UITableView *)tableView_ {
    self = [super init];
    if (self) {
        self.tableView      = tableView_;
        _imageCache         = [[NSMutableDictionary alloc] init];
        _currentRequests    = [[NSMutableDictionary alloc] init];
        _queue              = [[NSOperationQueue alloc] init];
        [_queue setMaxConcurrentOperationCount:1];
    }
    return self;
}

- (void)sendRequestForImage:(NSURL *)imageUrl 
                atIndexPath:(NSIndexPath *)indexPath {
    if ([_currentRequests objectForKey:indexPath]) {
        return; //already requestineg
    }
    
    //create the request
    ASIHTTPRequest *req = [ASIHTTPRequest requestWithURL:imageUrl];
    
    //enable caching
    req.cachePolicy = ASIOnlyLoadIfNotCachedCachePolicy;
    req.cacheStoragePolicy = ASICachePermanentlyCacheStoragePolicy;
    
    //make sure we're called back when the request 
    //finishes
    req.delegate = self;
    
    //need to keep track of the index path
    // that this request is for
    req.userInfo = [NSDictionary dictionaryWithObject:
                    indexPath forKey:@"indexPath"];
    
    //make sure we don't request for this index
    // path again
    [_currentRequests setObject:req forKey:indexPath];
    
    //add it to our queue
    // (the request is started automatically)
    [_queue addOperation:req];
}

- (UIImage *)imageForIndexPath:(NSIndexPath *)indexPath 
                      imageUrl:(NSURL *)url {
    
    //bail early if we've already fetched this image
    UIImage *existingImage = [_imageCache objectForKey:url];
    if (existingImage) {
        return existingImage;
    }
    
    [self sendRequestForImage:url atIndexPath:indexPath];
    
    return self.defaultImage;
}

- (void)requestFinished:(ASIHTTPRequest *)request {
    //pull out the index path
    NSIndexPath *indexPath = [request.userInfo 
                              objectForKey:@"indexPath"];
    [_currentRequests removeObjectForKey:indexPath];

    if (request.responseStatusCode == 200) {
        //pull out the raw bytes from the response
        NSData *imageData = [request responseData];
        
        //create our image
        UIImage *image = [UIImage imageWithData:imageData];
        
        //store it in the cache
        [_imageCache setObject:image forKey:request.url];
        
        
        //reload the row in question
        [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
                              withRowAnimation:UITableViewRowAnimationNone];
    }
}

- (void)dealloc {
    [_queue cancelAllOperations];
    [_queue release];
    [_currentRequests release];
    [_imageCache release];
    [tableView release];
    [defaultImage release];
    
    [super dealloc];
}

@end
