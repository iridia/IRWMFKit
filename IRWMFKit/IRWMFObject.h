//
//  IRWMFObject.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/17/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "IRWMFDecoding.h"

@class IRWMFRecord;
@interface IRWMFObject : NSObject <IRWMFDecoding>

@property (nonatomic, readwrite, assign) IRWMFRecord *record;

+ (id) objectUsingRecord:(IRWMFRecord *)record withData:(NSData *)data offset:(NSUInteger)offsetBytes usedBytes:(NSUInteger *)numberOfConsumedBytes error:(NSError **)error;

@end
