//
//  IRWMFKitTest.m
//  IRWMFKitTest
//
//  Created by Evadne Wu on 11/19/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFKitTest.h"
#import "IRWMFKit.h"

#import "IRWMFDocument+Exporting.h"

@implementation IRWMFKitTest

- (IRWMFDocument *) newTestDocument {

	NSBundle *ownBundle = [NSBundle bundleForClass:[self class]];
	NSString *imagePath = [ownBundle pathForResource:@"IRWMFKitTest-Word-RTF-Embedded" ofType:@"wmf"];
	STAssertNotNil(imagePath, @"Test image must exist.");
	
	IRWMFDocument *document = [IRWMFDocument documentWithData:[NSData dataWithContentsOfMappedFile:imagePath]];
	STAssertNotNil(document, @"Document must exist.");
	
	return [document retain];

}

- (void) testDocumentDecoding {

	IRWMFDocument *document = [[self newTestDocument] autorelease];
	NSArray *documentWMFRecords = document.wmfRecords;
	NSLog(@"documentWMFRecords %@", documentWMFRecords);
	STAssertNotNil(document.wmfRecords, @"Document should decode with WMF records.");

}

- (void) testExporting {

	IRWMFDocument *document = [[self newTestDocument] autorelease];
	
	CGImageRef fullResolutionImage = [document newFullResolutionImage];
	STAssertNotNil((id)fullResolutionImage, @"Document should export.");
	
	if (fullResolutionImage)
		CFRelease(fullResolutionImage);

}

@end
