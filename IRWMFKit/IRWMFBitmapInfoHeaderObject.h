//
//  IRWMFBitmapInfoHeaderObject.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/22/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFObject.h"
#import "IRWMFDefines.h"

@interface IRWMFBitmapInfoHeaderObject : IRWMFObject

@property (nonatomic, readonly, assign) int32_t width;
@property (nonatomic, readonly, assign) int32_t height;
@property (nonatomic, readonly, assign) uint16_t numberOfPlanes;
@property (nonatomic, readonly, assign) IRWMFBitCount bitCount;
@property (nonatomic, readonly, assign) IRWMFCompression compression;
@property (nonatomic, readonly, assign) uint32_t imageSize;
@property (nonatomic, readonly, assign) int32_t horizontalPPM;	// pixels per meter
@property (nonatomic, readonly, assign) int32_t verticalPPM; // pixels per meter
@property (nonatomic, readonly, assign) uint32_t numberOfColors;
@property (nonatomic, readonly, assign) uint32_t numberOfRequiredColors;

//	v4 header fields, may be initialized to 0 if the object is older
@property (nonatomic, readonly, assign) uint32_t redColorMask;
@property (nonatomic, readonly, assign) uint32_t greenColorMask;
@property (nonatomic, readonly, assign) uint32_t blueColorMask;
@property (nonatomic, readonly, assign) uint32_t alphaColorMask;
@property (nonatomic, readonly, assign) IRWMFLogicalColorSpace colorSpace;
@property (nonatomic, readonly, retain) IRWMFObject *chromaticityEndpoints;
@property (nonatomic, readonly, assign) Float32 redGamma;
@property (nonatomic, readonly, assign) Float32 greenGamma;
@property (nonatomic, readonly, assign) Float32 blueGamma;

//	v5 header fields, may be initialized to 0 if the object is older
@property (nonatomic, readonly, assign) uint32_t renderingIntent;
@property (nonatomic, readonly, assign) uint32_t colorProfileData;	//	minefield, might be pointer to unicode string or real data, both right in the following DIB data
@property (nonatomic, readonly, assign) uint32_t colorProfileSize;

@end
