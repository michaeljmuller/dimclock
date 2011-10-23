//
//  AsynchonousDownload.m
//  Alfresco
//
//  Created by Michael Muller on 10/16/09.
//  Copyright 2009 Zia Consulting. All rights reserved.
//

#import "AsynchronousDownload.h"

@implementation AsynchronousDownload

@synthesize data;
@synthesize url;
@synthesize delegate;
@synthesize urlConnection;

- (void) dealloc {
	[data release];
	[url release];
	[urlConnection release];
	[super dealloc];
}

- (AsynchronousDownload *) initWithURL:(NSURL *)u delegate:(id <AsynchronousDownloadDelegate>) del {
	
	NSLog(@"initializing asynchronous download from: %@", u);
	
	NSMutableData *d = [[NSMutableData alloc] init];
	self.data = d;
	[d release];
	
	self.url = u;
	self.delegate = del;
	
	return self;
}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	if ([response respondsToSelector:@selector(statusCode)])
	{
		int statusCode = [((NSHTTPURLResponse *)response) statusCode];
		if (statusCode >= 400)
		{
			[connection cancel];  // stop connecting; no more delegate messages
			NSString *msg = [[NSString alloc] initWithFormat: @"%d %@", statusCode, [NSHTTPURLResponse localizedStringForStatusCode:statusCode]];
			NSDictionary *errorInfo = [NSDictionary dictionaryWithObject:msg forKey:NSLocalizedDescriptionKey];
			NSError *statusError = [NSError errorWithDomain:@"httpResponseErrorDomain" code:statusCode userInfo:errorInfo];
			[self connection:connection didFailWithError:statusError];
			[msg release];
		}
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)chunk {
    [self.data appendData:chunk];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	
	// stop the "network activity" spinner 
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

	// let the user know something bad happened
	NSString *msg = [[NSString alloc] initWithFormat:@"The server returned an error connecting to %@\n\n%@", [self.url absoluteURL], [error localizedDescription]];
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Connection error" message:msg delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alert show];
	[msg release];
	
	if (self.delegate) {
		[delegate asyncDownload:self didFailWithError:error];
	}
}
 
- (void)connectionDidFinishLoading:(NSURLConnection *)connection {

	// log the response
	NSString *responseAsString = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
	NSLog(@"async result: %@", responseAsString);
	[responseAsString release];
	
	// stop the "network activity" spinner 
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];

	if (self.delegate) {
		[delegate asyncDownloadDidComplete:self];
	}
}

- (void)connection:(NSURLConnection *)connection didReceiveAuthenticationChallenge:(NSURLAuthenticationChallenge *)challenge {
}

- (void) start {
	// start downloading
	NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
	self.urlConnection = [NSURLConnection connectionWithRequest:requestObj delegate:self];
	[self.urlConnection start];
	
	// start the "network activity" spinner 
	[[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

@end
