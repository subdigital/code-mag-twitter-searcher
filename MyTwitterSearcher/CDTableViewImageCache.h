//
//  CDTableViewImageCache.h
//  MyTwitterSearcher
//
//  Created by Ben Scheirman on 6/12/11.
//  Copyright 2011 Code Magazine. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"

@interface CDTableViewImageCache : NSObject <ASIHTTPRequestDelegate> {
    NSMutableDictionary *_imageCache;
    NSMutableDictionary *_currentRequests;
    NSOperationQueue *_queue;
}

- (id)initWithTableView:(UITableView *)tableView;

@property (nonatomic, retain) UITableView *tableView;
@property (nonatomic, retain) UIImage *defaultImage;

- (UIImage *)imageForIndexPath:(NSIndexPath *)indexPath imageUrl:(NSURL *)url;

@end
