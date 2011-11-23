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

- (void) configureWithBytes:(const void *)dataBytes withPayloadAtOffset:(NSUInteger)offsetBytes;
//	Subclass responsibility.
//	offsetBytes starts when the payload starts — the first 6 bytes, 4 for the size and 2 for the function type, are skipped

- (NSString *) descriptionSubstring;
//	return @"Foo = Bar; Mon = Dux" for pretty printing

+ (CFMutableDictionaryRef) recordTypesToHandlerClasses;
+ (void) setClass:(Class)aClass forRecordType:(IRWMFRecordType)aType;
+ (Class) classForRecordType:(IRWMFRecordType)aType;
+ (BOOL) canHandleRecordType:(IRWMFRecordType)aType;

@end

#import "IRWMFRecordExporting.h"
