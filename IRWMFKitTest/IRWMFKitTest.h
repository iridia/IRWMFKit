//
//  IRWMFKitTest.h
//  IRWMFKitTest
//
//  Created by Evadne Wu on 11/19/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import <SenTestingKit/SenTestingKit.h>
#import <ImageIO/ImageIO.h>
#import <MobileCoreServices/MobileCoreServices.h>

@class IRWMFDocument;
@interface IRWMFKitTest : SenTestCase

- (NSData *) pngDataForImage:(CGImageRef)anImage;
- (NSString *) exportedFilePathForData:(NSData *)data;

- (IRWMFDocument *) newTestDocument NS_RETURNS_RETAINED;
- (IRWMFDocument *) newTestDocumentForFileNamed:(NSString *)aFileName NS_RETURNS_RETAINED;

@end
