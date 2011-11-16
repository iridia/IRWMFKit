//
//  IRWMFRecord.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/17/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFRecord.h"
#import "IRWMFDefines.h"

#import <libkern/OSByteOrder.h>

@implementation IRWMFRecord

+ (id) objectWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	if (offsetBytes == 0) {
		return [IRWMFHeaderRecord objectWithData:data offset:offsetBytes usedBytes:numberOfConsumedBytes error:error];
	}
	
	IRWMFRecord *returnedRecord = [[[self alloc] init] autorelease];
	NSUInteger ownOffset = 0;
	
	const void *dataBytes = [data bytes];
	int32_t objectSize = OSReadLittleInt32(dataBytes, offsetBytes + ownOffset);
	objectSize *= 2;	//	object size is in DWORDS, 1 DWORD = 2 BYTES
	ownOffset += 4;
	//	NSLog(@"objectSize %i", objectSize);
	
	IRWMFRecordType objectType = OSReadLittleInt16(dataBytes, offsetBytes + ownOffset);
	ownOffset += 2;
	
	//	[self readRecordPayloadFromData:data offset:(offsetBytes + ownOffset) usedBytes:&payloadLength];
	
	*numberOfConsumedBytes = objectSize;
	
	return returnedRecord;

}

@end
 