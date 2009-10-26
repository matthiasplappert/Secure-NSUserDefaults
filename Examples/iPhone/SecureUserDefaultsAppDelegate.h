//
//  SecureUserDefaultsAppDelegate.h
//  SecureUserDefaults
//
//  Created by Matthias Plappert on 25.10.09.
//  Copyright phapswebsolutions 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Test;

@interface SecureUserDefaultsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
	Test *test;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)writeTestUserDefaults;
- (IBAction)readTestUserDefaults;

@end

