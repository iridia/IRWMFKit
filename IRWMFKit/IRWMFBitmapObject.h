//
//  IRWMFBitmapObject.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/23/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import "IRWMFObject.h"

@class IRWMFBitmapInfoHeaderObject;

@interface IRWMFBitmapObject : IRWMFObject

@property (nonatomic, readonly, retain) IRWMFBitmapInfoHeaderObject *infoHeader;
@property (nonatomic, readonly, assign) CGImageRef image;

@end
