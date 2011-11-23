//
//  IRWMFBitmapObject.m
//  IRWMFKit
//
//  Created by Evadne Wu on 11/23/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFBitmapObject.h"
#import "IRWMFBitmapInfoHeaderObject.h"

@implementation IRWMFBitmapObject
@synthesize infoHeader, image;

- (void) dealloc {

	[infoHeader release];
	
	if (image)
		CFRelease(image);
	
	[super dealloc];

}

- (void) configureWithData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error {

	NSUInteger ownOffset = offsetBytes;
	const void * dataBytes = [data bytes];
	
	//	Read a header first
	
	NSUInteger headerLength = 0;
	NSError *headerReadingError = nil;
	infoHeader = [[IRWMFBitmapInfoHeaderObject objectWithData:data offset:ownOffset usedBytes:&headerLength error:&headerReadingError] retain];
	ownOffset += headerLength;
	
	if (!infoHeader) {
		NSLog(@"Error reading header: %@", headerReadingError);
		return;
	}
	
	NSLog(@"INFO HEADER now %@", infoHeader);
	
	CGColorSpaceRef colorSpace = CGColorSpaceCreateDeviceRGB();
	CGContextRef context = CGBitmapContextCreate(NULL, infoHeader.width, infoHeader.height, 8, 0, colorSpace, kCGImageAlphaPremultipliedLast);
	CGContextSetFillColorSpace(context, colorSpace);
	CGColorSpaceRelease(colorSpace);
	
	//	Handle Possible Color Table and decode the bitmap information
	
	switch (infoHeader.bitCount) {
	
		case IRWMFCompressedImageBitCount: {
		
			//	Compressed
		
			switch (infoHeader.compression) {

				case IRWMFCompression_BI_PNG: {
					CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, (dataBytes + headerLength), infoHeader.imageSize, NULL);
					image = CGImageCreateWithPNGDataProvider(dataProvider, NULL, YES, kCGRenderingIntentDefault);
					break;
				}
				
				case IRWMFCompression_BI_JPEG: {
					CGDataProviderRef dataProvider = CGDataProviderCreateWithData(NULL, (dataBytes + headerLength), infoHeader.imageSize, NULL);
					image = CGImageCreateWithJPEGDataProvider(dataProvider, NULL, YES, kCGRenderingIntentDefault);
					break;
				}

				default: {
					//	Compressed bitcount field must internally use PNG / JPEG
					NSParameterAssert(NO);
					break;
				}
				
			}
		
			break;
			
		}
		
		case IRWMF16MillionPaletteColorsBitCount: {
		
			//	The colors table is not important at all here
			
			ownOffset += 4 * infoHeader.numberOfColors;
			
			for (unsigned int offsetY = 0; offsetY < infoHeader.height; offsetY++)
			for (unsigned int offsetX = 0; offsetX < infoHeader.width; offsetX++) {
			
				uint8_t blueIntensity = ((uint8_t *)dataBytes)[ownOffset];
				uint8_t greenIntensity = ((uint8_t *)dataBytes)[ownOffset + 1];
				uint8_t redIntensity = ((uint8_t *)dataBytes)[ownOffset + 2];
			
				CGFloat colorTuple[4] = {
					((float_t)redIntensity / 256.0f),
					((float_t)greenIntensity / 256.0f),
					((float_t)blueIntensity / 256.0f),
					1.0f // alpha
				};
				
				ownOffset += 3;
				
				CGContextSetFillColor(context, colorTuple);
				CGContextFillRect(context, (CGRect){ (CGPoint){ offsetX, offsetY }, (CGSize){ 1, 1 }});
			
			}
			
			break;
			
		}
		
		default: {
			NSLog(@"Bit count %x not handled", infoHeader.bitCount);
			break;
		}

	}
	
	if (context && !image) {
		image = CGBitmapContextCreateImage(context);
	}
	
	if (numberOfConsumedBytes)
		*numberOfConsumedBytes = (ownOffset - offsetBytes);

}

@end
