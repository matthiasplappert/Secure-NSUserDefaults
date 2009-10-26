//
//  NSUserDefaults+PWSecuredUserDefaults.m
//  SecureUserDefaults
//
//  Created by Matthias Plappert on 25.10.09.
//  Copyright 2009 phapswebsolutions. All rights reserved.
//

#import "NSUserDefaults+PWSecuredUserDefaults.h"
#import "NSString+PWSecuredUserDefaults.h"

@implementation NSUserDefaults (PWSecuredUserDefaults)

static NSString *_secret;

+ (void)setSecret:(NSString *)secret
{
	[_secret release];
	_secret = [secret copy];
}

#pragma mark -
#pragma mark Read accessors

- (NSArray *)securedArrayForKey:(NSString *)key
{
	id object = [self validateValueForKey:key];
	
	// Check if everything is all right
	NSAssert1(object != nil, @"Secured NSUserDefaults entry for key %@ is corrupted.", key);
	return object;
}

- (BOOL)securedBoolForKey:(NSString *)key
{
	id object = [self validateValueForKey:key];
	
	// Check if everything is all right
	NSAssert1(object != nil, @"Secured NSUserDefaults entry for key %@ is corrupted.", key);
	return [object boolValue];
}

- (NSData *)securedDataForKey:(NSString *)key
{
	id object = [self validateValueForKey:key];
	
	// Check if everything is all right
	NSAssert1(object != nil, @"Secured NSUserDefaults entry for key %@ is corrupted.", key);
	return object;
}

- (NSDictionary *)securedDictionaryForKey:(NSString *)key
{
	id object = [self validateValueForKey:key];
	
	// Check if everything is all right
	NSAssert1(object != nil, @"Secured NSUserDefaults entry for key %@ is corrupted.", key);
	return object;
}

- (float)securedFloatForKey:(NSString *)key
{
	id object = [self validateValueForKey:key];
	
	// Check if everything is all right
	NSAssert1(object != nil, @"Secured NSUserDefaults entry for key %@ is corrupted.", key);
	return [object floatValue];
}

- (NSInteger)securedIntegerForKey:(NSString *)key
{
	id object = [self validateValueForKey:key];
	
	// Check if everything is all right
	NSAssert1(object != nil, @"Secured NSUserDefaults entry for key %@ is corrupted.", key);
	return [object intValue];
}

- (id)securedObjectForKey:(NSString *)key
{
	id object = [self validateValueForKey:key];
	
	// Check if everything is all right
	NSAssert1(object != nil, @"Secured NSUserDefaults entry for key %@ is corrupted.", key);
	return object;
}

- (NSArray *)securedStringArrayForKey:(NSString *)key
{
	id object = [self validateValueForKey:key];
	
	// Check if everything is all right
	NSAssert1(object != nil, @"Secured NSUserDefaults entry for key %@ is corrupted.", key);
	return object;
}

- (NSString *)securedStringForKey:(NSString *)key
{
	id object = [self validateValueForKey:key];
	
	// Check if everything is all right
	NSAssert1(object != nil, @"Secured NSUserDefaults entry for key %@ is corrupted.", key);
	return object;
}

- (double)securedDoubleForKey:(NSString *)key
{
	id object = [self validateValueForKey:key];
	
	// Check if everything is all right
	NSAssert1(object != nil, @"Secured NSUserDefaults entry for key %@ is corrupted.", key);
	return [object doubleValue];
}

#pragma mark -
#pragma mark Write accessors

- (void)setSecuredBool:(BOOL)value forKey:(NSString *)key
{
	NSNumber *objectRepresentation = [NSNumber numberWithBool:value];
	[self setSecuredObject:objectRepresentation forKey:key];
}

- (void)setSecuredFloat:(float)value forKey:(NSString *)key
{
	NSNumber *objectRepresentation = [NSNumber numberWithFloat:value];
	[self setSecuredObject:objectRepresentation forKey:key];
}

- (void)setSecuredInteger:(NSInteger)value forKey:(NSString *)key
{
	NSNumber *objectRepresentation = [NSNumber numberWithInt:value];
	[self setSecuredObject:objectRepresentation forKey:key];
}

- (void)setSecuredObject:(id)value forKey:(NSString *)key
{
	NSString *hash = [self generateHashableStringFromObject:value];
	NSString *finalHash = [[NSString stringWithFormat:@"%@%@", hash, _secret] md5Hash];
	NSDictionary *data = [NSDictionary dictionaryWithObjectsAndKeys:finalHash, @"hash", value, @"value", nil];
	[self setObject:data forKey:key];
}

- (void)setSecuredDouble:(double)value forKey:(NSString *)key
{
	NSNumber *objectRepresentation = [NSNumber numberWithDouble:value];
	[self setSecuredObject:objectRepresentation forKey:key];
}

#pragma mark -
#pragma mark Utility methods (mainly for internal usage)

- (NSString *)generateHashableStringFromObject:(id)object
{
	if ([object isKindOfClass:[NSData class]]) {
		// Data
		return [NSString stringWithFormat:@"%@", object];
	} else if ([object isKindOfClass:[NSString class]]) {
		// String
		return [NSString stringWithFormat:@"%@", object];
	} else if ([object isKindOfClass:[NSNumber class]]) {
		// Number
		return [NSString stringWithFormat:@"%@", object];
	} else if ([object isKindOfClass:[NSDate class]]) {
		// Date
		return [NSString stringWithFormat:@"%@", object];
	} else if ([object isKindOfClass:[NSArray class]]) {
		// Array
		NSMutableString *hash = [NSMutableString stringWithString:@"array"];
		for (int i = 0; i < [object count]; i++) {
			[hash appendFormat:@"%d%@", i, [self generateHashableStringFromObject:[object objectAtIndex:i]]];
		}
		return hash;
	} else if ([object isKindOfClass:[NSDictionary class]]) {
		// Dictionary
		NSMutableString *hash = [NSMutableString stringWithString:@"dictionary"];
		
		// Add hashes to a dictionary. We will sort them because NSDictionaries are not sorted.
		NSMutableArray *hashes = [NSMutableArray array];
		for (NSString *key in object) {
			[hashes addObject:[NSString stringWithFormat:@"%@%@", key, [self generateHashableStringFromObject:[object objectForKey:key]]]];
		}
		
		// Now sort hashes...
		[hashes sortUsingSelector:@selector(compare:)];
		
		// and transform them into one string
		for (int i = 0; i < [hashes count]; i++) {
			[hash appendString:[hashes objectAtIndex:i]];
		}
		
		return hash;
	} else {
		// Everything else
		NSAssert1(NO, @"Unsupported object: %@", object);
		return nil;
	}
}

- (id)validateValueForKey:(NSString *)key
{
	NSDictionary *data = [self dictionaryForKey:key];
	if (data != nil) {
		id value = [data objectForKey:@"value"];
		NSString *hash = [data objectForKey:@"hash"];
		
		NSString *checkHash = [[NSString stringWithFormat:@"%@%@", [self generateHashableStringFromObject:value], _secret] md5Hash];
		if ([checkHash isEqualToString:hash]) {
			return value;
		} else {
			return nil;
		}
	} else {
		return nil;
	}
}

@end
