//
//  NSString+PWSecuredUserDefaults.h
//  ConnectionKit
//
//  Created by Matthias Plappert on 13.06.09.
//  Copyright 2009 phapswebsolutions. All rights reserved.
//

#import "NSString+PWSecuredUserDefaults.h"

@implementation NSString (PWSecuredUserDefaults)

- (NSString *)md5Hash
{
	// Source: http://miketeo.net/wp/index.php/2008/09/22/calculating-md5-digest-with-iphone-sdk.html
	
	const char *cStr = [self UTF8String];
	unsigned char result[CC_MD5_DIGEST_LENGTH];
	CC_MD5(cStr, strlen(cStr), result);
	
	return [[NSString stringWithFormat:@"%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X%02X", result[0], result[1], result[2], result[3], result[4],
																											result[5], result[6], result[7],
																											result[8], result[9], result[10], result[11], result[12],
																											result[13], result[14], result[15]] lowercaseString];
}

@end
