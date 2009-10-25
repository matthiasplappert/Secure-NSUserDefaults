//
//  NSUserDefaults+PWSecuredUserDefaults.h
//  SecureUserDefaults
//
//  Created by Matthias Plappert on 25.10.09.
//  Copyright 2009 phapswebsolutions. All rights reserved.
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
