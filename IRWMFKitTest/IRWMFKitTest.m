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

- (NSData *) pngDataForImage:(CGImageRef)anImage {

	NSMutableData *pngData = [NSMutableData data];
	
	CGImageDestinationRef pngDestination = CGImageDestinationCreateWithData((CFMutableDataRef)pngData, kUTTypePNG, 1, NULL);
	CGImageDestinationAddImage(pngDestination, anImage, NULL);
	CGImageDestinationFinalize(pngDestination);
	
	if (pngDestination)
		CFRelease(pngDestination);
	
	return pngData;

}

- (NSString *) exportedFilePathForData:(NSData *)data {

	NSString *fileName = [[NSString stringWithFormat:@"Image Exported %@", [[NSDate date] description]] stringByAppendingPathExtension:@"png"];
	NSString *filePath = [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject] stringByAppendingPathComponent:fileName];
	[[NSFileManager defaultManager] createDirectoryAtPath:[filePath stringByDeletingLastPathComponent] withIntermediateDirectories:YES attributes:nil error:nil];
	
	if ([data writeToFile:filePath atomically:NO])
		return filePath;
	
	return nil;

}

- (IRWMFDocument *) newTestDocument {

	return [self newTestDocumentForFileNamed:@"IRWMFKitTest-WordPad-RTF-Embedded"];

}

- (IRWMFDocument *) newTestDocumentForFileNamed:(NSString *)aFileName {

	NSBundle *ownBundle = [NSBundle bundleForClass:[self class]];
	NSString *imagePath = [ownBundle pathForResource:aFileName ofType:@"wmf"];
	STAssertNotNil(imagePath, @"Test image must exist.");
	
	IRWMFDocument *document = [IRWMFDocument documentWithData:[NSData dataWithContentsOfMappedFile:imagePath]];
	STAssertNotNil(document, @"Document must exist.");
	
	return [document retain];

}

- (void) testDocumentDecoding {

	IRWMFDocument *document = [[self newTestDocument] autorelease];
	STAssertNotNil(document.wmfRecords, @"Document should decode with WMF records.");

}

- (void) testExporting {

	IRWMFDocument *document = [[self newTestDocument] autorelease];
	
	CGImageRef fullResolutionImage = [document newFullResolutionImage];
	STAssertNotNil((id)fullResolutionImage, @"Document should export.");
	
	if (fullResolutionImage)
		CFRelease(fullResolutionImage);
	
}

- (void) testBitmapExtraction {

	IRWMFDocument *document = [[self newTestDocument] autorelease];
	NSArray *bitmaps = [document copyEmbeddedImages];
	
	STAssertTrue(([bitmaps count] == 1), @"Number of embedded images in document should be 1");
	
}

@end
