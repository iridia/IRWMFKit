//
//  IRWMFSetWindowExtentRecord.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFSetWindowExtentRecord.h"
#import "IRWMFExportSession.h"

@implementation IRWMFSetWindowExtentRecord

@synthesize xExtent, yExtent;

- (void) configureWithBytes:(const void *)dataBytes withPayloadAtOffset:(NSUInteger)offsetBytes {

	NSUInteger ownOffset = 0;
	
	yExtent = OSReadLittleInt16(dataBytes, offsetBytes + ownOffset);
	ownOffset += 2;
	
	xExtent = OSReadLittleInt16(dataBytes, offsetBytes + ownOffset);
	ownOffset += 2;
	
}

- (NSString *) descriptionSubstring {

	return [[super descriptionSubstring] stringByAppendingString:[NSString stringWithFormat:	
		@"; X Extent = %i, Y Extent = %i",
		xExtent, yExtent
	]];

}

+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType {

	return (aType == IRWMFRecordType_META_SETWINDOWEXT);

}

- (void) configureSessionForExporting:(IRWMFExportSession *)aSession {

	aSession.contentRect = (CGRect){
		aSession.contentRect.origin,
		(CGSize){ xExtent - 1, yExtent - 1 }
	};

}

@end
