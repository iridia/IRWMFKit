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

#import "IRWMFBitmapObject.h"

@implementation IRWMFDocument (Exporting)

- (CGImageRef) newFullResolutionImage {

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
	
	if (!exportSession.context) {
		NSLog(@"Export Session %@ does not even hold a context", exportSession);
		return (CGImageRef)nil;
	}
	
	CGImageRef image = CGBitmapContextCreateImage(exportSession.context);	
	return (CGImageRef)image;

};

- (NSArray *) copyEmbeddedImages {

	NSMutableArray *returnedArray = [[NSMutableArray array] retain];
	
	[self.wmfRecords enumerateObjectsUsingBlock: ^ (IRWMFRecord *aRecord, NSUInteger idx, BOOL *stop) {
	
		if (![aRecord respondsToSelector:@selector(bitmapObject)])
			return;
		
		IRWMFBitmapObject *bitmapObject = [aRecord performSelector:@selector(bitmapObject)];
		if (![bitmapObject isKindOfClass:[IRWMFBitmapObject class]])
			return;
		
		CGImageRef bitmapImage = [bitmapObject image];
		[returnedArray addObject:(id)bitmapImage];
		
	}];
	
	return returnedArray;

}

@end
