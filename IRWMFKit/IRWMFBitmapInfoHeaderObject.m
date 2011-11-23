//
//  IRWMFBitmapInfoHeaderObject.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFBitmapInfoHeaderObject.h"

#define BYTES_PER_DWORD 4

@implementation IRWMFBitmapInfoHeaderObject

@synthesize width;
@synthesize height;
@synthesize numberOfPlanes;
@synthesize bitCount;
@synthesize compression;
@synthesize imageSize;
@synthesize horizontalPPM;
@synthesize verticalPPM;
@synthesize numberOfColors;
@synthesize numberOfRequiredColors;

@synthesize redColorMask;
@synthesize greenColorMask;
@synthesize blueColorMask;
@synthesize alphaColorMask;
@synthesize colorSpace;
@synthesize chromaticityEndpoints;
@synthesize redGamma;
@synthesize greenGamma;
@synthesize blueGamma;

@synthesize renderingIntent;
@synthesize colorProfileData;
@synthesize colorProfileSize;

- (void) configureWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	NSUInteger ownOffset = offsetBytes;
	const void * dataBytes = [data bytes];
	
	int32_t headerSize = OSReadLittleInt32(dataBytes, ownOffset);
	ownOffset += 4;
	
	width = OSReadLittleInt32(dataBytes, ownOffset);
	ownOffset += 4;
	
	height = OSReadLittleInt32(dataBytes, ownOffset);
	ownOffset += 4;
	
	numberOfPlanes = OSReadLittleInt16(dataBytes, ownOffset);
	ownOffset += 2;
	
	bitCount = OSReadLittleInt16(dataBytes, ownOffset);
	ownOffset += 2;
	
	if ((ownOffset - offsetBytes) == headerSize) {
		if (numberOfConsumedBytes) {
			*numberOfConsumedBytes = ownOffset - offsetBytes;
		}
		return;
	}
	
	//	Information exists beyond BitmapCoreHeader object bounds
	
	compression = OSReadLittleInt32(dataBytes, ownOffset);
	ownOffset += 4;
	
	imageSize = OSReadLittleInt32(dataBytes, ownOffset);
	ownOffset += 4;
	
	horizontalPPM = OSReadLittleInt32(dataBytes, ownOffset);
	ownOffset += 4;
	
	verticalPPM = OSReadLittleInt32(dataBytes, ownOffset);
	ownOffset += 4;
	
	numberOfColors = OSReadLittleInt32(dataBytes, ownOffset);
	ownOffset += 4;
	
	numberOfRequiredColors = OSReadLittleInt32(dataBytes, ownOffset);
	ownOffset += 4;
	
	if ((ownOffset - offsetBytes) == headerSize) {
		if (numberOfConsumedBytes) {
			*numberOfConsumedBytes = ownOffset - offsetBytes;
		}
		return;
	}
	
	//	Information exists beyond BitmapV4Header object bounds
	return;
	
	if (numberOfConsumedBytes) {
		*numberOfConsumedBytes = ownOffset - offsetBytes;
	}

}

@end
