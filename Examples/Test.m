//
//  Test.m
//  SecureUserDefaults
//
//  Created by Matthias Plappert on 26.10.09.
//  Copyright 2009 phapswebsolutions. All rights reserved.
//

#import "Test.h"
#import "NSUserDefaults+PWSecuredUserDefaults.h"

@implementation Test

+ (void)initialize
{
	if (self == [Test class]) {
		// Save secret. Make sure that you don't tell anyone your secret.
		// If you change this your existing secured user defaults will not be readable any more.
		[NSUserDefaults setSecret:@"4a7tl2L0mxlE"];
	}
}

- (void)write
{
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	
	// Write test data
	[defaults setSecuredBool:YES forKey:@"boolTest"];
	[defaults setSecuredDouble:1.234 forKey:@"doubleTest"];
	[defaults setSecuredFloat:2.345 forKey:@"floatTest"];
	[defaults setSecuredInteger:1234 forKey:@"intTest"];
	[defaults setSecuredObject:@"test" forKey:@"stringTest"];
	[defaults setSecuredObject:[NSDate date] forKey:@"dateTest"];
	[defaults setSecuredObject:[NSData data] forKey:@"dataTest"];
	[defaults setSecuredObject:[NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", nil] forKey:@"arrayTest"];
	[defaults setSecuredObject:[NSDictionary dictionaryWithObjectsAndKeys:@"value1", @"key1", [NSArray arrayWithObjects:[NSDate date], [NSNumber numberWithInt:123], nil], @"array", @"a1", @"b1", nil] forKey:@"dictionaryTest"];
}

- (void)read
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
