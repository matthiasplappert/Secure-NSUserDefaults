# About
SecureUserDefaults allows you to make your user defaults save. This means that no one but your application can modify your user defaults. This may be useful if you store information that only should not be modified but is uncritical if any can see it. So SecureUserDefaults can be considered to be something between normal user defaults and the Keychain (which might be overkill for some simple tasks).

# How it works
SecureUserDefaults is super easy to use. It simply adds a category to NSUserDefaults. You can now read and write user defaults as you always did. You simply have to append "secured" as a prefix to the already existing methods for reading and writing user defaults. For example - (void)setObject:(id)object forKey:(NSString *)key will be - (void)setSecuredObject:(id)object forKey:(NSString *)key. That's it.

# Installation
## Step 1
Simply add all files located in the Classes directory to your project and to a build target. Now include NSUserDefaults+PWSecuredUserDefaults.h where you need secure user defaults.

## Step 2
SecureUserDefaults uses a secret to hash your defaults. You must provide that secret by calling [NSUserDefaults setSecret:@"YourSecret"];. You only have to do this once, NSUserDefaults will remember your secret everywhere it is used. Make sure that you do not try to read or write secured user defaults without a secret which will make the system really weak. It is a good idea to set your secret as soon as your application did load. Also make sure that no one can access your secret, it isn't a good idea to save it in your Info.plist or something similar. Just write it directly into your code.

# Requirements
SecureUserDefaults works on Mac OS X and iPhone OS. It only requires Foundation framework.

# Examples
SecureUserDefaults comes with two examples. One runs on iPhone OS 3.0 or higher, the other one on Mac OS 10.5 or higher. Both read and write secure data. Have a look at them if you are not sure how to implement SecureUserDefaults. You can also try out what happens if you manipulate user defaults. If you are using Mac OS X simply go to ~/Library/Preferences and open de.phaps.secureuserdefaults.plist. Now modify an entry and try to read. If you undo your changes everything should work again.

# License
SecureUserDefaults is licensed under MIT License. If you use SecureUserDefaults I would really appreciate to hear from you.

## MIT License
Copyright (c) 2009 Matthias Plappert <mplappert@phaps.de>

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions: The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

HE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.