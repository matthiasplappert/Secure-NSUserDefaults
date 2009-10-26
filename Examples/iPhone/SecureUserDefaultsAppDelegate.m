//
//  SecureUserDefaultsAppDelegate.m
//  SecureUserDefaults
//
//  Created by Matthias Plappert on 25.10.09.
//  Copyright phapswebsolutions 2009. All rights reserved.
//

#import "SecureUserDefaultsAppDelegate.h"
#import "Test.h"

@implementation SecureUserDefaultsAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	test = [[Test alloc] init];
	
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}

- (void)dealloc
{
    [window release];
	[test release];
	
    [super dealloc];
}

#pragma mark -
#pragma mark Example imlementation

- (IBAction)writeTestUserDefaults
{
	[test write];
}

- (IBAction)readTestUserDefaults
{
	[test read];
}

@end
