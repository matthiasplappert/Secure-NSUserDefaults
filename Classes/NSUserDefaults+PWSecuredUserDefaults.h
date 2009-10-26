//
//  NSUserDefaults+PWSecuredUserDefaults.h
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

#import <Foundation/Foundation.h>

@interface NSUserDefaults (PWSecuredUserDefaults)

/* Sets the secret. Make sure that your secret is stored in a save place, it is recommanded
   to write it directly into your code (see example). The secret is a required value.
 */
+ (void)setSecret:(NSString *)secret;

// Read data from user defaults. If the data is corrupted, an assertion is thrown.
- (NSArray *)securedArrayForKey:(NSString *)key;
- (BOOL)securedBoolForKey:(NSString *)key;
- (NSData *)securedDataForKey:(NSString *)key;
- (NSDictionary *)securedDictionaryForKey:(NSString *)key;
- (float)securedFloatForKey:(NSString *)key;
- (NSInteger)securedIntegerForKey:(NSString *)key;
- (id)securedObjectForKey:(NSString *)key;
- (NSArray *)securedStringArrayForKey:(NSString *)key;
- (NSString *)securedStringForKey:(NSString *)key;
- (double)securedDoubleForKey:(NSString *)key;

// Write data to user defaults.
- (void)setSecuredBool:(BOOL)value forKey:(NSString *)key;
- (void)setSecuredFloat:(float)value forKey:(NSString *)key;
- (void)setSecuredInteger:(NSInteger)value forKey:(NSString *)key;
- (void)setSecuredObject:(id)value forKey:(NSString *)key;
- (void)setSecuredDouble:(double)value forKey:(NSString *)key;

// Internal utility methods, you should not need to call them directely.
- (NSString *)generateHashableStringFromObject:(id)object;
- (id)validateValueForKey:(NSString *)key;

@end
