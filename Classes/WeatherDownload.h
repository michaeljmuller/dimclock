//
//  WeatherDownload.h
//  Clock
//
//  Created by Michael Muller on 11/7/09.
//  Copyright 2009 Michael J Muller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AsynchonousDownload.h"

@interface WeatherDownload : AsynchonousDownload {
	NSString *sunrise;
	NSString *sunset;
	NSString *currentTemp;
	NSString *dayOne;
	NSString *dayTwo;
	NSString *weatherIconOne;
	NSString *weatherIconTwo;
	NSString *conditionsOne;
	NSString *conditionsTwo;
	NSString *tempsOne;
	NSString *tempsTwo;
	BOOL isDayOne;
}

@property (nonatomic, retain) NSString *sunrise;
@property (nonatomic, retain) NSString *sunset;
@property (nonatomic, retain) NSString *currentTemp;
@property (nonatomic, retain) NSString *dayOne;
@property (nonatomic, retain) NSString *dayTwo;
@property (nonatomic, retain) NSString *weatherIconOne;
@property (nonatomic, retain) NSString *weatherIconTwo;
@property (nonatomic, retain) NSString *conditionsOne;
@property (nonatomic, retain) NSString *conditionsTwo;
@property (nonatomic, retain) NSString *tempsOne;
@property (nonatomic, retain) NSString *tempsTwo;
@property (nonatomic, assign) BOOL isDayOne;

- (WeatherDownload *) initWithZip:(NSString *)zip delegate: (id <AsynchronousDownloadDelegate>) del;

@end
