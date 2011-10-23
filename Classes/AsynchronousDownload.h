//
//  AsynchonousDownload.h
//  Alfresco
//
//  Created by Michael Muller on 10/16/09.
//  Copyright 2009 Zia Consulting. All rights reserved.
//

#import <Foundation/Foundation.h>

@class AsynchronousDownload;

@protocol AsynchronousDownloadDelegate
- (void) asyncDownloadDidComplete:(AsynchronousDownload *)async;
- (void) asyncDownload:(AsynchronousDownload *)async didFailWithError:(NSError *)error;
@end

@interface AsynchronousDownload : NSObject {
	NSMutableData *data;
	NSURL *url;
	id <AsynchronousDownloadDelegate> delegate; 
	NSURLConnection *urlConnection;
}

@property (nonatomic, retain) NSMutableData *data;
@property (nonatomic, retain) NSURL *url;
@property (nonatomic, assign) id <AsynchronousDownloadDelegate> delegate; // apparently, by convention, you don't retain delegates: http://www.cocoadev.com/index.pl?DelegationAndNotification
@property (nonatomic, retain) NSURLConnection *urlConnection;

- (AsynchronousDownload *) initWithURL:(NSURL *)u delegate:(id <AsynchronousDownloadDelegate>) del;
- (void) start;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;

@end
