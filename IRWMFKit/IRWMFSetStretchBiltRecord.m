//
//  IRWMFSetStretchBiltRecord.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFSetStretchBiltRecord.h"

@implementation IRWMFSetStretchBiltRecord

@synthesize stretchMode;

- (void) configureWithBytes:(const void *)dataBytes withPayloadAtOffset:(NSUInteger)offsetBytes {

	NSUInteger ownOffset = 0;
	
	stretchMode = OSReadLittleInt16(dataBytes, offsetBytes + ownOffset);
	ownOffset += 2;

}

- (NSString *) descriptionSubstring {

	return [[super descriptionSubstring] stringByAppendingString:[NSString stringWithFormat:	
		@"; Stretch Mode (Composition Mode?) = %x",
		stretchMode
	]];

}

+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType {

	return (aType == IRWMFRecordType_META_SETSTRETCHBLTMODE);

}

- (void) configureSessionForExporting:(IRWMFExportSession *)aSession {

	//	No op

}

@end
