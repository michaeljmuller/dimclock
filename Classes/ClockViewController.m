//
//  ClockViewController.m
//  Clock
//
//  Created by Michael Muller on 11/5/09.
//  Copyright Michael J Muller 2009. All rights reserved.
//

#import "ClockViewController.h"

// private SDK function -- needs /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS3.1.sdk/System/Library/PrivateFrameworks/GraphicsServices.framework
void GSEventSetBacklightLevel(float newLevel); //The new level: 0.0 - 1.0.

@implementation ClockViewController
@synthesize time;
@synthesize brightness;
@synthesize sunrise;
@synthesize sunset;
@synthesize dayOne;
@synthesize dayTwo;
@synthesize weatherIconOne;
@synthesize weatherIconTwo;
@synthesize conditionsOne;
@synthesize conditionsTwo;
@synthesize tempsOne;
@synthesize tempsTwo;
@synthesize currentTemp;
@synthesize weatherDownload;
@synthesize weatherView;

- (void)dealloc {
	[time release];
	[sunrise release];
	[sunset release];
	[dayOne release];
	[dayTwo release];
	[weatherIconOne release];
	[weatherIconTwo release];
	[conditionsOne release];
	[conditionsTwo release];
	[tempsOne release];
	[tempsTwo release];
	[currentTemp release];
	[weatherDownload release];
	[weatherView release];
    [super dealloc];
}

- (void)updateTime {
	NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
	[dateFormat setDateFormat: @"h:mm"];
	NSString *dateString = [dateFormat stringFromDate: [NSDate date]];
	[dateFormat release];
	self.time.text = dateString;
}

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	
	// update the time, and start a job to update the time again every second
    [self updateTime];
    [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(updateTime) userInfo:nil repeats:YES]; 
    [super viewDidLoad];

	// update the weather
	[self updateWeather];

	// in 10 seconds, dim the screen
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(dimSlightly) userInfo:nil repeats:NO]; 
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}

- (IBAction)userTappedScreen {
	GSEventSetBacklightLevel(1);
	self.weatherView.alpha = 1;
	self.brightness = 1;
    [NSTimer scheduledTimerWithTimeInterval:10 target:self selector:@selector(dimSlightly) userInfo:nil repeats:NO]; 
}

- (void) dimSlightly {
	
	// if we're already all the way dim, then abort
	if (self.brightness <= 0) {
		self.brightness = 0;
		self.weatherView.alpha = 0;
		return;
	}
	
	self.brightness -= 0.01;
	self.brightness = (self.brightness < 0) ? 0 : self.brightness;
	self.weatherView.alpha = self.brightness;

	GSEventSetBacklightLevel(self.brightness);
	
	if (self.brightness > 0) {
		[NSTimer scheduledTimerWithTimeInterval:0.05 target:self selector:@selector(dimSlightly) userInfo:nil repeats:NO]; 
	}
}

- (void) updateWeather {
	
	NSString *zipCode = [[NSUserDefaults standardUserDefaults] stringForKey:@"zip"];
	if (zipCode == nil || [zipCode length] == 0) {
		zipCode = @"80304";
	}
	
	self.weatherDownload = [[WeatherDownload alloc] initWithZip:zipCode delegate:self];
	[self.weatherDownload start];
	
	// check again in an hour
	[NSTimer scheduledTimerWithTimeInterval:(60*60) target:self selector:@selector(updateWeather) userInfo:nil repeats:NO]; 
}

- (void) asyncDownloadDidComplete:(AsynchonousDownload *)async {
	
	WeatherDownload *w = (WeatherDownload *) async;
	
	NSString *temp = [[NSString alloc] initWithFormat:@"%@º", w.currentTemp];
	
	self.sunrise.text = w.sunrise;
	self.sunset.text = w.sunset;
	self.currentTemp.text = temp;
	self.dayOne.text = w.dayOne;
	self.dayTwo.text = w.dayTwo;
	self.conditionsOne.text = w.conditionsOne;
	self.conditionsTwo.text = w.conditionsTwo;
	self.tempsOne.text = w.tempsOne;
	self.tempsTwo.text = w.tempsTwo;
	self.weatherIconOne.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", w.weatherIconOne]];
	self.weatherIconTwo.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@.png", w.weatherIconTwo]];
}

- (void) asyncDownload:(AsynchonousDownload *)async didFailWithError:(NSError *)error {
}


@end
