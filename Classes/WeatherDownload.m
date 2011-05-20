//
//  WeatherDownload.m
//  Clock
//
//  Created by Michael Muller on 11/7/09.
//  Copyright 2009 Michael J Muller. All rights reserved.
//

#import "WeatherDownload.h"

@implementation WeatherDownload
@synthesize sunrise;
@synthesize sunset;
@synthesize currentTemp;
@synthesize dayOne;
@synthesize dayTwo;
@synthesize weatherIconOne;
@synthesize weatherIconTwo;
@synthesize conditionsOne;
@synthesize conditionsTwo;
@synthesize tempsOne;
@synthesize tempsTwo;
@synthesize isDayOne;

- (WeatherDownload *) initWithZip:(NSString *)zip delegate: (id <AsynchronousDownloadDelegate>) del {
	NSString *urlStr = [[NSString alloc] initWithFormat:@"http://weather.yahooapis.com/forecastrss?p=%@", zip];
	NSURL *u = [NSURL URLWithString:urlStr];
	[urlStr release];
	return (WeatherDownload *) [self initWithURL:u delegate:del];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	
	// create a parser and parse the xml
	NSXMLParser *parser = [[NSXMLParser alloc] initWithData:self.data];
	[parser setDelegate:self];
	self.isDayOne = YES;
	[parser parse];
	[parser release];
		
	[super connectionDidFinishLoading:connection];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict {
	
	if ([elementName isEqualToString:@"yweather:astronomy"]) {
		NSString *sunriseString = [[NSString alloc] initWithFormat:@"Sunrise: %@", [attributeDict objectForKey:@"sunrise"]];
		self.sunrise = sunriseString;
		[sunriseString release];

		NSString *sunsetString = [[NSString alloc] initWithFormat:@"Sunset: %@", [attributeDict objectForKey:@"sunset"]];
		self.sunset = sunsetString;
		[sunsetString release];
	}
	
	else if ([elementName isEqualToString:@"yweather:condition"]) {
		self.currentTemp = [attributeDict objectForKey:@"temp"];
	}

	else if ([elementName isEqualToString:@"yweather:forecast"]) {
		NSString *tempRange = [[NSString alloc] initWithFormat:@"H: %@º  L: %@º", [attributeDict objectForKey:@"high"], [attributeDict objectForKey:@"low"]];
		if (isDayOne) {
			self.dayOne = [attributeDict objectForKey:@"day"];
			self.tempsOne = tempRange;
			self.conditionsOne = [attributeDict objectForKey:@"text"];
			self.weatherIconOne = [attributeDict objectForKey:@"code"]; 
		}
		else {
			self.dayTwo = [attributeDict objectForKey:@"day"];
			self.tempsTwo = tempRange;
			self.conditionsTwo = [attributeDict objectForKey:@"text"];
			self.weatherIconTwo = [attributeDict objectForKey:@"code"]; 
		}
		[tempRange release];
		self.isDayOne = NO;
	}
}


@end
