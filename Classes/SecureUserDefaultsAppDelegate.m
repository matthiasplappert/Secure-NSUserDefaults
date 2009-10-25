//
//  SecureUserDefaultsAppDelegate.m
//  SecureUserDefaults
//
//  Created by Matthias Plappert on 25.10.09.
//  Copyright phapswebsolutions 2009. All rights reserved.
//

#import "SecureUserDefaultsAppDelegate.h"
#import "NSUserDefaults+PWSecuredUserDefaults.h"

@implementation SecureUserDefaultsAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(UIApplication *)application
{
	// Save secret. Make sure that you don't tell anyone your secret.
	// If you change this your existing secured user defaults will not be readable any more.
	[NSUserDefaults setSecret:@"4a7tl2L0mxlE"];
	
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}

- (void)dealloc
{
    [window release];
    [super dealloc];
}

#pragma mark -
#pragma mark Example imlementation

- (IBAction)writeTestUserDefaults
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	// Write test data
	[defaults setSecuredBool:YES forKey:@"boolTest"];
	[defaults setSecuredDouble:1.234 forKey:@"doubleTest"];
	[defaults setSecuredFloat:2.345 forKey:@"floatTest"];
	[defaults setSecuredInteger:1234 forKey:@"intTest"];
	[defaults setSecuredObject:@"test" forKey:@"stringTest"];
	[defaults setSecuredObject:[NSDate date] forKey:@"dateTest"];
	[defaults setSecuredObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"http://www.google.de"]] forKey:@"dataTest"];
	[defaults setSecuredObject:[NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil] forKey:@"arrayTest"];
	[defaults setSecuredObject:[NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", [NSArray arrayWithObjects:[NSDate date], [NSNumber numberWithInt:123], nil], @"array", nil] forKey:@"dictionaryTest"];
}

- (IBAction)readTestUserDefaults
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	// Read test data and log it
	NSLog(@"%d", [defaults securedBoolForKey:@"boolTest"]);
	NSLog(@"%f", [defaults securedDoubleForKey:@"doubleTest"]);
	NSLog(@"%f", [defaults securedFloatForKey:@"floatTest"]);
	NSLog(@"%d", [defaults securedIntegerForKey:@"intTest"]);
	NSLog(@"%@", [defaults securedStringForKey:@"stringTest"]);
	NSLog(@"%@", [defaults securedObjectForKey:@"dateTest"]);
	NSLog(@"%@", [defaults securedDataForKey:@"dataTest"]);
	NSLog(@"%@", [defaults securedObjectForKey:@"arrayTest"]);
	NSLog(@"%@", [defaults securedObjectForKey:@"dictionaryTest"]);
}

@end
