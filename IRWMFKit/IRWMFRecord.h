//
//  IRWMFRecord.h
//  IRWMFKit
//
//  Created by Evadne Wu on 11/17/11.
//  Copyright (c) 2011 Iridia Productions. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IRWMFDecoding.h"
#import "IRWMFDefines.h"

@interface IRWMFRecord : NSObject <IRWMFDecoding>

@property (nonatomic, readonly, assign) IRWMFRecordType recordType;
@property (nonatomic, readonly, assign) int32_t objectSize; 

+ (IRWMFRecordType) recordTypeFromData:(NSData *)incomingData atByteOffset:(NSUInteger)offsetBytes;
+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType;
+ (Class) bestClassForRecordType:(IRWMFRecordType)aType;

@end


@interface IRWMFHeaderRecord : IRWMFRecord

@end
