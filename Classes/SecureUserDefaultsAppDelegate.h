//
//  SecureUserDefaultsAppDelegate.h
//  SecureUserDefaults
//
//  Created by Matthias Plappert on 25.10.09.
//  Copyright phapswebsolutions 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SecureUserDefaultsAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

- (IBAction)writeTestUserDefaults;
- (IBAction)readTestUserDefaults;

@end

