//
//  AppController.h
//  SecureUserDefaults
//
//  Created by Matthias Plappert on 26.10.09.
//  Copyright 2009 phapswebsolutions. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@class Test;

@interface AppController : NSObject {
	Test *test;
}

- (IBAction)writeTestUserDefaults:(id)sender;
- (IBAction)readTestUserDefaults:(id)sender;

@end
