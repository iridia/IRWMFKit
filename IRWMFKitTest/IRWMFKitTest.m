//
//  IRWMFKitTest.m
//  IRWMFKitTest
//
//  Created by Evadne Wu on 11/19/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFKitTest.h"
#import "IRWMFKit.h"

@implementation IRWMFKitTest

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void) testDocumentDecoding {

	NSBundle *ownBundle = [NSBundle bundleForClass:[self class]];
	NSString *imagePath = [ownBundle pathForResource:@"IRWMFKitTest-Word-RTF-Embedded" ofType:@"wmf"];
	STAssertNotNil(imagePath, @"Test image must exist.");
	
	IRWMFDocument *document = [IRWMFDocument documentWithData:[NSData dataWithContentsOfMappedFile:imagePath]];
	STAssertNotNil(document, @"Document must exist.");
	
	NSLog(@"document records %@", document.wmfRecords);

}

@end
