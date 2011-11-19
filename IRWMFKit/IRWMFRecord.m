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

#define BYTES_PER_DWORD 2

@implementation IRWMFRecord

@synthesize recordType;

+ (id) objectWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	Class usedClass = [IRWMFRecord class];
	if (offsetBytes == 0) {
		usedClass = [IRWMFHeaderRecord class];
	}
	
	IRWMFRecord *returnedRecord = [[(IRWMFRecord *)[usedClass alloc] init] autorelease];
	[returnedRecord configureWithData:data offset:offsetBytes usedBytes:numberOfConsumedBytes error:error];
	
	return returnedRecord;

}

- (void) configureWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	NSUInteger ownOffset = 0;
	
	const void *dataBytes = [data bytes];
	int32_t objectSize = OSReadLittleInt32(dataBytes, offsetBytes + ownOffset) * BYTES_PER_DWORD;
	ownOffset += 4;
	
	//	WIP Maybe do sanity check here
	
	recordType = OSReadLittleInt16(dataBytes, offsetBytes + ownOffset);
	ownOffset += 2;
	
	NSLog(@"Found record type %x", recordType);
	//	Maybe mutate self->isa if subclasses don’t provide storage
	//	Otherwise, maybe else
	//	[self readRecordPayloadFromData:data offset:(offsetBytes + ownOffset) usedBytes:&payloadLength];
	
	if (numberOfConsumedBytes)
		*numberOfConsumedBytes = objectSize;

}

- (NSString *) description {

	return [[NSString stringWithFormat:@"<%@: 0x%X", NSStringFromClass([self class]), (unsigned int)self] stringByAppendingFormat:
		@"; Record Type = %x>",
		recordType
	];

}

@end





@interface IRWMFHeaderRecord ()

@property (nonatomic, readwrite, assign) int16_t metafileType;
@property (nonatomic, readwrite, assign) int16_t headerSize;
@property (nonatomic, readwrite, assign) int16_t headerVersion;
@property (nonatomic, readwrite, assign) int32_t fileSize;
@property (nonatomic, readwrite, assign) int16_t numberOfObjects;
@property (nonatomic, readwrite, assign) int32_t maxRecordSize;
@property (nonatomic, readwrite, assign) int16_t numberOfMembers;

@end


@implementation IRWMFHeaderRecord

@synthesize metafileType;
@synthesize headerSize;
@synthesize headerVersion;
@synthesize fileSize;
@synthesize numberOfObjects;
@synthesize maxRecordSize;
@synthesize numberOfMembers;

- (void) configureWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	NSParameterAssert(offsetBytes == 0);
		
	NSUInteger ownOffset = offsetBytes;
	const void *dataBytes = [data bytes];
	
	metafileType = OSReadLittleInt16(dataBytes, ownOffset);
	ownOffset += 2;
	
	headerSize = OSReadLittleInt16(dataBytes, ownOffset) * BYTES_PER_DWORD;
	ownOffset += 2;
	
	headerVersion = OSReadLittleInt16(dataBytes, ownOffset);
	ownOffset += 2;
	
	fileSize = OSReadLittleInt32(dataBytes, ownOffset) * BYTES_PER_DWORD;
	ownOffset += 4;
	
	numberOfObjects = OSReadLittleInt16(dataBytes, ownOffset);
	ownOffset += 2;
	
	maxRecordSize = OSReadLittleInt32(dataBytes, ownOffset) * BYTES_PER_DWORD;
	ownOffset += 4;
	
	numberOfMembers = OSReadLittleInt16(dataBytes, ownOffset);
	ownOffset += 2;
	
	if (numberOfConsumedBytes)
		*numberOfConsumedBytes = (ownOffset - offsetBytes);

}

- (NSString *) description {

	return [[NSString stringWithFormat:@"<%@: 0x%X", NSStringFromClass([self class]), (unsigned int)self] stringByAppendingFormat:
		@"; Record Type = %x; Metafile Type = %x; Header Size = %i; Header Version = %i; File Size = %i; Number of Objects = %i; Max Record Size = %i; Number of Members = %i>",
		self.recordType, metafileType, headerSize, headerVersion, fileSize, numberOfObjects, maxRecordSize, numberOfMembers
	];

}

@end