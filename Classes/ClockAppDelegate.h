//
//  ClockAppDelegate.h
//  Clock
//
//  Created by Michael Muller on 11/5/09.
//  Copyright Michael J Muller 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ClockViewController;

@interface ClockAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    ClockViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet ClockViewController *viewController;

@end

