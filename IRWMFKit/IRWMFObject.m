//
//  IRWMFObject.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/17/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFObject.h"

@implementation IRWMFObject

+ (id) objectWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	IRWMFObject *returnedObject = [[[self alloc] init] autorelease];
	[returnedObject configureWithData:data offset:offsetBytes usedBytes:numberOfConsumedBytes error:&configurationError];
	
	return returnedObject;

}

- (void) configureWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	//	nothing

}

@end
