//
//  ClockAppDelegate.m
//  Clock
//
//  Created by Michael Muller on 11/5/09.
//  Copyright Michael J Muller 2009. All rights reserved.
//

#import "ClockAppDelegate.h"
#import "ClockViewController.h"

// private SDK function -- needs /Developer/Platforms/iPhoneOS.platform/Developer/SDKs/iPhoneOS3.1.sdk/System/Library/PrivateFrameworks/GraphicsServices.framework
void GSEventSetBacklightLevel(float newLevel); //The new level: 0.0 - 1.0.

@implementation ClockAppDelegate

@synthesize window;
@synthesize viewController;

- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
	UIApplication *thisApp = [UIApplication sharedApplication];

	// hide the status bar at the top of the screen
	[thisApp setStatusBarHidden:YES animated:NO];
	
	// disable the auto-lock
	thisApp.idleTimerDisabled = YES;
	
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	// turn brightness all the way up
	viewController.brightness = 1;
	GSEventSetBacklightLevel(viewController.brightness);
}

- (void)applicationWillTerminate:(UIApplication *)application {
	GSEventSetBacklightLevel(1);
}

- (void)applicationWillResignActive:(UIApplication *)application {
	GSEventSetBacklightLevel(1);
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
	viewController.brightness = 1;
	[viewController dimSlightly];
}

@end
