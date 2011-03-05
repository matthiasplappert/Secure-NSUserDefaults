# Secure NSUserDefaults
Secure NSUserDefaults allows you to protect your user defaults against unauthorized modifications on iOS and Mac OS X. You can also link user defaults to the machine they’ve been created on which makes plist sharing impossible. Please note that this implementation does **not** use encryption. It is therefore **not** suitable to store sensitive data.

## Usage
Add `NSUserDefaults+MPSecureUserDefaults.h` and `NSUserDefaults+MPSecureUserDefaults.m` to your project. Secure NSUserDefaults expects a secret to generate app-specific hashes. If you intend to link your user defaults to the machine they’ve been created on, you’ll also have to pass a unique device identifier. The included example illustrates how to retrieve that identifier on both platforms, iOS and Mac OS X.
    #import "NSUserDefaults+MPSecureUserDefaults.h"
    
    // ...
    
    // Configuring user defaults. It is recommended that you do this
    // immediately after the app did launch.
    [NSUserDefaults setSecret:@"shh, this is secret!"];

    // Write secure user defaults
	NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setSecureBool:YES forKey:@"IsRegistered"];
    
    // Read secure user defaults
    BOOL valid = NO;
    BOOL registered = [defaults secureBoolForKey:@"IsRegistered" valid:&valid];
    if (!valid) {
	    // the property has been modified, handle this situation
    } else {
	    // Valid property, do whatever you need to do
    }

## Notes
* Secure NSUserDefaults mimics the non-secure NSUserDefaults methods
* A key that doesn’t exist yet is considered valid
* Do not read your secret from any resource but write it directly into your code

## MIT License
Copyright (c) 2011 Matthias Plappert <matthiasplappert@me.com>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

HE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.