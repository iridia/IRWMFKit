//
//  IRWMFRGBQuadObject.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/24/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFRGBQuadObject.h"

@implementation IRWMFRGBQuadObject

@synthesize red, green, blue;

- (void) configureWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	NSUInteger ownOffset = offsetBytes;
	const void * dataBytes = [data bytes];
	
	red = OSReadLittleInt16(dataBytes, ownOffset);
	ownOffset += 1;

	green = OSReadLittleInt16(dataBytes, ownOffset);
	ownOffset += 1;

	blue = OSReadLittleInt16(dataBytes, ownOffset);
	ownOffset += 1;
	
	//	Reserved byte
	ownOffset += 1;
	
	if (numberOfConsumedBytes)
		*numberOfConsumedBytes =  (ownOffset - offsetBytes);

}

@end
