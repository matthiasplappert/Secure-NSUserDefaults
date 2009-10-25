//
//  NSString+PWSecuredUserDefaults.h
//  ConnectionKit
//
//  Created by Matthias Plappert on 13.06.09.
//  Copyright 2009 phapswebsolutions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonDigest.h>

@interface NSString (PWSecuredUserDefaults)

- (NSString *)md5Hash;

@end
