//
//  main.m
//  SecureUserDefaults
//
//  Created by Matthias Plappert on 25.10.09.
//  Copyright phapswebsolutions 2009. All rights reserved.
//

#if MACOSX
	#import <Cocoa/Cocoa.h>
#elif IPHONE
	#import <UIKit/UIKit.h>
#endif

int main(int argc, char *argv[]) {
    
	#if MACOSX
		return NSApplicationMain(argc,  (const char **) argv);
	#elif IPHONE
		NSAutoreleasePool * pool = [[NSAutoreleasePool alloc] init];
		int retVal = UIApplicationMain(argc, argv, nil, nil);
		[pool release];
		return retVal;
	#endif
}
