//
//  IRWMFDocument.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/14/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

@interface IRWMFDocument : NSObject

+ (id) documentWithData:(NSData *)data;
- (id) initWithData:(NSData *)data;

- (NSArray *) wmfRecords;

@end
