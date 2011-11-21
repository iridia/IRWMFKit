//
//  IRWMFSetMapModeRecord.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFSetMapModeRecord.h"

@implementation IRWMFSetMapModeRecord

@synthesize mapMode;

- (void) configureWithBytes:(const void *)dataBytes withPayloadAtOffset:(NSUInteger)offsetBytes {

	NSUInteger ownOffset = 0;
	
	mapMode = OSReadLittleInt16(dataBytes, offsetBytes + ownOffset);
	ownOffset += 2;
	
}

- (NSString *) descriptionSubstring {

	return [[super descriptionSubstring] stringByAppendingString:[NSString stringWithFormat:	
		@"; Map Mode = %x",
		mapMode
	]];

}

+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType {

	return (aType == IRWMFRecordType_META_SETMAPMODE);

}

- (void) configureSessionForExporting:(IRWMFExportSession *)aSession {

	//	Nothing.

}

@end
