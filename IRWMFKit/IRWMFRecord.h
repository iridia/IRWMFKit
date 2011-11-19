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

@end

@interface IRWMFHeaderRecord : IRWMFRecord

@end
