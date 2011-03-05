//
//  Example.m
//  Secure-NSUserDefaults
//
//  Copyright (c) 2011 Matthias Plappert <matthiasplappert@me.com>
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

#import <Foundation/Foundation.h>
#import "NSUserDefaults+MPSecureUserDefaults.h"


int main(int argc, const char * argv[])
{
    NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
	
	// Get device identifier
	NSString *deviceIdentifier = nil;
#if TARGET_OS_IPHONE
	deviceIdentifier = [[UIDevice currentDevice] uniqueIdentifier];
#else
	io_service_t platformExpert = IOServiceGetMatchingService(kIOMasterPortDefault,
															  IOServiceMatching("IOPlatformExpertDevice"));
	
	if (platformExpert) {
		CFTypeRef serialNumberAsCFString = IORegistryEntryCreateCFProperty(platformExpert,
																		   CFSTR(kIOPlatformSerialNumberKey),
																		   kCFAllocatorDefault,
																		   0);
		deviceIdentifier = [(NSString *)serialNumberAsCFString autorelease];
		IOObjectRelease(platformExpert);
    }
#endif
	
	// Configure user defaults
	[NSUserDefaults setSecret:@"somethingsupersecret"];
	[NSUserDefaults setDeviceIdentifier:deviceIdentifier];
	
	// Tests
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
	BOOL valid = NO;
	
	// Primitive datatypes
	[defaults setSecureBool:YES forKey:@"bool"];
	[defaults setSecureDouble:1.23e300 forKey:@"double"];
	[defaults setSecureFloat:1.23456789 forKey:@"float"];
	[defaults setSecureInteger:123456789 forKey:@"integer"];
	
	valid = NO;
	NSLog(@"secureBoolForKey: %d", [defaults secureBoolForKey:@"bool" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	valid = NO;
	NSLog(@"secureDoubleForKey: %e", [defaults secureDoubleForKey:@"double" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	valid = NO;
	NSLog(@"secureFloatForKey: %f", [defaults secureFloatForKey:@"float" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	valid = NO;
	NSLog(@"secureIntegerForKey: %d", [defaults secureIntegerForKey:@"integer" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	// NSData, NSString, NSNumber & NSDate
	[defaults setSecureObject:[@"data" dataUsingEncoding:NSUTF8StringEncoding] forKey:@"data"];
	[defaults setSecureObject:@"string" forKey:@"string"];
	[defaults setSecureObject:[NSNumber numberWithInt:123] forKey:@"number"];
	[defaults setSecureObject:[NSDate date] forKey:@"date"];
	
	valid = NO;
	NSLog(@"secureDataForKey: %@", [defaults secureDataForKey:@"data" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	valid = NO;
	NSLog(@"secureStringForKey: %@", [defaults secureStringForKey:@"string" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	valid = NO;
	NSLog(@"secureObjectForKey (number): %@", [defaults secureObjectForKey:@"number" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	valid = NO;
	NSLog(@"secureObjectForKey: (date) %@", [defaults secureObjectForKey:@"date" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	// NSArray & NSDictionary
	NSArray *validArray = [NSArray arrayWithObjects:[NSNumber numberWithInt:123],
													[@"data" dataUsingEncoding:NSUTF8StringEncoding], 
													@"string",
													[NSDictionary dictionaryWithObject:[NSNumber numberWithInt:123] forKey:@"key"],
													[NSDate date], nil];
	NSArray *validStringArray = [NSArray arrayWithObjects:@"string1", @"string2", @"string3", nil];
	NSArray *invalidArray = [NSArray arrayWithObjects:@"string", [[[NSObject alloc] init] autorelease], nil];
	
	[defaults setSecureObject:validArray forKey:@"validarray"];
	[defaults setSecureObject:validStringArray forKey:@"validstringarray"];
	[defaults setSecureObject:invalidArray forKey:@"invalidarray"]; // fails because array contains invalid object
	
	valid = NO;
	NSLog(@"secureObjectForKey (validarray): %@", [defaults secureObjectForKey:@"validarray" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	valid = NO;
	NSLog(@"secureStringArrayForKey: %@", [defaults secureObjectForKey:@"validstringarray" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	valid = NO;
	NSLog(@"secureObjectForKey (invalidarray): %@", [defaults secureObjectForKey:@"invalidarray" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	// Invalidate array (simulates what a user would try to do in the plist file)
	NSMutableArray *modifiedValidArray = [validArray mutableCopy];
	[modifiedValidArray replaceObjectAtIndex:0 withObject:[NSNumber numberWithInt:124]];
	NSMutableDictionary *dict = [[defaults objectForKey:@"validarray"] mutableCopy];
	[dict setObject:modifiedValidArray forKey:@"MPSecureUserDefaultsValue"];
	[defaults setObject:dict forKey:@"validarray"];
	[dict release];
	[modifiedValidArray release];
	
	valid = NO;
	NSLog(@"secureObjectForKey (validarray): %@", [defaults secureObjectForKey:@"validarray" valid:&valid]);
	NSLog(@"valid: %d\n\n", valid);
	
	
	[pool drain];
    return 0;
}