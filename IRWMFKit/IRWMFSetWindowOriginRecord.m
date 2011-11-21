//
//  IRWMFSetWindowOriginRecord.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFSetWindowOriginRecord.h"
#import "IRWMFExportSession.h"

@implementation IRWMFSetWindowOriginRecord

@synthesize xOffset, yOffset;

- (void) configureWithBytes:(const void *)dataBytes withPayloadAtOffset:(NSUInteger)offsetBytes {

	NSUInteger ownOffset = 0;
	
	xOffset = OSReadLittleInt16(dataBytes, offsetBytes + ownOffset);
	ownOffset += 2;
	
	yOffset = OSReadLittleInt16(dataBytes, offsetBytes + ownOffset);
	ownOffset += 2;
	
}

- (NSString *) descriptionSubstring {

	return [[super descriptionSubstring] stringByAppendingString:[NSString stringWithFormat:	
		@"; X Offset = %i, Y Offset = %i",
		xOffset, yOffset
	]];

}

+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType {

	return (aType == IRWMFRecordType_META_SETWINDOWORG);

}

- (void) configureSessionForExporting:(IRWMFExportSession *)aSession {

	aSession.contentRect = (CGRect){
		(CGPoint){ xOffset, yOffset },
		aSession.contentRect.size
	};

}

@end
