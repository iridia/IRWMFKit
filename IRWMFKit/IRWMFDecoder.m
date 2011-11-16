//
//  IRWMFDecoder.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/17/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFDecoder.h"
#import "IRWMFRecord.h"
#import "IRWMFDocument.h"

@implementation IRWMFDecoder

+ (id) sharedDecoder {

	static dispatch_once_t onceToken = 0;
	static id instance = nil;
	dispatch_once(&onceToken, ^{
			instance = [[self alloc] init];
	});
	
	return instance;

}

- (IRWMFDocument *) documentWithData:(NSData *)data {

	return [self documentWithData:data error:nil];

}

- (IRWMFDocument *) documentWithData:(NSData *)data error:(NSError **)error {
	
	if (![data length])
		return nil;
	
	NSUInteger totalBytes = [data length];
	NSUInteger consumedBytes = 0;
	
	NSUInteger currentRecordSize = 0;
	NSError *currentRecordDecodingError = nil;
	
	IRWMFDocument *document = [[[IRWMFDocument alloc] init] autorelease];
	
	while (consumedBytes < totalBytes) {
	
		IRWMFRecord *currentRecord = [IRWMFRecord objectWithData:data offset:consumedBytes usedBytes:&currentRecordSize error:&currentRecordDecodingError];
		
		if (!currentRecord) {
			NSLog(@"Error decoding: %@", currentRecordDecodingError);
			if (error) {
				error = &currentRecordDecodingError;
			}
			return nil;
		}
		
		consumedBytes += currentRecordSize;
		
		if (!currentRecordSize) {
			NSLog(@"Found zero-length record: bail.");
			return nil;
		}
	
	}
	
	return document;

}

@end
