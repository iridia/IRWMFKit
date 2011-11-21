//
//  IRWMFExportSession.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/20/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFExportSession.h"

@implementation IRWMFExportSession

@synthesize context, contentRect;

- (id) init {

	self = [super init];
	if (!self)
		return nil;
		
	contentRect = CGRectNull;
	
	return self;

}

- (CGContextRef) context {

	if (context)
		return context;
	
	NSLog(@"%s Creating context using content rect { %f, %f; %f, %f }", __PRETTY_FUNCTION__, contentRect.origin.x, contentRect.origin.y, contentRect.size.width, contentRect.size.height);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	context = CGBitmapContextCreate(NULL, contentRect.size.width, contentRect.size.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
	CGColorSpaceRelease(colorSpace);
	
	return context;

}

- (void) dealloc {

	if (context)
		CFRelease(context);
	
	[super dealloc];

}

@end
