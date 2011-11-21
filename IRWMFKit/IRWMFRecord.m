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
	
@class IRWMFRecord;
@class IRWMFHeaderRecord;
@class IRWMFSetMapModeRecord;

static void __attribute__((constructor)) initialize() {
	
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	[IRWMFRecord setClass:NSClassFromString(@"IRWMFHeaderRecord") forRecordType:IRWMFRecordHeaderType];
	[IRWMFRecord setClass:NSClassFromString(@"IRWMFSetMapModeRecord") forRecordType:IRWMFRecordType_META_SETMAPMODE];
	[IRWMFRecord setClass:NSClassFromString(@"IRWMFSetWindowOriginRecord") forRecordType:IRWMFRecordType_META_SETWINDOWORG];
	[IRWMFRecord setClass:NSClassFromString(@"IRWMFSetWindowExtentRecord") forRecordType:IRWMFRecordType_META_SETWINDOWEXT];
	[IRWMFRecord setClass:NSClassFromString(@"IRWMFSaveDeviceContextRecord") forRecordType:IRWMFRecordType_META_SAVEDC];
	[IRWMFRecord setClass:NSClassFromString(@"IRWMFSetStretchBiltRecord") forRecordType:IRWMFRecordType_META_SETSTRETCHBLTMODE];
	[IRWMFRecord setClass:NSClassFromString(@"IRWMFBitMapStretchBiltRecord") forRecordType:IRWMFRecordType_META_DIBSTRETCHBLT];
	[IRWMFRecord setClass:NSClassFromString(@"IRWMFRestoreDeviceContextRecord") forRecordType:IRWMFRecordType_META_RESTOREDC];

	[pool drain];	
}


@interface IRWMFRecord () <IRWMFRecordExporting>

@end


@implementation IRWMFRecord

@synthesize recordType;
@synthesize objectSize;

+ (id) objectWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	IRWMFRecordType inferredRecordType = [self recordTypeFromData:data atByteOffset:offsetBytes];
	Class usedClass = [self classForRecordType:inferredRecordType];
	NSLog(@"currently inferred type is %i, record class is %@", inferredRecordType, usedClass);
	
	if (!usedClass) {
		usedClass = [IRWMFRecord class];
		NSLog(@"using IRWMFRecord as intended class");
	}
	
	IRWMFRecord *returnedRecord = [[(IRWMFRecord *)[usedClass alloc] init] autorelease];
	[returnedRecord configureWithData:data offset:offsetBytes usedBytes:numberOfConsumedBytes error:error];
	
	return returnedRecord;

}

- (void) configureWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	NSUInteger ownOffset = 0;
	
	const void *dataBytes = [data bytes];
	objectSize = OSReadLittleInt32(dataBytes, offsetBytes + ownOffset) * BYTES_PER_DWORD;
	ownOffset += 4;
	
	//	WIP Maybe do sanity check here
	
	recordType = OSReadLittleInt16(dataBytes, offsetBytes + ownOffset);
	ownOffset += 2;
	
	[self configureWithBytes:dataBytes withPayloadAtOffset:(offsetBytes + ownOffset)];
	
	if (numberOfConsumedBytes)
		*numberOfConsumedBytes = objectSize;

}

- (void) configureWithBytes:(const void *)dataBytes withPayloadAtOffset:(NSUInteger)offsetBytes {

	//	Root implementation is a no-op

}

- (NSString *) description {

	NSString *descriptionRootString = [NSString stringWithFormat:@"<%@: 0x%X", NSStringFromClass([self class]), (unsigned int)self];
	NSString *descriptionSubstring = [self descriptionSubstring];
	
	if (!descriptionSubstring)
		return [descriptionRootString stringByAppendingString:@">"];
	
	return [descriptionRootString stringByAppendingFormat:
		@"; %@>",
		descriptionSubstring
	];

}

- (NSString *) descriptionSubstring {
	
	return [NSString stringWithFormat:	
		@"Record Type = %@; Declared Size = %i",
		IRWMFRecordTypeNames[recordType], objectSize
	];

}

+ (IRWMFRecordType) recordTypeFromData:(NSData *)incomingData atByteOffset:(NSUInteger)offsetBytes {

	if (offsetBytes == 0)
		return IRWMFRecordHeaderType;

	NSParameterAssert([incomingData length] >= (offsetBytes + 4 + 2));
	
	return OSReadLittleInt16([incomingData bytes], offsetBytes + 4);

}


+ (CFMutableDictionaryRef) recordTypesToHandlerClasses { 

	static CFMutableDictionaryRef registry = nil;
	
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
	
		CFDictionaryKeyCallBacks keyCallbacks = (CFDictionaryKeyCallBacks) { 0, NULL, NULL, NULL, NULL, NULL };
		registry = CFDictionaryCreateMutable(NULL, 0, &keyCallbacks, NULL);
					
	});
	
	return registry;

}

+ (void) setClass:(Class)aClass forRecordType:(IRWMFRecordType)aType {

	NSParameterAssert(aClass);
	NSParameterAssert([aClass canHandleRecordType:aType]);
	
	CFDictionarySetValue([self recordTypesToHandlerClasses], (void *)aType, aClass);

}

+ (Class) classForRecordType:(IRWMFRecordType)aType {

	return CFDictionaryGetValue([self recordTypesToHandlerClasses], (void *)aType);

}

+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType {

	return YES;

}

- (void) configureSessionForExporting:(IRWMFExportSession *)aSession {

	//	Base class, no op

}

@end
