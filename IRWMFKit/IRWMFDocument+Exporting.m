//
//  IRWMFDocument+Exporting.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/20/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFDocument+Exporting.h"
#import "IRWMFExportSession.h"
#import "IRWMFRecord.h"
#import "IRWMFRecordExporting.h"

@implementation IRWMFDocument (Exporting)

- (CGImageRef) fullResolutionImage {

	//	CGContextRef context = cgcontext
	
	IRWMFExportSession *exportSession = [[[IRWMFExportSession alloc] init] autorelease];
	
	[self.wmfRecords enumerateObjectsUsingBlock: ^ (IRWMFRecord *aRecord, NSUInteger idx, BOOL *stop) {
	
		if (![aRecord conformsToProtocol:@protocol(IRWMFRecordExporting)]) {
			NSLog(@"Error: WMF Record %@ does not conform to IRWMFRecordExporting.  Exporting will now fail.", aRecord);
			*stop = YES;
			return;
		}
		
		[((IRWMFRecord<IRWMFRecordExporting> *)aRecord) configureSessionForExporting:exportSession];
		
	}];
	
	return [exportSession fullResolutionImage];

};

@end
