//
//  IRWMFDocument.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/14/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFDocument.h"

@interface IRWMFDocument ()
@property (nonatomic, readwrite, retain) NSData *data;
@property (nonatomic, readwrite, retain) NSArray *wmfObjects;
@property (nonatomic, readwrite, retain) NSArray *wmfRecords;
@end

@implementation IRWMFDocument
@synthesize data, wmfObjects, wmfRecords;

+ (id) documentWithData:(NSData *)data {

	return [[[self alloc] initWithData:data] autorelease];

}

- (id) initWithData:(NSData *)inData {

	self = [super init];
	if (!self)
		return nil;
	
	self.data = inData;
	
	return self;

}

- (CGImageRef) fullResolutionImage {

	return nil;

}

- (void) dealloc {

	[data release];
	[wmfObjects release];
	[wmfRecords release];
	[super dealloc];

}

@end
