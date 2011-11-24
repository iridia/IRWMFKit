//
//  IRWMFDocument+Exporting.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/20/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFDocument.h"

@interface IRWMFDocument (Exporting)

- (CGImageRef) newFullResolutionImage;
//	Returns the image filled in a region as large as specified by window extents, which might be thousands as RTF specs them in twips
//	it makes all the stuff complicated as hell, as well

- (NSArray *) copyEmbeddedImages NS_RETURNS_RETAINED;
// Returns all the images in the document in their native resolutions as CGImageRef objects, or nothing if there is nothing

@end
