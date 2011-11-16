//
//  IRWMFDecoder.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/17/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

@class IRWMFDocument;

@interface IRWMFDecoder : NSObject

+ (id) sharedDecoder;

- (IRWMFDocument *) documentWithData:(NSData *)data;
- (IRWMFDocument *) documentWithData:(NSData *)data error:(NSError **)error;

@end
