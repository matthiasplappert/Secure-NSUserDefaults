//
//  AppController.m
//  SecureUserDefaults
//
//  Created by Matthias Plappert on 26.10.09.
//  Copyright 2009 phapswebsolutions. All rights reserved.
//

#import "AppController.h"
#import "Test.h"

@implementation AppController

- (void)awakeFromNib
{
	test = [[Test alloc] init];
}

- (IBAction)writeTestUserDefaults:(id)sender
{
	[test write];
}

- (IBAction)readTestUserDefaults:(id)sender
{
	[test read];
}

@end
