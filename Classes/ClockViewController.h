//
//  ClockViewController.h
//  Clock
//
//  Created by Michael Muller on 11/5/09.
//  Copyright Michael J Muller 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WeatherDownload.h"

@interface ClockViewController : UIViewController <AsynchronousDownloadDelegate> {
	IBOutlet UILabel *time;
	float brightness;
	IBOutlet UILabel *sunrise;
	IBOutlet UILabel *sunset;
	IBOutlet UILabel *currentTemp;
	IBOutlet UILabel *dayOne;
	IBOutlet UILabel *dayTwo;
	IBOutlet UIImageView *weatherIconOne;
	IBOutlet UIImageView *weatherIconTwo;
	IBOutlet UILabel *conditionsOne;
	IBOutlet UILabel *conditionsTwo;
	IBOutlet UILabel *tempsOne;
	IBOutlet UILabel *tempsTwo;
	WeatherDownload *weatherDownload;
	IBOutlet UIView *weatherView;
}

@property (nonatomic, retain) UILabel *time;
@property (nonatomic, assign) float brightness;
@property (nonatomic, retain) UILabel *sunrise;
@property (nonatomic, retain) UILabel *sunset;
@property (nonatomic, retain) UILabel *currentTemp;
@property (nonatomic, retain) UILabel *dayOne;
@property (nonatomic, retain) UILabel *dayTwo;
@property (nonatomic, retain) UIImageView *weatherIconOne;
@property (nonatomic, retain) UIImageView *weatherIconTwo;
@property (nonatomic, retain) UILabel *conditionsOne;
@property (nonatomic, retain) UILabel *conditionsTwo;
@property (nonatomic, retain) UILabel *tempsOne;
@property (nonatomic, retain) UILabel *tempsTwo;
@property (nonatomic, retain) WeatherDownload *weatherDownload;
@property (nonatomic, retain) UIView *weatherView;

- (void)updateTime;
- (void) updateWeather;
- (IBAction)userTappedScreen;
- (void) dimSlightly;

@end

