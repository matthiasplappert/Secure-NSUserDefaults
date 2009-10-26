//
//  Test.m
//  SecureUserDefaults
//
//  Copyright (c) 2009 Matthias Plappert <mplappert@phaps.de>
//  
//  Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated
//  documentation files (the "Software"), to deal in the Software without restriction, including without limitation
//  the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and
//  to permit persons to whom the Software is furnished to do so, subject to the following conditions:
//  The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
//  
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE
//  WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR
//  COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
//  ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
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
