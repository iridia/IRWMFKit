//
//  IRWMFBitMapStretchBiltRecord.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFBitMapStretchBiltRecord.h"
#import "IRWMFExportSession.h"

#define BYTES_PER_DWORD 2

@implementation IRWMFBitMapStretchBiltRecord

@synthesize rasterOperation;
@synthesize sourceRectHeight, sourceRectWidth, sourceRectYOffset, sourceRectXOffset;
@synthesize destinationRectHeight, destinationRectWidth, destinationRectYOffset, destinationRectXOffset;
@synthesize bitmapObject;

- (void) dealloc {

	[bitmapObject release];
	[super dealloc];

}

- (void) configureWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	NSUInteger ownOffset = offsetBytes;
	const void *dataBytes = [data bytes];
	
	int32_t recordSize = OSReadLittleInt32(dataBytes, ownOffset) * BYTES_PER_DWORD;
	ownOffset += 4;
	
	int32_t recordFunction = OSReadLittleInt16(dataBytes, ownOffset);
	ownOffset += 2;
	
	//	ummm	
	BOOL recordHasEmbeddedBitmap = (recordSize != ((recordFunction >> 8) + 3));
	
	if (recordHasEmbeddedBitmap) {
	
		rasterOperation = OSReadLittleInt32(dataBytes, ownOffset);
		ownOffset += 4;
		
		sourceRectHeight = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		sourceRectWidth = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		sourceRectYOffset = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		sourceRectXOffset = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		destinationRectHeight = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		destinationRectWidth = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		destinationRectYOffset = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		destinationRectXOffset = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		NSLog(@"TBD: Read DIB Object at offset %i with probable length of %i", ownOffset, recordSize - ownOffset);
	
	} else {
		
		sourceRectYOffset = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		sourceRectXOffset = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
	
		//	RESERVED
		ownOffset += 2;
		
		destinationRectHeight = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		destinationRectWidth = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
				
		destinationRectYOffset = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
		
		destinationRectXOffset = OSReadLittleInt16(dataBytes, ownOffset);
		ownOffset += 2;
	
	}
	
	if (numberOfConsumedBytes)
		*numberOfConsumedBytes = recordSize;

}

+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType {

	return (aType == IRWMFRecordType_META_DIBSTRETCHBLT);

}

- (void) configureSessionForExporting:(IRWMFExportSession *)aSession {
	
	//	Fill aSession.context ONE BY ONE (SLOW)
	
	if (!self.bitmapObject)
		return;

}

@end
