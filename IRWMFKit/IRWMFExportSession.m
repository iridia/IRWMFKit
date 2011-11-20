//
//  IRWMFExportSession.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/20/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFExportSession.h"

@implementation IRWMFExportSession

@synthesize context;

- (void) dealloc {

	if (context)
		CFRelease(context);
	
	[super dealloc];

}

@end
